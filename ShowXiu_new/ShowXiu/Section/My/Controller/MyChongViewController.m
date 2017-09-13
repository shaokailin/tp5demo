//
//  MyChongViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/5/10.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "MyChongViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import <CommonCrypto/CommonDigest.h>
#import "WXApiObject.h"
#import "WXApi.h"
#import "MyOneTableViewCell.h"
#import "MyChongTableViewCell.h"
#import "MyChongModel.h"
#import "PrivilegeTableViewCell.h"
#import "JInModel.h"
#import "MyCongView.h"
#import "SMKCycleScrollView.h"
#import "OrderViewController.h"
#import <StoreKit/StoreKit.h>
#define PRODUCTID @"4949002" //商品ID（请填写你商品的id）
#define PRODUC99 @"9999002" //商品ID（请填写你商品的id）
#define PRODUCT4930 @"49302" //商品ID（请填写你商品的id）
#define PRODUCT90 @"1293602" //商品ID（请填写你商品的id）



@interface MyChongViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSString *qianstring;
@property (nonatomic, strong)NSDictionary *weiDic;
@property (nonatomic, strong)UIButton *VIPButton;
@property (nonatomic, strong)UIButton * qianBUtton;

@property (nonatomic, strong)UILabel *xianLabel;
@property (nonatomic, strong)UITableView *tabelView;
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSDictionary *uinfoDic;
@property (nonatomic, strong)UIView *fooView;
@property (nonatomic, strong)MyCongView * HaerView;
@property (nonatomic, strong)UIView * FooterViewXIU;

//支付类型
@property (nonatomic, copy)NSString *zhitype;
@property (nonatomic, copy)MyChongModel *zhimodel;
@property (nonatomic, copy)NSString *VIPJIN;
@property (nonatomic, strong)UILabel *Label11;
@property (nonatomic, strong) SMKCycleScrollView *cycleScrollView;
@property (nonatomic, assign) int HHXIU;
@property (nonatomic, assign) int xiuHH;
@property (nonatomic, assign) int typeHH;
@property (nonatomic, strong)UILabel *teLabel;
/**
 *  定时器
 */
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic, strong)NSMutableArray *gunDataArray;

@property (strong, nonatomic) SKPayment *payment;
@property (strong, nonatomic) SKMutablePayment *g_payment;
@property (nonatomic, copy)NSString *moZF;

@end

@implementation MyChongViewController
- (NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
- (NSMutableArray *)gunDataArray{
    if (!_gunDataArray) {
        _gunDataArray = [[NSMutableArray alloc]init];
    }
    return _gunDataArray;
}
- (MyCongView *)HaerView{
    if (!_HaerView) {
        NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"MyCongView" owner:nil options:nil];
        
        _HaerView = [nibContents lastObject];
        _HaerView.frame = CGRectMake(0, 0, kScreen_w, 320);
        [_HaerView.oneButton setBackgroundImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
        [_HaerView.oneButton addTarget:self action:@selector(addoneButton:) forControlEvents:UIControlEventTouchUpInside];
        [_HaerView.twoButton setBackgroundImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
        [_HaerView.twoButton addTarget:self action:@selector(addtwoButton:) forControlEvents:UIControlEventTouchUpInside];
        [_HaerView.zhhifuButton addTarget:self action:@selector(addzhhifuButton:) forControlEvents:UIControlEventTouchUpInside];
        _HaerView.zhhifuButton.layer.cornerRadius = 3;
        _HaerView.zhhifuButton.layer.masksToBounds = YES;
        [_HaerView.touIamgeView sd_setImageWithURL:[NSURL URLWithString:self.touxaingST] placeholderImage:[UIImage imageNamed:zhantuImage]];

  
    }
    return _HaerView;
}
//第一个Button
- (void)addoneButton:(UIButton *)sender{
    [_HaerView.oneButton setBackgroundImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    [_HaerView.twoButton setBackgroundImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
    self.typeHH = 0;

}
//第二个Button
- (void)addtwoButton:(UIButton *)sender{
    [_HaerView.oneButton setBackgroundImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
    [_HaerView.twoButton setBackgroundImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    self.typeHH = 1;

}
//立即支付
- (void)addzhhifuButton:(UIButton *)sender{
    NSString *strmony = [NSString stringWithFormat:@"%@",self.uinfoDic[@"is_pay"]];
    if([strmony isEqualToString:@"0"]){
        if ([self.VIPJIN isEqualToString:@"1000"]) {
            if (self.typeHH == 0) {
                self.moZF = PRODUCT4930;
            }else {
                self.moZF = PRODUCT90;
            }
        }else {
            if (self.typeHH == 0) {
                self.moZF = PRODUCTID;
            }else {
                self.moZF = PRODUC99;
            }
        }
        [self testPay];
        
    }else {
        
        if ([self.VIPJIN isEqualToString:@"1000"]) {
            MyChongModel *model = self.dataArray[self.typeHH];
            OrderViewController *OrderView = [[OrderViewController alloc]init];
            NSString *name = [NSString stringWithFormat:@"购买VIP%@天",model.day];
            NSString *mony = [NSString stringWithFormat:@"%@元",model.price];
            OrderView.name = name;
            OrderView.mony = mony;
            OrderView.ZFtype = @"1";
            OrderView.goID = model.ID;
            OrderView.qqST = self.uinfoDic[@"qq"];
            [self.navigationController pushViewController:OrderView animated:nil];
        }else {
            JInModel *model = self.dataArray[self.typeHH];
            OrderViewController *OrderView = [[OrderViewController alloc]init];
            NSString *name = [NSString stringWithFormat:@"购买%@秀币",model.gold];
            NSString *mony = [NSString stringWithFormat:@"%@元",model.money];
            OrderView.name = name;
            OrderView.mony = mony;
            OrderView.ZFtype = @"2";
            OrderView.goID = model.ID;
            OrderView.qqST = self.uinfoDic[@"qq"];
            [self.navigationController pushViewController:OrderView animated:nil];
        }
    }
}



- (UIView *)FooterViewXIU{
    if (!_FooterViewXIU) {
        _FooterViewXIU = [[UIView alloc]init];
        _FooterViewXIU.frame = CGRectMake(0, 0, kScreen_w, 300);
        UILabel *Label = [[UILabel alloc]init];
        Label.frame = CGRectMake(0, 0, kScreen_w, 30);
        Label.text = @"  已充值的用户";
        Label.font = [UIFont systemFontOfSize:15];
        Label.alpha = 0.6;
        Label.backgroundColor = ViewRGB;
        [_FooterViewXIU addSubview:Label];
        self.cycleScrollView = [[SMKCycleScrollView alloc] init];
        self.cycleScrollView.frame = CGRectMake(10, 30, [UIScreen mainScreen].bounds.size.width - 40, 270);
//        self.cycleScrollView.backColor = [UIColor orangeColor];
//        self.cycleScrollView.titleColor = [UIColor blackColor];
        self.cycleScrollView.titleFont = [UIFont systemFontOfSize:15];
        
        
//        self.cycleScrollView.titleArray = [NSArray arrayWithObjects:
//                                           @"微软CEO：我们没有放弃智能手机 会来点不一样的",
//                                           @"李彦宏发内部信，再次强调人工智能战略",
//                                           @"iPhone 8会亮相6月WWDC吗？分析师为此互相打脸",
//                                           @"孙宏斌：乐视汽车贾跃亭该怎么弄怎么弄，其他的该卖的卖掉",
//                                           nil];
        
        [self.cycleScrollView setSelectedBlock:^(NSInteger index, NSString *title) {
            NSLog(@"%zd-----%@",index,title);
        }];
        [_FooterViewXIU addSubview:self.cycleScrollView];
    }
    return _FooterViewXIU;
}


- (void)addTimer{
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)nextPage{
    NSString *string = @"";
    if ([self.VIPJIN isEqualToString:@"1000"]) {
        string = [NSString stringWithFormat:@"已开通VIP用户：%d人",_HHXIU];
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
        
        [attrString addAttribute:NSForegroundColorAttributeName value:hong range:NSMakeRange(9,6)];
      }else {
        string = [NSString stringWithFormat:@"已充值秀币用户：%d人",_xiuHH];
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
        [attrString addAttribute:NSForegroundColorAttributeName value:hong range:NSMakeRange(8,6)];
    }
    
}
- (void)removeTimer {
    
    [self.timer invalidate];
    self.timer = nil;
}

- (void)dealloc {
    
    [self.timer invalidate];
    self.timer = nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ViewRGB;
    self.navigationItem.title = @"充值中心";
    UIImage *leimage = [UIImage imageNamed:@"形状16"];
    UIImage *Leimage = [leimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:Leimage style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarLeftitemAction:)];
    
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_2"] style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarLeftitemAction:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.VIPJIN = @"1001";

    [self addView];
    [self addTableView];
    self.typeHH = 0;
}
#pragma mark - 页面布局
- (void)addView{
    self.VIPButton = [[UIButton alloc]init];
    _VIPButton.tag = 1000;
    _VIPButton.frame = CGRectMake(0, 64,kScreen_w/2, 40);
    [_VIPButton setTitle:@"升级VIP会员" forState:UIControlStateNormal];
    [_VIPButton addTarget:self action:@selector(addzhiButton:) forControlEvents:UIControlEventTouchUpInside];
    _VIPButton.backgroundColor = [UIColor whiteColor];
    _VIPButton.alpha = 0.8;
    //    _VIPButton.titleLabel.font = [UIFont systemFontOfSize:15];
    _VIPButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.VIPButton setTitleColor:[UIColor colorWithRed:240.0/255.0 green:110.0/255.0 blue:134.0/255.0 alpha:1] forState:UIControlStateNormal];
    [self.view addSubview:_VIPButton];
    
    self.qianBUtton = [[UIButton alloc]init];
    _qianBUtton.tag = 1001;
    _qianBUtton.frame = CGRectMake(kScreen_w/2, 64, kScreen_w/2, 40);
    [_qianBUtton setTitle:@"充值秀币" forState:UIControlStateNormal];
    _qianBUtton.alpha = 0.8;
    _qianBUtton.backgroundColor = [UIColor whiteColor];
    [_qianBUtton addTarget:self action:@selector(addzhiButton:) forControlEvents:UIControlEventTouchUpInside];
    _qianBUtton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_qianBUtton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:_qianBUtton];
    
    self.xianLabel = [[UILabel alloc]init];
    _xianLabel.frame = CGRectMake(kScreen_w/2, 103, kScreen_w/2, 1);
    _xianLabel.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:110.0/255.0 blue:134.0/255.0 alpha:1];
    [self.view addSubview:_xianLabel];
    
    
    
}
- (void)addTableView{
    self.tabelView = [[UITableView alloc]init];
    self.tabelView.frame = CGRectMake(0, 106, kScreen_w, kScreen_h);
    self.tabelView.delegate = self;
    self.tabelView.dataSource = self;
    self.tabelView.tableHeaderView = self.HaerView;
    self.tabelView.tableFooterView = self.FooterViewXIU;
    __weak typeof(self) ws = self;
    self.tabelView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [ws refreshData];
    }];
    self.tabelView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [ws loadData];
    }];
    
    [self.tabelView registerNib:[UINib nibWithNibName:@"PrivilegeTableViewCell" bundle:nil] forCellReuseIdentifier:@"PrivilegeTableViewCell"];
    
    [self.view addSubview:_tabelView];
    
    [self refreshData];
    
}

#pragma mark - 下拉刷新 上拉加载
- (void)refreshData {
    self.page = 1;
    [self.tabelView.mj_footer endRefreshing];
    [self ladeData];
}

- (void)loadData {
    self.page ++ ;
    [self.tabelView.mj_header endRefreshing];
    [self ladeData];
}


#pragma make ------ UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PrivilegeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PrivilegeTableViewCell" forIndexPath:indexPath];
    [cell.contentView addSubview:self.fooView];
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
      CGFloat collectionView_h = [HelperClass calculationHeightWithTextsize:15.0 LabelWidth:kScreen_w - 24 WithText:self.uinfoDic[@"vip_desc"] LineSpacing:0];
    return collectionView_h + 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        UIAlertController *ALertView = [UIAlertController alertControllerWithTitle:@"请选择支付方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *WView = [UIAlertAction actionWithTitle:@"支付宝" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.zhitype = @"0";
            self.zhimodel = self.dataArray[indexPath.row];
            [self data];
        }];
        UIAlertAction *ZView = [UIAlertAction actionWithTitle:@"微信" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.zhitype = @"1";
            self.zhimodel = self.dataArray[indexPath.row];
            [self data];
            
            
        }];
        [ALertView addAction:quxiao];
        [ALertView addAction:WView];
        [ALertView addAction:ZView];
        [self presentViewController:ALertView animated:YES completion:nil];
        
        
        
    }
    
    
}
- (void)addyuanButton:(UIButton *)sender{
//    UIView *v = [sender superview];//获取父类view
//    UIView *v1 = [v superview];
    UITableViewCell *cell = (UITableViewCell *)[sender superview];//获取cell
    NSIndexPath *indexPathAll = [self.tabelView indexPathForCell:cell];//获取cell对应的section
    
    UIAlertController *ALertView = [UIAlertController alertControllerWithTitle:@"请选择支付方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *WView = [UIAlertAction actionWithTitle:@"支付宝" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.zhitype = @"0";
        self.zhimodel = self.dataArray[indexPathAll.row];
        [self data];
    }];
    UIAlertAction *ZView = [UIAlertAction actionWithTitle:@"微信" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.zhitype = @"1";
        self.zhimodel = self.dataArray[indexPathAll.row];
        [self data];
        
        
    }];
    [ALertView addAction:quxiao];
    [ALertView addAction:WView];
    [ALertView addAction:ZView];
    [self presentViewController:ALertView animated:YES completion:nil];
    
    
    

    
}



#pragma mark -- fooView
- (UIView *)fooView{
    if (!_fooView) {
        _fooView = [[UIView alloc]init];
        self.teLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 12, kScreen_w - 24, 20)];
        _teLabel.text = @"VIP特权介绍";
        _teLabel.textColor = [UIColor colorWithRed:251.0/255.0 green:0 blue:42.0/255.0 alpha:0.8];
        _teLabel.font = [UIFont systemFontOfSize:15];
        
        [_fooView addSubview:_teLabel];
        
        self.Label11 = [[UILabel alloc]init];
        _Label11.font = [UIFont systemFontOfSize:15];
        _Label11.numberOfLines = 0;
        _Label11.alpha = 0.8;
        [_fooView addSubview:_Label11];
        
    }
    return _fooView;
}
#pragma mark - 数据请求
- (void)ladeData{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *URL11 = @"";
    NSString *uidS = [defatults objectForKey:uidSG];
    if ([self.VIPJIN isEqualToString:@"1001"]) {
        URL11 = [NSString stringWithFormat:@"%@%@",AppURL,API_MY_recharge];

    }else {
        URL11 = [NSString stringWithFormat:@"%@%@",AppURL,API_MY_Vipuser];

    }
    
    
    [HttpUtils postRequestWithURL:URL11 withParameters:@{@"uid":uidS} withResult:^(id result) {
        self.gunDataArray = result[@"data"][@"loglist"];
        self.cycleScrollView.titleArray = self.gunDataArray;

        if ([self.VIPJIN isEqualToString:@"1001"]) {
            [self.dataArray removeAllObjects];
            self.uinfoDic = result[@"data"][@"uinfo"];
            NSArray *Array = result[@"data"][@"recharge"];
            for (NSDictionary *dci in Array) {
                JInModel *model = [[JInModel alloc]initWithDictionary:dci error:nil];
                [self.dataArray addObject:model];
            }
            self.fooView.hidden = NO;
            CGFloat collectionView_h = [HelperClass calculationHeightWithTextsize:15.0 LabelWidth:kScreen_w - 24 WithText:self.uinfoDic[@"vip_desc"] LineSpacing:0];
            self.fooView.frame = CGRectMake(0, 0, kScreen_w - 24, collectionView_h + 34);
            _Label11.frame = CGRectMake(12, 30, kScreen_w - 24, collectionView_h);
            _Label11.text = self.uinfoDic[@"vip_desc"];
            _teLabel.text = @"秀币特权介绍";
            
            
            JInModel *Onemodel = self.dataArray[0];
            JInModel *Twomodel = self.dataArray[1];
            self.HaerView.namelabel.text = self.uinfoDic[@"user_nicename"];
            NSString *user_rank = [NSString stringWithFormat:@"%@",self.uinfoDic[@"user_rank"]];
            int renk = [user_rank intValue];
            if (renk == 0) {
                self.HaerView.VIP.hidden = YES;
            }else {
                self.HaerView.VIP.hidden = NO;
            }
            self.HaerView.neiLabel.text = @"秀币剩余个数";
            NSString *str = [NSString stringWithFormat:@"%@",self.uinfoDic[@"money"]];
            self.HaerView.daylabel.text = str;
            self.HaerView.biaotiLabel.text = @"购买秀币后可与MM/GG畅聊";
            self.HaerView.onedayLabel.text = [NSString stringWithFormat:@"%@秀币",Onemodel.gold];
            self.HaerView.onemonyLabel.text = [NSString stringWithFormat:@"￥%@元",Onemodel.money];
          
            self.HaerView.onedayMony.text = [NSString stringWithFormat:@"赠送秀币：%@",Onemodel.zmoney];
            
            self.HaerView.twodayLabel.text = [NSString stringWithFormat:@"%@秀币",Twomodel.gold];
            self.HaerView.twomonyLabel.text = [NSString stringWithFormat:@"￥%@元",Twomodel.money];
          
            self.HaerView.teodayMonyLabel.text = [NSString stringWithFormat:@"赠送秀币：%@",Twomodel.zmoney];
            
            
            
        }else {
            [self.dataArray removeAllObjects];
            
            
            self.uinfoDic = result[@"data"][@"uinfo"];
            NSArray *Array = result[@"data"][@"vip"];
            for (NSDictionary *dci in Array) {
                MyChongModel *model = [[MyChongModel alloc]initWithDictionary:dci error:nil];
                [self.dataArray addObject:model];
            }
            CGFloat collectionView_h = [HelperClass calculationHeightWithTextsize:15.0 LabelWidth:kScreen_w - 24 WithText:self.uinfoDic[@"vip_desc"] LineSpacing:0];
            self.fooView.hidden = NO;
            self.fooView.frame = CGRectMake(0, 0, kScreen_w - 24, collectionView_h + 34);
            _Label11.frame = CGRectMake(12, 33, kScreen_w - 24, collectionView_h);
            _Label11.text = self.uinfoDic[@"vip_desc"];
            
            MyChongModel *Onemodel = self.dataArray[0];
            MyChongModel *Twomodel = self.dataArray[1];
            self.HaerView.namelabel.text = self.uinfoDic[@"user_nicename"];
            NSString *user_rank = [NSString stringWithFormat:@"%@",self.uinfoDic[@"user_rank"]];
            int renk = [user_rank intValue];
            if (renk == 0) {
                self.HaerView.VIP.hidden = YES;
            }else {
                self.HaerView.VIP.hidden = NO;
            }
            self.HaerView.neiLabel.text = @"VIP特权剩余天数";
            NSString *strli = [NSString stringWithFormat:@"%@",self.uinfoDic[@"rank_time"]];
            self.HaerView.daylabel.text = strli;
            
            self.HaerView.biaotiLabel.text = @"开通VIP后可无限制聊天人数与MM/GG聊天";

            self.HaerView.onedayLabel.text = [NSString stringWithFormat:@"%@天",Onemodel.day];
            self.HaerView.onemonyLabel.text = [NSString stringWithFormat:@"￥%@元",Onemodel.price];
            CGFloat print= [Onemodel.price floatValue];
            CGFloat BBB = [Onemodel.day floatValue];
            CGFloat a = print / BBB;
            NSString *str = [NSString stringWithFormat:@"%.1f元/天",a];
            
            self.HaerView.onedayMony.text = str;
            
            self.HaerView.twodayLabel.text = [NSString stringWithFormat:@"%@天",Twomodel.day];
            self.HaerView.twomonyLabel.text = [NSString stringWithFormat:@"￥%@元",Twomodel.price];
            CGFloat print2= [Twomodel.price floatValue];
            CGFloat BB = [Twomodel.day floatValue];
            CGFloat a2 = print2 / BB;
            NSString *str2 = [NSString stringWithFormat:@"%.1f元/天",a2];
            self.HaerView.teodayMonyLabel.text = str2;

            
        }
        NSString *strmony = [NSString stringWithFormat:@"%@",self.uinfoDic[@"is_pay"]];
        if([strmony isEqualToString:@"0"]){
            [_HaerView.zhhifuButton setTitle:@"苹果支付" forState:UIControlStateNormal];
        }else {
            [_HaerView.zhhifuButton setTitle:@"立即支付" forState:UIControlStateNormal];
            
        }
        

        [self.tabelView reloadData];
        [self.tabelView.mj_header endRefreshing];
        [self.tabelView.mj_footer endRefreshing];
        
    } withError:^(NSString *msg, NSError *error) {
        [self.tabelView.mj_header endRefreshing];
        [self.tabelView.mj_footer endRefreshing];
    }];
}
- (void)data{
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_MY_payApi];
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    NSString *yuH = @"";
    if ([self.VIPJIN isEqualToString:@"1001"]){
        yuH = @"2";
    }else {
        yuH = @"1";
    }
    
    
    NSDictionary *dic = @{@"uid":uidS,@"accountType":yuH,@"accountId":self.zhimodel.ID,@"phoneType":@"2",@"accountForm":self.zhitype,@"hash":@""};
    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
        if([self.zhitype isEqualToString:@"0"]){
            self.qianstring = result[@"data"][@"orderString"];
            [self zhifu];
            
        }else {
            self.weiDic = result[@"data"];
            [self weifu];
        }
        
        
        
    } withError:^(NSString *msg, NSError *error) {
        
    }];
    
}
#pragma mark - 页面换
- (void)addzhiButton:(UIButton *)sender{
    if (sender.tag == 1000) {
        self.xianLabel.frame = CGRectMake(0, 103, kScreen_w/2, 1);
        [self.VIPButton setTitleColor:[UIColor colorWithRed:240.0/255.0 green:110.0/255.0 blue:134.0/255.0 alpha:1] forState:UIControlStateNormal];
        [self.qianBUtton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.VIPJIN = @"1000";
        [self ladeData];
        [_HaerView.oneButton setBackgroundImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
        [_HaerView.twoButton setBackgroundImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
        self.typeHH = 0;
        
    }else {
        self.xianLabel.frame = CGRectMake(kScreen_w/2, 103, kScreen_w/2, 1);
        [self.qianBUtton setTitleColor:[UIColor colorWithRed:240.0/255.0 green:110.0/255.0 blue:134.0/255.0 alpha:1] forState:UIControlStateNormal];
        [self.VIPButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.VIPJIN = @"1001";
        [self ladeData];
        
        [_HaerView.oneButton setBackgroundImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
        [_HaerView.twoButton setBackgroundImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
        self.typeHH = 0;

        
    }
}


#pragma mark - 用户交互
- (void)handleNavigationBarLeftitemAction:(UIBarButtonItem *)sender {
    [self removeTimer];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 支付
- (void)zhifu{
    NSString *appScheme = @"alisdkdemoLixiuxiu";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(participatePayWXVIP) name:@"participatePayWXVIP" object:nil];

    //
    [[AlipaySDK defaultService] payOrder:self.qianstring fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        // 支付宝给我们的回调信息，标示成功还是失败，还是用户取消，网络中断等信息
        // 客户端错误码
        //            9000 成功
        //            8000 正在处理中
        //            4000 订单失败
        NSString *str = resultDic[@"memo"];
        NSString *resultStatus = resultDic[@"resultStatus"];
        int resultStatu = [resultStatus intValue];
        
        if(resultStatu == 9000){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"充值成功" message:@"充值成功" preferredStyle:UIAlertControllerStyleAlert];
            //2.创建action按钮
            //取消样式
            
            UIAlertAction *seqing = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self ladeData];
            }];
            [alert addAction:seqing];
            [self presentViewController:alert animated:YES completion:nil];
            
            
        }else if(resultStatu ==  8000){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"充值失败" message:@"订单正在处理中" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *seqing = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //                    [self participatePayWX];
            }];
            [alert addAction:seqing];
            [self presentViewController:alert animated:YES completion:nil];
        }else if(resultStatu == 4000) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"充值失败" message:@"充值订单失败" preferredStyle:UIAlertControllerStyleAlert];
            
            
            UIAlertAction *seqing = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //                    [self participatePayWX];
            }];
            [alert addAction:seqing];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            //[self mbhud:str numbertime:1];
        }
        
        //
    }];
    
    ////
    //
    //
    
}
- (void)weifu{
    
    NSString *appid = self.weiDic[@"appid"];
    NSString *noncestr = self.weiDic[@"noncestr"];
    NSString *packages = self.weiDic[@"package"];
    NSString *partnerid = self.weiDic[@"partnerid"];
    NSString *prepayid = self.weiDic[@"prepayid"];
    NSString *sign = self.weiDic[@"sign"];
    NSString *timestamp = self.weiDic[@"timestamp"];
    
    //注册微信支付
    [WXApi registerApp:appid];
    //    [WXApi registerApp:appid withDescription:@"demo 2.0"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(participatePayWXVIP) name:@"participatePayWXVIP" object:nil];
    
    //发起微信支付
    PayReq *request = [[PayReq alloc]init];
    
    
    request.partnerId = partnerid;
    
    request.prepayId = prepayid;
    
    request.package = packages;
    
    request.nonceStr = noncestr;
    
    int a = [timestamp intValue];
    
    request.timeStamp = a;
    
    request.sign= sign;
    
    [WXApi sendReq:request];
    
    
    
}
- (void)participatePayWXVIP{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    [defatults setObject:@"1" forKey:user_rankVIP];
    [defatults synchronize];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//苹果支付
- (void)testPay {
    //判断是否可进行支付
    if ([SKPaymentQueue canMakePayments]) {
        [self requestProductData:self.moZF];
    } else {
        NSLog(@"不允许程序内付费");
    }
}
//收到产品返回信息
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    
    NSLog(@"--------------收到产品反馈消息---------------------");
    NSArray *product = response.products;
    if([product count] == 0){
        [SVProgressHUD dismiss];
        NSLog(@"--------------没有商品------------------");
        return;
    }
    
    NSLog(@"productID:%@", response.invalidProductIdentifiers);
    NSLog(@"产品付费数量:%lu",(unsigned long)[product count]);
    
    SKProduct *p = nil;
    for (SKProduct *pro in product) {
        NSLog(@"1--%@", [pro description]);
        NSLog(@"2--%@", [pro localizedTitle]);
        NSLog(@"3--%@", [pro localizedDescription]);
        NSLog(@"4--%@", [pro price]);
        NSLog(@"5--%@", [pro productIdentifier]);
        
        if([pro.productIdentifier isEqualToString:self.moZF]){
            p = pro;
        }
    }
    
    SKPayment *payment = [SKPayment paymentWithProduct:p];
    
    NSLog(@"发送购买请求");
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (void)requestProductData:(NSString *)type {
    //根据商品ID查找商品信息
    NSArray *product = [[NSArray alloc] initWithObjects:type, nil];
    NSSet *nsset = [NSSet setWithArray:product];
    //创建SKProductsRequest对象，用想要出售的商品的标识来初始化， 然后附加上对应的委托对象。
    //该请求的响应包含了可用商品的本地化信息。
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
    request.delegate = self;
    [request start];
}
//- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
//    //接收商品信息
//    NSArray *product = response.products;
//    if ([product count] == 0) {
//        return;
//    }
//    // SKProduct对象包含了在App Store上注册的商品的本地化信息。
//    SKProduct *storeProduct = nil;
//    for (SKProduct *pro in product) {
//        if ([pro.productIdentifier isEqualToString:PRODUCTID]) {
//            storeProduct = pro;
//        }
//    }
//    //创建一个支付对象，并放到队列中
//    self.g_payment = [SKMutablePayment paymentWithProduct:storeProduct];
//    //设置购买的数量
//    self.g_payment.quantity = 1;
//    [[SKPaymentQueue defaultQueue] addPayment:self.g_payment];
//}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"请求商品失败%@", error);
}

- (void)requestDidFinish:(SKRequest *)request {
    NSLog(@"反馈信息结束调用");
}
//监听购买结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transaction {
    for (SKPaymentTransaction *tran in transaction) {
        // 如果小票状态是购买完成
        if (SKPaymentTransactionStatePurchased == tran.transactionState) {
            [[SKPaymentQueue defaultQueue] finishTransaction:tran];
            // 更新界面或者数据，把用户购买得商品交给用户
            //返回购买的商品信息
            [self verifyPruchase];
            //商品购买成功可调用本地接口
        } else if (SKPaymentTransactionStateRestored == tran.transactionState) {
            // 将交易从交易队列中删除
            [[SKPaymentQueue defaultQueue] finishTransaction:tran];
        } else if (SKPaymentTransactionStateFailed == tran.transactionState) {
            // 支付失败
            // 将交易从交易队列中删除
            [[SKPaymentQueue defaultQueue] finishTransaction:tran];
        }
    }
}
//交易结束
- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    NSLog(@"交易结束");
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}
#pragma mark 验证购买凭据

- (void)verifyPruchase {
    // 验证凭据，获取到苹果返回的交易凭据
    // appStoreReceiptURL iOS7.0增加的，购买交易完成后，会将凭据存放在该地址
    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    // 从沙盒中获取到购买凭据
    NSData *receiptData = [NSData dataWithContentsOfURL:receiptURL];
    // 发送网络POST请求，对购买凭据进行验证
    //测试验证地址:https://sandbox.itunes.apple.com/verifyReceipt
    //正式验证地址:https://buy.itunes.apple.com/verifyReceipt
    NSURL *url = [NSURL URLWithString:@"https://sandbox.itunes.apple.com/verifyReceipt"];
    NSMutableURLRequest *urlRequest =
    [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    urlRequest.HTTPMethod = @"POST";
    NSString *encodeStr = [receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSString *payload = [NSString stringWithFormat:@"{\"receipt-data\" : \"%@\"}", encodeStr];
    NSData *payloadData = [payload dataUsingEncoding:NSUTF8StringEncoding];
    urlRequest.HTTPBody = payloadData;
    // 提交验证请求，并获得官方的验证JSON结果 iOS9后更改了另外的一个方法
    NSData *result = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:nil];
    // 官方验证结果为空
    if (result == nil) {
        NSLog(@"验证失败");
        return;
    }
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingAllowFragments error:nil];
    if (dict != nil) {
        // 比对字典中以下信息基本上可以保证数据安全
        // bundle_id , application_version , product_id , transaction_id
        NSLog(@"验证成功！购买的商品是：%@", @"_productName");
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

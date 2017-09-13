//
//  MainXiuViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/6/2.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "MainXiuViewController.h"
#import "MyTableViewCell.h"
#import "FourTableViewCell.h"
#import "MianImageTableViewCell.h"
#import "GiftView.h"
#import "ChatViewController.h"
#import "GiftViewController.h"
#import "ImageListViewController.h"
#import "SiimaViewController.h"
#import "ShiImaViewController.h"
#import "MyChongViewController.h"
#import "PotuViewController.h"
#import "VideoPlaybackViewController.h"
#import "MianAllModel.h"
#import "MianImageAllTableViewCell.h"
#import "MianAllModel.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "GoldTwoView.h"
#import "TopUpTwoView.h"
@interface MainXiuViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic,strong)UIImageView *headImageView;//头部图片
@property(nonatomic,strong)UIImageView * avatarImage;
@property(nonatomic,strong)UILabel *countentLabel;
@property (nonatomic, strong) UIVisualEffectView *effectView;
@property(nonatomic, strong)UIView *BANVIew;
@property(nonatomic, strong)UILabel *WNEZILabel;
@property(nonatomic, strong)UIButton *xiangimageVIew;
@property(nonatomic, strong)UIImageView *VIBImageVIew;
@property (nonatomic, strong) UILabel *nianLabel;
@property (nonatomic, strong) UILabel *meiLabel;
@property (nonatomic, strong) UIButton *guanzhuButton;
@property (nonatomic, strong) UITableView *tableView;
//数据
@property (nonatomic, strong) NSDictionary *dataDic;

//礼物
@property (nonatomic, strong)UIView *BViewLi;
@property(nonatomic, strong)UIView *BView;
@property(nonatomic, strong)GiftView *liView;
//VIP
@property (nonatomic, strong)TopUpTwoView *topUpTwoView;
//秀币
@property (nonatomic, strong)GoldTwoView * goldTwoView;

@property(nonatomic, strong)UIView *qunaView;
@property(nonatomic, strong)UIView *jubaoView;
@property(nonatomic, strong)UIButton *typeButton;
@property(nonatomic, strong)UITextView *textView;
@property(nonatomic, copy)NSString *jutype;
@property(nonatomic, strong)MBProgressHUD *MBhud;
//图片
@property(nonatomic, strong)NSMutableArray *tuImageArray;
//可看图片
@property(nonatomic, strong)NSMutableArray *xiantuImageArray;

//视频
@property(nonatomic, strong)NSMutableArray *viodArray;
//拉黑
@property (nonatomic, copy)NSString *islh;
//分享
@property (nonatomic, strong)NSDictionary *fenDic;


@end

@implementation MainXiuViewController
-(NSMutableArray *)xiantuImageArray{
    if (!_xiantuImageArray) {
        _xiantuImageArray = [[NSMutableArray alloc]init];
    }
    return _xiantuImageArray;
}

- (NSMutableArray *)tuImageArray{
    if (!_tuImageArray) {
        _tuImageArray = [[NSMutableArray alloc]init];
    }
    return _tuImageArray;
}
- (NSMutableArray *)viodArray{
    if (!_viodArray) {
        _viodArray = [[NSMutableArray alloc]init];
    }
    return _viodArray;
}

- (MBProgressHUD *)MBhud{
    if (!_MBhud) {
        _MBhud = [[MBProgressHUD alloc]init];
        
    }
    return _MBhud;
}


//提示框
- (void)mbhudtui:(NSString *)textname numbertime:(int)nuber{
    //提示框
    [self.view addSubview:self.MBhud];
    [self.MBhud show:YES];
    _MBhud.labelText = textname;
    _MBhud.mode = MBProgressHUDModeText;
    [_MBhud showAnimated:YES whileExecutingBlock:^{
        sleep(nuber);
    } completionBlock:^{
        [_MBhud removeFromSuperview];
        _MBhud = nil;
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ViewRGB;
    UIImage *leimage = [UIImage imageNamed:@"形状16"];
    UIImage *Leimage = [leimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:Leimage style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarLeftitemAction:)];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:leftItem, nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addtuAction) name:@"adddtuXIUXIU" object:nil];

    
    [self addUITableView];
    [self dibuView];
    [self lirequestData];
    [self Addhello];
    [self addView];
    [self fengxiangData];
}
- (void)addtuAction{
    [self lirequestData];
}

//返回
- (void)addView{
    UIButton *fanButton = [[UIButton alloc]init];
    fanButton.frame = CGRectMake(10, 30, 30, 30);
    [fanButton setImage:[UIImage imageNamed:@"go_back"] forState:UIControlStateNormal];
    [fanButton setBackgroundImage:[UIImage imageNamed:@"椭圆3"] forState:UIControlStateNormal];
    [fanButton addTarget:self action:@selector(AddBack:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:fanButton];
    
    UIButton *sanButton = [[UIButton alloc]init];
    sanButton.frame = CGRectMake(kScreen_w - 35, 30, 30, 30);
    // 椭圆3 椭圆4拷贝2
    [sanButton setBackgroundImage:[UIImage imageNamed:@"椭圆3"] forState:UIControlStateNormal];
    [sanButton setImage:[UIImage imageNamed:@"椭圆4拷贝2"] forState:UIControlStateNormal];
    [sanButton addTarget:self action:@selector(addsanButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sanButton];
}

//礼物
- (void)Addhello{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *uidS = [defatults objectForKey:uidSG];
    if ([uidS isEqualToString:@"257555"]) {
        
    }else {
        UIButton *zhFU = [UIButton new];
        zhFU.frame = CGRectMake(kScreen_w - 70, kScreen_h - 150, 60, 60);
        zhFU.alpha = 1;
        [zhFU addTarget:self action:@selector(addliwuButotnLI:) forControlEvents:UIControlEventTouchUpInside];
        [zhFU setBackgroundImage:[UIImage imageNamed:@"icon-gift"] forState:UIControlStateNormal];
        [self.view addSubview:zhFU];
        
    }
    
    

    
}
//礼物
- (void)addliwuButotnLI:(UIButton *)sender{
    if (!_liView){
        self.BViewLi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_w, kScreen_h)];
        _BViewLi.backgroundColor = [UIColor blackColor];
        _BViewLi.alpha = 0.3;
        //创建手势对象
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self     action:@selector(tapActionBVIewLI)];
        //讲手势添加到指定的视图上
        [_BViewLi addGestureRecognizer:tap];
        [self.view addSubview:_BViewLi];
        
        self.liView = [[GiftView alloc]init];
        _liView.LUID = self.UID;
        _liView.backgroundColor = ViewRGB;
        _liView.frame = CGRectMake(0, kScreen_h - 370, kScreen_w, 370);
        [_liView.shenjiButton addTarget:self action:@selector(addshenjiButton:) forControlEvents:UIControlEventTouchUpInside];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addchpngbutton) name:@"zhifujinbiXIUXIU" object:nil];
        
        [_liView.chpngbutton addTarget:self action:@selector(addchpngbutton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_liView];
        
        
    }else {
        _BViewLi.hidden = NO;
        _liView.hidden = NO;
    }
}
- (void)tapActionBVIewLI {
    _BViewLi.hidden = YES;
    _liView.hidden = YES;
}

//升级VIP
- (void)addshenjiButton:(UIButton *)sender{
    self.liView.hidden = YES;
    [self shengVIPView];
}
//充值
- (void)addchpngbutton{
    self.liView.hidden = YES;
    [self chongView];
    
}

#pragma mark -- 升级VIP界面
- (void)shengVIPView{
    self.BView = [[UIView alloc]init];
    _BView.frame = CGRectMake(0, 0, kScreen_w, kScreen_h);
    _BView.backgroundColor = [UIColor blackColor];
    _BView.alpha = 0.3;
    [self.view addSubview:_BView];
    //创建手势对象
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self     action:@selector(tapAction:)];
    //讲手势添加到指定的视图上
    [_BView addGestureRecognizer:tap];
    
    self.topUpTwoView = [[TopUpTwoView alloc]init];
    _topUpTwoView.frame = CGRectMake(kScreen_w / 2 - 140, kScreen_h / 2 - 150, 280, 300);
    _topUpTwoView.backgroundColor = [UIColor whiteColor];
    _topUpTwoView.layer.cornerRadius = 5;
    _topUpTwoView.layer.masksToBounds = YES;
    [self.view addSubview:_topUpTwoView];
    
    
}
#pragma mark -- 充值界面
- (void)chongView{
    self.BView = [[UIView alloc]init];
    _BView.frame = CGRectMake(0, 0, kScreen_w, kScreen_h);
    _BView.backgroundColor = [UIColor blackColor];
    _BView.alpha = 0.3;
    [self.view addSubview:_BView];
    //创建手势对象
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self     action:@selector(tapAction:)];
    //讲手势添加到指定的视图上
    [_BView addGestureRecognizer:tap];
    
    self.goldTwoView = [[GoldTwoView alloc]init];
    _goldTwoView.frame = CGRectMake(kScreen_w / 2 - 150, kScreen_h / 2 - 150, 300, 300);
    _goldTwoView.backgroundColor = [UIColor whiteColor];
    _goldTwoView.layer.cornerRadius = 5;
    _goldTwoView.layer.masksToBounds = YES;
    [self.view addSubview:_goldTwoView];

}
//轻拍事件

-(void)tapAction:(UITapGestureRecognizer *)tap
{
    if(_BViewLi){
        _BViewLi.hidden = YES;
    }
    
    [_BView removeFromSuperview];
    [_goldTwoView removeFromSuperview];
    [_topUpTwoView removeFromSuperview];
}





#pragma mark - 数据请求
- (void)lirequestData{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    
    NSDictionary *dic = @{@"fromuid":uidS,@"touid":self.UID};
    
    [HttpUtils postRequestWithURL:API_showUser2 withParameters:dic withResult:^(id result) {
        [self.tuImageArray removeAllObjects];
        [self.xiantuImageArray removeAllObjects];
        [self.viodArray removeAllObjects];
        
        NSDictionary *dic = result[@"data"];
        NSArray *rry = dic[@"gk_img"];
        self.islh = dic[@"islh"];
        for (NSDictionary *dic in rry) {
            MianAllModel *model = [[MianAllModel alloc]initWithDictionary:dic error:nil];
            [self.tuImageArray addObject:model];
        }
        for (MianAllModel *model in self.tuImageArray) {
            int SE = [model.see_status intValue];
            if (SE == 1) {
                [self.xiantuImageArray addObject:model];
            }
        }
        NSArray *arry = dic[@"sm_video"];
        for (NSDictionary *dic in arry) {
            MianAllModel *model = [[MianAllModel alloc]initWithDictionary:dic error:nil];
            [self.viodArray addObject:model];
        }
        
        self.dataDic = dic;
        
        NSString *ninaSTring = [NSString stringWithFormat:@"%@ %@",dic[@"area"],dic[@"astro"]];
        _nianLabel.text = ninaSTring;
      
        NSString *guanString = [NSString stringWithFormat:@"%@",dic[@"isgz"]];
        int isgz = [guanString intValue];
        if (isgz == 0) {
            [self.guanzhuButton setBackgroundImage:[UIImage imageNamed:@"icon-unconcern"] forState:UIControlStateNormal];
//            [self.guanzhuButton setTitle:@"未关注" forState:UIControlStateNormal];
            [self.guanzhuButton addTarget:self action:@selector(addguanzhu:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            [self.guanzhuButton setBackgroundImage:[UIImage imageNamed:@"icon-concerned"] forState:UIControlStateNormal];
//            [self.guanzhuButton setTitle:@"已关注" forState:UIControlStateNormal];
            

        }
        if ([dic[@"avatar"] isEqualToString:@""]) {
            self.headImageView.image = [UIImage imageNamed:@"bg-title"];
            _effectView.hidden = YES;
        }else {
            [self.headImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"avatar"]] placeholderImage:[UIImage imageNamed:zhantuImage]];

        }
        
        
        
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:16]};
        CGSize size=[self.name sizeWithAttributes:attrs];
        
        //            CGFloat *KK = size.width + 56.0;
        _WNEZILabel.frame = CGRectMake((kScreen_w - size.width - 56) / 2 , 0, size.width , 20);
        self.WNEZILabel.font = [UIFont systemFontOfSize:16];
        self.WNEZILabel.text = self.name;
        self.WNEZILabel.textColor = [UIColor whiteColor];
        self.xiangimageVIew.frame = CGRectMake((kScreen_w - size.width - 56) / 2 + size.width + 10, 4, 30, 12);
        int ST = [dic[@"sex"] intValue];
        NSString *age = [NSString stringWithFormat:@"%@",dic[@"age"]];
        if (ST == 1){
            NSString *meiString = [NSString stringWithFormat:@"财富值 %@ |",dic[@"jifen"]];
            _meiLabel.text = meiString;
            [_xiangimageVIew setImage:[UIImage imageNamed:@"icon-manX"] forState:UIControlStateNormal];
            [_xiangimageVIew setTitleColor:blueC forState:UIControlStateNormal];

            [_xiangimageVIew setTitle:age forState:UIControlStateNormal];
        }else{
            NSString *meiString = [NSString stringWithFormat:@"魅力值 %@ |",dic[@"jifen"]];
            _meiLabel.text = meiString;
            [_xiangimageVIew setImage:[UIImage imageNamed:@"icon-womanX"] forState:UIControlStateNormal];
            [_xiangimageVIew setTitleColor:hong forState:UIControlStateNormal];

            [_xiangimageVIew setTitle:age forState:UIControlStateNormal];
        }
        self.VIBImageVIew.frame = CGRectMake((kScreen_w - size.width - 56) / 2 + size.width + 57, 4, 22, 12);
        NSString *user_rank = [NSString stringWithFormat:@"%@",result[@"data"][@"user_rank"]];
        
        int RK = [user_rank intValue];
        if (RK == 1) {
            _VIBImageVIew.image = [UIImage imageNamed:@"圆角矩形1"]; //要添加的图片
        }

      
        [_avatarImage sd_setImageWithURL:[NSURL URLWithString:dic[@"avatar"]] placeholderImage:[UIImage imageNamed:zhantuImage]];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    } withError:^(NSString *msg, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSLog(@"确定执行");
            
        }];
        
        
        [alert addAction:otherAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }];
    

}




#pragma mark - 用户交互
- (void)handleNavigationBarLeftitemAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)addUITableView{
    self.tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, 0, kScreen_w, kScreen_h - 50);
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableHeaderView = self.headImageView;
    [self.view addSubview:_tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FourTableViewCell" bundle:nil] forCellReuseIdentifier:@"FourTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MianImageTableViewCell" bundle:nil] forCellReuseIdentifier:@"MianImageTableViewCell"];
    [self.tableView registerClass:[MianImageAllTableViewCell class]forCellReuseIdentifier:@"MianImageAllTableViewCell"];
    
    __weak typeof(self) ws = self;
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [ws lirequestData];
    }];
 
    
}
- (void)dibuView{
    UIView * dibuView = [[UIView alloc]init];
    dibuView.frame = CGRectMake(0, kScreen_h - 54, kScreen_w, 54);
    dibuView.backgroundColor = ViewRGB;
    [self.view addSubview:dibuView];
    
    UIButton *siButton = [[UIButton alloc]init];
    siButton.frame = CGRectMake(0, 0, kScreen_w / 2 - 1, 54);
    [siButton setImage:[UIImage imageNamed:@"形状3"] forState:UIControlStateNormal];
    [siButton setTitle:@" 私信" forState:UIControlStateNormal];
    siButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [siButton setTitleColor:hong forState:UIControlStateNormal];
    [siButton addTarget:self action:@selector(addsiButton:) forControlEvents:UIControlEventTouchUpInside];
    [dibuView addSubview:siButton];
    
    UIButton *zhaoButton = [[UIButton alloc]init];
    zhaoButton.frame = CGRectMake(kScreen_w / 2 - 1, 0, kScreen_w / 2, 54);
    [zhaoButton setImage:[UIImage imageNamed:@"icon-hi"] forState:UIControlStateNormal];
    [zhaoButton setTitle:@"  打招呼" forState:UIControlStateNormal];
    zhaoButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [zhaoButton setTitleColor:hong forState:UIControlStateNormal];
    [zhaoButton addTarget:self action:@selector(addzhaoButton:) forControlEvents:UIControlEventTouchUpInside];
    [dibuView addSubview:zhaoButton];
    
    UILabel *xainLabel = [[UILabel alloc]init];
    xainLabel.frame = CGRectMake(kScreen_w/2 - 0.5, 15, 1, 24);
    xainLabel.backgroundColor = [UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1];
    xainLabel.alpha = 0.6;
    [dibuView addSubview:xainLabel];
    
}


#pragma mark -- 私信
- (void)addsiButton:(UIButton *)sender{
    int hh = [self.islh intValue];
    
    if (hh == 1) {
        [self mbhudtui:@"黑名单状态无法私信" numbertime:1];
    }else {
        NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
        NSString *uidS = [defatults objectForKey:uidSG];
        //    NSString *dianstring = [NSString stringWithFormat:@"%@",model.list2arr[@"isread"]];
        //    cell.bianButton.hidden = YES;
        
        
        ChatViewController *ChatView = [[ChatViewController alloc]init];
        //    if ([self.UID isEqualToString:uidS]) {
        //        ChatView.TOID = model.touid;
        //    }else {
        //        ChatView.TOID = model.fromuid;
        //
        //    }
        ChatView.TOID = self.UID;
        ChatView.name = self.name;
        UINavigationController *ChatViewNVC = [[UINavigationController alloc]initWithRootViewController:ChatView];
        [self showViewController:ChatViewNVC sender:nil];
    }
}


#pragma mark -- 打招呼
- (void)addzhaoButton:(UIButton *)sender{
    int hh = [self.islh intValue];
    if (hh == 1) {
        [self mbhudtui:@"黑名单状态无法打招呼" numbertime:1];

    }else {
        NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
        NSString *uidS = [defatults objectForKey:uidSG];
        NSDictionary *dic = @{@"fromuid":uidS,@"touid":self.UID};
        [HttpUtils postRequestWithURL:API_sendzh withParameters:dic withResult:^(id result) {
            [sender setTitle:@"已招呼" forState:UIControlStateNormal];
            [self mbhudtui:@"打招呼成功" numbertime:1];
        } withError:^(NSString *msg, NSError *error) {
            
            
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                NSLog(@"确定执行");
                
            }];
            UIAlertAction *oAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                NSLog(@"确定执行");
                
            }];
            
            [alert addAction:oAction];
            [alert addAction:otherAction];
            
            [self presentViewController:alert animated:YES completion:nil];
            
        }];
        

        
    }
    
    
    
     
}


-(UIImageView *)headImageView
{
    if (_headImageView == nil)
    {
//        _headImageView = [[UIImageView alloc]init];
        _headImageView= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg.jpg"]];
        _headImageView.frame=CGRectMake(0,0 ,kScreen_w,246);
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.layer.masksToBounds = YES;
        _headImageView.userInteractionEnabled = YES;
        UIImageView *imaV = [[UIImageView alloc]init];
        imaV.frame = _headImageView.frame;
        imaV.image = [UIImage imageNamed:@"black-bg-title"];
        [_headImageView addSubview:imaV];
        
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        //  毛玻璃view 视图
        _effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        //添加到要有毛玻璃特效的控件中
        _effectView.frame = CGRectMake(0, 0, kScreen_w, 246);
        [_headImageView addSubview:_effectView];
        //设置模糊透明度
        _effectView.alpha = 0.4;
        
        
        _avatarImage = [[UIImageView alloc] initWithFrame:CGRectMake(kScreen_w/2-40, 56, 80, 80)];
        [_headImageView addSubview:_avatarImage];
        _avatarImage.userInteractionEnabled = YES;
        _avatarImage.layer.masksToBounds = YES;
        _avatarImage.layer.borderWidth = 1;
        _avatarImage.layer.borderColor =[[UIColor colorWithRed:255/255. green:253/255. blue:253/255. alpha:1.] CGColor];
        _avatarImage.layer.cornerRadius = 40;
     
        self.BANVIew = [[UIView alloc]init];
        _BANVIew.backgroundColor = [UIColor clearColor];
        _BANVIew.frame = CGRectMake(20, 146, kScreen_w - 40, 20);
        [_headImageView addSubview:_BANVIew];
        
        self.WNEZILabel = [[UILabel alloc]init];
        self.WNEZILabel.alpha = 0.8;
        self.xiangimageVIew = [[UIButton alloc]init];
        self.xiangimageVIew.layer.cornerRadius = 2;
        self.xiangimageVIew.layer.masksToBounds = YES;
        self.xiangimageVIew.titleLabel.font = [UIFont systemFontOfSize:10];
        self.xiangimageVIew.backgroundColor = [UIColor whiteColor];
        self.VIBImageVIew = [[UIImageView alloc]init];
        [self.BANVIew addSubview:self.WNEZILabel];
        [self.BANVIew addSubview:_xiangimageVIew];
        [self.BANVIew addSubview:_VIBImageVIew];
        
        
        self.nianLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 170, kScreen_w - 80, 30)];
        _nianLabel.textColor = [UIColor whiteColor];
        _nianLabel.font = [UIFont systemFontOfSize:14];
        _nianLabel.text = @"24岁 福建厦门 天秤座";
        _nianLabel.alpha = 0.6;
        _nianLabel.textAlignment = NSTextAlignmentCenter;
        [_headImageView addSubview:_nianLabel];
        
        self.meiLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 200, (kScreen_w - 80 )/ 2, 30)];
        _meiLabel.textColor = [UIColor whiteColor];
        _meiLabel.font = [UIFont systemFontOfSize:15];
        _meiLabel.text = @"魅力值 3665 ";
        _meiLabel.alpha = 0.8;
        _meiLabel.textAlignment = NSTextAlignmentRight;
        [_headImageView addSubview:_meiLabel];
        

        self.guanzhuButton = [UIButton new];
        _guanzhuButton.frame = CGRectMake(kScreen_w/2 + 10, 206, 60, 21);
//        [_guanzhuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        _guanzhuButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        _guanzhuButton.alpha = 0.8;
        _guanzhuButton.titleLabel.font = [UIFont systemFontOfSize:15];
//        [_guanzhuButton setImage:[UIImage imageNamed:@"icon-star"] forState:UIControlStateNormal];
        [_headImageView addSubview:_guanzhuButton];
    }
    return _headImageView;
}
#pragma make ------ UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if(!_dataDic){
            return 0;
        }else {
            NSString *reality = [NSString stringWithFormat:@"%@",self.dataDic[@"reality"]];
            int HH = [reality intValue];
            if (HH == 1) {
                return 1;
            }else {
                return 0;
            }
        }
    }else if (section == 1){
        if(!_dataDic){
            return 0;
        }else {
            int KK = 0;
            NSString *gk_img_count = [NSString stringWithFormat:@"%@",self.dataDic[@"gk_img_count"]];
            int HH = [gk_img_count intValue];
            if (HH == 0) {
                KK = KK + 1;
            }else {
                KK = KK + 1;
            }
            NSString *sm_video_count = [NSString stringWithFormat:@"%@",self.dataDic[@"sm_video_count"]];
            int HHT = [sm_video_count intValue];
            if (HHT == 0) {
                KK = KK + 1;
            }else {
                KK = KK + 1;
            }
            return KK;
        }
//        return 2;
    }else if (section == 2){
        return 1;
    }else {
        return 9;
        
    }
}


    

    

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        FourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTableViewCell" forIndexPath:indexPath];
        cell.nameLabel.text = @"真人认证";
        cell.neiLabel.text = @"已认证";
        //        NSString *mobST = [NSString stringWithFormat:@"%@",self.dataDic[@"mob"]];
        //        cell.neiLabel.text = mobST;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0){
//            if (self.tuImageArray.count > 0) {
                MianImageAllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MianImageAllTableViewCell" forIndexPath:indexPath];
                cell.dataMutableArray = self.tuImageArray;
                cell.xiantuimageArray = self.xiantuImageArray;
                cell.superVC = self;
                cell.dataDic = self.dataDic;
                cell.UID = self.UID;
            cell.tyst = @"个人相册";
            if (self.tuImageArray.count == 0) {
                cell.hengButton.hidden = YES;
                cell.wenziLabel.text = @"个人相册";
                cell.suzilabel.text = @"";
            }else {
                cell.hengButton.hidden = NO;

                [cell.hengButton addTarget:self action:@selector(addhengButton:) forControlEvents:UIControlEventTouchUpInside];
                cell.wenziLabel.text = @"个人相册";
                NSString *str = [NSString stringWithFormat:@"%@",self.dataDic[@"gk_img_count"]];
                cell.suzilabel.text = str;
                
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
                
//            }else {
//                MianImageAllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MianImageAllTableViewCell" forIndexPath:indexPath];
//                cell.dataMutableArray = self.viodArray;
//                cell.superVC = self;
//                cell.dataDic = self.dataDic;
//                cell.UID = self.UID;
//                [cell.hengButton addTarget:self action:@selector(addhengButton:) forControlEvents:UIControlEventTouchUpInside];
//                cell.wenziLabel.text = @"个人相册";
//                NSString *str = [NSString stringWithFormat:@"%@",self.dataDic[@"sm_video_count"]];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.suzilabel.text = str;
//                return cell;
//            }
            

        }else {
            MianImageAllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MianImageAllTableViewCell" forIndexPath:indexPath];
            cell.dataMutableArray = self.viodArray;
            cell.superVC = self;
            cell.dataDic = self.dataDic;
            cell.UID = self.UID;
            cell.tyst = @"个人视频";

            [cell.hengButton addTarget:self action:@selector(addhengButton:) forControlEvents:UIControlEventTouchUpInside];
            if (self.viodArray.count == 0) {
                cell.wenziLabel.text = @"个人视频";
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.hengButton.hidden = YES;
                
                cell.suzilabel.text = @"";
            }else {
                cell.hengButton.hidden = NO;

                cell.wenziLabel.text = @"个人视频";
                NSString *str = [NSString stringWithFormat:@"%@",self.dataDic[@"sm_video_count"]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.suzilabel.text = str;
                
            }
            
          
            return cell;
            
        }
        
    }else if (indexPath.section == 2){
        MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTableViewCell" forIndexPath:indexPath];
        cell.nameLabel.text = @"礼物";
        NSString *mobST = [NSString stringWithFormat:@"%@",self.dataDic[@"sumgift"]];
        cell.neiLabel.text = mobST;
        cell.neiLabel.textColor = hong;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }else {
        if (indexPath.row == 0){
            MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTableViewCell" forIndexPath:indexPath];
            cell.nameLabel.text = @"手机号码";
            NSString *mobST = [NSString stringWithFormat:@"%@",self.dataDic[@"mob"]];
            cell.neiLabel.text = mobST;
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
            
        }else if(indexPath.row == 1){
            MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTableViewCell" forIndexPath:indexPath];
            cell.nameLabel.text = @"微信号码";
            cell.neiLabel.text = self.dataDic[@"weixin"];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }else {
            FourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FourTableViewCell" forIndexPath:indexPath];
            
            if(indexPath.row == 2){
                cell.nameLabel.text = @"交友目的";
                cell.neiLabel.text = self.dataDic[@"mudi"];
            }else if(indexPath.row == 3){
                cell.nameLabel.text = @"对情感的态度";
                cell.neiLabel.text = self.dataDic[@"attitude"];
            }else if(indexPath.row == 4){
                cell.nameLabel.text = @"婚姻状况";
                cell.neiLabel.text = self.dataDic[@"marriage"];
            }else if(indexPath.row == 5){
                cell.nameLabel.text = @"内心独白";
                if ([self.dataDic[@"monolog"] isEqual:[NSNull null]]) {
                    
                }else {
                    cell.neiLabel.text = self.dataDic[@"monolog"];
                }
                
            }else  if (indexPath.row == 6) {
                cell.nameLabel.text = @"Ta的粉丝";
                NSString *fansmum = [NSString stringWithFormat:@"%@",self.dataDic[@"fansmum"]];
                cell.neiLabel.text = fansmum;
            }else if(indexPath.row == 7){
                cell.nameLabel.text = @"关注的人";
                NSString *gzString = [NSString stringWithFormat:@"%@",self.dataDic[@"gznum"]];
                cell.neiLabel.text = gzString;
            }else if(indexPath.row == 8){
                cell.nameLabel.text = @"送礼";
                NSString *sendnum = [NSString stringWithFormat:@"%@",self.dataDic[@"sendnum"]];
                cell.neiLabel.text = sendnum;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }

        
    }
  
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            NSArray *gima = self.dataDic[@"gk_img"];
            NSUInteger JJ = 0;
            if (gima.count == 0) {
                JJ = 1;
            }else {
                JJ = gima.count;
            }
            
            CGFloat KK = 0.0;
            if (JJ > 0) {
                int LL = (kScreen_w - 26)/4 - 0.5 ;
                int A = JJ % 4;
                float B = JJ / 4;
                int C = (int)B;
                if (A == 0) {
                    KK = C * LL + 40;
                }else {
                    KK = (C + 1) * LL + 40;
                }
                
            }else {
                NSArray *viod = self.dataDic[@"sm_video"];
                int KK = 0;
                int LL = (kScreen_w - 40)/4 ;
                int A = viod.count % 4;
                float B = viod.count / 4;
                int C = (int)B;
                if (A == 0) {
                    KK = C * LL + 50;
                }else {
                    KK = (C + 1) * LL + 50;
                }
            }
            return KK;

            
        }else {
            NSArray *viod = self.dataDic[@"sm_video"];
            NSUInteger JJ = 0;
            if (viod.count == 0) {
                JJ = 1;
            }else {
                JJ = viod.count;
            }
            
            int KK = 0;
            int LL = (kScreen_w - 26)/4 - 0.5;
            int A = JJ % 4;
            float B = JJ / 4;
            int C = (int)B;
            if (A == 0) {
                KK = C * LL + 40;
            }else {
                KK = (C + 1) * LL + 40;
            }
            return KK;

            
        }
    }else {
        return 50;
        
    }

}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else {
        return 10;
        
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2){
        
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        
        self.tabBarController.tabBar.hidden = NO;
        GiftViewController *GiftView = [[GiftViewController alloc]init];
        GiftView.uid = self.UID;
        [self.navigationController pushViewController:GiftView animated:nil];
    }else if (indexPath.section == 3){
        NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
        NSString *user_renk = [defatults objectForKey:user_rankVIP];
        int userIn = [user_renk intValue];
        if (userIn == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"你现在还不是VIP，不能查看，是否充值！" message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *seqing = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                
            }];
            UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"去充值" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                MyChongViewController *mychong = [[MyChongViewController alloc]init];
                UINavigationController *mychongNVC =[[UINavigationController alloc]initWithRootViewController:mychong];
                [self showViewController:mychongNVC sender:nil];
                //                [self presentViewController:mychongNVC animated:YES completion:nil];
                
            }];
            [alert addAction:seqing];
            [alert addAction:quxiao];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
    }


}
#pragma mark -- 关注
- (void)addguanzhu:(UIButton *)sender{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    
    NSString *stURL = [NSString stringWithFormat:@"%@%@",AppURL,API_guanzhu];
    NSDictionary *dic = @{@"fromuid":uidS,@"touid":self.UID};
    [HttpUtils postRequestWithURL:stURL withParameters:dic withResult:^(id result) {
        [_guanzhuButton setBackgroundImage:[UIImage imageNamed:@"icon-concerned"] forState:UIControlStateNormal];
//        [_guanzhuButton setTitle:@"已关注" forState:UIControlStateNormal];
        [self mbhudtui:@"关注成功" numbertime:1];

        
    } withError:^(NSString *msg, NSError *error) {
        [self mbhudtui:msg numbertime:1];

    }];

}
#pragma mark -- 上部的按钮

- (void)AddBack:(UIButton *)sender{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    self.tabBarController.tabBar.hidden = NO;
    //    [self.navigationController popViewControllerAnimated:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//三个点
- (void)addsanButton:(UIButton *)sender{
    UIAlertController *albel = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *fenxiang = [UIAlertAction actionWithTitle:@"分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self addFenButton];
    }];
    
    UIAlertAction *pai = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self AddjubaoView];
    }];
    NSString *laSt = @"";
    int islhin = [self.islh intValue];
    if (islhin == 0) {
        laSt = @"拉黑";
    }else {
        laSt = @"取消拉黑";
    }
    
    
    
    UIAlertAction *cong = [UIAlertAction actionWithTitle:laSt style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (islhin == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认要拉黑对方吗" message:@"拉黑将取消对方的关注且无法私信" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *quxiaoAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                
            }];
            
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定拉黑" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                //l拉黑
                [self laheiData];
                
            }];
            
            [alert addAction:quxiaoAction];
            [alert addAction:otherAction];
            
            [self presentViewController:alert animated:YES completion:nil];

        }else {
            [self laheiData];

        }
        
        
    }];
    [albel addAction:quxiao];
    [albel addAction:fenxiang];
    [albel addAction:pai];
    [albel addAction:cong];
    [self presentViewController:albel animated:YES completion:nil];
    
}

- (void)AddjubaoView{
    self.qunaView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_w, kScreen_h)];
    _qunaView.backgroundColor = [UIColor blackColor];
    _qunaView.alpha = 0.3;
    [self.view addSubview:_qunaView];
    //创建手势对象
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self     action:@selector(tapAction)];
    //讲手势添加到指定的视图上
    [_qunaView addGestureRecognizer:tap];
    
    self.jubaoView = [[UIView alloc]init];
    _jubaoView.frame = CGRectMake(kScreen_w / 2 - 143, kScreen_h / 2 - 163, 286, 300);
    _jubaoView.backgroundColor = ViewRGB;
    _jubaoView.layer.cornerRadius = 5;
    _jubaoView.layer.masksToBounds = YES;
    [self.view addSubview:_jubaoView];
    
    
    UILabel *jubao = [[UILabel alloc]init];
    jubao.frame = CGRectMake(0, 10, 296, 20);
    jubao.text = @"举报";
    jubao.textAlignment = NSTextAlignmentCenter;
    [_jubaoView addSubview:jubao];
    
    UIButton *XButton = [[UIButton alloc]init];
    [XButton setTitle:@"X" forState:UIControlStateNormal];
    XButton.frame = CGRectMake(236, 0, 60, 40);
    [XButton addTarget:self action:@selector(addXButton:) forControlEvents:UIControlEventTouchUpInside];
    [XButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    XButton.alpha = 0.3;
    [_jubaoView addSubview:XButton];
    
    UILabel *typeLaebl = [[UILabel alloc]init];
    typeLaebl.text = @"举报类型";
    typeLaebl.frame = CGRectMake(10, 30, 286 - 20, 20);
    typeLaebl.font = [UIFont systemFontOfSize:15];
    [_jubaoView addSubview:typeLaebl];
    
    self.typeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _typeButton.frame = CGRectMake(10, 60, 286 - 20, 30);
    
    [_typeButton setTitle:@"请选着举报类型" forState:UIControlStateNormal];
    [_typeButton addTarget:self action:@selector(addtyprButotn:) forControlEvents:UIControlEventTouchUpInside];
    _typeButton.layer.masksToBounds = YES;
    _typeButton.layer.cornerRadius = 15.0;
    _typeButton.layer.borderWidth = 1.0;
    _typeButton.layer.borderColor = [UIColor grayColor].CGColor;
    _typeButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_typeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_jubaoView addSubview:_typeButton];
    
    UIButton *tubiao = [UIButton buttonWithType:UIButtonTypeSystem];
    tubiao.frame = CGRectMake(286 - 38, 70, 14, 8);
    [tubiao setBackgroundImage:[UIImage imageNamed:@"arrow_down_28.149732620321px_1157526_easyicon.net"] forState:UIControlStateNormal];
    [_jubaoView addSubview:tubiao];
    
    
    
    
    UILabel *yuanLabel= [[UILabel alloc]init];
    yuanLabel.text = @"举报原因";
    yuanLabel.frame = CGRectMake(10, 100, 80, 20);
    yuanLabel.font = [UIFont systemFontOfSize:15];
    [_jubaoView addSubview:yuanLabel];
    
    self.textView =[[UITextView  alloc]init];
    self.textView.frame = CGRectMake(10, 126, 286 - 20, 90);
    [_jubaoView addSubview:self.textView];
    
    UILabel *tiLabel = [[UILabel alloc]init];
    tiLabel.frame = CGRectMake(10, 220, 286 - 20, 16);
    tiLabel.text = @"温馨提示:请输入举报描述，不能超过30个字符";
    tiLabel.font = [UIFont systemFontOfSize:12];
    tiLabel.alpha = 0.6;
    [_jubaoView addSubview:tiLabel];
    
    
    UIButton *queButton = [[UIButton alloc]init];
    queButton.frame =CGRectMake(10, 250, 286 - 20, 40);
    queButton.backgroundColor = hong;
    [queButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [queButton setTitle:@"提交举报" forState:UIControlStateNormal];
    [queButton addTarget:self action:@selector(addqueButton:) forControlEvents:UIControlEventTouchUpInside];
    queButton.layer.cornerRadius = 20;
    queButton.layer.masksToBounds = YES;
    [_jubaoView addSubview:queButton];
    
    
}
- (void)addXButton:(UIButton *)sender{
    [self.jubaoView removeFromSuperview];
    [self.qunaView removeFromSuperview];
}
- (void)tapAction{
    [self.jubaoView removeFromSuperview];
    [self.qunaView removeFromSuperview];
}

//举报类型
- (void)addtyprButotn:(UIButton *)sender{
    UIAlertController *albel = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *pai = [UIAlertAction actionWithTitle:@"色情" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.jutype = @"色情";
        [self.typeButton setTitle:self.jutype forState:UIControlStateNormal];
        
    }];
    UIAlertAction *cong = [UIAlertAction actionWithTitle:@"政治敏感" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.jutype = @"政治敏感";
        [self.typeButton setTitle:self.jutype forState:UIControlStateNormal];
        
    }];
    UIAlertAction *weicong = [UIAlertAction actionWithTitle:@"违法" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.jutype = @"违法";
        [self.typeButton setTitle:self.jutype forState:UIControlStateNormal];
        
        
    }];
    UIAlertAction *guancong = [UIAlertAction actionWithTitle:@"广告骚扰" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.jutype = @"广告骚扰";
        [self.typeButton setTitle:self.jutype forState:UIControlStateNormal];
        
        
    }];
    [albel addAction:quxiao];
    [albel addAction:pai];
    [albel addAction:cong];
    [albel addAction:weicong];
    [albel addAction:guancong];
    [self presentViewController:albel animated:YES completion:nil];
    
}
- (void)addqueButton:(UIButton *)sender{
    [self.jubaoView removeFromSuperview];
    [self.qunaView removeFromSuperview];
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    
    NSString *stURL = [NSString stringWithFormat:@"%@%@",AppURL,API_Report];
    NSDictionary *dic = @{@"fromuid":uidS,@"touid":self.UID,@"type":self.jutype,@"jbdesc":self.textView.text};
    [HttpUtils postRequestWithURL:stURL withParameters:dic withResult:^(id result) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:result[@"msg"] preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            
        }];
        
        
        [alert addAction:otherAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
    } withError:^(NSString *msg, NSError *error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            
            
        }];
        
        
        [alert addAction:otherAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }];
    
    
}
//拉黑
- (void)laheiData{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    
    NSString *stURL = [NSString stringWithFormat:@"%@%@",AppURL,API_lahei];
    NSDictionary *dic = @{@"fromuid":uidS,@"touid":self.UID};
    [HttpUtils postRequestWithURL:stURL withParameters:dic withResult:^(id result) {
        int islhin = [self.islh intValue];
        if (islhin == 0) {
            [self mbhudtui:@"拉黑成功" numbertime:1];
            self.islh = @"1";
        }else {
            [self mbhudtui:@"取消拉黑" numbertime:1];
            self.islh = @"0";
        }
        
        
        
    } withError:^(NSString *msg, NSError *error) {
        [self mbhudtui:msg numbertime:1];

    }];
    
    
}

//点击事件 更多
- (void)addhengButton:(UIButton *)sender{
    UITableViewCell *cell = (UITableViewCell *)[[sender superview] superview];//获取cell
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];//获取
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *user_renk = [defatults objectForKey:user_rankVIP];
    int userIn = [user_renk intValue];
    if (userIn == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"你现在还不是VIP，不能查看，是否充值！" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *seqing = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"去充值" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            MyChongViewController *mychong = [[MyChongViewController alloc]init];
            UINavigationController *mychongNVC =[[UINavigationController alloc]initWithRootViewController:mychong];
            
            [self showViewController:mychongNVC sender:nil];
            //                [self presentViewController:mychongNVC animated:YES completion:nil];
            
        }];
        [alert addAction:seqing];
        [alert addAction:quxiao];
        
        [self presentViewController:alert animated:YES completion:nil];
    }else {
        if (indexPath.row == 0) {
            if (self.tuImageArray.count == 0) {
                [self.navigationController setNavigationBarHidden:NO animated:YES];
                ShiImaViewController *imageListView = [[ShiImaViewController alloc]init];
                imageListView.UID = self.UID;
                [self.navigationController pushViewController:imageListView animated:nil];
                
                
            }else {
                [self.navigationController setNavigationBarHidden:NO animated:YES];
                SiimaViewController *imageListView = [[SiimaViewController alloc]init];
                imageListView.UID = self.UID;
                [self.navigationController pushViewController:imageListView animated:nil];
            }
            
        }else {
            [self.navigationController setNavigationBarHidden:NO animated:YES];
            ShiImaViewController *imageListView = [[ShiImaViewController alloc]init];
            imageListView.UID = self.UID;
            [self.navigationController pushViewController:imageListView animated:nil];
            
            
        }

    }

}

   



#pragma mark - 视图出现时机
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    self.tabBarController.tabBar.hidden = YES;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

////分享
- (void)fengxiangData{
  
    
    
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_MY_share];
    NSDictionary *dic = @{@"uid":uidS};
    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
        self.fenDic = result[@"data"];
        
    } withError:^(NSString *msg, NSError *error) {
        
        
    }];
    
    
}
//分享
- (void)addFenButton{
    if (_fenDic == nil) {
        [self mbhudtui:@"分享失败" numbertime:1];
    }else {
    
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    
    
    NSArray* imageArray = @[self.fenDic[@"icon"]];
    [shareParams SSDKSetupShareParamsByText:self.fenDic[@"desc"]
                                     images:imageArray
                                        url:[NSURL URLWithString:self.fenDic[@"url"]]
                                      title:self.fenDic[@"title"]
                                       type:SSDKContentTypeAuto];
    //优先使用平台客户端分享
    [shareParams SSDKEnableUseClientShare];
    //设置微博使用高级接口
    //2017年6月30日后需申请高级权限
    //    [shareParams SSDKEnableAdvancedInterfaceShare];
    //设置显示平台 只能分享视频的YouTube MeiPai 不显示
    NSArray *items = @[
                       @(SSDKPlatformTypeQQ),
                       @(SSDKPlatformTypeWechat),
                       @(SSDKPlatformTypeSinaWeibo)
                       ];
    
    [ShareSDK showShareActionSheet:self.view
                             items:items
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state) {
                           
                       case SSDKResponseStateBegin:
                       {
                           //设置UI等操作
                           break;
                       }
                       case SSDKResponseStateSuccess:
                       {
                           //Instagram、Line等平台捕获不到分享成功或失败的状态，最合适的方式就是对这些平台区别对待
                           if (platformType == SSDKPlatformTypeInstagram)
                           {
                               break;
                           }
                           
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                           message:[NSString stringWithFormat:@"%@",error]
                                                                          delegate:nil
                                                                 cancelButtonTitle:@"OK"
                                                                 otherButtonTitles:nil, nil];
                           [alert show];
                           break;
                       }
                       case SSDKResponseStateCancel:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       default:
                           break;
                   }
               }];
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

//
//  VideoPlaybackViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/5/9.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "VideoPlaybackViewController.h"
#import "IntroduceTableViewCell.h"
#import "GiftNumberTableViewCell.h"
#import "GiftTableViewCell.h"
#import "CommentsTableViewCell.h"
#import "EvaluationModel.h"
#import "ChatViewController.h"
#import "GiftView.h"
#import "TopUpTwoView.h"
#import "GoldTwoView.h"
#import "ZGLVideoPlyer.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "MainXiuViewController.h"
@interface VideoPlaybackViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *tabelView;
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSDictionary *dataDic;

//@property (strong,nonatomic)AVPlayer * player;
@property (strong,nonatomic)AVPlayerItem * playerItem;
@property (strong,nonatomic)UILabel * testlab;

@property (nonatomic, strong)UIView *teView;
@property (nonatomic, strong)UITextField *pingTextField;
@property (nonatomic, strong)UIView *jubaoView;
@property (nonatomic, strong)UIView *qunaView;
@property (nonatomic, strong)UITextView *textView;
@property (nonatomic, copy) NSString *jutype;
@property (nonatomic, strong)GiftView *liView;
@property (nonatomic, strong)TopUpTwoView *TUpView;
@property (nonatomic, strong)GoldTwoView *golView;

@property (nonatomic, strong) ZGLVideoPlyer *player;
@property (nonatomic, copy)NSString *guanString;

@property (nonatomic, strong)UIView *BViewLi;
@property (nonatomic, strong)UIButton *typeButton;
@property (nonatomic, strong)NSDictionary *fenDic;



@end

@implementation VideoPlaybackViewController
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.guanString = @"";
    [self addtabelView];
    [self requestListData];
    [self dibuView];
    [self addCent];
    [self fengxiangData];
}
//底部视图
- (void)dibuView{
    UIView *duView = [[UIView alloc]init];
    duView.frame = CGRectMake(0, kScreen_h - 54, kScreen_w, 54);
    duView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:duView];
    UILabel *xianLabel = [[UILabel alloc]init];
    xianLabel.frame = CGRectMake(0, 0, kScreen_w, 1);
    xianLabel.backgroundColor = [UIColor blackColor];
    xianLabel.alpha = 0.1;
    [duView addSubview:xianLabel];
    
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *uidS = [defatults objectForKey:uidSG];
    
    
    if ([uidS isEqualToString:@"257555"]) {
        
    }else {
        
        UIButton *liButton = [[UIButton alloc]init];
        liButton.frame = CGRectMake(kScreen_w/3/2 - 50, 15, 100, 30);
        [liButton setImage:[UIImage imageNamed:@"形状30"] forState:UIControlStateNormal];
        [liButton setTitle:@"礼物" forState:UIControlStateNormal];
        [liButton setTitleColor:[UIColor colorWithRed:240.0/255.0 green:0/255.0 blue:94.0/255.0 alpha:1] forState:UIControlStateNormal];
        [liButton addTarget:self action:@selector(addLiwu:) forControlEvents:UIControlEventTouchUpInside];
        [duView addSubview:liButton];
    }
    

    
    UIButton *guanButton = [[UIButton alloc]init];
    guanButton.frame = CGRectMake(kScreen_w/3 + kScreen_w/3/2 - 50, 15, 100, 30);
    [guanButton setImage:[UIImage imageNamed:@"形状3"] forState:UIControlStateNormal];
    [guanButton setTitle:@"评价" forState:UIControlStateNormal];
    [guanButton setTitleColor:[UIColor colorWithRed:240.0/255.0 green:0/255.0 blue:94.0/255.0 alpha:1] forState:UIControlStateNormal];
    [guanButton addTarget:self action:@selector(addguanzhuButton:) forControlEvents:UIControlEventTouchUpInside];
    [duView addSubview:guanButton];
    
    UIButton *sixinButton = [[UIButton alloc]init];
    sixinButton.frame = CGRectMake(kScreen_w/3*2 + kScreen_w/3/2 - 50, 15, 100, 30);
    [sixinButton setImage:[UIImage imageNamed:@"形状3"] forState:UIControlStateNormal];
    [sixinButton setTitle:@"私信" forState:UIControlStateNormal];
    [sixinButton setTitleColor:[UIColor colorWithRed:240.0/255.0 green:0/255.0 blue:94.0/255.0 alpha:1] forState:UIControlStateNormal];
    [sixinButton addTarget:self action:@selector(addsixinButton:) forControlEvents:    UIControlEventTouchUpInside];
    [duView addSubview:sixinButton];
    
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
    
    UIAlertAction *cong = [UIAlertAction actionWithTitle:@"拉黑" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认要拉黑对方吗" message:@"拉黑将取消对方的关注且无法私信" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定拉黑" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            //l拉黑
            [self laheiData];
            
        }];
        
        
        [alert addAction:otherAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }];
    [albel addAction:quxiao];
    [albel addAction:fenxiang];
    [albel addAction:pai];
    [albel addAction:cong];
    [self presentViewController:albel animated:YES completion:nil];

}

//
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
    _jubaoView.frame = CGRectMake(kScreen_w / 2 - 143, kScreen_h / 2 - 163, 286, 260);
    _jubaoView.backgroundColor = ViewRGB;
    _jubaoView.layer.cornerRadius = 5;
    _jubaoView.layer.masksToBounds = YES;
    [self.view addSubview:_jubaoView];
    
    
    UILabel *jubao = [[UILabel alloc]init];
    jubao.frame = CGRectMake(0, 0, 296, 20);
    jubao.text = @"举报";
    jubao.textAlignment = NSTextAlignmentCenter;
    [_jubaoView addSubview:jubao];
    
    UIButton *XButton = [[UIButton alloc]init];
    [XButton setTitle:@"X" forState:UIControlStateNormal];
    XButton.frame = CGRectMake(296 - 50, 0, 50, 50);
    [XButton addTarget:self action:@selector(addXButton:) forControlEvents:UIControlEventTouchUpInside];
    [_jubaoView addSubview:XButton];
    
    UILabel *typeLaebl = [[UILabel alloc]init];
    typeLaebl.text = @"举报类型";
    typeLaebl.frame = CGRectMake(10, 20, 286 - 20, 20);
    [_jubaoView addSubview:typeLaebl];
    
    self.typeButton = [[UIButton alloc]init];
    _typeButton.frame = CGRectMake(10, 40, 286 - 20, 30);
    _typeButton.layer.cornerRadius = 15;
    _typeButton.layer.masksToBounds = YES;
    [_typeButton setTitle:@"请选着举报类型" forState:UIControlStateNormal];
    [_typeButton addTarget:self action:@selector(addtyprButotn:) forControlEvents:UIControlEventTouchUpInside];
    _typeButton.layer.masksToBounds = YES;
    _typeButton.layer.cornerRadius = 5.0;
    _typeButton.layer.borderWidth = 1.0;
    _typeButton.layer.borderColor = [UIColor grayColor].CGColor;
    [_typeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_jubaoView addSubview:_typeButton];
    
    UILabel *yuanLabel= [[UILabel alloc]init];
    yuanLabel.text = @"举报原因";
    yuanLabel.frame = CGRectMake(10, 85, 286 - 20, 20);
    [_jubaoView addSubview:yuanLabel];
    
    self.textView =[[UITextView  alloc]init];
    self.textView.frame = CGRectMake(10, 110, 286 - 20, 90);
    [_jubaoView addSubview:self.textView];
    
    UIButton *queButton = [[UIButton alloc]init];
    queButton.frame =CGRectMake(10, 210, 286 - 20, 40);
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


#pragma mark -- 布局
- (void)addtabelView{
    self.tabelView = [[UITableView alloc]init];
    _tabelView.frame = CGRectMake(0, 0, kScreen_w, kScreen_h - 64);
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    
    UIView *View = [[UIView alloc]init];
    View.frame = CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, kScreen_w / 3 * 4);
    UIImageView *image = [[UIImageView alloc]init];
    [image sd_setImageWithURL:[NSURL URLWithString:self.mp4imag] placeholderImage:[UIImage imageNamed:zhantuImage]];
    image.frame = CGRectMake(0, 0, kScreen_w, kScreen_w / 3 * 4);
    [View addSubview:image];
    
    self.player = [[ZGLVideoPlyer alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kScreen_w / 3 * 4)];
    
    self.player.videoUrlStr = self.mp4;
    [View addSubview:self.player];
    _tabelView.tableHeaderView = View;

    [self.tabelView registerNib:[UINib nibWithNibName:@"IntroduceTableViewCell" bundle:nil] forCellReuseIdentifier:@"IntroduceTableViewCell"];
    [self.tabelView registerNib:[UINib nibWithNibName:@"GiftNumberTableViewCell" bundle:nil] forCellReuseIdentifier:@"GiftNumberTableViewCell"];
    
    [self.tabelView registerNib:[UINib nibWithNibName:@"GiftTableViewCell" bundle:nil] forCellReuseIdentifier:@"GiftTableViewCell"];
    [self.tabelView registerNib:[UINib nibWithNibName:@"CommentsTableViewCell" bundle:nil] forCellReuseIdentifier:@"CommentsTableViewCell"];
    
    
    
    [self.view addSubview:_tabelView];
}



#pragma mark - 下拉刷新 上拉加载
- (void)refreshData {
    self.page = 1;
    [self.tabelView.mj_footer endRefreshing];
    [self requestListData];
}

- (void)loadData {
    self.page ++ ;
    [self.tabelView.mj_header endRefreshing];
    [self requestListData];
}


#pragma make ------ UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return 2;
    }else {
        return self.dataArray.count + 1;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        IntroduceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IntroduceTableViewCell" forIndexPath:indexPath];

       
        [cell.toimageView sd_setImageWithURL:[NSURL URLWithString:self.dataDic[@"avatar"]]  placeholderImage:[UIImage imageNamed:zhanImage]];
        [cell.imaButton addTarget:self action:@selector(addimaButton:) forControlEvents:UIControlEventTouchUpInside];

        
        cell.nameLabel.text = self.dataDic[@"user_nicename"];
        cell.neiLabel.text = self.dataDic[@"title"];
        NSString *str = [HelperClass timeStampIsConvertedToTime:self.dataDic[@"timeline"] formatter:@"yyyy-MM-dd HH:mm:ss"];
        cell.timeLabel.text = str;
        if ([self.guanString isEqualToString:@""]) {
            if (self.dataDic == nil) {
                self.guanString = @"";
            }else {
                self.guanString = [NSString stringWithFormat:@"%@",self.dataDic[@"isgz"]];

            }
            
        }
        if ([self.guanString isEqualToString:@"1"]) {
            [cell.gaunzhuButton setTitle:@"已关注" forState:UIControlStateNormal];
        }else {
            [cell.gaunzhuButton setTitle:@"未关注" forState:UIControlStateNormal];
            [cell.gaunzhuButton addTarget:self action:@selector(addgaunzhuButton:) forControlEvents:UIControlEventTouchUpInside];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            GiftNumberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GiftNumberTableViewCell" forIndexPath:indexPath];
            NSString *string = [NSString stringWithFormat:@"收到礼物%@",self.dataDic[@"sumgift"]];
            cell.nameLabel.text = string;
            return cell;
        }else {
            NSArray *Array = self.dataDic[@"giftlist"];
            GiftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GiftTableViewCell" forIndexPath:indexPath];
            if (Array.count ==  0) {
                }else  {
                for (NSDictionary *dci in Array) {
                    [cell.oneImagView sd_setImageWithURL:[NSURL URLWithString:dci[@"gift_image"]] placeholderImage:[UIImage imageNamed:zhanImage]];
                    [cell.oneTImageView sd_setImageWithURL:[NSURL URLWithString:dci[@"fromer"]] placeholderImage:[UIImage imageNamed:zhantuImage]];
                }
                
            }
            return cell;
            
        }
    }else {
        if (indexPath.row == 0) {
            GiftNumberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GiftNumberTableViewCell" forIndexPath:indexPath];
            NSString *string = [NSString stringWithFormat:@"评价 %@",self.dataDic[@"comment"]];
            cell.nameLabel.text = string;
            return cell;
        }else {
            EvaluationModel *model = self.dataArray[indexPath.row - 1];
            CommentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentsTableViewCell" forIndexPath:indexPath];
            [cell.tuimageview sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:zhantuImage]];
            cell.nameLabel.text = model.user_nicename;
            cell.neiLaebl.text = model.content;
            if ([model.user_rank isEqualToString:@"1"]) {
                cell.VIBButton.hidden = 0;
            }else {
                cell.VIBButton.hidden = 1;
            }
            cell.timeLabel.text = model.time;

            return cell;
            
        }
        
    }
}





//头像点击
- (void)addimaButton:(UIButton *)sender{
//    self.player.hidden = YES;
//    self.player = nil;
    [self.player pause];
//    [self.player removeFromSuperview];
    
    MainXiuViewController *MainView = [[MainXiuViewController alloc]init];
    MainView.name = self.dataDic[@"user_nicename"];
    MainView.UID = self.dataDic[@"uid"];
    UINavigationController *tgirNVC = [[UINavigationController alloc]initWithRootViewController:MainView];
    
    [self showViewController:tgirNVC sender:nil];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CGFloat content_h = [HelperClass calculationHeightWithTextsize:15.0 LabelWidth:kScreen_w - 80 WithText:self.dataDic[@"title"] LineSpacing:0];
        return content_h + 115;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            return 52;
        }else {
           NSArray *Array = self.dataDic[@"giftlist"];
            if (Array.count == 0) {
                return 0;
            }else {
                return 110;

            }
        }
        
    }else {
        if (indexPath.row == 0) {
            return 52;
        }else {
            if (self.dataArray.count == 0){
                return 0;
            }else {
                return 70;

            }
            
        }
        
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
    
}


#pragma mark ------- 获取数据
- (void)requestListData{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_photohead];
    NSDictionary *dic = @{@"uid":uidS,@"photoid":self.photoid};
    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
        self.dataDic = result[@"data"];

        [self requestListevaluationData];
        //        [self.tabelView reloadData];
        //        if (self.page == 1) [self.tabelView.mj_header endRefreshing];
        //        if (self.page != 1) [self.tabelView.mj_footer endRefreshing];
    } withError:^(NSString *msg, NSError *error) {
        if (self.page == 1) [self.tabelView.mj_header endRefreshing];
        if (self.page != 1) [self.tabelView.mj_footer endRefreshing];
        
    }];
    
    
}
//评价
- (void)requestListevaluationData{
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_commentList];
    NSString *string = [NSString stringWithFormat:@"%ld",(long)self.page];
    NSDictionary *dic = @{@"photoid":self.photoid,@"p":string};
    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
        if (self.page == 1) {
            [self.dataArray removeAllObjects];
        }
        NSArray *array = result[@"data"];
        for (NSDictionary *dic in array) {
            EvaluationModel *model = [[EvaluationModel alloc]initWithDictionary:dic error:nil];
            [self.dataArray addObject:model];
        }
        [self.tabelView reloadData];
        if (self.page == 1) [self.tabelView.mj_header endRefreshing];
        if (self.page != 1) [self.tabelView.mj_footer endRefreshing];
    } withError:^(NSString *msg, NSError *error) {
        if (self.page == 1) [self.tabelView.mj_header endRefreshing];
        if (self.page != 1) [self.tabelView.mj_footer endRefreshing];
        
    }];
    
    
    
}

#pragma mark -- 按钮点击事件
- (void)addsixinButton:(UIButton *)sender{
    [self.player pause];
    
    ChatViewController *ChatView = [[ChatViewController alloc]init];
    ChatView.TOID = self.UID;
    ChatView.name = self.name;
    UINavigationController *ChatViewNVC = [[UINavigationController alloc]initWithRootViewController:ChatView];
    
    [self showViewController:ChatViewNVC sender:nil];
}
//礼物
- (void)addLiwu:(UIButton *)sender{
    if (!_liView) {
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
        //升级VIP
        [_liView.shenjiButton addTarget:self action:@selector(addShenjiButton:) forControlEvents:UIControlEventTouchUpInside];
        [_liView.chpngbutton addTarget:self action:@selector(addchpngbutton:) forControlEvents:UIControlEventTouchUpInside];
        _liView.backgroundColor = ViewRGB;
        _liView.frame = CGRectMake(0, kScreen_h - 370, kScreen_w, 370);
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


- (void)addchpngbutton:(UIButton *)sender
{
    [self.liView removeFromSuperview];
    self.golView = [[GoldTwoView alloc]init];
    _golView.frame = CGRectMake(kScreen_w / 2 - 150, kScreen_h / 2 - 150, 300, 300);
    _golView.backgroundColor = [UIColor whiteColor];
    _golView.layer.cornerRadius = 5;
    _golView.layer.masksToBounds = YES;
    [self.view addSubview:_golView];
    
}
- (void)addShenjiButton:(UIButton *)sender {
    [self.liView removeFromSuperview];
    self.TUpView = [[TopUpTwoView alloc]init];
    _TUpView.frame = CGRectMake(kScreen_w / 2 - 150, kScreen_h / 2 - 150, 300, 300);
    _TUpView.backgroundColor = [UIColor whiteColor];
    _TUpView.layer.cornerRadius = 5;
    _TUpView.layer.masksToBounds = YES;
    [self.view addSubview:_TUpView];

}



#pragma mark - 视图出现时机
- (void)viewWillAppear:(BOOL)animated{
    [self.player play];

    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    self.tabBarController.tabBar.hidden = YES;
    
    
}

#pragma mark - 返回
- (void)addfanhuiButton:(UIButton *)sender{
    self.player.hidden = YES;
    [self.player removeFromSuperview];

    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)AddBack:(UIButton *)sender{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    self.tabBarController.tabBar.hidden = NO;
//    [self.navigationController popViewControllerAnimated:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//关注
- (void)addguanzhuButton:(UIButton *)sender{
    self.teView = [[UIView alloc]init];
    self.teView.frame = CGRectMake(0, kScreen_h - 64, kScreen_w, 64);
    self.teView.backgroundColor = ViewRGB;
    [self.view addSubview:_teView];
    
    self.pingTextField = [[UITextField alloc]init];
    _pingTextField.frame = CGRectMake(10, 10, kScreen_w - 100, 40);
    _pingTextField.layer.cornerRadius = 20;
    _pingTextField.layer.masksToBounds = YES;
    _pingTextField.backgroundColor = [UIColor whiteColor];
    [_teView addSubview:_pingTextField];
    
    UIButton *fabutton = [[UIButton alloc]init];
    fabutton.frame = CGRectMake(kScreen_w - 70, 10, 60, 36);
    fabutton.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:64.0/255.0 blue:129.0/255.0 alpha:1];
    [fabutton addTarget:self action:@selector(addfabutton:) forControlEvents:UIControlEventTouchUpInside];
    fabutton.layer.cornerRadius = 18;
    fabutton.layer.masksToBounds = YES;
    [fabutton setTitle:@"发送" forState:UIControlStateNormal];
    [_teView addSubview:fabutton];
    
    [self addCent];

}
//评价的发送 API_comment
- (void)addfabutton:(UIButton *)sender{
    [self.view endEditing:YES];
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_comment];
    NSDictionary *dic = @{@"photoid":self.photoid,@"content":self.pingTextField.text,@"uid":uidS};
    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
        //        if (self.page == 1) {
        //            [self.dataArray removeAllObjects];
        //        }
        //        NSArray *array = result[@"data"];
        //        for (NSDictionary *dic in array) {
        //            EvaluationModel *model = [[EvaluationModel alloc]initWithDictionary:dic error:nil];
        //            [self.dataArray addObject:model];
        //        }
        [SVProgressHUD showSuccessWithStatus:@"评论成功"];
        [SVProgressHUD dismissWithDelay:1.0];
        [self refreshData];
        [self.teView removeFromSuperview];
        
    } withError:^(NSString *msg, NSError *error) {
        [SVProgressHUD showSuccessWithStatus:@"评论失败"];
        [SVProgressHUD dismissWithDelay:1.0];
    }];
    
    
    
    
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
//拉黑
- (void)laheiData{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    
    NSString *stURL = [NSString stringWithFormat:@"%@%@",AppURL,API_lahei];
    NSDictionary *dic = @{@"fromuid":uidS,@"touid":self.UID};
    [HttpUtils postRequestWithURL:stURL withParameters:dic withResult:^(id result) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"拉黑成功！" preferredStyle:UIAlertControllerStyleAlert];
        
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

#pragma Mark - 关注
- (void)addgaunzhuButton:(UIButton *)sender{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_guanzhu];
    
    NSDictionary *dic = @{@"touid":self.dataDic[@"uid"],@"fromuid":uidS};
    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
        NSString *code = result[@"code"];
        int hh = [code intValue];
        if (hh == 1) {
            self.guanString = @"1";
        }
        [SVProgressHUD showSuccessWithStatus:result[@"msg"]];
        [SVProgressHUD dismissWithDelay:1.0];
        [self.tabelView reloadData];
        
    } withError:^(NSString *msg, NSError *error) {
        [SVProgressHUD showSuccessWithStatus:msg];
        [SVProgressHUD dismissWithDelay:1.0];
    }];
    
    
}

#pragma mark -- 监听
//监听键盘状态
- (void)addCent{
    
    //弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //收起
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

//健谈将要弹出调用的方法
- (void)keyboardWillShow:(NSNotification *)aNotification{
    NSDictionary * userInFo = [aNotification userInfo];
    NSValue * aValue = [userInFo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyBoardRect = [aValue CGRectValue];
    int HH = keyBoardRect.size.height;
    //添加动画改变
    [UIView animateWithDuration:0.1 animations:^{
        [_teView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(kScreen_h-HH-58, 0, HH, 0));
        }];
        //        [_tabelView mas_updateConstraints:^(MASConstraintMaker *make) {
        //            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, _messHeight+50, 0));
        //        }];
        //告诉self.view约束改变重新计算，否则无动画
        [self.view layoutIfNeeded];
    }];
}
//键盘将要收起时调用
- (void)keyboardWillHide:(NSNotification *)aNotification{
    
    //添加动画改变
    [UIView animateWithDuration:0.1 animations:^{
        //mas_updateConstraints 更改约束的值
        [_teView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(kScreen_h-50, 0, 0, 0));
        }];
        //        [_tabelView mas_updateConstraints:^(MASConstraintMaker *make) {
        //            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 50, 0));
        //        }];
        
        //告诉self.view约束改变重新计算，否则无动画
        [self.view layoutIfNeeded];
    }];}

//table滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
    
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

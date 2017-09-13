//
//  ChatViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/5/3.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "ChatViewController.h"
#import "MessageSSModel.h"
#import "MessTxtContentTableViewCell.h"
#import "MessImageTableViewCell.h"
#import "MessVoideTableViewCell.h"
#import "MyChongTableViewCell.h"
#import "JInModel.h"
#import "MyChongModel.h"
#import <AlipaySDK/AlipaySDK.h>
#import <CommonCrypto/CommonDigest.h>
#import "WXApiObject.h"
#import "WXApi.h"
#import "GiftView.h"
#import "MainXiuViewController.h"
#import "SMKCycleScrollView.h"
#import "MyChongViewController.h"
#import "GoldTwoView.h"
#import "TopUpTwoView.h"
#import "TZImagePickerController.h"
#import "MessTiShiTableViewCell.h"
@interface ChatViewController ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate>
//顶部视图
@property (nonatomic, strong)UIButton *guanButton;
@property (nonatomic, strong)UIButton *yueButton;
@property (nonatomic, strong)UITableView *tabelView;
@property (nonatomic, strong)NSMutableArray *chudataArray;


@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UIView *BView;



//底部View
@property (nonatomic, strong)UIView *lasView;
@property(nonatomic,assign)int messHeight;//键盘高度
@property(nonatomic, strong)UIButton *yuYin;
@property(nonatomic,assign)BOOL isYuYin;//语音
@property (nonatomic,assign) BOOL switchingKeybaord;//键盘切换判断
@property(nonatomic,strong)UIView * yuView;//语音uiview
@property (strong, nonatomic) AVAudioPlayer *avPlay;//播放录制语音
@property(nonatomic,strong)UIImageView * yuYinImageView;//语音提示图片
@property(nonatomic, strong)UITextField *yuyinTextField; //语音输入框
@property(nonatomic,strong) UILabel *labelemotion;//textview文字
@property(nonatomic, strong)UIButton *liwuButton;//礼物
@property(nonatomic, strong)UIButton *fasongButton;//发送按钮
@property(nonatomic, copy)NSString *msgid;//消息ID

@property(nonatomic, strong)GiftView *liView;
//礼物
@property(nonatomic, strong)UILabel *VIPLabel;
//金额
@property(nonatomic, strong)UILabel *monyLaebel;
///全部
@property(nonatomic, strong)UIButton *quabutton;
///千以下
@property(nonatomic, strong)UIButton *qianxiaButton;
///一千
@property(nonatomic, strong)UIButton *yiqianButton;
///十万
@property(nonatomic, strong)UIButton *shiwanButton;
///VIP专享价
@property(nonatomic, strong)UILabel *zhuangxiangLabel;


//充值View
@property(nonatomic, strong)UIView *BViewLi;
@property(nonatomic, copy)NSString *tyString;
@property(nonatomic, copy)NSString *tyTableView;
@property (nonatomic, strong)NSDictionary *uinfoDic;
@property(nonatomic, strong)UITableView * zhitabelView;
@property(nonatomic, strong)UIButton *WEILButton;
@property(nonatomic, strong)UIButton *zhiButton;
@property (nonatomic, strong)NSString *qianstring;
@property (nonatomic, strong)NSDictionary *weiDic;
@property(nonatomic, strong)NSString *accountId;
@property (nonatomic, strong)NSMutableArray *dataArrayTwo;

@property (nonatomic, strong)NSString *accountTypeST;
//金币TabelView
@property (nonatomic, strong)UITableView *jinTabelView;
//加号
@property (nonatomic, strong)UIView * jiahaoView;
@property (nonatomic, strong)SMKCycleScrollView *cycleScrollView;
//微信
@property (nonatomic, copy)NSString *WXStrig;
//手机号
@property (nonatomic, copy)NSString *shouString;
//VIP
@property (nonatomic, strong)TopUpTwoView *topUpTwoView;
//秀币
@property (nonatomic, strong)GoldTwoView * goldTwoView;
@property (nonatomic, strong)UIView *BGView;
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
//图片
@property (nonatomic, strong)UIImageView *tuimagViewXIu;
//文字
@property (nonatomic, copy)NSString *wenziString;
@property(nonatomic, strong)MBProgressHUD *MBhud;



@end

@implementation ChatViewController


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


- (UIImageView *)tuimagViewXIu{
    if (!_tuimagViewXIu) {
        _tuimagViewXIu = [[UIImageView alloc]init];
    }
    return _tuimagViewXIu;
}
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}


- (UIView *)jiahaoView{
    if (!_jiahaoView) {
        _jiahaoView = [[UIView alloc]init];
        _jiahaoView.frame = CGRectMake(0, 56, kScreen_w, 90);
        
        UIButton *tuButton = [UIButton new];
        tuButton.frame = CGRectMake(30, 0, 70, 70);
        [tuButton setBackgroundImage:[UIImage imageNamed:@"icon-picture"] forState:UIControlStateNormal];
        [tuButton addTarget:self action:@selector(addtuButton:) forControlEvents:UIControlEventTouchUpInside];
        [_jiahaoView addSubview:tuButton];
        
    }
    return _jiahaoView;
}


- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
- (NSMutableArray *)dataArrayTwo{
    if (!_dataArrayTwo) {
        _dataArrayTwo = [[NSMutableArray alloc]init];
    }
    return _dataArrayTwo;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ViewRGB;
    self.msgid = @"0";


    [self configureNavigationView];
    [self addUITableView];
    [self liwuUIButton];//礼物按钮

    [self addUIView];
    
    //添加  监听键盘状态
    [self addCent];
//    GoldTwoView *view = [[GoldTwoView alloc]init];
//    view.frame = CGRectMake(kScreen_w / 2 - 140, kScreen_h / 2 - 150, 280, 300);
//    
//    [self.view addSubview:view];

    //数据请求
    [self laodData];
    [self wechat_msgData];


    
}
#pragma mark - 初始化视图
- (void)configureNavigationView {
    self.navigationItem.title = self.name;
    UIImage *leimage = [UIImage imageNamed:@"形状16"];
    UIImage *Leimage = [leimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:Leimage style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarLeftitemAction:)];
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:leftItem, nil];
    UIImage *reimage = [UIImage imageNamed:@"icon-person"];
    UIImage *Reimage = [reimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *ReftItem = [[UIBarButtonItem alloc] initWithImage:Reimage style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationrightBarButtonAction)];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:ReftItem, nil];
    
    

    UIView *tiView = [[UIView alloc]init];
    tiView.backgroundColor = [UIColor whiteColor];
    tiView.frame = CGRectMake(0, 64, kScreen_w, 35);
    [self.view addSubview:tiView];
    
    self.guanButton = [[UIButton alloc]init];
    _guanButton.frame = CGRectMake(0, 0, kScreen_w / 4 , 35);
//    [_guanButton setImage:[UIImage imageNamed:@"contacted_img"] forState:UIControlStateNormal];
    _guanButton.titleLabel.textColor = [UIColor redColor];
    [_guanButton setTitle:@"已关注" forState:UIControlStateNormal];
    [_guanButton setTitleColor:hong forState:UIControlStateNormal];
    _guanButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [tiView addSubview:_guanButton];
    
    UILabel *xianLabel = [[UILabel alloc]init];
    xianLabel.frame = CGRectMake(kScreen_w / 4 - 1, 8, 1, 20);
    xianLabel.backgroundColor = [UIColor blackColor];
    xianLabel.alpha = 0.6;
    [tiView addSubview:xianLabel];
    
    self.yueButton = [[UIButton alloc]init];
    _yueButton.frame = CGRectMake(kScreen_w / 4 , 0, kScreen_w / 4, 35);
    [_yueButton setTitle:@"秀币：" forState:UIControlStateNormal];
    _yueButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_yueButton setTitleColor:hong forState:UIControlStateNormal];
    [_yueButton addTarget:self action:@selector(addyuButton:) forControlEvents:UIControlEventTouchUpInside];
    [tiView addSubview:_yueButton];
    
    UILabel *xianLabel1 = [[UILabel alloc]init];
    xianLabel1.frame = CGRectMake(kScreen_w / 2 - 1, 8, 1, 20);
    xianLabel1.backgroundColor = [UIColor blackColor];
    xianLabel1.alpha = 0.6;
    [tiView addSubview:xianLabel1];
    
 
    
    UIButton *Mobilebutton = [[UIButton alloc]init];
    Mobilebutton.frame = CGRectMake(kScreen_w / 2, 0, kScreen_w / 4, 35);
    [Mobilebutton setTitle:@"查看手机" forState:UIControlStateNormal];
    [Mobilebutton addTarget:self action:@selector(addMobilebutton) forControlEvents:UIControlEventTouchUpInside];
    Mobilebutton.titleLabel.font = [UIFont systemFontOfSize:13];
    [Mobilebutton setTitleColor:hong forState:UIControlStateNormal];
    [tiView addSubview:Mobilebutton];
    
    UILabel *xianLabel2 = [[UILabel alloc]init];
    xianLabel2.frame = CGRectMake(kScreen_w / 4 * 3 - 1, 8, 1, 20);
    xianLabel2.backgroundColor = [UIColor blackColor];
    xianLabel2.alpha = 0.6;
    [tiView addSubview:xianLabel2];
    
    
    UIButton *WXButton = [[UIButton alloc]init];
    WXButton.frame = CGRectMake(kScreen_w / 4 * 3, 0, kScreen_w / 4, 35);
    [WXButton setTitle:@"查看微信" forState:UIControlStateNormal];
    WXButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [WXButton addTarget:self action:@selector(addWXButton) forControlEvents:UIControlEventTouchUpInside];
    [WXButton setTitleColor:hong forState:UIControlStateNormal];
    [tiView addSubview:WXButton];
    
    UIView *tingView = [[UIView alloc]init];
    tingView.frame = CGRectMake(0, 99, kScreen_w, 30);
    tingView.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:226.0/255.0 blue:226.0/255.0 alpha:1];
    [self.view addSubview:tingView];
    
    self.cycleScrollView = [[SMKCycleScrollView alloc] init];
    self.cycleScrollView.frame = CGRectMake(12, 0, [UIScreen mainScreen].bounds.size.width - 24, 30);
    self.cycleScrollView.backColor = ViewRGB;
    self.cycleScrollView.titleColor = [UIColor blackColor];

    self.cycleScrollView.titleFont = [UIFont systemFontOfSize:15];
    
    [self.view addSubview:self.cycleScrollView];

    self.cycleScrollView.typeString = @"chat";
    
    [self.cycleScrollView setSelectedBlock:^(NSInteger index, NSString *title) {
        NSLog(@"%zd-----%@",index,title);
    }];
    [tingView addSubview:self.cycleScrollView];
    
    
    
}
- (void)addUITableView{
    self.tabelView = [[UITableView alloc]init];
    _tabelView.dataSource = self;
    _tabelView.delegate = self;
    _tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tabelView.allowsSelection = NO;
    _tabelView.showsVerticalScrollIndicator = NO;
    _tabelView.frame = CGRectMake(0, 130, kScreen_w, kScreen_h - 200);
    _tabelView.backgroundColor = [UIColor redColor];
    __weak typeof(self) ws = self;
    _tabelView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [ws refreshData];
    }];
    _tabelView.backgroundColor = ViewRGB;
    [self.view addSubview:_tabelView];
}
#pragma mark - 下拉刷新 上拉加载
- (void)refreshData {
    if (self.dataArrayTwo.count) {
        MessageSSModel *model = self.dataArrayTwo[0];
        self.msgid = model.msgid;

        
    }else {
        
    }
    
    [self wechat_msgData];
}

//添加评论框
- (void)addUIView{
    _lasView = [[UIView alloc] init];
//    _lasView.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
    _lasView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_lasView];
    _lasView.frame = CGRectMake(0, kScreen_h-50, kScreen_w, 50);
//    _lasView.backgroundColor = [UIColor redColor];
    
//    //添加约束
//    [_lasView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(UIEdgeInsetsMake(kScreen_w-50, 0, 0, 0));
//    }];
    
//    [self addYuYin];//添加label
    [self addTextField];//添加textFile
//    [self addYuYin];//语音
    [self fasongUIButton];//发送
    [self jiahaoUIbutton];//加好；
//    [self addBiaoQing];//添加button
//    [self addJiaHao];//添加发送
//    [self addYuinBtn];//语音UIView按钮
//    [self addBtnMessView];//添加底部功能按钮
    
}
//输入框
- (void)addTextField{
    _yuyinTextField = [[UITextField alloc]init];
    _yuyinTextField.frame = CGRectMake(50, 10, kScreen_w - 110, 30);
    _yuyinTextField.placeholder = @"请文明聊天";
    _yuyinTextField.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1];
//    _yuyinTextField.layer.cornerRadius = 15;
//    _yuyinTextField.layer.masksToBounds = YES;
    _yuyinTextField.borderStyle = UITextBorderStyleRoundedRect;
//    UIImageView *imageViewPwdq=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 18, 40)];
//    
//    _yuyinTextField.leftView = imageViewPwdq;
    _yuyinTextField.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机

    [_lasView addSubview:_yuyinTextField];
}
//礼物按钮
- (void)liwuUIButton{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *uidS = [defatults objectForKey:uidSG];
    if ([uidS isEqualToString:@"257555"]) {
        
    }else {
        _liwuButton = [[UIButton alloc]init];
        _liwuButton.frame = CGRectMake(kScreen_w - 70, kScreen_h - 120, 60, 60);
        [_liwuButton setBackgroundImage:[UIImage imageNamed:@"icon-gift"] forState:UIControlStateNormal];
        [_liwuButton addTarget:self action:@selector(addliwuButotnLI:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_liwuButton];
        
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
        _liView.LUID = self.TOID;
        _liView.backgroundColor = ViewRGB;
        _liView.frame = CGRectMake(0, kScreen_h - 370, kScreen_w, 370);
        [_liView.shenjiButton addTarget:self action:@selector(addshenjiButton) forControlEvents:UIControlEventTouchUpInside];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addchpngbutton) name:@"zhifujinbiXIUXIU" object:nil];

        [_liView.chpngbutton addTarget:self action:@selector(addchpngbutton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_liView];

        
    }else {
        _BViewLi.hidden = NO;
        _liView.hidden = NO;
        
    }
    

    
    
}
- (void)addshenjiButton{
    [self tapActionBVIewLI];
    [self shengVIPView];
}
- (void)addchpngbutton{
    [self tapActionBVIewLI];
    [self chongView];
}




- (void)tapActionBVIewLI {
    _BViewLi.hidden = YES;
    _liView.hidden = YES;
}


//发送
- (void)fasongUIButton{
    _fasongButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreen_w - 50, 10, 45, 30)];

    [_fasongButton setBackgroundImage:[UIImage imageNamed:@"btn-send"] forState:UIControlStateNormal];
    _fasongButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_fasongButton addTarget:self action:@selector(addfasongButton:) forControlEvents:UIControlEventTouchUpInside];
    [_lasView addSubview:_fasongButton];
    
}
//加好
- (void)jiahaoUIbutton{
    UIButton *jiahaoButton = [UIButton new];
    jiahaoButton.frame = CGRectMake(12, 10, 30, 30);
    [jiahaoButton setBackgroundImage:[UIImage imageNamed:@"btn-add"] forState:UIControlStateNormal];
    [jiahaoButton addTarget:self action:@selector(addjiahaoButton:) forControlEvents:UIControlEventTouchUpInside];
    [_lasView addSubview:jiahaoButton];
    
    
}
- (void)addjiahaoButton:(UIButton *)sender{
    [self.view endEditing:YES];

    if (!_BGView) {
        self.BGView = [[UIView alloc]init];
        _BGView.frame = CGRectMake(0, 0, kScreen_w, kScreen_h - 90);
        //创建手势对象
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapActionBVIewBGView)];
        //讲手势添加到指定的视图上
        [_BGView addGestureRecognizer:tap];
        [self.view addSubview:_BGView];
        
        [_lasView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(kScreen_h - 140, 0, 0, 0));
        }];
        [_lasView addSubview:self.jiahaoView];
        
    }else {
      
        [_lasView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(kScreen_h - 140, 0, 0, 0));
        }];
        _BGView.hidden = NO;
        _jiahaoView.hidden = NO;
    }
    
    
//    [self.view layoutIfNeeded];
}
- (void)tapActionBVIewBGView{
    _BGView.hidden = YES;
    _jiahaoView.hidden = YES;
    [_lasView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(kScreen_h - 50, 0, 0, 0));
    }];
    [self.view layoutIfNeeded];

}

#pragma mark -- 监听
//监听键盘状态
- (void)addCent{
//    // 表情选中的通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelect:) name:HWEmotionDidSelectNotification object:nil];
//    // 删除文字的通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidDelete) name:HWEmotionDidDeleteNotification object:nil];
    //充值是否成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(laodData) name:@"chongzhiwanchengXIU" object:nil];

    
    //充值VIP
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shengVIPView) name:@"chongzhiVIP" object:nil];
    //弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //收起
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - 数据请求
//私信窗口消息接口
- (void)wechat_msgData{
    [self.view addSubview:self.MBhud];
    [self.MBhud show:YES];
    
    NSString *stringURL = [NSString stringWithFormat:@"%@%@",AppURL,wechat_msgURL];
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *uidS = [defatults objectForKey:uidSG];
    
    [HttpUtils postRequestWithURL:stringURL withParameters:@{@"fromuid":uidS,@"touid":self.TOID,@"msgid":self.msgid} withResult:^(id result) {
        
        NSArray *array = result[@"data"];
        int a = 0;
        for (NSDictionary *dic in array) {
            MessageSSModel *model = [[MessageSSModel alloc]initWithDictionary:dic error:nil];
            [self.dataArrayTwo insertObject:model atIndex:a];
            a = a + 1;
        }
        [self.tabelView reloadData];
        [self.tabelView.mj_header endRefreshing];
        [self.MBhud hide:YES];
        if ([self.msgid isEqualToString:@"0"]) {
            [self scrollToBottom];
        }
        
    } withError:^(NSString *msg, NSError *error) {
        [self.tabelView.mj_header endRefreshing];
        [self mbhudtui:msg numbertime:1];

        
        
    }];
}
//私信窗口头部
- (void)laodData{
    NSString *stringURL = [NSString stringWithFormat:@"%@%@",AppURL,wechatURL];
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *uidS = [defatults objectForKey:uidSG];
    
    [HttpUtils postRequestWithURL:API_wechat2 withParameters:@{@"fromuid":uidS,@"touid":self.TOID} withResult:^(id result) {
        self.WXStrig = result[@"data"][@"weixin"];
        self.shouString = result[@"data"][@"mob"];
        NSString *isgz = result[@"data"][@"isgz"];
        int a = [isgz intValue];
        if (a == 0) {
//            [_guanButton setImage:[UIImage imageNamed:@"contact_img"] forState:UIControlStateNormal];
            [_guanButton setTitle:@"关注Ta" forState:UIControlStateNormal];
            [_guanButton addTarget:self action:@selector(addguanButtton:) forControlEvents:UIControlEventTouchUpInside];
        }else {
//            [_guanButton setImage:[UIImage imageNamed:@"contacted_img"] forState:UIControlStateNormal];
            [_guanButton setTitle:@"已关注" forState:UIControlStateNormal];
        }
        NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
        NSString *uidS = [defatults objectForKey:uidSG];
        if ([uidS isEqualToString:@"257555"]) {
            [_yueButton setTitle:@"" forState:UIControlStateNormal];

        }else {
            NSString *yueString = [NSString stringWithFormat:@"秀币:%@",result[@"data"][@"money"]];
            [_yueButton setTitle:yueString forState:UIControlStateNormal];
            self.cycleScrollView.titleArray = result[@"data"][@"giftdata"];

        }
        
    } withError:^(NSString *msg, NSError *error) {
        
    }];
}
//发送消息接口
- (void)sendmsgData{
    
    if ([self.yuyinTextField.text isEqualToString:@""] || self.yuyinTextField.text == nil) {
        [SVProgressHUD showErrorWithStatus:@"聊天内容不能为空"];
        [SVProgressHUD dismissWithDelay:1];
    }else {
        NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
        NSString *uidS = [defatults objectForKey:uidSG];
        
        NSString *stringURL = [NSString stringWithFormat:@"%@%@",AppURL,sendmsgURL];
        NSDictionary *dic = @{@"fromuid":uidS,@"touid":self.TOID,@"content":self.yuyinTextField.text,@"msg_type":@"0",@"voice_time":@""};
        _yuyinTextField.text = @"";

        AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
        manage.requestSerializer = [AFHTTPRequestSerializer serializer];
        manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
        [manage POST:stringURL parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
            
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *daDic = responseObject;
            NSString *codeSt = [NSString stringWithFormat:@"%@",daDic[@"code"]];
            
            int a = [codeSt intValue];
            if (a == -100 ) {
                if ([daDic[@"msg"] isEqualToString:@"请升级vip"]) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"VIP聊天次数没有限制，是否去升级VIP" message:nil preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        
                        [self shengVIPView];
                    }];
                    
                    
                    [alert addAction:otherAction];
                    
                    [self presentViewController:alert animated:YES completion:nil];
                    
                }else {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"你的余额不足,请充值" message:nil preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        self.tyString = @"zhitabelView";
                        [self chongView];
                    }];
                    
                    
                    [alert addAction:otherAction];
                    
                    [self presentViewController:alert animated:YES completion:nil];
                    
                }
                
            }
            [self.dataArrayTwo removeAllObjects];
            [self wechat_msgData];
            [self laodData];

            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];

    }


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


- (void)participatePayWX{
    [self laodData];
    [self wechat_msgData];
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

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArrayTwo.count;
    

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageSSModel * mode = self.dataArrayTwo[indexPath.row];
    NSLog(@"%@",mode);
    NSString * txt = mode.content;
    
    MessageSSModel *model = self.dataArrayTwo[indexPath.row];
    NSString *msg_type = model.msg_type;
    int a = [msg_type intValue];
    
    //图片
    if (a == 20) {
        return [MessImageTableViewCell heightOfImageCellWithMessage:txt imagData:mode.content nstime:mode.content];
        return 0;
        //语音
    }if (a == 1 || a== 30 ){
        return  [MessVoideTableViewCell heightOfVoideCellWithMessage:txt yuyin:mode.content nstime:mode.content];
        //文字
    }if (a == 2) {
        return [MessTiShiTableViewCell heightOfTxtCellWithMessage:txt nstime:model.content];
    }else {
        return [MessTxtContentTableViewCell heightOfTxtCellWithMessage:txt nstime:mode.content];
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageSSModel *model = self.dataArrayTwo[indexPath.row];
    NSString *msg_type = model.msg_type;
    int a = [msg_type intValue];
    //图片
    if (a == 20) {
        MessImageTableViewCell *cell = [MessImageTableViewCell cellWithImageTableView:tableView];
        cell.messFriendModel = self.dataArrayTwo[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.headBtn addTarget:self action:@selector(addHeadportraita:) forControlEvents:UIControlEventTouchUpInside];
        cell.superVC = self.navigationController;
        
        //        [cell.deleBbbtn addTarget:self action:@selector(shanchule:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
        //语音
    }if (a == 1 || a== 30 ){
        MessVoideTableViewCell *cell = [MessVoideTableViewCell cellWithVoideTableView:tableView];
        cell.messFriendModel = self.dataArrayTwo[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.headBtn addTarget:self action:@selector(addHeadportraita:) forControlEvents:UIControlEventTouchUpInside];
//        [cell.deleBbbtn addTarget:self action:@selector(shanchule:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        //提示框
    }else if (a == 2){
        MessTiShiTableViewCell *cell = [MessTiShiTableViewCell cellWithTxtTableView:tableView];
        cell.messFriendModel = self.dataArrayTwo[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.headBtn addTarget:self action:@selector(shengVIPView) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    
        //文字
    }else {
        
        MessTxtContentTableViewCell *cell = [MessTxtContentTableViewCell cellWithTxtTableView:tableView];
        cell.messFriendModel = self.dataArrayTwo[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.headBtn addTarget:self action:@selector(addHeadportraita:) forControlEvents:UIControlEventTouchUpInside];
        //        [cell.headBtn addTarget:self action:@selector(headKongjian:) forControlEvents:UIControlEventTouchUpInside];
        //
        //        return cell;
        return cell;
        
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageSSModel *model = self.dataArrayTwo[indexPath.row];
    NSString *msg_type = model.msg_type;
    int a = [msg_type intValue];
    if (a == 2) {
        [self shengVIPView];
    }
    
    

}


- (void)addHeadportraita:(UIButton *)sender{
    UITableViewCell * cell = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath * path = [self.tabelView indexPathForCell:cell];//获取cell对应的section
    MessageSSModel *model = self.dataArrayTwo[path.row];
    MainXiuViewController *MainView = [[MainXiuViewController alloc]init];
    MainView.name = self.name;
    MainView.UID = model.fromuid;
    UINavigationController *tgirNVC = [[UINavigationController alloc]initWithRootViewController:MainView];
    
    [self showViewController:tgirNVC sender:nil];
}
- (void)handleNavigationrightBarButtonAction{
    MainXiuViewController *MainView = [[MainXiuViewController alloc]init];
    MainView.name = self.name;
    MainView.UID = self.TOID;
    UINavigationController *tgirNVC = [[UINavigationController alloc]initWithRootViewController:MainView];
    
    [self showViewController:tgirNVC sender:nil];
}

    

    
//健谈将要弹出调用的方法
- (void)keyboardWillShow:(NSNotification *)aNotification{
    
    NSDictionary * userInFo = [aNotification userInfo];
    NSValue * aValue = [userInFo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyBoardRect = [aValue CGRectValue];
    _messHeight = keyBoardRect.size.height;
    //添加动画改变
    [UIView animateWithDuration:0.1 animations:^{
        
        [_lasView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(kScreen_h-_messHeight-50, 0, _messHeight, 0));
        }];
        [_tabelView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(130, 0, _messHeight+50, 0));
        }];
//        _liwuButton.frame = CGRectMake(kScreen_w - 70, kScreen_h - 120, 60, 60);
     ;
        //告诉self.view约束改变重新计算，否则无动画
        [self.view layoutIfNeeded];
    }];
}
//键盘将要收起时调用
- (void)keyboardWillHide:(NSNotification *)aNotification{

    //添加动画改变
    [UIView animateWithDuration:0.1 animations:^{
        //mas_updateConstraints 更改约束的值
        [_lasView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(kScreen_h-50, 0, 0, 0));
        }];
        [_tabelView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(130, 0, 50, 0));

        }];
    
        //告诉self.view约束改变重新计算，否则无动画
        [self.view layoutIfNeeded];
    }];}
#pragma mark - 消息的发送
- (void)addfasongButton:(UIButton *)sender{
    [self.view endEditing:YES];
    self.wenziString = self.yuyinTextField.text;
    [self sendmsgData];
}
//table滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
    
}

#pragma mark - 用户交互
- (void)handleNavigationBarLeftitemAction:(UIBarButtonItem *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shuxinTableVIew" object:nil];

    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 键盘隐藏
//点击tableview手势
- (void)addTap{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    tap.numberOfTapsRequired = 1;
    tap.cancelsTouchesInView = NO;
    [_tabelView addGestureRecognizer:tap];
}

//手势调用
- (void)tap{
    [self.view endEditing:YES];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

  

 
//礼物的数据
- (void)liwuData{
    NSString *stringURL = [NSString stringWithFormat:@"%@%@",AppURL,API_shopgift];
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *uidS = [defatults objectForKey:uidSG];
    
    [HttpUtils postRequestWithURL:stringURL withParameters:@{@"uid":uidS,@"p":@""} withResult:^(id result) {
        NSDictionary *uinfoDic = result[@"data"][@"uinfo"];
        NSString *VIPString = [NSString stringWithFormat:@"VIP剩余天数:%@",uinfoDic[@"rank_time"]];
        if (VIPString == nil || [VIPString isEqualToString:@"0"]) {
            VIPString = @"VIP剩余天数:0";
        }
        _VIPLabel.text = VIPString;
        _monyLaebel.text = uinfoDic[@"money"];
        NSArray *giftlistArray = result[@"data"][@"giftlist"];
        
        
//        NSArray *array = result[@"data"];
//        int a = 0;
//        for (NSDictionary *dic in array) {
//            MessageSSModel *model = [[MessageSSModel alloc]initWithDictionary:dic error:nil];
//            [self.dataArray insertObject:model atIndex:a];
//            a = a + 1;
//        }
//        [self.tabelView reloadData];
//        [self.tabelView.mj_header endRefreshing];
        
    } withError:^(NSString *msg, NSError *error) {
        [self.tabelView.mj_header endRefreshing];
        
        
    }];

}
#pragma mark - 关注
- (void)addguanButtton:(UIButton *)sender{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_guanzhu];
    NSDictionary *dic = @{@"touid":self.TOID,@"fromuid":uidS};
    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
//        [_guanButton setImage:[UIImage imageNamed:@"contacted_img"] forState:UIControlStateNormal];
        [_guanButton setTitle:@"已关注" forState:UIControlStateNormal];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"adddtuXIUXIU" object:nil];

   
        [SVProgressHUD showSuccessWithStatus:result[@"msg"]];
        [SVProgressHUD dismissWithDelay:1.0];
        
    } withError:^(NSString *msg, NSError *error) {
        [SVProgressHUD showSuccessWithStatus:msg];
        [SVProgressHUD dismissWithDelay:1.0];
    }];

 
}
//加好里面图片
- (void)addtuButton:(UIButton *)sender{
    [self pushTZImagePickerController];
    
}
//查看微信
- (void)addWXButton{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *user_renk = [defatults objectForKey:user_rankVIP];
    int userIn = [user_renk intValue];
    if (userIn == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"你现在还不是VIP，不能查看，是否充值！" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *seqing = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"去开通" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self shengVIPView];
        }];
        [alert addAction:seqing];
        [alert addAction:quxiao];
        [self presentViewController:alert animated:YES completion:nil];
    }else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:self.WXStrig message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *seqing = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:seqing];
        [alert addAction:quxiao];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
//查看手机号
- (void)addMobilebutton{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *user_renk = [defatults objectForKey:user_rankVIP];
    int userIn = [user_renk intValue];
    if (userIn == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"你现在还不是VIP，不能查看，是否充值！" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *seqing = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"去开通" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self shengVIPView];
            
        }];
        [alert addAction:seqing];
        [alert addAction:quxiao];
        [self presentViewController:alert animated:YES completion:nil];
    }else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:self.shouString message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *seqing = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:seqing];
        [alert addAction:quxiao];
        [self presentViewController:alert animated:YES completion:nil];
    }

}
- (void)addyuButton:(UIButton *)sender{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *uidS = [defatults objectForKey:uidSG];
    if ([uidS isEqualToString:@"257555"]) {
        
    }else {
        [self chongView];
  
    }

    
    
}
//相册

#pragma mark - TZImagePickerController

- (void)pushTZImagePickerController {
    if (1 <= 0) {
        return;
    }
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:3 delegate:self pushPhotoPickerVc:YES];
    
    
#pragma mark - 四类个性化设置，这些参数都可以不传，此时会走默认设置
    

    imagePickerVc.allowTakePicture = YES; // 在内部显示拍照按钮
    
    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
    // imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
    // imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
    // imagePickerVc.navigationBar.translucent = NO;
    
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.allowPickingGif = YES;
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = NO;
    
    // imagePickerVc.minImagesCount = 3;
    // imagePickerVc.alwaysEnableDoneBtn = YES;
    
    // imagePickerVc.minPhotoWidthSelectable = 3000;
    // imagePickerVc.minPhotoHeightSelectable = 2000;
    
    /// 5. Single selection mode, valid when maxImagesCount = 1
    /// 5. 单选模式,maxImagesCount为1时才生效
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = NO;
    imagePickerVc.needCircleCrop = NO;
    imagePickerVc.circleCropRadius = 100;
//    imagePickerVc.isStatusBarDefault = NO;
    /*
     [imagePickerVc setCropViewSettingBlock:^(UIView *cropView) {
     cropView.layer.borderColor = [UIColor redColor].CGColor;
     cropView.layer.borderWidth = 2.0;
     }];*/
    
    //imagePickerVc.allowPreview = NO;
#pragma mark - 到这里为止
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        self.tuimagViewXIu.image = photos[0];
        [self shangData];
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
- (void)shangData{
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_upload];
    [self.view addSubview:self.MBhud];
    [self.MBhud show:YES];
    
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.requestSerializer = [AFHTTPRequestSerializer serializer];
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    //    NSDictionary *dic = @{@"uid":@"21444"};
    [manage POST:URL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //转化为data类型  0.5图片压缩比例 image 图片格式
        NSData *data = UIImageJPEGRepresentation(self.tuimagViewXIu.image, 1);
        
        //PNG图片不需要压缩
        //        NSData *data1 = UIImagePNGRepresentation(image1);
        
        //参数1:: 就是我要上传的data数据
        //参数2: 后台要求的图片名
        //参数3: 图片上传以后的名字
        //参数4: image/jpg 图片是什么格式 就写什么格式
        //            NSString *string = info[@"UIImagePickerControllerMediaType"];
        //            [formData appendPartWithFormData:data name:@"file"];
        
        [formData appendPartWithFileData:data name:[NSString stringWithFormat:@"img%d", 100+1] fileName:[NSString stringWithFormat:@"img%d.jpg", 100+1] mimeType:@"image/jpeg"];
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        NSString *code = dic[@"code"];
        int incode = [code intValue];
        if (incode == 1) {
            
            [self dataImagViewString:dic[@"data"][@"img101"][@"url"]];
//            [self requestListData];
//            [self sendmsgData];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        [self mbhudtui:@"图片发送失败！" numbertime:1];

        
        
    }];
    
    
}



- (void)dataImagViewString:(NSString *)imagViewString{
    
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *uidS = [defatults objectForKey:uidSG];
    
    NSString *stringURL = [NSString stringWithFormat:@"%@%@",AppURL,sendmsgURL];
    NSDictionary *dic = @{@"fromuid":uidS,@"touid":self.TOID,@"content":imagViewString,@"msg_type":@"20",@"voice_time":@""};
    
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.requestSerializer = [AFHTTPRequestSerializer serializer];
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    
    [manage POST:stringURL parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.MBhud hide:YES];
        [self tapActionBVIewBGView];

        NSDictionary *daDic = responseObject;
        NSString *codeSt = [NSString stringWithFormat:@"%@",daDic[@"code"]];
        int a = [codeSt intValue];
        if (a == -100 ) {
            if ([daDic[@"msg"] isEqualToString:@"请升级vip"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"VIP聊天次数没有限制，是否去升级VIP" message:nil preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    [self shengVIPView];
                }];
                
                
                [alert addAction:otherAction];
                
                [self presentViewController:alert animated:YES completion:nil];
                
            }else {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"你的余额不足,请充值" message:nil preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    self.tyString = @"zhitabelView";
                    [self chongView];
                }];
                
                
                [alert addAction:otherAction];
                
                [self presentViewController:alert animated:YES completion:nil];
                
            }
            
        }
        [self.dataArrayTwo removeAllObjects];
        [self wechat_msgData];
        [self laodData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self mbhudtui:@"图片发送失败" numbertime:1];

    }];
    
}
- (void)scrollToBottom
{
    CGFloat yOffset = 0; //设置要滚动的位置 0最顶部 CGFLOAT_MAX最底部
    if (self.tabelView.contentSize.height > self.tabelView.bounds.size.height) {
        yOffset = self.tabelView.contentSize.height - self.tabelView.bounds.size.height;
    }
    [self.tabelView setContentOffset:CGPointMake(0, yOffset) animated:NO];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

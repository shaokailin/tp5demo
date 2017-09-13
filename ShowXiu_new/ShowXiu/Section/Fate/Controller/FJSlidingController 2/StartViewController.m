//
//  StartViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/4/24.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "StartViewController.h"
#import "NearViewController.h"
#import "RecommendedViewController.h"
#import "VideoViewController.h"
#import "RootViewController.h"
#import "ChaViewController.h"
#import "RankingViewController.h"
#import "JPUSHService.h"
#import "StartTheView.h"
#import "CityChoose.h"
#import "ZhuCeViewController.h"
#import "RankingViewController.h"
#import "ThroughViewController.h"
//一键撩吧
#import "LiaoSisterView.h"
@interface StartViewController ()<FJSlidingControllerDataSource,FJSlidingControllerDelegate>
@property (nonatomic, strong)NSArray *titles;
@property (nonatomic, strong)NSArray *controllers;
//漏斗的View
@property (nonatomic, strong)UIView *louView;

@property (nonatomic, strong)StartTheView *startView;

@property (nonatomic, strong)UIButton *quanButton;
@property (nonatomic, strong)UIButton *nvButton;
@property (nonatomic, strong)UIButton *nanButton;

@property (nonatomic, strong)UIButton *shengButton;
@property (nonatomic, strong)UIButton *shiButton;

@property (nonatomic, strong)UIButton *buxianButton;
@property (nonatomic, strong)UIButton *eighteenthButton;
@property (nonatomic, strong)UIButton *twentySixButton;
@property (nonatomic, strong)UIButton *thirtysixButton;
@property (nonatomic, strong)UIButton *fortyButton;
@property (nonatomic, strong)UIButton *tfiftyButton;

@property (nonatomic, strong) CityChoose *cityChoose;    /** 城市选择 */
@property (nonatomic, strong) NSString *shenID;
@property (nonatomic, strong) NSString *shiID;
@property (nonatomic, strong) NSString *xingsex;
@property (nonatomic, strong) NSString *nian;
@property (nonatomic, strong) UIButton *quxiaoButton;
@property (nonatomic, strong) UIButton *queButton;
@property (nonatomic, strong) LiaoSisterView *LiaoSisterViewXIuXIU;

@end

@implementation StartViewController

- (StartTheView *)startView{
    if (!_startView) {
        NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"StartTheView" owner:nil options:nil];
        
        // Find the view among nib contents (not too hard assuming there is only one view in it).
        _startView = [nibContents lastObject];
        _startView.frame = CGRectMake(0, 0, kScreen_w, kScreen_h);
    }
    return  _startView;
}

- (LiaoSisterView *)LiaoSisterViewXIuXIU{
    if (!_LiaoSisterViewXIuXIU) {
        NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"LiaoSisterView" owner:nil options:nil];
        // Find the view among nib contents (not too hard assuming there is only one view in it).
        _LiaoSisterViewXIuXIU = [nibContents lastObject];
        _LiaoSisterViewXIuXIU.frame = CGRectMake(0, 0, kScreen_w, kScreen_h);
        //        _LiaoSisterViewXIuXIU.backgroundColor = [UIColor whiteColor];
        //        _LiaoSisterViewXIuXIU.layer.cornerRadius = 5;
        //        _LiaoSisterViewXIuXIU.layer.masksToBounds = 1;
    }
    return _LiaoSisterViewXIuXIU;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *uidS = [defatults objectForKey:uidSG];

//    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,qdshowURL];

    
    if ([uidS isEqualToString:@""] || uidS == nil){
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        self.tabBarController.tabBar.hidden = YES;

        [self.view addSubview:self.startView];
    
        
        [self.startView.nanButton addTarget:self action:@selector(addnanButton:) forControlEvents:UIControlEventTouchUpInside];
        [_startView.nvButton addTarget:self action:@selector(addnvButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addzhiliaoAction:) name:@"addzhiliaoAction" object:nil];
        

        
    }else {
        self.nian = @"";
        self.shiID = @"";
        self.shenID = @"";
        self.xingsex = @"";
        [[NSNotificationCenter defaultCenter] removeObserver:@"addzhiliaoAction" name:nil object:self];
        

        [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.tabBarController.tabBar.hidden = NO;

        [self addnavigationItem];
        self.datasouce = self;
        self.delegate = self;
        
        NearViewController *v1 = [[NearViewController alloc]init];
        v1.parentController = self;
        
        
        RecommendedViewController *v2 = [[RecommendedViewController alloc]init];
        v2.parentController = self;
        VideoViewController *v3 = [[VideoViewController alloc]init];
        v3.parentController = self;
        
        RankingViewController *v4 = [[RankingViewController alloc]init];
        v4.parentController = self;
        
        self.titles      = @[@"推荐",@"附近",@"视频",@"排行"];
        self.controllers = @[v1,v2,v3,v4];
        [self addChildViewController:v1];
        [self addChildViewController:v2];
        [self addChildViewController:v3];
        [self addChildViewController:v4];
        //    self.title = self.titles[0];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addLiaoSisterViewXiuXiAction) name:@"LiaoSisterViewXiuXiu" object:nil];

        [self reloadData];



    }
 
}

//
- (void)addLiaoSisterViewXiuXiAction{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.tabBarController.tabBar.hidden = YES;
    if (!_LiaoSisterViewXIuXIU) {
        [self.view addSubview:self.LiaoSisterViewXIuXIU];

    }else {
        _LiaoSisterViewXIuXIU.hidden = NO;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addLiaoSisterViewXiuAction) name:@"LiaoSisterViewXiu" object:nil];


}
- (void)addLiaoSisterViewXiuAction{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"detectionXIUXIULI" object:nil];

    self.LiaoSisterViewXIuXIU.hidden = YES;
    [SVProgressHUD showSuccessWithStatus:@"打招呼成功！"];
    [SVProgressHUD dismissWithDelay:1.0];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden = NO;
}



- (void)addnavigationItem{
    self.navigationItem.title = @"同城秀秀";
    
    UIImage *aimage = [UIImage imageNamed:@"filter"];
    UIImage *image = [aimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarRinghtOneAction:)];

    
    
    
//    UIImage *leimage = [UIImage imageNamed:@"形状16"];
//    UIImage *Leimage = [leimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:Leimage style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarLeftitemAction:)];
    
    UIImage *leimage1 = [UIImage imageNamed:@"search_"];
    UIImage *Leimage1 = [leimage1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem1 = [[UIBarButtonItem alloc] initWithImage:Leimage1 style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarLeftitemONeAction:)];
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:leftItem1, nil];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rightItem, nil];
//    [self biaotiView];
//    [self addCollectionView];
//    [self addData];
//    self.zhuaString = @"0";

}
#pragma mark - navigationItem点击事件

//搜索
- (void)handleNavigationBarLeftitemONeAction:(UIBarButtonItem *)sender{
    _louView.hidden = 1;

    ChaViewController *chaViewC = [[ChaViewController alloc]init];
    [self.navigationController pushViewController:chaViewC animated:nil];
    
    //    CATransition *animation = [CATransition animation];
    //    animation.duration = 0.3;
    //    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    //    animation.type = kCATransitionPush;
    //    animation.subtype = kCATransitionFromRight;
    //
    //    // 在window上执行CATransition, 即可在ViewController转场时执行动画。
    //    [self.view.window.layer addAnimation:animation forKey:@"kTransitionAnimation"];
    //
    ////    [self.navigationController pushViewController:chaViewC animated:YES];
    //    [self.navigationController presentViewController:chaBViewNVC animated:YES completion:nil];
}
//漏斗
- (void)handleNavigationBarRinghtOneAction:(UIBarButtonItem *)sender{
    if (!_louView) {
        _louView = [[UIView alloc]init];
        _louView.frame = CGRectMake(0, 64, kScreen_w, 350);
        _louView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_louView];
        
//        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
//        //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
//        tapGestureRecognizer.cancelsTouchesInView = NO;
//        //将触摸事件添加到当前view
//        [self.view addGestureRecognizer:tapGestureRecognizer];
//        
        
        UILabel *yongLabel = [[UILabel alloc]init];
        yongLabel.frame = CGRectMake(15, 12, kScreen_w - 24, 20);
        yongLabel.text = @"想看到的用户";
        yongLabel.font = [UIFont systemFontOfSize:15];
        yongLabel.alpha = 0.8;
        [_louView addSubview:yongLabel];
        
        self.quanButton = [[UIButton alloc]init];
        _quanButton.frame = CGRectMake(15, 40, (kScreen_w - 60) / 3, 30);
        [_quanButton setTitle:@"全部" forState:UIControlStateNormal];
        [_quanButton setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
        _quanButton.layer.masksToBounds = YES;
        _quanButton.layer.cornerRadius = 15.0;
        _quanButton.layer.borderWidth = 1.0;
        _quanButton.layer.borderColor = [UIColor grayColor].CGColor;
        _quanButton.tag = 1000;
        _quanButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_quanButton addTarget:self action:@selector(addyonghu:) forControlEvents:UIControlEventTouchUpInside];
        [_louView addSubview:_quanButton];
        
        self.nvButton = [[UIButton alloc]init];
        _nvButton.frame = CGRectMake(30 +(kScreen_w - 60) / 3 , 40, (kScreen_w - 60) / 3, 30);
        [_nvButton setTitle:@"男" forState:UIControlStateNormal];
        [_nvButton setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
        _nvButton.layer.masksToBounds = YES;
        _nvButton.layer.cornerRadius = 15.0;
        _nvButton.layer.borderWidth = 1.0;
        _nvButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _nvButton.layer.borderColor = [UIColor grayColor].CGColor;
        [_nvButton addTarget:self action:@selector(addyonghu:) forControlEvents:UIControlEventTouchUpInside];
        _nvButton.tag = 1001;
        [_louView addSubview:_nvButton];
        
        self.nanButton = [[UIButton alloc]init];
        _nanButton.frame = CGRectMake(45 + (kScreen_w - 60) / 3 * 2, 40, (kScreen_w - 60) / 3, 30);
        [_nanButton setTitle:@"女" forState:UIControlStateNormal];
        [_nanButton setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
        _nanButton.layer.masksToBounds = YES;
        _nanButton.layer.cornerRadius = 15.0;
        _nanButton.layer.borderWidth = 1.0;
        _nanButton.layer.borderColor = [UIColor grayColor].CGColor;
        [_nanButton addTarget:self action:@selector(addyonghu:) forControlEvents:UIControlEventTouchUpInside];
        _nanButton.tag = 1002;
        _nanButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_louView addSubview:_nanButton];
        
        NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
        NSString *uidSXB = [defatults objectForKey:sexXB];
        int XBS = [uidSXB intValue];
        if(XBS == 1){
            [_nanButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            _nanButton.layer.borderColor = [UIColor redColor].CGColor;
        }else {
            [_nvButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            _nvButton.layer.borderColor = [UIColor redColor].CGColor;

        }
            
        
        
        //地区
        UILabel * diLabel = [[UILabel alloc]init];
        diLabel.frame = CGRectMake(15, 80, kScreen_w - 30, 20);
        diLabel.text = @"所在地区筛选";
        diLabel.alpha = 0.8;
        diLabel.font = [UIFont systemFontOfSize:15];
        [_louView addSubview:diLabel];
        
        self.shengButton = [[UIButton alloc]init];
//        _shengButton.frame = CGRectMake(15 , 110, (kScreen_w - 60) / 3, 30);
         _shengButton.frame = CGRectMake(15 , 110, (kScreen_w - 60) / 3 + 50, 30);

        [_shengButton setTitle:@"请选择" forState:UIControlStateNormal];
        [_shengButton setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
        _shengButton.layer.masksToBounds = YES;
        _shengButton.layer.cornerRadius = 15.0;
        _shengButton.layer.borderWidth = 1.0;
        _shengButton.layer.borderColor = [UIColor grayColor].CGColor;
        _shengButton.tag = 1003;
        [_shengButton addTarget:self action:@selector(adddiqu:) forControlEvents:UIControlEventTouchUpInside];
        [_louView addSubview:_shengButton];
        
//        self.shiButton = [[UIButton alloc]init];
//        _shiButton.frame = CGRectMake(30 + (kScreen_w - 60) / 3 , 110, (kScreen_w - 60) / 3, 30);
//        [_shiButton setTitle:@"厦门" forState:UIControlStateNormal];
//        [_shiButton setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
//        _shiButton.layer.masksToBounds = YES;
//        _shiButton.layer.cornerRadius = 15.0;
//        _shiButton.layer.borderWidth = 1.0;
//        _shiButton.layer.borderColor = [UIColor grayColor].CGColor;
//        _shiButton.tag = 1004;
//        [_shiButton addTarget:self action:@selector(adddiqu:) forControlEvents:UIControlEventTouchUpInside];
//
//        [_louView addSubview:_shiButton];
        //年龄筛选
        UILabel * lingLabel = [[UILabel alloc]init];
        lingLabel.frame = CGRectMake(15, 150, kScreen_w - 30, 20);
        lingLabel.text = @"所在地区筛选";
        lingLabel.font = [UIFont systemFontOfSize:15];
        lingLabel.alpha = 0.8;
        [_louView addSubview:lingLabel];
        
        self.buxianButton = [[UIButton alloc]init];
        _buxianButton.frame = CGRectMake(15 , 180, (kScreen_w - 60) / 3, 30);
        [_buxianButton setTitle:@"不限" forState:UIControlStateNormal];
        [_buxianButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _buxianButton.layer.borderColor = [UIColor redColor].CGColor;
//        [_buxianButton setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
        _buxianButton.layer.masksToBounds = YES;
        _buxianButton.layer.cornerRadius = 15.0;
        _buxianButton.layer.borderWidth = 1.0;
        _buxianButton.layer.borderColor = [UIColor grayColor].CGColor;
        _buxianButton.tag = 1005;
        [_buxianButton addTarget:self action:@selector(addnianling:) forControlEvents:UIControlEventTouchUpInside];
        _nanButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_louView addSubview:_buxianButton];
        
        self.eighteenthButton = [[UIButton alloc]init];
        _eighteenthButton.frame = CGRectMake(30 + (kScreen_w - 60) / 3 , 180, (kScreen_w - 60) / 3, 30);
        [_eighteenthButton setTitle:@"18-25岁" forState:UIControlStateNormal];
        [_eighteenthButton setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
        _eighteenthButton.layer.masksToBounds = YES;
        _eighteenthButton.layer.cornerRadius = 15.0;
        _eighteenthButton.layer.borderWidth = 1.0;
        _eighteenthButton.layer.borderColor = [UIColor grayColor].CGColor;
        _eighteenthButton.tag = 1006;
        [_eighteenthButton addTarget:self action:@selector(addnianling:) forControlEvents:UIControlEventTouchUpInside];
        _eighteenthButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_louView addSubview:_eighteenthButton];

        self.twentySixButton = [[UIButton alloc]init];
        _twentySixButton.frame = CGRectMake(45 + (kScreen_w - 60) / 3 *2 , 180, (kScreen_w - 60) / 3, 30);
        [_twentySixButton setTitle:@"26-35岁" forState:UIControlStateNormal];
        [_twentySixButton setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
        _twentySixButton.layer.masksToBounds = YES;
        _twentySixButton.layer.cornerRadius = 15.0;
        _twentySixButton.layer.borderWidth = 1.0;
        _twentySixButton.layer.borderColor = [UIColor grayColor].CGColor;
        _twentySixButton.tag = 1007;
        [_twentySixButton addTarget:self action:@selector(addnianling:) forControlEvents:UIControlEventTouchUpInside];
        _twentySixButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_louView addSubview:_twentySixButton];
        
        self.thirtysixButton = [[UIButton alloc]init];
        _thirtysixButton.frame = CGRectMake(15 , 220, (kScreen_w - 60) / 3, 30);
        [_thirtysixButton setTitle:@"36-40岁" forState:UIControlStateNormal];
        [_thirtysixButton setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
        _thirtysixButton.layer.masksToBounds = YES;
        _thirtysixButton.layer.cornerRadius = 15.0;
        _thirtysixButton.layer.borderWidth = 1.0;
        _thirtysixButton.layer.borderColor = [UIColor grayColor].CGColor;
        _thirtysixButton.tag = 1008;
        [_thirtysixButton addTarget:self action:@selector(addnianling:) forControlEvents:UIControlEventTouchUpInside];
        _thirtysixButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_louView addSubview:_thirtysixButton];
        
        self.fortyButton = [[UIButton alloc]init];
        _fortyButton.frame = CGRectMake(30 + (kScreen_w - 60) / 3 , 220, (kScreen_w - 60) / 3, 30);
        [_fortyButton setTitle:@"40-50岁" forState:UIControlStateNormal];
        [_fortyButton setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
        _fortyButton.layer.masksToBounds = YES;
        _fortyButton.layer.cornerRadius = 15.0;
        _fortyButton.layer.borderWidth = 1.0;
        _fortyButton.layer.borderColor = [UIColor grayColor].CGColor;
        _fortyButton.tag = 1009;
        [_fortyButton addTarget:self action:@selector(addnianling:) forControlEvents:UIControlEventTouchUpInside];
        _fortyButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_louView addSubview:_fortyButton];
        
        self.tfiftyButton = [[UIButton alloc]init];
        _tfiftyButton.frame = CGRectMake(45 + (kScreen_w - 60) / 3 *2 , 220, (kScreen_w - 60) / 3, 30);
        [_tfiftyButton setTitle:@"50岁以上" forState:UIControlStateNormal];
        [_tfiftyButton setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
        _tfiftyButton.layer.masksToBounds = YES;
        _tfiftyButton.layer.cornerRadius = 15.0;
        _tfiftyButton.layer.borderWidth = 1.0;
        _tfiftyButton.layer.borderColor = [UIColor grayColor].CGColor;
        _tfiftyButton.tag = 1010;
        [_tfiftyButton addTarget:self action:@selector(addnianling:) forControlEvents:UIControlEventTouchUpInside];
        _tfiftyButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_louView addSubview:_tfiftyButton];
        
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake( 15, 270, kScreen_w - 30, 40)];
        titleView.layer.masksToBounds = YES;
        titleView.layer.cornerRadius = 20.0;
        titleView.layer.borderWidth = 1.0;
        titleView.layer.borderColor = hong.CGColor;
        self.quxiaoButton = [[UIButton alloc]init];
        _quxiaoButton.frame = CGRectMake(0, 0, kScreen_w / 2 - 15, 40);
        [_quxiaoButton addTarget:self action:@selector(addquxiaoButton:) forControlEvents:UIControlEventTouchUpInside];
        [_quxiaoButton setTitle:@"取消" forState:UIControlStateNormal];
        _quxiaoButton.tag = 1000;
        [titleView addSubview:_quxiaoButton];
        
        self.queButton = [[UIButton alloc]init];
        _queButton.frame = CGRectMake(kScreen_w / 2 - 15, 0, kScreen_w / 2 - 15, 40);
        [_queButton addTarget:self action:@selector(addquxiaoButton:) forControlEvents:UIControlEventTouchUpInside];
        [_queButton setTitle:@"确定" forState:UIControlStateNormal];
        _queButton.tag = 1001;
        [titleView addSubview:_queButton];
        self.quxiaoButton.backgroundColor = hong;
        [self.quxiaoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.queButton.backgroundColor = [UIColor whiteColor];
        [self.queButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        
//        UISegmentedControl *segContontrol = [[UISegmentedControl alloc] initWithItems:@[@"取消",@"确定"]];
//        
//        segContontrol.frame = CGRectMake(0, 0,titleView.frame.size.width, 40);
//        segContontrol.layer.masksToBounds = YES;
//        segContontrol.layer.cornerRadius = 20.0;
//        segContontrol.layer.borderWidth = 1.0;
//        segContontrol.layer.borderColor = [UIColor redColor].CGColor;
//        
//        // 设置UISegmentedControl选中的图片
//        [segContontrol setBackgroundImage:[UIImage imageNamed:@"CPArenaSegmentSelectedBG"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
//        
//        
//        // 正常的图片
//        [segContontrol setBackgroundImage:[UIImage imageNamed:@"CPArenaSegmentBG"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//        
//        [segContontrol setTintColor:[UIColor colorWithRed:246.0/255.0 green:49.0/255.0 blue:109.0/255.0 alpha:1]];
//        
//        // 设置选中的文字颜色
//        [segContontrol setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateSelected];
//        segContontrol.selectedSegmentIndex = 0;
//        [segContontrol addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
//        [titleView addSubview:segContontrol];
        [_louView addSubview:titleView];

        
        
    }else {
        _louView.hidden = !_louView.hidden;
    }
    
    
    
    
}
- (void)addquxiaoButton:(UIButton *)sender{
    if (sender.tag == 1000) {
        _louView.hidden = YES;
        self.quxiaoButton.backgroundColor = hong;
        [self.quxiaoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.queButton.backgroundColor = [UIColor whiteColor];
        [self.queButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }else {
        self.quxiaoButton.backgroundColor = [UIColor whiteColor];
        [self.quxiaoButton setTitleColor:hong forState:UIControlStateNormal];
        self.queButton.backgroundColor = hong;
        [self.queButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self shuaxuan];
        _louView.hidden = YES;
    }
}




#pragma mark dataSouce
- (NSInteger)numberOfPageInFJSlidingController:(FJSlidingController *)fjSlidingController{
    return self.titles.count;
}
- (UIViewController *)fjSlidingController:(FJSlidingController *)fjSlidingController controllerAtIndex:(NSInteger)index{
    return self.controllers[index];
}
- (NSString *)fjSlidingController:(FJSlidingController *)fjSlidingController titleAtIndex:(NSInteger)index{
    return self.titles[index];
}
/*
 - (UIColor *)titleNomalColorInFJSlidingController:(FJSlidingController *)fjSlidingController;
 - (UIColor *)titleSelectedColorInFJSlidingController:(FJSlidingController *)fjSlidingController;
 - (UIColor *)lineColorInFJSlidingController:(FJSlidingController *)fjSlidingController;
 - (CGFloat)titleFontInFJSlidingController:(FJSlidingController *)fjSlidingController;
 */

#pragma mark delegate
- (void)fjSlidingController:(FJSlidingController *)fjSlidingController selectedIndex:(NSInteger)index{
    // presentIndex
//    NSLog(@"%ld",index);
//    self.title = [self.titles objectAtIndex:index];
//    self.title = @"同城秀秀";

}
- (void)fjSlidingController:(FJSlidingController *)fjSlidingController selectedController:(UIViewController *)controller{
    // presentController
}
- (void)fjSlidingController:(FJSlidingController *)fjSlidingController selectedTitle:(NSString *)title{
    // presentTitle
}
-(void)dealloc{
    NSLog(@"!dealloc!");
}


#pragma mark --- 已有账号 点此登录


//登录
- (void)addnanButton:(UIButton *)sender{
  
    
    RootViewController *RoVi = [[RootViewController alloc]init];
    [self.navigationController pushViewController:RoVi animated:nil];
    
//    [self.navigationController presentViewController:RoVi animated:YES completion:nil];
}
//注册
- (void)addnvButton:(UIButton *)sender{
    ZhuCeViewController *zhuceView = [[ZhuCeViewController alloc]init];
    [self.navigationController pushViewController:zhuceView animated:nil];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//隐藏tabBarController
- (void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];

    if ([uidS isEqualToString:@""] || uidS == nil){
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        self.tabBarController.tabBar.hidden = YES;
       
    }else {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.tabBarController.tabBar.hidden = NO;
    }
    
}

-(void)addzhiliaoAction:(NSNotification *)obj{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    [defatults setObject:@"LLLLL" forKey:user_bioashi];

    [defatults synchronize];
    
    [self.startView removeFromSuperview];
    
    
    self.nian = @"";
    self.shiID = @"";
    self.shenID = @"";
    self.xingsex = @"";
    [[NSNotificationCenter defaultCenter] removeObserver:@"addzhiliaoAction" name:nil object:self];
    
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    self.tabBarController.tabBar.hidden = NO;
    
    [self addnavigationItem];
    self.datasouce = self;
    self.delegate = self;
    
    NearViewController *v1 = [[NearViewController alloc]init];
    v1.parentController = self;
    
    
    RecommendedViewController *v2 = [[RecommendedViewController alloc]init];
    v2.parentController = self;
    VideoViewController *v3 = [[VideoViewController alloc]init];
    v3.parentController = self;
    
    RankingViewController *v4 = [[RankingViewController alloc]init];
    v4.parentController = self;
    
    self.titles      = @[@"推荐",@"附近",@"视频",@"排行"];
    self.controllers = @[v1,v2,v3,v4];
    [self addChildViewController:v1];
    [self addChildViewController:v2];
    [self addChildViewController:v3];
    [self addChildViewController:v4];
    
    //    self.title = self.titles[0];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addLiaoSisterViewXiuXiAction) name:@"LiaoSisterViewXiuXiu" object:nil];
    
    [self reloadData];

    
}



-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    _louView.hidden = 1;
}

//具体委托方法实例

-(void)segmentAction:(UISegmentedControl *)Seg{
    
    NSInteger Index = Seg.selectedSegmentIndex;
    
    switch (Index) {
            
        case 0:
            
            _louView.hidden = YES;
            break;
            
        case 1:
            [self shuaxuan];
            _louView.hidden = YES;
            break;
            
        default:
            
            break;
            
    }
    
}
- (void)shuaxuan{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    [defatults setObject:self.xingsex forKey:@"shaisex"];
    [defatults setObject:self.nian forKey:@"shuanian"];
    [defatults setObject:self.shenID forKey:@"shuashenID"];
    [defatults setObject:self.shiID forKey:@"shuashiID"];
   
    [defatults synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"InfoNotificationLI" object:nil];

}

#pragma mark - 漏斗点击事件
//性别 1000 1001女 1002男
- (void)addyonghu:(UIButton *)sender{
    if (sender.tag == 1000) {
        [_quanButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _quanButton.layer.borderColor = [UIColor redColor].CGColor;
        [_nvButton setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
        _nvButton.layer.borderColor = [UIColor grayColor].CGColor;
        [_nanButton setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
        _nanButton.layer.borderColor = [UIColor grayColor].CGColor;
        self.xingsex = @"0";

    }else if(sender.tag == 1001) {
        [_nvButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _nvButton.layer.borderColor = [UIColor redColor].CGColor;
        [_quanButton setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
        _quanButton.layer.borderColor = [UIColor grayColor].CGColor;
        [_nanButton setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
        _nanButton.layer.borderColor = [UIColor grayColor].CGColor;
        self.xingsex = @"1";
    }else{
        [_nanButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _nanButton.layer.borderColor = [UIColor redColor].CGColor;
        [_nvButton setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
        _nvButton.layer.borderColor = [UIColor grayColor].CGColor;
        [_quanButton setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
        _quanButton.layer.borderColor = [UIColor grayColor].CGColor;
        self.xingsex = @"2";
    }
    
    
}
//地区 1003省 1004市
- (void)adddiqu:(UIButton *)sender{
    
    self.cityChoose = [[CityChoose alloc] init];
    __weak typeof(self) weakSelf = self;
    self.cityChoose.config = ^(NSString *province, NSString *city, NSString *town, NSString *shenID){
        NSString *string = [NSString stringWithFormat:@"%@-%@",province,city];
        [weakSelf.shengButton setTitle:string forState:UIControlStateNormal];
        weakSelf.shenID = shenID;
        weakSelf.shiID = town;
//        weakSelf.shengButton.text = [NSString stringWithFormat:@"%@-%@",province,city];
//        _town = town;
    };
    [self.view addSubview:self.cityChoose];
    
    
}
//年龄
- (void)addnianling:(UIButton *)sender{
    
    [_buxianButton setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
    _buxianButton.layer.borderColor = [UIColor grayColor].CGColor;
    [_eighteenthButton setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
    _eighteenthButton.layer.borderColor = [UIColor grayColor].CGColor;
    [_twentySixButton setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
    _twentySixButton.layer.borderColor = [UIColor grayColor].CGColor;
    [_thirtysixButton setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
    _thirtysixButton.layer.borderColor = [UIColor grayColor].CGColor;
    [_fortyButton setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
    _fortyButton.layer.borderColor = [UIColor grayColor].CGColor;
    [_tfiftyButton setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
    _tfiftyButton.layer.borderColor = [UIColor grayColor].CGColor;
    
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    sender.layer.borderColor = [UIColor redColor].CGColor;
    NSString *st = [NSString stringWithFormat:@"%ld",sender.tag - 1005];
    self.nian = st;
  
    
    
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

//
//  AppDelegate.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/2/27.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "StartViewController.h"
#import "MessagesViewController.h"
#import "DynamicViewController.h"
#import "MyViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

//新浪微博SDK头文件
#import "WeiboSDK.h"

//推送的跳转
#import "ChatViewController.h"
#import "MainXiuViewController.h"
#import "MyManyViewController.h"
#import <AlipaySDK/AlipaySDK.h>

@interface AppDelegate ()<JPUSHRegisterDelegate>
@property (nonatomic, strong) MessagesViewController * second;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIView *BaView;
@property (nonatomic, strong) NSDictionary *shujuData;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSTimer *timer2;

@property (nonatomic, strong) UIApplication *appliLi;
@property (nonatomic, copy)NSString *hhhh;
@property (nonatomic, strong)NSDictionary *uidData;
@end

@implementation AppDelegate
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
//
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self configRootViewController];
    
    // Override point for customization after application launch.
    [ShareSDK registerApp:@"19a116f508618" activePlatforms:@[@(SSDKPlatformTypeWechat),
                                                             @(SSDKPlatformTypeQQ),
                                                             @(SSDKPlatformTypeSinaWeibo)] onImport:^(SSDKPlatformType platformType) {
                                                                 switch (platformType) {
                                                                     case SSDKPlatformTypeWechat:
                                                                         [ShareSDKConnector connectWeChat:[WXApi class]];
                                                                         break;
                                                                     case SSDKPlatformTypeQQ:
                                                                         [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                                                                         break;
                                                                     case SSDKPlatformTypeSinaWeibo:
                                                                         [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                                                                         break;
                                                                     default:
                                                                         break;
                                                                 }
                                                             } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                                                                 switch (platformType) {
                                                                     case SSDKPlatformTypeWechat:
                                                                         [appInfo SSDKSetupWeChatByAppId:WXAppId appSecret:@"ec9423ddc4c6ec73395f0da8de91afbd"];
                                                                         break;
                                                                     case SSDKPlatformTypeQQ:
                                                                         [appInfo SSDKSetupQQByAppId:@"1105394029" appKey:@"jRbLab3xDyPLii5d" authType:SSDKAuthTypeBoth];
                                                                         break;
                                                                     case SSDKPlatformTypeSinaWeibo:
                                                                         [appInfo SSDKSetupSinaWeiboByAppKey:@"2606672122"
                                                                                                   appSecret:@"7b7e08969c36bac248a5f8c496ca2e5d"
                                                                                                 redirectUri:@"http://www.sharesdk.cn"
                                                                                                    authType:SSDKAuthTypeBoth];
                                                                         break;
                                                                     default:
                                                                         break;
                                                                 }
                                                                 
                                                                 
                                                             }];
    //推送
    // 3.0.0及以后版本注册可以这样写，也可以继续用旧的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    
    return YES;
}
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    self.uidData = userInfo;
    if ([self.hhhh isEqualToString:@"NO"]) {
        [self houtaiView];
        }else {
        [self qiantaiView];
        

    }
    
    
}
//前台
- (void)qiantaiView{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shuxinTableVIew" object:nil];

    NSDictionary *userInfo = self.uidData;
    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    self.shujuData = extras;
    NSString *typeString = extras[@"type"];
    
    if ([typeString isEqualToString:@"私信"]) {
        _BaView.hidden = YES;
        [_BaView removeFromSuperview];
        [self.timer invalidate];
        self.BaView = [[UIView alloc]init];
        _BaView.backgroundColor = [UIColor colorWithRed:63.0/255.0 green:63.0/255.0 blue:63.0/255.0 alpha:1];
        _BaView.frame = CGRectMake(0, 0, kScreen_w, 80);
        //创建手势对象
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dianjitapAction)];
        //讲手势添加到指定的视图上
        [_BaView addGestureRecognizer:tap];
        [self.window addSubview:_BaView];
        
        UIImageView *aleImageView = [[UIImageView alloc]init];
        aleImageView.frame = CGRectMake(10, 24, 46, 46);
        aleImageView.layer.cornerRadius = 23;
        aleImageView.layer.masksToBounds = YES;
        
        [aleImageView sd_setImageWithURL:[NSURL URLWithString:extras[@"data"][@"avatar"]] placeholderImage:[UIImage imageNamed:zhantuImage]];
        [_BaView addSubview:aleImageView];
        UILabel *nameLabel = [[UILabel alloc]init];
        
        NSString *nameSt = extras[@"data"][@"user_nicename"];
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:15]};
        CGSize size=[nameSt sizeWithAttributes:attrs];
        nameLabel.text = extras[@"data"][@"user_nicename"];
        nameLabel.frame = CGRectMake(80, 30, size.width, 20);
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.font = [UIFont systemFontOfSize:15];
        [_BaView addSubview:nameLabel];
        UIButton *xiButton = [UIButton new];
        xiButton.frame = CGRectMake(86 + size.width , 24, 30, 12);
        xiButton.layer.cornerRadius = 3;
        xiButton.layer.masksToBounds = YES;
        xiButton.backgroundColor = [UIColor whiteColor];
        //            NSString *sexST = extras[@"data"][@"sex"];
        //            int ST = [sexST intValue];
        //            if (ST == 1) {
        //                [xiButton setImage:[UIImage imageNamed:@"icon-man2"] forState:UIControlStateNormal];
        //                NSString *age = [NSString stringWithFormat:@"%@",extras[@"age"]];
        //                [xiButton setTitle:age forState:UIControlStateNormal];
        //                [xiButton setTitleColor:blueC forState:UIControlStateNormal];
        //            }else {
        //                [xiButton setImage:[UIImage imageNamed:@"icon-woman2"] forState:UIControlStateNormal];
        //                NSString *age = [NSString stringWithFormat:@"%@",extras[@"age"]];
        //                [xiButton setTitle:age forState:UIControlStateNormal];
        //                [xiButton setTitleColor:hong forState:UIControlStateNormal];
        //            }
        //            [_BaView addSubview:xiButton];
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.frame = CGRectMake(80, 50, kScreen_w - 150, 20);
        titleLabel.text = extras[@"data"][@"content"];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:13];
        [_BaView addSubview:titleLabel];
        
        UIButton *anButton = [UIButton new];
        anButton.frame = CGRectMake(kScreen_w - 70, 32, 60, 27);
        [anButton setBackgroundImage:[UIImage imageNamed:@"icon-check"] forState:UIControlStateNormal];
        [anButton addTarget:self action:@selector(dianjitapAction) forControlEvents:UIControlEventTouchUpInside];
        [_BaView addSubview:anButton];
        
        //                self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(addTimer) userInfo:nil repeats:NO];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(action) userInfo:nil repeats:NO];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    }

}
//后台
- (void)houtaiView {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shuxinTableVIew" object:nil];

        NSDictionary *userInfo = self.uidData;
        NSDictionary *extras = [userInfo valueForKey:@"extras"];
    
        //#import "ChatViewController.h"
        //#import "MainViewController.h"
        //#import "MyManyViewController.h"
    
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"shuxinTableVIew" object:nil];
    
    //    if (self.appliLi.applicationState == UIApplicationStateActive) {
    NSString *typeString = extras[@"type"];

    if([typeString isEqualToString:@"私信"]){
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        UITabBarController *tab = (UITabBarController *)delegate.window.rootViewController;
        tab.selectedIndex = 1;
        
    }else if([typeString isEqualToString:@"返利"]){
     
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        UITabBarController *tab = (UITabBarController *)delegate.window.rootViewController;
        tab.selectedIndex = 1;
        
    }else if ([typeString isEqualToString:@"关注"]){
    
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        UITabBarController *tab = (UITabBarController *)delegate.window.rootViewController;
        tab.selectedIndex = 1;
    }else if([typeString isEqualToString:@"收礼"]){


 
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        UITabBarController *tab = (UITabBarController *)delegate.window.rootViewController;
        tab.selectedIndex = 1;
        
//        UITabBarController *tabbarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//        
//        NSNumber *index = [NSNumber numberWithInt:1];
//        
//        [tabbarVc setSelectedIndex:[index intValue]];
//        
//        [self.window.rootViewController dismissViewControllerAnimated:YES completion:^{
//            
//            
//            
//        } ];
    }
    
    
    
    
}



- (void)InfoNotificationActionLilllll{
    self.timer2 = [NSTimer scheduledTimerWithTimeInterval:6.0 target:self selector:@selector(houtaiView) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}


// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {

    NSDictionary * userInfo = notification.request.content.userInfo;

    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];

        
    
    }else {
        [JPUSHService handleRemoteNotification:userInfo];

//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ajsbd" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];

    }
//    // Required
//    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
//        [self qiantaiView];
//        
//    }else if([UIApplication sharedApplication].applicationState == UIApplicationStateBackground){
//        [self InfoNotificationActionLilllll];
//        
//    }
//    
    
    
    
    completionHandler(UNNotificationPresentationOptionBadge); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}
- (void)InfoNotificationActionLillxiuxiu{
    self.hhhh = @"2222";
}
- (void)action{
    _BaView.hidden = YES;
    [_BaView removeFromSuperview];
    [self.timer invalidate];
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    
    
    [JPUSHService handleRemoteNotification:userInfo];

    // 取得 APNs 标准信息内容
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"];                 // 推送显示的内容
    NSInteger badge = [[aps valueForKey:@"badge"] integerValue];    // badge数量
    NSString *sound = [aps valueForKey:@"sound"];                   // 播放的声音
    
    // 取得Extras字段内容
    NSString *customizeField1 = [userInfo valueForKey:@"customizeExtras"];  // 服务端中Extras字段，key是自己定义的
    NSLog(@"\nAppDelegate:\ncontent =[%@], badge=[%ld], sound=[%@], customize field  =[%@]",content,badge,sound,customizeField1);
    
   NSDictionary *extras = [userInfo valueForKey:@"extras"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shuxinTableVIew" object:nil];
    
   
    
    NSString *typeString = extras[@"type"];
    UIAlertView *alertll = [[UIAlertView alloc] initWithTitle:typeString message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertll show];
    
    
    
    completionHandler(UIBackgroundFetchResultNewData);


    
//    // Required
//    [JPUSHService handleRemoteNotification:userInfo];
//    completionHandler(UIBackgroundFetchResultNewData);
}



//注册APNs成功并上报DeviceToken

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];

    NSLog(@"deviceToken%@",deviceToken);
}
//注册失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}



- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    self.hhhh = @"YES";

//        [self loadData];

    
//    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
//    
//    NSString *user_iconST = [defatults objectForKey:user_icon];
//    int USE = [user_iconST intValue];
//    int a = USE + 1;
//    
//    
////    [UIApplication sharedApplication].applicationIconBadgeNumber = a;
//    [self.second.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d",a]];
//    NSString * st = [NSString stringWithFormat:@"%d",a];
//    [defatults setObject:st forKey:user_icon];
//    [defatults synchronize];
//    
    
    
}

#pragma mark --- 数据
- (void)loadData{

    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    if (uidS == nil) {
        
    }else {
        
        NSDictionary *dic = @{@"uid":uidS};
        [HttpUtils postRequestWithURL:API_msglist2 withParameters:dic withResult:^(id result) {
            [self.dataArray removeAllObjects];
            NSArray *array = result[@"data"];
            for (NSDictionary *dic in array) {
                MessagesModel *model = [[MessagesModel alloc]initWithDictionary:dic error:nil];
                [self.dataArray addObject:model];
            }
            int a = 0;
            for (MessagesModel *mdoel in self.dataArray) {
                int b = [mdoel.unread intValue];
                a = a + b;
            }
            if (a == 0) {
                [_second.tabBarItem setBadgeValue:nil];
                
                NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
                [defatults setObject:[NSString stringWithFormat:@"%d",a] forKey:user_icon];
                [defatults synchronize];
//                [UIApplication sharedApplication].applicationIconBadgeNumber  =  a;
                
            }else {
                [_second.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d",a]];
                NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
                
                [defatults setObject:[NSString stringWithFormat:@"%d",a] forKey:user_icon];
                [defatults synchronize];
//                [UIApplication sharedApplication].applicationIconBadgeNumber  =  a;
            }
            
            
            
        } withError:^(NSString *msg, NSError *error) {
            
        }];

        
    }
}



- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark ------------ RootViewController ---------------
-(void)configRootViewController
{

    StartViewController *tgirVC = [[StartViewController  alloc]init];
    tgirVC.tabBarItem.title = @"缘分";
    
    UIImage *musicImage = [UIImage imageNamed:@"形状-11"];
    UIImage *musicImageSel = [UIImage imageNamed:@"形状-12"];
    
    musicImage = [musicImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    musicImageSel = [musicImageSel imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [tgirVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor grayColor]} forState:UIControlStateNormal];
    
    [tgirVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor]} forState:UIControlStateSelected];
    
    
    tgirVC.tabBarItem.image = musicImage;
    tgirVC.tabBarItem.selectedImage = musicImageSel;
    UINavigationController *tgirNVC = [[UINavigationController alloc]initWithRootViewController:tgirVC];

    
    
    self.second = [[MessagesViewController alloc]init];
    _second.tabBarItem.title = @"私信";
    UIImage *secondImage = [UIImage imageNamed:@"形状-345"];
    UIImage *secondImageSel = [UIImage imageNamed:@"形状-3-拷贝"];
    
    secondImage = [secondImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    secondImageSel = [secondImageSel imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [_second.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor grayColor]} forState:UIControlStateNormal];

    [_second.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor]} forState:UIControlStateSelected];
    _second.tabBarItem.image = secondImage;
    _second.tabBarItem.selectedImage = secondImageSel;
    
    UINavigationController *secondNVC = [[UINavigationController alloc]initWithRootViewController:_second];
    
    
    
    
    
    DynamicViewController *three = [[DynamicViewController alloc]init];
    three.tabBarItem.title = @"动态";
    UIImage *threeImage = [UIImage imageNamed:@"形状-91"];
    UIImage *threeImageSel = [UIImage imageNamed:@"形状-9-拷贝"];
    
    threeImage = [threeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    threeImageSel = [threeImageSel imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [three.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor grayColor]} forState:UIControlStateNormal];
    
    [three.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor]} forState:UIControlStateSelected];
    
    three.tabBarItem.image = threeImage;
    three.tabBarItem.selectedImage = threeImageSel;
    UINavigationController *threeNVC = [[UINavigationController alloc]initWithRootViewController:three];
    
    MyViewController *MyView = [[MyViewController alloc]init];
    MyView.tabBarItem.title = @"我的";
    
    UIImage *MyImage = [UIImage imageNamed:@"形状-74"];
    UIImage *MyImageSel = [UIImage imageNamed:@"形状-7-拷贝-2"];
    
    MyImage = [MyImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    MyImageSel = [MyImageSel imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [MyView.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor grayColor]} forState:UIControlStateNormal];
    
    [MyView.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor]} forState:UIControlStateSelected];
    
    MyView.tabBarItem.image = MyImage;
    MyView.tabBarItem.selectedImage = MyImageSel;
    UINavigationController *MyViewNVC = [[UINavigationController alloc]initWithRootViewController:MyView];
    
    
    
    
    UITabBarController *tabBarViewController = [[UITabBarController alloc]init];
    [tabBarViewController setViewControllers:[NSArray arrayWithObjects:tgirNVC,secondNVC,threeNVC,MyViewNVC,nil]];
    
    //tabBarViewController.viewControllers = [NSArray arrayWithObjects:firstVc, second,three,nil];
    [self.window setRootViewController:tabBarViewController];
    
    
//    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
//    NSString *uidS = [defatults objectForKey:uidSG];
//    if (uidS == nil) {
//        
//    }else {
//        NSDictionary *dic = @{@"uid":uidS};
//        [HttpUtils postRequestWithURL:API_unreadmsg2 withParameters:dic withResult:^(id result) {
//            int a = [result[@"data"][@"totalmsg"] intValue];
//            if (a == 0){
//                [_second.tabBarItem setBadgeValue:nil];
//
//            }else {
//                [_second.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%@",result[@"data"][@"totalmsg"]]];
//
//            }
//            
//            
//            [UIApplication sharedApplication].applicationIconBadgeNumber = a;
//
//            NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
//            [defatults setObject:result[@"data"][@"totalmsg"] forKey:user_icon];
//            [defatults synchronize];
//            
//            
//            
//        } withError:^(NSString *msg, NSError *error) {
//            
//        }];
//    }
    [self loadData];
    
}

#pragma mark- JPUSHRegisterDelegate



- (void)dianjitapAction{
    _BaView.hidden = YES;
    [_BaView removeFromSuperview];
    ChatViewController *ChatView = [[ChatViewController alloc]init];
    ChatView.TOID = self.shujuData[@"fromuid"];
    ChatView.name = self.shujuData[@"user_nicename"];
    UINavigationController *ChatViewNVC = [[UINavigationController alloc]initWithRootViewController:ChatView];
    [self.window.rootViewController showViewController:ChatViewNVC sender:nil];
}


// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
    
}


//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    
//    // Required,For systems with less than or equal to iOS6
//    [JPUSHService handleRemoteNotification:userInfo];
//}
//



// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
    

            
            NSString *resultStatus = [resultDic objectForKey:@"resultStatus"];
            NSString *memo;
            if ([resultStatus intValue] == 9000) {
                memo = @"支付成功!";
                [[NSNotificationCenter defaultCenter] postNotificationName:@"participatePayWXXIU" object:nil];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"chongzhiwanchengXIU" object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"participatePayWX" object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"participatePayWXVIP" object:nil];

            }else {
                switch ([resultStatus intValue]) {
                    case 4000:
                        memo = @"失败原因:订单支付失败!";
                        break;
                    case 6001:
                        memo = @"失败原因:用户中途取消!";
                        break;
                    case 6002:
                        memo = @"失败原因:网络连接出错!";
                        break;
                    case 8000:
                        memo = @"正在处理中...";
                        break;
                    default:
                        memo = [resultDic objectForKey:@"memo"];
                        break;
                }
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:memo message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];

        }];
    }else {
        return [WXApi handleOpenURL:url delegate:self];

    }
        
    return YES;
}
#pragma mark - 微信支付回调 participatePayWX
#pragma mark 微信回调方法

- (void)onResp:(BaseResp *)resp
{
    NSString * strMsg = [NSString stringWithFormat:@"errorCode: %d",resp.errCode];
    NSLog(@"strMsg: %@",strMsg);
    
    NSString * errStr       = [NSString stringWithFormat:@"errStr: %@",resp.errStr];
    NSLog(@"errStr: %@",errStr);
    
    
    NSString * strTitle;
    //判断是微信消息的回调 --> 是支付回调回来的还是消息回调回来的.
    if ([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息的结果"];
    }
    
    NSString * wxPayResult;
    //判断是否是微信支付回调 (注意是PayResp 而不是PayReq)
    
    if ([resp isKindOfClass:[PayResp class]])
    {
        //支付返回的结果, 实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        switch (resp.errCode)
        {
            case WXSuccess:
            {
                strMsg = @"支付结果:支付成功";
                NSLog(@"支付成功: %d",resp.errCode);
                wxPayResult = @"success";
                [[NSNotificationCenter defaultCenter] postNotificationName:@"participatePayWXXIU" object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"chongzhiwanchengXIU" object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"participatePayWX" object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"participatePayWXVIP" object:nil];


                break;
            }
            case WXErrCodeUserCancel:
            {
                strMsg = @"用户取消了支付";
                NSLog(@"用户取消支付: %d",resp.errCode);
                wxPayResult = @"cancel";
                break;
            }
            default:
            {
                strMsg = [NSString stringWithFormat:@"支付失败! code: %d  errorStr: %@",resp.errCode,resp.errStr];
                strMsg = @"支付失败!";
                NSLog(@":支付失败: code: %d str: %@",resp.errCode,resp.errStr);
                wxPayResult = @"faile";
                break;
            }
        }
        //发出通知 从微信回调回来之后,发一个通知,让请求支付的页面接收消息,并且展示出来,或者进行一些自定义的展示或者跳转
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strMsg message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
   
    }
}


//
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
//{
//    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
//}
//
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
//}
//
//// NOTE: 9.0以后使用新API接口
//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
//{
//    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
//}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    //程序进入后台
    self.hhhh = @"NO";


    [JPUSHService setBadge:0];//清空JPush服务器中存储的badge值
    [JPUSHService resetBadge];
    [application setApplicationIconBadgeNumber:0];//小红点清0操作



}



@end

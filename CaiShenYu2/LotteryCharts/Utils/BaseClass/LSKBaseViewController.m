//
//  LSKBaseViewController.m
//  SingleStore
//
//  Created by hsPlan on 2017/9/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseViewController.h"
#import "UIViewController+Extend.h"
#import "LCLoginMainVC.h"
#import <UMSocialCore/UMSocialCore.h>
static const NSInteger kNavigationBarButton_Font = 15;
static NSString * const kNavigation_BackImg = @"navi_back";
@interface LSKBaseViewController ()

@end

@implementation LSKBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置不全局布局
    [self setupNotFullScreen];
    self.view.backgroundColor = ColorHexadecimal(kMainBackground_Color, 1.0);
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}
- (BOOL)isCanJumpViewForLogin:(BOOL)isNeedHiden {
    if (!kUserMessageManager.isLogin) {
        LCLoginMainVC *loginVC = [[LCLoginMainVC alloc]init];
        loginVC.isHidenNavi = YES;
        loginVC.hidesBottomBarWhenPushed = isNeedHiden;
        [self.navigationController pushViewController:loginVC animated:YES];
        return NO;
    }
    return YES;
}
- (CGFloat)viewMainHeight {
    return SCREEN_HEIGHT - STATUSBAR_HEIGHT - [self navibarHeight];
}
- (CGFloat)tabbarHeight {
    return self.tabBarController.tabBar.frame.size.height;
}
- (CGFloat)navibarHeight {
    return self.navigationController.navigationBar.frame.size.height;
}
- (CGFloat)tabbarBetweenHeight {
    if (self.tabbarHeight <= 0) {
        return 0;
    }
    return ([self tabbarHeight] - 49.0);
}
- (void)backToNornalNavigationColor {
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = KColorUtilsString(kNavigationBackground_Color);
    self.navigationController.navigationBar.tintColor = KColorUtilsString(kNavigationBackground_Color);
    [self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
}
#pragma mark - 添加返回按钮
- (void)addNavigationBackButton {
    [self addLeftNavigationButtonWithNornalImage:kNavigation_BackImg seletedImage:nil target:self action:@selector(navigationBackClick)];
}
- (void)addRedNavigationBackButton {
    [self addLeftNavigationButtonWithNornalImage:@"navi_redback" seletedImage:nil target:self action:@selector(navigationBackClick)];
}
//界面的返回 1种是 导航栏多个返回，一种是dismiss过去的导航栏
- (void)navigationBackClick {
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }
}
#pragma  mark share
- (void)shareEventClick {
    BOOL isWx = NO;
    BOOL isQQ = NO;
    if ([[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_WechatSession]) {
        isWx = YES;
    }
    if([[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_QQ]) {
        isQQ = YES;
    }
    if (!isWx && !isQQ) {
        [SKHUD showMessageInWindowWithMessage:@"暂无分享的平台"];
        return;
    }
    UIActionSheet *sheetView = [[UIActionSheet alloc]initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: nil];
    if (isWx) {
        [sheetView addButtonWithTitle:@"发送给微信好友"];
        [sheetView addButtonWithTitle:@"分享到微信朋友圈"];
    }
    if (isQQ) {
        [sheetView addButtonWithTitle:@"分享到QQ"];
    }
    @weakify(self)
    [[sheetView rac_buttonClickedSignal ]subscribeNext:^(NSNumber * _Nullable x) {
        @strongify(self)
        NSInteger index = [x integerValue];
        if (index == 1 && !isWx) {
            index = 3;
        }
        [self shareEvent:index];
    }];
    [sheetView showInView:self.view];
}
- (void)shareEvent:(NSInteger)type {
    UMSocialPlatformType platformType = UMSocialPlatformType_QQ;
    if (type == 1) {
        platformType = UMSocialPlatformType_WechatSession;
    }else if (type == 2){
        platformType = UMSocialPlatformType_WechatTimeLine;
    }
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    NSString* thumbURL = @"http://www.09041.com/logo.jpg";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"神仙鱼" descr:@"神仙鱼APP是一款可以发布3D推荐号码，云集各路3D高手精英。每天发布最新最精准最全面的3D推荐号，有效提高3D命中率，造福各地各路广大彩民的共享交流平台。" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = @"http://www.09041.com/";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    @weakify(self)
    [[UMSocialManager defaultManager]shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id result, NSError *error) {
        if (error) {
            [SKHUD showMessageInWindowWithMessage:@"分享失败"];
        }else {
            @strongify(self)
            [self shareSuccess];
            [SKHUD showMessageInWindowWithMessage:@"分享成功"];
        }
    }];
}
- (void)shareSuccess {
    
}
#pragma mark 添加导航栏按钮
//添加导航栏左按钮
- (void)addLeftNavigationButtonWithNornalImage:(NSString *)nornalImage
                                  seletedImage:(NSString *)seletedImage
                                        target:(id)target
                                        action:(SEL)action {
    UIBarButtonItem *tLeftButton = [UIBarButtonItem initBarButtonItemWithNornalImage:nornalImage seletedImage:seletedImage title:nil font:0 fontColor:nil target:target action:action isRight:NO];
    [self addNavigationLeftButton:tLeftButton];
}
- (void)addLeftNavigationButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIBarButtonItem *tLeftButton = [UIBarButtonItem initBarButtonItemWithNornalImage:nil seletedImage:nil title:title font:kNavigationBarButton_Font fontColor:KColorUtilsString(kNavigationBarButtonTitle_Color) target:target action:action isRight:NO];
    [self addNavigationLeftButton:tLeftButton];
}

//添加导行条右边按钮
- (void)addRightNavigationButtonWithNornalImage:(NSString *)nornalImage
                    seletedIamge:(NSString *)seletedImage
                          target:(id)target
                          action:(SEL)action {
    UIBarButtonItem *tRightButton = [UIBarButtonItem initBarButtonItemWithNornalImage:nornalImage seletedImage:seletedImage title:nil font:0 fontColor:nil target:target action:action isRight:YES];
    [self addNavigationRightButton:tRightButton];
}
- (void)addRightNavigationButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIBarButtonItem *tRightButton = [UIBarButtonItem initBarButtonItemWithNornalImage:nil seletedImage:nil title:title font:kNavigationBarButton_Font fontColor:KColorUtilsString(kNavigationBarButtonTitle_Color) target:target action:action isRight:YES];
    [self addNavigationRightButton:tRightButton];
}
#pragma mark - 通知
//添加监听
- (void)addNotificationWithSelector:(SEL)selector name:(NSString *)name {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:selector
                                                 name:name
                                               object:nil];
}
//移除一个通知
- (void)removeNotificationWithName:(NSString *)name {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:name object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    LSKLog(@"%@:内存回收", NSStringFromClass([self class]));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

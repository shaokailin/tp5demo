//
//  PPSSShopCardVC.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/20.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSShopCardVC.h"
#import "PPSSShopCardView.h"
#import "PPSSShareView.h"
#import <UMSocialCore/UMSocialCore.h>
@interface PPSSShopCardVC ()
@property (nonatomic, weak) PPSSShopCardView *shopCardView;
@property (nonatomic, strong) UMSocialMessageObject *shareObject;
@end

@implementation PPSSShopCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kShopCard_Title_Name;
    [self addNavigationBackButton];
    [self initializeMainView];
}
- (void)shareShopCard {
    @weakify(self)
    PPSSShareView *shareView = [[PPSSShareView alloc]initWithShareBlock:^(NSInteger shareType) {
      @strongify(self)
        [self shareCardWithType:shareType];
    } tabbarHeight:self.tabbarBetweenHeight];
    [shareView shopInView];
}
- (void)shareCardWithType:(NSInteger)type {
    @weakify(self)
    [[UMSocialManager defaultManager]shareToPlatform:type messageObject:self.shareObject currentViewController:self completion:^(id result, NSError *error) {
        @strongify(self)
        [SKHUD showMessageInView:self.view withMessage:error == nil ? @"分享成功":@"分享失败"];
    }];
}
- (UMSocialMessageObject *)shareObject {
    if (!_shareObject) {
        _shareObject = [UMSocialMessageObject messageObject];
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"花生计划分享" descr:@"花生计划间距" thumImage:ImageNameInit(@"appicon")];
        //设置网页地址
        shareObject.webpageUrl = KUserMessageManager.qcode;
        //分享消息对象设置分享内容对象
        _shareObject.shareObject = shareObject;
    }
    return _shareObject;
}
- (void)initializeMainView {
    PPSSShopCardView *cardView = [[PPSSShopCardView alloc]init];
    cardView.shopName = KUserMessageManager.shopName;
    @weakify(self)
    [[cardView.applyBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self shareShopCard];
    }];
    self.shopCardView = cardView;
    [self.view addSubview:cardView];
    WS(ws)
    [cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
    }];
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

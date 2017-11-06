//
//  PPSSCashierHomeFooterReusableView.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/27.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSCashierHomeFooterReusableView.h"
#import "LSKBarnerScrollView.h"
@interface PPSSCashierHomeFooterReusableView (){
    UILabel *_collectionMoneyLbl;
    UILabel *_collectionCountLbl;
    UILabel *_addMemberCountLbl;
}
@property (nonatomic, weak) UIButton *noticeBtn;
@property (nonatomic, weak) UIView *userSettingBtn;
@property (nonatomic, weak) LSKBarnerScrollView *bannerView;
@end
@implementation PPSSCashierHomeFooterReusableView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self _layoutMainView];
    }
    return self;
}
- (void)setupCashierContentWithMoney:(NSString *)money count:(NSString *)count addMember:(NSString *)member {
    _collectionMoneyLbl.text = NSStringFormat(@"￥%@",money);
    _collectionCountLbl.text = count;
    _addMemberCountLbl.text = member;
}
- (void)setupBannersImageArray:(NSArray *)array {
    [_bannerView setupBannarContentWithUrlArray:array];
}
- (void)_layoutMainView {
    [self _layoutMoneyView];
//    44 + 2 + 60
    @weakify(self)
    LSKBarnerScrollView *banner = [[LSKBarnerScrollView alloc]initWithFrame:CGRectMake(0, 44 + 2 + 60, SCREEN_WIDTH, WIDTH_RACE_6S(75)) placeHolderImage:nil imageDidSelectedBlock:^(NSInteger selectedIndex) {
        @strongify(self)
        if (self.clickBlock) {
            self.clickBlock(selectedIndex);
        }
    }];
    self.bannerView = banner;
    [self addSubview:_bannerView];
    [self _layoutNoticeView];
}
- (void)viewDidAppearForBanner {
    [_bannerView viewDidAppearStartRun];
}
- (void)viewDidDisAppearForBanner {
    [_bannerView viewDidDisappearStop];
}
- (void)_layoutMoneyView {
    UIView *todayDataView = [[UIView alloc]init];
    UIView *lineView = [PPSSPublicViewManager initializeLineView];
    [todayDataView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(todayDataView);
        make.top.equalTo(todayDataView).with.offset(43);
        make.height.mas_equalTo(LINEVIEW_WIDTH);
    }];
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:@"今日数据" font:14 textColor:[UIColor blackColor] textAlignment:0 backgroundColor:nil];
    [todayDataView addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(todayDataView).with.offset(15);
        make.top.equalTo(todayDataView);
        make.bottom.equalTo(lineView.mas_top);
    }];
    
    UILabel *collectionMoneyTitleLbl = [PPSSPublicViewManager initLblForColor3333:[self returnTitleWithIndex:0] textAlignment:1];
    
    [todayDataView addSubview:collectionMoneyTitleLbl];
    UILabel *collectionMoneyLbl = [PPSSPublicViewManager initLblForColorPink:@"￥0.00" textAlignment:1];
    _collectionMoneyLbl = collectionMoneyLbl;
    [todayDataView addSubview:collectionMoneyLbl];
    
    UILabel *collectionCountTitleLbl = [PPSSPublicViewManager initLblForColor3333:[self returnTitleWithIndex:1] textAlignment:1];
    [todayDataView addSubview:collectionCountTitleLbl];
    UILabel *collectionCountLbl = [PPSSPublicViewManager initLblForColorPink:@"0" textAlignment:1];
    _collectionCountLbl = collectionCountLbl;
    [todayDataView addSubview:collectionCountLbl];
    
    UILabel *addMemberCountTitleLbl = [PPSSPublicViewManager initLblForColor3333:[self returnTitleWithIndex:2] textAlignment:1];
    [todayDataView addSubview:addMemberCountTitleLbl];
    UILabel *addMemberCountLbl = [PPSSPublicViewManager initLblForColorPink:@"0" textAlignment:1];
    _addMemberCountLbl = addMemberCountLbl;
    [todayDataView addSubview:addMemberCountLbl];
    
    
    [collectionMoneyTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(todayDataView);
        make.top.equalTo(lineView.mas_bottom).with.offset(11);
    }];
    [collectionMoneyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(collectionMoneyTitleLbl.mas_bottom).with.offset(9);
        make.left.right.equalTo(collectionMoneyTitleLbl);
    }];
    [collectionCountTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(collectionMoneyTitleLbl.mas_right);
        make.top.equalTo(collectionMoneyTitleLbl);
        make.width.equalTo(collectionMoneyTitleLbl);
    }];
    [collectionCountLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(collectionMoneyLbl);
        make.left.right.equalTo(collectionCountTitleLbl);
    }];
    
    [addMemberCountTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(collectionCountTitleLbl.mas_right);
        make.top.equalTo(collectionMoneyTitleLbl);
        make.right.equalTo(todayDataView);
        make.width.equalTo(collectionCountTitleLbl);
    }];
    [addMemberCountLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(collectionMoneyLbl);
        make.left.right.equalTo(addMemberCountTitleLbl);
    }];
    UIView *lineView2 = [PPSSPublicViewManager initializeLineView];
    [todayDataView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(todayDataView);
        make.height.mas_equalTo(2);
    }];
    [self addSubview:todayDataView];
    WS(ws)
    [todayDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(ws);
        make.height.mas_equalTo(44 + 60 + 2);
    }];
}
- (void)_layoutNoticeView {
    UIView *noticeView = [[UIView alloc]init];
    noticeView.backgroundColor = ColorHexadecimal(kMainBackground_Color, 1.0);
    UIButton *notice = [self customBtnWithImage:@"cashier_notice" title:@"系统公告" tag:101];
    _noticeBtn = notice;
    [noticeView addSubview:_noticeBtn];
    
    [_noticeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(noticeView).with.insets(UIEdgeInsetsMake(10, 0, 10, 0));
    }];
    [self addSubview:noticeView];
    WS(ws)
    [noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(ws);
        make.top.equalTo(ws.bannerView.mas_bottom);
        make.height.mas_equalTo(44 + 20);
    }];
}
- (UIButton *)customBtnWithImage:(NSString *)image title:(NSString *)title tag:(NSInteger)tag {
    UIButton *noticeBtn = [LSKViewFactory initializeButtonWithTitle:nil nornalImage:nil selectedImage:nil target:self action:@selector(clickEvent:) textfont:0 textColor:nil backgroundColor:COLOR_WHITECOLOR backgroundImage:nil];
    noticeBtn.tag = tag;
    UIImageView *iconImageView = [[UIImageView alloc]initWithImage:ImageNameInit(image)];
    [noticeBtn addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(noticeBtn).with.offset(15);
        make.centerY.equalTo(noticeBtn);
        make.width.mas_equalTo(20);
    }];
    
    UILabel *titleLbl = [PPSSPublicViewManager initLblForColor3333:title textAlignment:0];
    [noticeBtn addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageView.mas_right).with.offset(8);
        make.centerY.equalTo(noticeBtn);
    }];
    UIImageView *arrow = [[UIImageView alloc]initWithImage:ImageNameInit(@"arrow_right")];
    [noticeBtn addSubview:arrow];
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(noticeBtn).with.offset(-15);
        make.centerY.equalTo(noticeBtn);
        make.width.mas_equalTo(7);
    }];
    return noticeBtn;
}
- (void)showSettingView:(BOOL)isShow {
    if (!_userSettingBtn && !isShow) {
        return;
    }
    if (self.userSettingBtn.hidden != !isShow) {
        self.userSettingBtn.hidden = !isShow;
        [self layoutIfNeeded];
    }
    
}
- (UIView *)userSettingBtn {
    if (!_userSettingBtn) {
        UIView *settingView = [[UIView alloc]init];
        settingView.backgroundColor = ColorHexadecimal(kMainBackground_Color, 1.0);
        _userSettingBtn = settingView;
        UIButton *settingBtn = [self customBtnWithImage:@"cashier_setting" title:@"账号设置" tag:102];
        [settingView addSubview:settingBtn];
        WS(ws)
        [settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(settingView);
            make.bottom.equalTo(settingView).with.offset(-10);
        }];
        [self addSubview:settingView];
        [settingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(ws);
            make.height.mas_equalTo(54);
        }];
    }
    return _userSettingBtn;
}
- (void)clickEvent:(UIButton *)btn {
    if (self.btnBlock) {
        self.btnBlock(btn.tag - 100);
    }
}
- (NSString *)returnTitleWithIndex:(NSInteger)index {
    NSString *title = nil;
    switch (index) {
        case 0:
            title = @"收款金额";
            break;
        case 1:
            title = @"收款笔数";
            break;
        default:
            title = @"新增会员";
            break;
    }
    return title;
}
@end

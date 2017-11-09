//
//  LCHomeHeaderView.m
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/7.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCHomeHeaderView.h"
#import "LCSearchBarView.h"
#import "LSKBarnerScrollView.h"
#import "LCHomeFuncView.h"
#import "LCHomeNoticeView.h"
#import "LCLottery3DView.h"
#import "LCHomeHotPostHeaderView.h"
@interface LCHomeHeaderView ()
@property (nonatomic, weak) LCSearchBarView *searchBarView;
@property (nonatomic, weak) LSKBarnerScrollView *bannerView;
@property (nonatomic, weak) LCHomeNoticeView *noticeView;
@property (nonatomic, weak) LCLottery3DView *lottery3DView;
@property (nonatomic, weak) LCHomeHotPostHeaderView *hotHeaderView;
@end
@implementation LCHomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)searchViewEvent:(NSInteger)type {//1目录，2.搜索
    
}
- (void)bannerViewClick:(NSInteger)index {
    
}
- (void)_layoutMainView {
    [self _layoutSearchView];
}
- (void)_layoutSearchView {
    WS(ws)
    LCSearchBarView *searchView = [[LCSearchBarView alloc]init];
    self.searchBarView = searchView;
    searchView.searchBlock = ^(NSInteger type) {
        [ws searchViewEvent:type];
    };
    [self addSubview:searchView];
    
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(ws);
        make.height.mas_equalTo(40);
    }];
    LSKBarnerScrollView *bannerView = [[LSKBarnerScrollView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 127) placeHolderImage:nil imageDidSelectedBlock:^(NSInteger selectedIndex) {
        [ws bannerViewClick:selectedIndex];
    }];
    self.bannerView = bannerView;
    [self addSubview:bannerView];
    [bannerView setupBannarContentWithUrlArray:@[@"",@"",@""]];
    
    LCHomeFuncView *funcView = [[LCHomeFuncView alloc]init];
    [self addSubview:funcView];
    [funcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(ws);
        make.top.equalTo(bannerView.mas_bottom);
        make.height.mas_equalTo(60);
    }];
    
    LCHomeNoticeView *noticeView = [[LCHomeNoticeView alloc]init];
    self.noticeView = noticeView;
    [self addSubview:noticeView];
    [noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(ws);
        make.top.equalTo(funcView.mas_bottom);
        make.height.mas_equalTo(30);
    }];
    LCLottery3DView *lotteryView = [[[NSBundle mainBundle] loadNibNamed:@"LCLottery3DView" owner:self options:nil] lastObject];
    self.lottery3DView = lotteryView;
    [self addSubview:lotteryView];
    [lotteryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(ws);
        make.top.equalTo(noticeView.mas_bottom);
        make.height.mas_equalTo(178);
    }];
    LCHomeHotPostHeaderView *hotView = [[LCHomeHotPostHeaderView alloc]init];
    self.hotHeaderView = hotView;
    [self addSubview:hotView];
    [hotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(ws);
        make.top.equalTo(lotteryView.mas_bottom).with.offset(10);
        make.height.mas_equalTo(40);
    }];
    
}
@end

//
//  LCHomeHeaderView.m
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/7.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCHomeHeaderView.h"
#import "LCSearchBarView.h"
@interface LCHomeHeaderView ()
@property (nonatomic, weak) LCSearchBarView *searchBarView;
@end
@implementation LCHomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)_layoutMainView {
    [self _layoutSearchView];
}
- (void)_layoutSearchView {
    LCSearchBarView *searchView = [[LCSearchBarView alloc]init];
    self.searchBarView = searchView;
    [self addSubview:searchView];
    WS(ws)
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(ws);
        make.height.mas_equalTo(40);
    }];
}
@end

//
//  LCPublicNoticeDetailVC.m
//  LotteryCharts
//
//  Created by shaokai lin on 2018/6/20.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LCPublicNoticeDetailVC.h"

@interface LCPublicNoticeDetailVC ()

@end

@implementation LCPublicNoticeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavigationBackButton];
    self.navigationItem.title = @"公共内容";
    [self initializeMainView];
}
- (void)initializeMainView {
    UIScrollView *mainScroller = [LSKViewFactory initializeScrollView];
    
    CGFloat contentHeight = [self.model.title calculateTextHeight:18 width:ScreenWidth - 32];
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:self.model.title font:0 textColor:ColorRGBA(51, 51, 51, 1.0) textAlignment:0 backgroundColor:nil];
    titleLbl.font = FontBoldInit(18);
    titleLbl.numberOfLines = 0;
    [mainScroller addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mainScroller.mas_left).with.offset(16);
        make.top.equalTo(mainScroller).with.offset(18);
        make.width.mas_equalTo(ScreenWidth - 32);
    }];
    
    contentHeight += 18;
    
    UILabel *timeLbl = [LSKViewFactory initializeLableWithText:self.model.update_time font:12 textColor:ColorRGBA(153, 153, 153, 1.0) textAlignment:0 backgroundColor:nil];
    [mainScroller addSubview:timeLbl];
    [timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(titleLbl);
        make.top.equalTo(titleLbl.mas_bottom).with.offset(6);
    }];
    
    contentHeight += 18;
    contentHeight+= (40);
    contentHeight += [self.model.content calculateTextHeight:14 width:ScreenWidth - 32];
    UILabel *contentLbl = [LSKViewFactory initializeLableWithText:self.model.content font:14 textColor:ColorRGBA(51, 51, 51, 1.0) textAlignment:0 backgroundColor:nil];
    contentLbl.numberOfLines = 0;
    [mainScroller addSubview:contentLbl];
    [contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(titleLbl);
        make.top.equalTo(titleLbl.mas_bottom).with.offset(40);
    }];
    contentHeight += 20;
    mainScroller.contentSize = CGSizeMake(ScreenWidth, contentHeight);
    [self.view addSubview:mainScroller];
    [mainScroller mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, self.tabbarBetweenHeight, 0));
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

//
//  PPSSShopCardVC.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/20.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSShopCardVC.h"
#import "PPSSShopCardView.h"
@interface PPSSShopCardVC ()
@property (nonatomic, weak) PPSSShopCardView *shopCardView;
@end

@implementation PPSSShopCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kShopCard_Title_Name;
    [self addNavigationBackButton];
    [self initializeMainView];
}
- (void)initializeMainView {
    PPSSShopCardView *cardView = [[PPSSShopCardView alloc]init];
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

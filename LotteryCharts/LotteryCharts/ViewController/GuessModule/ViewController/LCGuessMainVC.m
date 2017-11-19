//
//  LCGuessMainVC.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/6.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCGuessMainVC.h"
#import "PopoverView.h"
#import "LCRechargeMainVC.h"
@interface LCGuessMainVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, weak) UITableView *mainTableView;

@end

@implementation LCGuessMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
}
- (void)showMeunView:(UIButton *)btn {
    PopoverView *popoverView = [PopoverView popoverView];
    popoverView.arrowStyle = PopoverViewArrowStyleTriangle;
    popoverView.showShade = YES;
    [popoverView showToView:btn withActions:[self neumActions]];
}

#pragma mark delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    LCHomeHotPostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCHomeHotPostTableViewCell];
//    return cell;
}


- (NSArray<PopoverAction *> *)neumActions {
    @weakify(self)
    PopoverAction *multichatAction = [PopoverAction actionWithImage:nil title:@"发帖" handler:^(PopoverAction *action) {
        
    }];
    PopoverAction *addFriAction = [PopoverAction actionWithImage:nil title:@"充值" handler:^(PopoverAction *action) {
        @strongify(self)
        LCRechargeMainVC *recgarge = [[LCRechargeMainVC alloc]init];
        recgarge.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:recgarge animated:YES];
    }];
    return @[multichatAction, addFriAction];
}
- (void)initializeMainView {
    [self addRightNavigationButtonWithNornalImage:@"home_more" seletedIamge:@"home_more" target:self action:@selector(showMeunView:)];
    UITableView *mainTableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:2 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:@selector(pullUpLoadMore) separatorColor:ColorRGBA(213, 213, 215, 1.0) backgroundColor:nil];
   
//    [mainTableView registerNib:[UINib nibWithNibName:kLCHomeHotPostTableViewCell bundle:nil] forCellReuseIdentifier:kLCHomeHotPostTableViewCell];
    mainTableView.rowHeight = 80;
    self.mainTableView = mainTableView;
    [self.view addSubview:mainTableView];
    WS(ws)
    [mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
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

//
//  PPSSOderDetailVC.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/20.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSOrderDetailVC.h"
#import "PPSSOrderDetailHeaderView.h"
#import "PPSSOrderDetailTableViewCell.h"
static NSString * const kOrderDetailLeftTitlePlist = @"OrderDetailTitle";
@interface PPSSOrderDetailVC ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *_leftTitleArr;
}
@property (nonatomic, weak) PPSSOrderDetailHeaderView *hearderView;
@property (nonatomic, weak) UITableView *mainTableView;
@end

@implementation PPSSOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kOrderDetail_Title_Name;
    [self addNavigationBackButton];
    [self initializeMainView];
}
#pragma mark delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _leftTitleArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PPSSOrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSOrderDetailTableViewCell];
    NSInteger type = indexPath.row < 5 ? 1:2;
    BOOL isLast = indexPath.row == _leftTitleArr.count - 1 ? YES:NO;
    [cell setupContentWithLeft:[_leftTitleArr objectAtIndex:indexPath.row] right:@"123" type:type isLast:isLast];
    return cell;
}
#pragma mark 界面
- (void)initializeMainView {
    _leftTitleArr = [NSArray arrayWithPlist:kOrderDetailLeftTitlePlist];
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:nil footRefreshAction:nil separatorColor:ColorHexadecimal(kMainBackground_Color, 1.0) backgroundColor:nil];
    tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    [tableView registerClass:[PPSSOrderDetailTableViewCell class] forCellReuseIdentifier:kPPSSOrderDetailTableViewCell];
    tableView.rowHeight = 44;
    PPSSOrderDetailHeaderView *header = [[PPSSOrderDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 133)];
    self.hearderView = header;
    tableView.tableHeaderView = header;
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    tableView.tableFooterView = footView;
    self.mainTableView = tableView;
    [self.view addSubview:tableView];
    WS(ws)
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
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

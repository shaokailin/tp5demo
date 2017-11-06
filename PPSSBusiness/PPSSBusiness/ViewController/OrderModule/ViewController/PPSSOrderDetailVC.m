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
#import "PPSSOrderDetailViewModel.h"
static NSString * const kOrderDetailLeftTitlePlist = @"OrderDetailTitle";
@interface PPSSOrderDetailVC ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *_leftTitleArr;
}
@property (nonatomic, assign) NSInteger cellCount;
@property (nonatomic, weak) PPSSOrderDetailHeaderView *hearderView;
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, strong) PPSSOrderDetailViewModel *viewModel;
@end

@implementation PPSSOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kOrderDetail_Title_Name;
    [self addNavigationBackButton];
    [self initializeMainView];
    [self bindSignal];
}
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[PPSSOrderDetailViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        self.cellCount = _leftTitleArr.count;
        if (self.viewModel && self.viewModel.orderDetailModel && self.viewModel.orderDetailModel.account && [self.viewModel.orderDetailModel.account isKindOfClass: [NSArray class]]) {
            self.cellCount += self.viewModel.orderDetailModel.account.count;
        }
        [self.hearderView changeMoneyString:self.viewModel.orderDetailModel.realPay];
        [self.mainTableView reloadData];
    } failure:nil];
    self.viewModel.orderNo = self.orderNo;
    [self.viewModel getOrderDetail];
}
#pragma mark delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PPSSOrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSOrderDetailTableViewCell];
    NSInteger type = indexPath.row < _leftTitleArr.count - 1 ? 1:2;
    BOOL isLast = indexPath.row == _cellCount - 1 ? YES:NO;
    NSString *leftString = nil;
    NSString *rightString = nil;
    if (indexPath.row < _leftTitleArr.count) {
        leftString = [_leftTitleArr objectAtIndex:indexPath.row];
        rightString = [self returnRightValue:indexPath.row];
    }else {
        NSDictionary *dict = [self.viewModel.orderDetailModel.account objectAtIndex:indexPath.row - _leftTitleArr.count];
        leftString = [PPSSPublicMethod returnPayTypeStringWithType:[[dict objectForKey:@"payType"]integerValue]];
        rightString = NSStringFormat(@"￥%@",KNullTransformMoney([dict objectForKey:@"payFee"]));
    }
    [cell setupContentWithLeft:leftString right:rightString type:type isLast:isLast];
    return cell;
}
- (NSString *)returnRightValue:(NSInteger)index {
    NSString *value = nil;
    if (self.viewModel && self.viewModel.orderDetailModel) {
        switch (index) {
            case 0:
                value = self.viewModel.orderDetailModel.businessTime;
                break;
            case 1:
                value = KNullTransformString(self.viewModel.orderDetailModel.userName);
                break;
            case 2:
                value = [PPSSPublicMethod returnPayTypeStringWithType:[self.viewModel.orderDetailModel.businessType integerValue]];
                break;
            case 3:
                value = [self.viewModel.orderDetailModel.payState integerValue] == 1?@"支付成功":@"支付失败";
                break;
            case 4:
                value = self.viewModel.orderDetailModel.orderNo;
                break;
            case 5:
                value = self.viewModel.orderDetailModel.shopName;
                break;
            case 6:
                value = self.viewModel.orderDetailModel.totalPay;
                break;
            default:
                break;
        }
    }
    return value;
}


#pragma mark 界面
- (void)initializeMainView {
    _leftTitleArr = [NSArray arrayWithPlist:kOrderDetailLeftTitlePlist];
    _cellCount = _leftTitleArr.count;
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
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(0, 0, ws.tabbarBetweenHeight, 0));
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

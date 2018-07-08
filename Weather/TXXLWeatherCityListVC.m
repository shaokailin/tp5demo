//
//  TXXLWeatherCityListVC.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/6/27.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLWeatherCityListVC.h"
#import "TXXLCItyListHeaderView.h"
#import "TXXLCityListCell.h"
#import "TXXLWealtherVM.h"
#import "TXXLCityDBManager.h"
#import "TXXLWeatherDataManager.h"
@interface TXXLWeatherCityListVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _selectIndex;
}
@property (nonatomic, strong) TXXLWealtherVM *weatherVM;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) TXXLUserSharedInstance *manager;
@property (nonatomic, weak) TXXLWeatherDataManager *weatherManager;
@property (nonatomic, weak) TXXLCItyListHeaderView *headerView;

@end

@implementation TXXLWeatherCityListVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
    [self bindSignal];
}
- (TXXLWealtherVM *)weatherVM {
    if (!_weatherVM) {
        @weakify(self)
        _weatherVM = [[TXXLWealtherVM alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
            @strongify(self)
            if (KJudgeIsArrayAndHasValue(model)) {
                [self setupWeathData:model];
            }
        } failure:^(NSUInteger identifier, NSError *error) {
            
        }];
    }
    return _weatherVM;
}
- (void)bindSignal {
    self.weatherManager = [TXXLWeatherDataManager sharedInstance];
    [self loadWeather];
}
- (void)loadWeather {
    for (NSInteger i = 0; i < self.weatherManager.dataArray.count; i++) {
        TXXLWeatherDataModel *model = [self.weatherManager.dataArray objectAtIndex:i];
        if (model.isNeedTopReload || model.current == nil) {
            self.weatherVM.cityCode = model.code;
            [self.weatherVM getWealtherCurrent:NO];
        }
    }
}
- (void)setupWeathData:(NSArray *)array {
    NSDictionary *dict1 = [array objectAtIndex:0];
    NSDictionary *dict = [dict1 objectForKey:@"l"];
    if (!dict && array.count > 1) {
        NSDictionary *dict2 = [array objectAtIndex:1];
        dict = [dict2 objectForKey:@"l"];
    }
    NSDictionary *cityinfo = [dict1 objectForKey:@"cityinfo"];
    NSString *areaid = [cityinfo objectForKey:@"areaid"];
    NSInteger index = [self.manager cityIndex:areaid];
    if (self->_selectIndex == index) {
        if (self.listBlock) {
            self.listBlock(4, dict);
        }
    }
    [self.weatherManager updateTopData:dict index:index];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}
- (void)refreshData {
    [self.tableView reloadData];
}
- (void)headerViewClick:(NSInteger)type {
    if (type == 0) {
        if (self.tableView.editing) {
            [self.tableView setEditing:NO];
        }else {
            [self.tableView setEditing:YES];
        }
    }else if (type == 1 && self.listBlock) {
        if (self.manager.cityArray.count < 9) {
            self.listBlock(1, nil);
        }else {
            [SKHUD showMessageInWindowWithMessage:@"最多只能添加9个城市"];
        }
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.manager.cityArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TXXLCityListCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXXLCityListCell];
    TXXLCityModel *model = [self.manager.cityArray objectAtIndex:indexPath.row];
    TXXLWeatherDataModel *model1 = [self.weatherManager.dataArray objectAtIndex:indexPath.row];
    NSString *temp = @"";
    NSString *state = @"";
    if (model1.current) {
        temp = [model1.current objectForKey:@"l1"];
        NSString *code = [model1.current objectForKey:@"l5"];
        state = [TXXLCityDBManager weatherState:code];
    }
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [cell addGestureRecognizer:longPressGestureRecognizer];
    [cell setupCellContent:temp state:state cityInfo:model isSelect:indexPath.row == _selectIndex?YES:NO];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.listBlock(2,@(indexPath.row));
}
- (void)longPress:(UILongPressGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        TXXLCityListCell *cell = (TXXLCityListCell *) gestureRecognizer.view;
        [cell becomeFirstResponder];
        [self.tableView setEditing:YES];
        self.headerView.isSelect = YES;
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_selectIndex == indexPath.row) {
        return NO;
    }else {
        return YES;
    }
}
//实现这个方法不仅可以实现左滑功能,还可以自定义左滑的按钮,并且实现按钮点击处理的事件
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    self.tableView.editing = YES;
    @weakify(self)
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"设为默认" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        @strongify(self)
        if (indexPath.row != self->_selectIndex) {
            self.manager.selectIndex = indexPath.row;
            self->_selectIndex = indexPath.row;
            TXXLWeatherDataModel *model1 = [self.weatherManager.dataArray objectAtIndex:indexPath.row];
            if (!model1.current) {
                self.weatherVM.cityCode = model1.code;
                [self.weatherVM getWealtherCurrent:YES];
            }else {
                if (self.listBlock ) {
                    self.listBlock(4, model1.current);
                }
            }
#warning 修改
            [self.tableView reloadData];
        }else {
            self.tableView.editing = NO;
        }
    }];
    
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        @strongify(self)
        self.tableView.editing = NO;
        [self.manager removeCityModel:[self.manager.cityArray objectAtIndex:indexPath.row]];
        if (self.listBlock) {
            self.listBlock(3, @(indexPath.row));
        }
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }];
    return @[action1,action];
}
- (void)initializeMainView {
    self.manager = [TXXLUserSharedInstance sharedInstance];
    _selectIndex = self.manager.selectIndex;
    TXXLCItyListHeaderView *headerView = [[TXXLCItyListHeaderView alloc]init];
    @weakify(self)
    headerView.headerBlock = ^(NSInteger type) {
        @strongify(self)
        [self headerViewClick:type];
    };
    self.headerView = headerView;
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(STATUSBAR_HEIGHT + 25);
    }];
    
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:nil footRefreshAction:nil separatorColor:KColorHexadecimal(kLineMain_Color, 1.0) backgroundColor:nil];
    [tableView registerNib:[UINib nibWithNibName:kTXXLCityListCell bundle:nil] forCellReuseIdentifier:kTXXLCityListCell];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(-self.tabbarBetweenHeight);
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

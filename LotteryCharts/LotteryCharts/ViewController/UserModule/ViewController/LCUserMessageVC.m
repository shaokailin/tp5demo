//
//  LCUserMessageVC.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCUserMessageVC.h"
#import "TPKeyboardAvoidingTableView.h"
#import "LCPhotoTableViewCell.h"
#import "LCNameInputTableViewCell.h"
#import "LCSexTableViewCell.h"
#import "LCUserMessageTableViewCell.h"
#import "LCSpaceTableViewCell.h"
#import "HSPDatePickView.h"
@interface LCUserMessageVC ()<UITableViewDelegate, UITableViewDataSource>
{
    BOOL _isChange;
}
@property (nonatomic, weak) TPKeyboardAvoidingTableView *mainTableView;
@property (nonatomic, strong) HSPDatePickView *datePickView;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, assign) NSInteger sexState;
@property (nonatomic, copy) NSString *dateString;
@end

@implementation LCUserMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavigationBackButton];
    [self backToNornalNavigationColor];
    self.title = @"个人信息";
    [self addRightNavigationButtonWithTitle:@"完成" target:self action:@selector(completeEdit)];
    [self initializeMainView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_isChange) {
        [self backToNornalNavigationColor];
    }
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _isChange = YES;
}
- (void)completeEdit {
    [self.view endEditing:YES];
}
#pragma mark -delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        LCPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCPhotoTableViewCell];
        [cell setupUserPhoto:nil];
        return cell;
    }else if (indexPath.row == 4){
        LCSpaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCSpaceTableViewCell];
        return cell;
    }else if(indexPath.row == 5) {
        LCSexTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCSexTableViewCell];
        [cell setupCurrentSex:self.sexState];
        WS(ws)
        cell.sexBlock = ^(NSInteger type) {
            ws.sexState = type;
        };
        return cell;
    }else if (indexPath.row == 1) {
        LCNameInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCNameInputTableViewCell];
        [cell setupCellContentWithName:self.userName];
        WS(ws)
        cell.nameBlock = ^(NSString *name) {
            ws.userName = name;
        };
        return cell;
    }else {
        LCUserMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCUserMessageTableViewCell];
        [cell setupCellContentWithTitle:[self returnLeftString:indexPath.row] detail:[self returnRightString:indexPath.row] isShowArrow:indexPath.row == 6? YES:NO];
        return cell;
    }
}
- (NSString *)returnLeftString:(NSInteger)index {
    NSString *title = nil;
    switch (index) {
        case 2:
            title = @"码师ID";
            break;
        case 3:
            title = @"手机号码";
            break;
        case 6:
            title = @"出生日期";
            break;
        default:
            break;
    }
    return title;
}
- (NSString *)returnRightString:(NSInteger)index {
    NSString *title = nil;
    switch (index) {
        case 2:
            title = @"CSB22440";
            break;
        case 3:
            title = @"18800000000";
            break;
        case 6:
            title = self.dateString;
            break;
        default:
            break;
    }
    return title;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 75;
    }else if (indexPath.row == 4){
        return 10;
    }else {
        return 50;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 6) {
        [self.datePickView showInView];
    }
}
- (HSPDatePickView *)datePickView {
    if (!_datePickView) {
        HSPDatePickView *datePick = [[HSPDatePickView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        datePick.datePickerMode = UIDatePickerModeDate;
        WS(ws)
        datePick.dateBlock = ^(NSDate *date) {
            ws.dateString = [date dateTransformToString:@"yyyy/MM/dd"];
            [ws.mainTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:6 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        };
        _datePickView = datePick;
        [[UIApplication sharedApplication].keyWindow addSubview:datePick];
    }
    _datePickView.maxDate = [NSDate date];
    return _datePickView;
}
#pragma mark - init view
- (void)initializeMainView {
    self.userName = @"凯先生";
    self.sexState = 1;
    self.dateString = [[NSDate date]dateTransformToString:@"yyyy/MM/dd"];
    TPKeyboardAvoidingTableView *tableview = [LSKViewFactory initializeTPTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:nil footRefreshAction:nil separatorColor:nil backgroundColor:nil];
     tableview.separatorInset = UIEdgeInsetsMake(0, 20, 0, 0);
    [tableview registerNib:[UINib nibWithNibName:kLCPhotoTableViewCell bundle:nil] forCellReuseIdentifier:kLCPhotoTableViewCell];
    [tableview registerNib:[UINib nibWithNibName:kLCNameInputTableViewCell bundle:nil] forCellReuseIdentifier:kLCNameInputTableViewCell];
    [tableview registerNib:[UINib nibWithNibName:kLCUserMessageTableViewCell bundle:nil] forCellReuseIdentifier:kLCUserMessageTableViewCell];
    [tableview registerNib:[UINib nibWithNibName:kLCSexTableViewCell bundle:nil] forCellReuseIdentifier:kLCSexTableViewCell];
    [tableview registerClass:[LCSpaceTableViewCell class] forCellReuseIdentifier:kLCSpaceTableViewCell];
    self.mainTableView = tableview;
    [self.view addSubview:tableview];
    WS(ws)
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
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

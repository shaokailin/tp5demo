//
//  PPSSCashierDetailVC.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/21.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSCashierDetailVC.h"
#import "TPKeyboardAvoidingTableView.h"
#import "PPSSCashierInputTableViewCell.h"
#import "PPSSCashierSwitchTableViewCell.h"
static NSString * const kCashierTitlePlistName = @"CashierTitle";
@interface PPSSCashierDetailVC ()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *_dataArray;
}
@property (nonatomic ,weak) TPKeyboardAvoidingTableView *mainTableView;

@end

@implementation PPSSCashierDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationBackButton];
    [self initializeMainView];
}
- (void)delectCashierAction {
    
}
- (void)cashierExitAction {
    
}
#pragma mark -delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *leftString = [_dataArray objectAtIndex:indexPath.row + (indexPath.section * 4)];
    if (indexPath.section == 0) {
        PPSSCashierInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSCashierInputTableViewCell];
        [cell setupInputContentWithTitle:leftString content:nil index:indexPath.row];
        return cell;
    }else {
        PPSSCashierSwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSCashierSwitchTableViewCell];
        [cell setupSwitchContentWithTitle:leftString isSwitch:-1];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }else {
        return 44;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    }else {
        UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        UILabel *titleLbl = [PPSSPublicViewManager initLblForColor9999:@"配置该收银员权限"];
        titleLbl.font = FontNornalInit(12);
        titleLbl.frame = CGRectMake(15, 0, 200, 44);
        [sectionView addSubview:titleLbl];
        return sectionView;
    }
}
#pragma mark - init
- (void)initializeMainView {
    _dataArray = [NSArray arrayWithPlist:kCashierTitlePlistName];
    TPKeyboardAvoidingTableView *tablView = [LSKViewFactory initializeTPTableViewWithDelegate:self tableType:0 separatorStyle:1 headRefreshAction:nil footRefreshAction:nil separatorColor:ColorHexadecimal(kMainBackground_Color, 1.0) backgroundColor:nil];
    [tablView registerClass:[PPSSCashierInputTableViewCell class] forCellReuseIdentifier:kPPSSCashierInputTableViewCell];
    [tablView registerClass:[PPSSCashierSwitchTableViewCell class] forCellReuseIdentifier:kPPSSCashierSwitchTableViewCell];
    tablView.backgroundColor = ColorHexadecimal(kMainBackground_Color, 1.0);
    self.mainTableView = tablView;
    [self.view addSubview:tablView];
    WS(ws)
    [tablView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(0, 0, 45, 0));
    }];
    [self _layoutBottonView];
}
- (void)_layoutBottonView {
    NSString *btnTitle = nil;
    UIButton *cancleBtn = nil;
    WS(ws)
    if (_actionType == CashierDetailType_Add) {
        self.title = kCashierAdd_Title_Name;
        btnTitle = @"保存";
    }else {
        self.title = kCashierDetail_Title_Name;
        btnTitle = @"修改信息";
        
        cancleBtn = [LSKViewFactory initializeButtonWithTitle:@"删除收银员" nornalImage:nil selectedImage:nil target:self action:@selector(delectCashierAction) textfont:15 textColor:ColorHexadecimal(Color_Text_6666, 1) backgroundColor:COLOR_WHITECOLOR backgroundImage:nil];
        [self.view addSubview:cancleBtn];
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = ColorHexadecimal(Color_Text_6666, 1);
        [self.view addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.view);
            make.top.equalTo(ws.view.mas_bottom).with.offset(-45);
            make.right.equalTo(ws.view.mas_centerX);
            make.height.mas_equalTo(LINEVIEW_WIDTH);
        }];
        [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(ws.view);
            make.top.equalTo(lineView.mas_bottom);
            make.right.equalTo(lineView);
        }];
    }
    UIButton *sureBtn = [PPSSPublicViewManager initAPPThemeBtn:btnTitle font:15 target:self action:@selector(cashierExitAction)];
    [self.view addSubview:sureBtn];
    
    if (cancleBtn) {
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(ws.view);
            make.height.mas_equalTo(45);
            make.left.equalTo(ws.view.mas_centerX);
        }];
    }else {
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(ws.view);
            make.height.mas_equalTo(45);
        }];
    }
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

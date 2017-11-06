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
#import "PPSSCashierModel.h"
#import "PPSSCashierEditViewModel.h"

static NSString * const kCashierTitlePlistName = @"CashierTitle";
@interface PPSSCashierDetailVC ()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *_dataArray;
    NSDictionary *_valueDict;
}
@property (nonatomic ,weak) TPKeyboardAvoidingTableView *mainTableView;
@property (nonatomic, strong) PPSSCashierEditViewModel *viewModel;
@end

@implementation PPSSCashierDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationBackButton];
    [self initializeMainView];
    [self bindSignal];
}
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[PPSSCashierEditViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        NSString *alterString = nil;
        if (self.viewModel.editType == 1) {
            alterString = @"添加成功";
        }else if (self.viewModel.editType == 2) {
            alterString = @"修改成功";
        }else {
            alterString = @"删除成功";
        }
        [SKHUD showMessageInView:self.view withMessage:alterString];
        [self performSelector:@selector(navigationBackClick) withObject:nil afterDelay:1.25];
        if (KJudgeIsNullData(model)) {
            self.cashierModel.userId = model;
        }
        if (self.editBlock) {
            self.editBlock(self.viewModel.editType, self.cashierModel);
        }
    } failure:nil];
}

- (void)delectCashierAction {
    [self.view endEditing:YES];
    UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否删除当前收银员" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
    @weakify(self)
    [alterView.rac_buttonClickedSignal subscribeNext:^(NSNumber * _Nullable x) {
        @strongify(self)
        if ([x integerValue] == 1) {
            self.viewModel.editType = self.actionType;
            [self.viewModel editCashierEvent:self.cashierModel];
        }
        [KUserMessageManager hidenAlertView];
    }];
    [KUserMessageManager showAlertView:alterView weight:2];
    
}
- (void)cashierExitAction {
    [self.view endEditing:YES];
    self.viewModel.editType = self.actionType;
    [self.viewModel editCashierEvent:self.cashierModel];
}
#pragma mark -delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *leftString = [_dataArray objectAtIndex:indexPath.row + (indexPath.section * 4)];
//    if (indexPath.section == 0) {
        PPSSCashierInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSCashierInputTableViewCell];
        [cell setupInputContentWithTitle:leftString content:[self returnInputValue:indexPath.row] index:indexPath.row];
        @weakify(self)
        cell.inputBlock = ^(id cell, NSString *text) {
            @strongify(self)
            [self inputChangeWithCell:cell content:text];
        };
        return cell;
//    }
//    else {
//        PPSSCashierSwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSCashierSwitchTableViewCell];
//        [cell setupSwitchContentWithTitle:leftString isSwitch:[self returnSwitchValue:indexPath.row]];
//        @weakify(self)
//        cell.switchBlock = ^(id cell, NSInteger isOn) {
//            @strongify(self)
//            [self switchChangeWithCell:cell state:isOn];
//        };
//        return cell;
//    }
}
- (void)inputChangeWithCell:(PPSSCashierInputTableViewCell *)cell content:(NSString *)content {
    NSInteger index = [self.mainTableView indexPathForCell:cell].row;
    switch (index) {
        case 0:
            self.cashierModel.name = content;
            break;
        case 1:
            self.cashierModel.phone = content;
            break;
        case 2:
            self.cashierModel.password = content;
            break;
        case 3:
            self.cashierModel.againPassword = content;
            break;
        default:
            break;
    }
}
- (NSString *)returnInputValue:(NSInteger)index {
    NSString *content = nil;
    switch (index) {
        case 0:
            content = self.cashierModel.name;
            break;
        case 1:
            content = self.cashierModel.phone;
            break;
        case 2:
            content = self.cashierModel.password;
            break;
        case 3:
            content = self.cashierModel.againPassword;
            break;
        default:
            break;
    }
    return content;
}
//- (void)switchChangeWithCell:(PPSSCashierSwitchTableViewCell *)cell state:(NSInteger)state {
//    NSInteger index = [self.mainTableView indexPathForCell:cell].row;
//    switch (index) {
//        case 0:
//            self.cashierModel.powerIncome = state;
//            break;
//        case 1:
//            self.cashierModel.powerStream = state;
//            break;
//        case 2:
//            self.cashierModel.powerPromotion = state;
//            break;
//        case 3:
//            self.cashierModel.powermember = state;
//            break;
//        default:
//            break;
//    }
//}
//- (NSInteger)returnSwitchValue:(NSInteger)index {
//    NSInteger indexValue = -1;
//    switch (index) {
//        case 0:
//            indexValue = self.cashierModel.powerIncome;
//            break;
//        case 1:
//            indexValue = self.cashierModel.powerStream;
//            break;
//        case 2:
//            indexValue = self.cashierModel.powerPromotion;
//            break;
//        case 3:
//            indexValue = self.cashierModel.powermember;
//            break;
//        default:
//            break;
//    }
//    return indexValue;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    if (section == 0) {
//        return 0;
//    }else {
//        return 44;
//    }
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    if (section == 0) {
//        return nil;
//    }else {
//        UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
//        UILabel *titleLbl = [PPSSPublicViewManager initLblForColor9999:@"配置该收银员权限"];
//        titleLbl.font = FontNornalInit(12);
//        titleLbl.frame = CGRectMake(15, 0, 200, 44);
//        [sectionView addSubview:titleLbl];
//        return sectionView;
//    }
//}
#pragma mark - init
- (void)initializeMainView {
    _dataArray = [NSArray arrayWithPlist:kCashierTitlePlistName];
    if (!_cashierModel) {
        _cashierModel = [[PPSSCashierModel alloc]init];
//        _cashierModel.powerIncome = 1;
//        _cashierModel.powermember = 1;
//        _cashierModel.powerStream = 1;
//        _cashierModel.powerPromotion = 1;
    }
    TPKeyboardAvoidingTableView *tablView = [LSKViewFactory initializeTPTableViewWithDelegate:self tableType:0 separatorStyle:1 headRefreshAction:nil footRefreshAction:nil separatorColor:ColorHexadecimal(kMainBackground_Color, 1.0) backgroundColor:nil];
    [tablView registerClass:[PPSSCashierInputTableViewCell class] forCellReuseIdentifier:kPPSSCashierInputTableViewCell];
//    [tablView registerClass:[PPSSCashierSwitchTableViewCell class] forCellReuseIdentifier:kPPSSCashierSwitchTableViewCell];
    tablView.backgroundColor = ColorHexadecimal(kMainBackground_Color, 1.0);
    tablView.rowHeight = 50;
    self.mainTableView = tablView;
    [self.view addSubview:tablView];
    WS(ws)
    [tablView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(0, 0, 45 + ws.tabbarBetweenHeight, 0));
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
        lineView.backgroundColor = ColorHexadecimal(Color_Text_CCCC, 1);
        [self.view addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.view);
            make.top.equalTo(ws.view.mas_bottom).with.offset(-45 - ws.tabbarBetweenHeight);
            make.right.equalTo(ws.view.mas_centerX);
            make.height.mas_equalTo(LINEVIEW_WIDTH);
        }];
        [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.view);
            make.bottom.equalTo(ws.view).with.offset(- ws.tabbarBetweenHeight);
            make.top.equalTo(lineView.mas_bottom);
            make.right.equalTo(lineView);
        }];
    }
    UIButton *sureBtn = [PPSSPublicViewManager initAPPThemeBtn:btnTitle font:15 target:self action:@selector(cashierExitAction)];
    [self.view addSubview:sureBtn];
    
    if (cancleBtn) {
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(ws.view);
            make.bottom.equalTo(ws.view).with.offset(- ws.tabbarBetweenHeight);
            make.height.mas_equalTo(45);
            make.left.equalTo(ws.view.mas_centerX);
        }];
    }else {
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(ws.view);
            make.bottom.equalTo(ws.view).with.offset(- ws.tabbarBetweenHeight);
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

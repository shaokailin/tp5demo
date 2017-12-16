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
#import "RSKImageCropper.h"
#import "LCUserMessageViewModel.h"
@interface LCUserMessageVC ()<UITableViewDelegate, UITableViewDataSource,RSKImageCropViewControllerDelegate>
{
    BOOL _isChange;
}
@property (nonatomic, weak) TPKeyboardAvoidingTableView *mainTableView;
@property (nonatomic, strong) HSPDatePickView *datePickView;
@property (nonatomic, strong) LCUserMessageViewModel *viewModel;
@end

@implementation LCUserMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavigationBackButton];
    [self backToNornalNavigationColor];
    self.title = @"个人信息";
    [self addRightNavigationButtonWithTitle:@"完成" target:self action:@selector(completeEdit)];
    [self bindSignal];
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
- (void)bindSignal {
    _viewModel = [[LCUserMessageViewModel alloc]init];
}
- (void)completeEdit {
    [self.view endEditing:YES];
    [self.viewModel updateUserMessage];
}
#pragma mark 拍照
- (void)selectImage:(UIImage *)image {
    RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:image cropMode:RSKImageCropModeSquare];
    imageCropVC.delegate = self;
    imageCropVC.portraitSquareMaskRectInnerEdgeInset = (SCREEN_WIDTH - 260) / 2.0;
    imageCropVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:imageCropVC animated:NO];
}
#pragma mark - RSKImageCropViewControllerDelegate

- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)imageCropViewController:(nonnull RSKImageCropViewController *)controller didCropImage:(nonnull UIImage *)croppedImage usingCropRect:(CGRect)cropRect rotationAngle:(CGFloat)rotationAngle {
    self.viewModel.photoImage = croppedImage;
    [self.mainTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)changePhoto {
    UIActionSheet *sheetView = [[UIActionSheet alloc]initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"手机相册", nil];
    @weakify(self)
    [sheetView.rac_buttonClickedSignal subscribeNext:^(NSNumber * _Nullable x) {
        @strongify(self)
        if ([x integerValue] == 0) {
            [self takeCameraPhoto];
        }else if ([x integerValue] == 1){
            [self takeLocationImage];
        }
    }];
    [sheetView showInView:self.view];
}

#pragma mark -delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        LCPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCPhotoTableViewCell];
        [cell setupUserPhoto:(_viewModel && _viewModel.photoImage) ? _viewModel.photoImage : kUserMessageManager.logo ];
        WS(ws)
        cell.block = ^(BOOL isPhoto) {
            [ws changePhoto];
        };
        return cell;
    }else if (indexPath.row == 4){
        LCSpaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCSpaceTableViewCell];
        return cell;
    }else if(indexPath.row == 5) {
        LCSexTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCSexTableViewCell];
        [cell setupCurrentSex:self.viewModel.sexString];
        WS(ws)
        cell.sexBlock = ^(NSInteger type) {
            ws.viewModel.sexString = type;
        };
        return cell;
    }else if (indexPath.row == 1) {
        LCNameInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCNameInputTableViewCell];
        [cell setupCellContentWithName:self.viewModel.nameString];
        WS(ws)
        cell.nameBlock = ^(NSString *name) {
            ws.viewModel.nameString = name;
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
            title = kUserMessageManager.mch_no;
            break;
        case 3:
            title = [kUserMessageManager getMessageManagerForObjectWithKey:kUserMessage_Mobile];
            break;
        case 6:
            title = self.viewModel.birthday;
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
            ws.viewModel.birthday = [date dateTransformToString:@"yyyy/MM/dd"];
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

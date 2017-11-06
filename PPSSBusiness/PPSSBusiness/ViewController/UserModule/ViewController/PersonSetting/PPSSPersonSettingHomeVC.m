//
//  PPSSPersonSettingHomeVC.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/21.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSPersonSettingHomeVC.h"
#import "PPSSSettingPasswordTableViewCell.h"
#import "LSKActionSheetView.h"
#import "PPSSChangePasswordVC.h"
#import "RSKImageCropper.h"
#import "LSKImageManager.h"
#import "PPSSCashierSwitchTableViewCell.h"
#import "AppDelegate.h"
#import "PPSSAppVersionManager.h"
@interface PPSSPersonSettingHomeVC ()<UITableViewDataSource, UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,RSKImageCropViewControllerDelegate>{
    BOOL _isOpenVoice;
    CGFloat _memoryCacheSize;
    BOOL _isHasNewAppVersion;
}
@property (nonatomic ,weak) UITableView *mainTableView;
@end

@implementation PPSSPersonSettingHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = kPersonSetting_Title_Name;
    [self addNavigationBackButton];
    [self initializeMainView];
}
#pragma mark -delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1 || indexPath.row == 3){
        static NSString *kSpaceCellIdentifier = @"SpaceCellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSpaceCellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kSpaceCellIdentifier];
            cell.selectionStyle = 0;
            cell.backgroundColor = [UIColor clearColor];
        }
        return cell;
    }else if (indexPath.row == 2){
        PPSSCashierSwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSCashierSwitchTableViewCell];
        [cell setupSwitchContentWithTitle:@"语音播报" isSwitch:!_isOpenVoice];
        @weakify(self)
        cell.switchBlock = ^(id cell, NSInteger isOn) {
            @strongify(self)
            [self changeSwitch:cell];
        };
        return cell;
    }
    else {
        PPSSSettingPasswordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSSettingPasswordTableViewCell];
        [cell setupCellContentWithLeft:[self returnLeftString:indexPath.row] right:[self returnRightString:indexPath.row]];
        return cell;
    }
}
- (void)changeSwitch:(PPSSCashierSwitchTableViewCell *)cell {
    [KUserMessageManager setMessageManagerForBoolWithKey:kSystemNoticeSetting_Voice value:!_isOpenVoice];
    _isOpenVoice = !_isOpenVoice;
    [cell setupSwitchContentWithTitle:@"语音播报" isSwitch:!_isOpenVoice];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 0) {
//        return 75;
//    }else
    if (indexPath.row == 1 || indexPath.row == 3){
        return 10;
    }
    else {
        return 44;
    }
}

#pragma mark -事件处理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 0) {
//        WS(ws)
//        LSKActionSheetView *actionSheet = [[LSKActionSheetView alloc]initWithCancelButtonTitle:@"取消" clcikIndex:^(NSInteger seletedIndex) {
//            if (seletedIndex == 2) {
//                [ws takeLocationImage];
//            }else if (seletedIndex == 1){
//                [ws takeCameraPhoto];
//            }
//        } otherButtonTitles:@"立即拍照",@"从图库中选择", nil];
//        [actionSheet showInView];
//    }else
    if (indexPath.row == 0){
        PPSSChangePasswordVC *change = [[PPSSChangePasswordVC alloc]init];
        [self.navigationController pushViewController:change animated:YES];
    }else if (indexPath.row == 4){
        if (_memoryCacheSize > 0) {
            [SKHUD showLoadingDotInView:self.view];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [LSKPublicMethodUtil clearMemoryCache];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self performSelector:@selector(showCleanSuccess) withObject:nil afterDelay:1.0];
                });
            });
        }else {
            [SKHUD showMessageInView:self.view withMessage:@"暂无缓存!~"];
        }
        
    }else if (indexPath.row == 5 && _isHasNewAppVersion){
        [PPSSAppVersionManager jumpUpdateVersion];
    }
}
- (void)showCleanSuccess {
    _memoryCacheSize = 0.00;
    [self.mainTableView reloadData];
    [SKHUD showMessageInView:self.view withMessage:@"清除缓存成功"];
}
- (void)loginOutClick {
    UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:nil message:@"确定要退出登录吗?" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
    [alterView.rac_buttonClickedSignal subscribeNext:^(NSNumber * _Nullable x) {
        if ([x integerValue] == 1) {
            [KUserMessageManager removeUserMessage];
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [appDelegate windowRootControllerChange:NO];
            [appDelegate delectFontSettingTabbar];
        }
        [KUserMessageManager hidenAlertView];
    }];
    [KUserMessageManager showAlertView:alterView weight:2];
}
#pragma mark - init
- (void)initializeMainView {
    _isOpenVoice = [KUserMessageManager getMessageManagerForBoolWithKey:kSystemNoticeSetting_Voice];
    _isHasNewAppVersion = [PPSSAppVersionManager isHasNewVersion];
    _memoryCacheSize = [LSKPublicMethodUtil memoryCacheSize];
    UITableView *tablView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:0 separatorStyle:1 headRefreshAction:nil footRefreshAction:nil separatorColor:ColorHexadecimal(kMainBackground_Color, 1.0) backgroundColor:nil];
    [tablView registerClass:[PPSSSettingPasswordTableViewCell class] forCellReuseIdentifier:kPPSSSettingPasswordTableViewCell];
    [tablView registerClass:[PPSSCashierSwitchTableViewCell class] forCellReuseIdentifier:kPPSSCashierSwitchTableViewCell];
    self.mainTableView = tablView;
    [self.view addSubview:tablView];
    WS(ws)
    [tablView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(0, 0, 49 + ws.tabbarBetweenHeight, 0));
    }];
    UIButton *loginOutBtn = [PPSSPublicViewManager initAPPThemeBtn:@"退出登录" font:18 target:self action:@selector(loginOutClick)];
    [self.view addSubview:loginOutBtn];
    [loginOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(ws.view);
        make.bottom.equalTo(ws.view).with.offset(-ws.tabbarBetweenHeight);
        make.top.equalTo(tablView.mas_bottom);
    }];
}

- (NSString *)returnLeftString:(NSInteger)index {
    NSString *titleString = nil;
    switch (index) {
        case 0:
            titleString = @"修改密码";
            break;
        case 4:
            titleString = @"清理缓存";
            break;
        case 5:
            titleString = @"版本检测";
            break;
            
        default:
            break;
    }
    return titleString;
}
- (NSString *)returnRightString:(NSInteger)index {
    NSString *titleString = nil;
    switch (index) {
        case 0:
            titleString = @"请输入密码";
            break;
        case 4:
            titleString = NSStringFormat(@"%.2fM",_memoryCacheSize);
            break;
        case 5:
            titleString = _isHasNewAppVersion == YES? NSStringFormat(@"有最新版本! 点击更新"):NSStringFormat(@"当前版本%@",[LSKPublicMethodUtil getAppVersion]);
            break;
            
        default:
            break;
    }
    return titleString;
}
//#pragma mark 头像更换
//#pragma mark 拍照
//- (void)takeCameraPhoto {
//    if ([LSKImageManager isAvailableSelectAVCapture:AVMediaTypeVideo]) {
//        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
//        if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
//            UIImagePickerController *imagePick = [[UIImagePickerController alloc]init];
//            imagePick.delegate = self;
//            imagePick.allowsEditing = YES;
//            imagePick.sourceType = sourceType;
//            [self presentViewController:imagePick animated:YES completion:^{
//
//            }];
//        }
//    }
//}
//
//- (void)takeLocationImage {
//    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
//        UIImagePickerController *imagePick = [[UIImagePickerController alloc]init];
//        imagePick.delegate = self;
//        imagePick.sourceType = sourceType;
//        [self presentViewController:imagePick animated:YES completion:^{
//
//        }];
//    }
//}
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
//    if ( [type isEqualToString:@"public.image"] )
//    {
//        __strong UIImage *image=nil;
//        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
//        {
//            image=[info objectForKey:UIImagePickerControllerEditedImage];
//        }else
//        {
//            image=[info objectForKey:UIImagePickerControllerOriginalImage];
//        }
//        [picker dismissViewControllerAnimated:NO completion:^{
//        }];
//        RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:image cropMode:RSKImageCropModeSquare];
//        imageCropVC.delegate = self;
//        imageCropVC.portraitSquareMaskRectInnerEdgeInset = (SCREEN_WIDTH - 280) / 2.0;
//        imageCropVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:imageCropVC animated:NO];
//    }
//}
//
//
//#pragma mark - RSKImageCropViewControllerDelegate
//- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller {
//    [self.navigationController popViewControllerAnimated:YES];
//}
//- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage usingCropRect:(CGRect)cropRect {
////    _changeImage = croppedImage;
//    [self.navigationController popViewControllerAnimated:YES];
//}
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
//    [picker dismissViewControllerAnimated:YES completion:^{
//    }];
//}
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

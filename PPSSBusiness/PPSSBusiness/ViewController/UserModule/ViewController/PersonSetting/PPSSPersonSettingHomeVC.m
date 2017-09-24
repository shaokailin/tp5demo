//
//  PPSSPersonSettingHomeVC.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/21.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSPersonSettingHomeVC.h"
#import "PPSSSettingPhotoTableViewCell.h"
#import "PPSSSettingPasswordTableViewCell.h"
#import "LSKActionSheetView.h"
#import "PPSSChangePasswordVC.h"
#import "RSKImageCropper.h"
#import "LSKImageManager.h"
#import <AVFoundation/AVFoundation.h>
@interface PPSSPersonSettingHomeVC ()<UITableViewDataSource, UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,RSKImageCropViewControllerDelegate>
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
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        PPSSSettingPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSSettingPhotoTableViewCell];
        [cell setupContentWithPhoto:nil];
        return cell;
    }else {
        PPSSSettingPasswordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPPSSSettingPasswordTableViewCell];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 75;
    }else {
        return 44;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        WS(ws)
        LSKActionSheetView *actionSheet = [[LSKActionSheetView alloc]initWithCancelButtonTitle:@"取消" clcikIndex:^(NSInteger seletedIndex) {
            if (seletedIndex == 2) {
                [ws takeLocationImage];
            }else if (seletedIndex == 1){
                [ws takeCameraPhoto];
            }
        } otherButtonTitles:@"立即拍照",@"从图库中选择", nil];
        [actionSheet showInView];
    }else {
        PPSSChangePasswordVC *change = [[PPSSChangePasswordVC alloc]init];
        [self.navigationController pushViewController:change animated:YES];
    }
}
#pragma mark - init
- (void)initializeMainView {
    UITableView *tablView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:0 separatorStyle:1 headRefreshAction:nil footRefreshAction:nil separatorColor:ColorHexadecimal(kMainBackground_Color, 1.0) backgroundColor:nil];
    [tablView registerClass:[PPSSSettingPhotoTableViewCell class] forCellReuseIdentifier:kPPSSSettingPhotoTableViewCell];
    [tablView registerClass:[PPSSSettingPasswordTableViewCell class] forCellReuseIdentifier:kPPSSSettingPasswordTableViewCell];
    self.mainTableView = tablView;
    [self.view addSubview:tablView];
    WS(ws)
    [tablView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
    }];
}
#pragma mark 头像更换

#pragma mark 拍照
-(void)takeCameraPhoto
{
    if ([LSKImageManager isAvailableSelectAVCapture:AVMediaTypeVideo]) {
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
            UIImagePickerController *imagePick = [[UIImagePickerController alloc]init];
            imagePick.delegate = self;
            imagePick.allowsEditing = YES;
            imagePick.sourceType = sourceType;
            [self presentViewController:imagePick animated:YES completion:^{
                
            }];
        }
    }
}

-(void)takeLocationImage
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        UIImagePickerController *imagePick = [[UIImagePickerController alloc]init];
        imagePick.delegate = self;
        imagePick.sourceType = sourceType;
        [self presentViewController:imagePick animated:YES completion:^{
            
        }];
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ( [type isEqualToString:@"public.image"] )
    {
        __strong UIImage *image=nil;
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
        {
            image=[info objectForKey:UIImagePickerControllerEditedImage];
        }else
        {
            image=[info objectForKey:UIImagePickerControllerOriginalImage];
        }
        [picker dismissViewControllerAnimated:NO completion:^{
        }];
        RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:image cropMode:RSKImageCropModeSquare];
        imageCropVC.delegate = self;
        imageCropVC.portraitSquareMaskRectInnerEdgeInset = (SCREEN_WIDTH - 280) / 2.0;
        imageCropVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:imageCropVC animated:NO];
    }
}


#pragma mark - RSKImageCropViewControllerDelegate

- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage usingCropRect:(CGRect)cropRect {
//    _changeImage = croppedImage;
    [self.navigationController popViewControllerAnimated:YES];
}




-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
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

//
//  LCPushPostMainVC.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/21.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCPushPostMainVC.h"
#import "LCPostTopView.h"
#import "LCPostShowTypeView.h"
#import "LCPostContentView.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "LSKImageManager.h"
#import "RSKImageCropper.h"
#import <AVFoundation/AVFoundation.h>
#import "LCPostVoiceView.h"
#import "LCPostAlertView.h"
@interface LCPushPostMainVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,RSKImageCropViewControllerDelegate>
@property (nonatomic, weak) TPKeyboardAvoidingScrollView *mainScrollerView;
@property (nonatomic, weak) LCPostContentView *contentView;
@property (nonatomic, weak) LCPostShowTypeView *typeView;
@property (nonatomic, weak) LCPostTopView *bottonView;
@end

@implementation LCPushPostMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发布帖子";
    [self addNavigationBackButton];
    [self initializeMainView];
    [self bindSignal];
}
- (void)pushPost {
    LCPostAlertView *alertView = [[[NSBundle mainBundle] loadNibNamed:@"LCPostAlertView" owner:self options:nil] lastObject];
    alertView.alertBlock = ^(NSInteger clickIndex) {
        if (clickIndex == 1) {
            [self navigationBackClick];
        }
    };
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:alertView];
    [alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(window);
    }];
}
- (void)bindSignal {
    @weakify(self)
    self.typeView.typeBlock = ^(NSInteger type) {
        @strongify(self)
        [self.view endEditing:YES];
        CGFloat height = self.typeView.frame.size.height;
        BOOL isNeedChange = NO;
        if (type != 1 && height != 107) {
            height = 107;
            isNeedChange = YES;
        }else if(type == 1 && height != 167) {
            height = 167;
            isNeedChange = YES;
        }
        if (isNeedChange) {
            [self.typeView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(height);
            }];
        }
    };
    self.contentView.frameBlock = ^(CGFloat height) {
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
        }];
    };
    self.contentView.mediaBlock = ^(NSInteger type) {
        @strongify(self)
        [self.view endEditing:YES];
        if (type == 0) {
            UIActionSheet *sheetView = [[UIActionSheet alloc]initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"手机相册", nil];
            [sheetView.rac_buttonClickedSignal subscribeNext:^(NSNumber * _Nullable x) {
                @strongify(self)
                if ([x integerValue] == 0) {
//                    [self takeCameraPhoto];
                    [self.contentView addImage:ImageNameInit(@"takeImage")];
                }else if ([x integerValue] == 1){
//                    [self takeLocationImage];
                     [self.contentView addImage:ImageNameInit(@"takeImage")];
                }
            }];
            [sheetView showInView:self.view];
        }else {
            LCPostVoiceView *voiceView = [[[NSBundle mainBundle] loadNibNamed:@"LCPostVoiceView" owner:self options:nil] lastObject];
            voiceView.voiceBlock = ^(NSString *time) {
                @strongify(self)
                [self.contentView addVoice:nil];
            };
             [self.view addSubview:voiceView];
            [voiceView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.view);
            }];
        }
    };
}
- (void)initializeMainView {
    [self addRightNavigationButtonWithTitle:@"发布" target:self action:@selector(pushPost)];
    WS(ws)
    TPKeyboardAvoidingScrollView *mainScrollerView = [LSKViewFactory initializeTPScrollView];
    mainScrollerView.backgroundColor = ColorHexadecimal(kMainBackground_Color, 1.0);
    self.mainScrollerView = mainScrollerView;
    [self.view addSubview:mainScrollerView];
    LCPostContentView *contentView = [[LCPostContentView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 230)];
    self.contentView = contentView;
    [mainScrollerView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(mainScrollerView);
        make.right.equalTo(ws.view);
        make.height.mas_equalTo(230);
    }];
    LCPostShowTypeView *typeView = [[[NSBundle mainBundle] loadNibNamed:@"LCPostShowTypeView" owner:self options:nil] lastObject];
    self.typeView = typeView;
    [mainScrollerView addSubview:typeView];
    
    [typeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mainScrollerView);
        make.top.equalTo(contentView.mas_bottom).with.offset(0.5);
        make.right.equalTo(ws.view);
        make.height.mas_equalTo(107);
    }];
    
    LCPostTopView *topView = [[[NSBundle mainBundle] loadNibNamed:@"LCPostTopView" owner:self options:nil] lastObject];
    self.bottonView = topView;
    [mainScrollerView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mainScrollerView);
        make.top.equalTo(typeView.mas_bottom).with.offset(10);
        make.right.equalTo(ws.view);
        make.height.mas_equalTo(184);
    }];
    
    [mainScrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(0, 0, ws.tabbarBetweenHeight , 0));
    }];
    mainScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, 107 + 184 + 230 + 30);
}

#pragma mark 拍照
- (void)takeCameraPhoto {
    [LSKImageManager isAvailableSelectAVCapture:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
            UIImagePickerController *imagePick = [[UIImagePickerController alloc]init];
            imagePick.delegate = self;
            imagePick.allowsEditing = YES;
            imagePick.sourceType = sourceType;
            [self presentViewController:imagePick animated:YES completion:^{
                
            }];
        }
    }];
}

- (void)takeLocationImage {
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
        RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:image cropMode:RSKImageCropModeCustom];
        imageCropVC.delegate = self;
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
    [self.contentView addImage:croppedImage];
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

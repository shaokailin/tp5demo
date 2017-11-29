//
//  LCBaseMediaViewController.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/29.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCBaseMediaViewController.h"
#import "LSKImageManager.h"
#import <AVFoundation/AVFoundation.h>
@interface LCBaseMediaViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation LCBaseMediaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
        [self selectImage:image];
    }
}
- (void)selectImage:(UIImage *)image {
    
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

//
//  ThroughViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/5/31.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "ThroughViewController.h"

@interface ThroughViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong)UIImageView *touimageView;

@property(nonatomic,copy)NSString * image_type;
@property(nonatomic,copy)NSString * imageFileName;
//头像
@property(nonatomic, strong)NSString *touString;

@end

@implementation ThroughViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"上传头像";
    
    UIImage *leimage = [UIImage imageNamed:@"形状16"];
    UIImage *Leimage = [leimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:Leimage style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarRinghtAction:)];
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:leftItem, nil];
    
    UIBarButtonItem *rightItem11 = [[UIBarButtonItem alloc]initWithTitle:@"跳过" style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarRinghtAction:)];
    rightItem11.tintColor = [UIColor colorWithRed:247.0/255.0 green:48.0/255.0 blue:103.0/255.0 alpha:1];
    self.navigationItem.rightBarButtonItem = rightItem11;
    
    [self addThroughView];

}
#pragma mark - 用户交互
- (void)handleNavigationBarRinghtAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)addThroughView{
    UIImageView *beiImageView = [[UIImageView alloc]init];
    beiImageView.frame = CGRectMake(0, 64, kScreen_w, kScreen_h);
    beiImageView.image = [UIImage imageNamed:@"bg-update head"];
    [self.view addSubview:beiImageView];
    UIImageView *touImageView = [[UIImageView alloc]init];
    touImageView.frame = CGRectMake(kScreen_w / 2 - 64, 120, 128, 128);
//    touImageView.backgroundColor = [UIColor redColor];
    [touImageView sd_setImageWithURL:[NSURL URLWithString:self.araet] placeholderImage:[UIImage imageNamed:zhantuImage]];
    touImageView.layer.cornerRadius = 64;
    touImageView.layer.masksToBounds = YES;
    [self.view addSubview:touImageView];
    UIImageView *touImageView1 = [[UIImageView alloc]init];
    touImageView1.frame = CGRectMake(kScreen_w / 2 - 64, 120, 128, 128);
    //    touImageView.backgroundColor = [UIColor redColor];
    touImageView1.image = [UIImage imageNamed:@"head-1"];
    touImageView1.layer.cornerRadius = 64;
    touImageView1.layer.masksToBounds = YES;
    [self.view addSubview:touImageView1];
    
    
    UILabel *tiLabel = [[UILabel alloc]init];
    tiLabel.frame = CGRectMake(12, 310, kScreen_w - 24, 30);
    tiLabel.font = [UIFont systemFontOfSize:20];
    tiLabel.text = @"您的头像被拒绝,请重新上传";
    tiLabel.alpha = 0.6;
    tiLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tiLabel];
    
    UIButton *xaingce = [UIButton new];
    xaingce.frame = CGRectMake(20, 410, 100, 40);
    xaingce.backgroundColor = [UIColor colorWithRed:70.0/255.0 green:160.0/255.0 blue:219.0/255.0 alpha:1];
    xaingce.layer.cornerRadius = 5;
    xaingce.layer.masksToBounds = YES;
    [xaingce setTitle:@"相册选取" forState:UIControlStateNormal];
    xaingce.titleLabel.font = [UIFont systemFontOfSize:15];
    [xaingce addTarget:self action:@selector(addxaingce:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:xaingce];
    
    UIButton *paizhao = [UIButton new];
    paizhao.frame = CGRectMake(kScreen_w - 120, 410, 100, 40);
    paizhao.backgroundColor = hong;
    [paizhao setTitle:@"拍照上传" forState:UIControlStateNormal];
    paizhao.layer.cornerRadius = 5;
    paizhao.layer.masksToBounds = YES;
    paizhao.titleLabel.font = [UIFont systemFontOfSize:15];
    [paizhao addTarget:self action:@selector(addpaizhao:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:paizhao];
    
    UILabel *wenLabel = [[UILabel alloc]init];
    wenLabel.frame = CGRectMake(20, 470, kScreen_w - 40, 80);
    wenLabel.numberOfLines = 0;
    wenLabel.textColor = hong;
    wenLabel.font = [UIFont systemFontOfSize:14];
    wenLabel.text = @"温馨提示:\n请上传真实、清晰的个人近照，\n上传宠物、照片不清晰、裸露的照片不与通过";
    [self.view addSubview:wenLabel];
    
    
}
//相册
- (void)addxaingce:(UIButton *)sender{
    [self openPics];

}
//拍照
- (void)addpaizhao:(UIButton *)sender{
    [self openCamera];


}
// 打开相机
- (void)openCamera {
    // UIImagePickerControllerCameraDeviceRear 后置摄像头
    // UIImagePickerControllerCameraDeviceFront 前置摄像头
    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    if (!isCamera) {
        //        [self mbhud:@"摄像头调取失败" numbertime:1];
        return ;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    // 编辑模式
    imagePicker.allowsEditing = YES;
    
    [self  presentViewController:imagePicker animated:YES completion:^{
    }];
    
    
}

// 打开相册
- (void)openPics {
    
    UIImagePickerController *pc = [[UIImagePickerController alloc]init];
    pc.delegate = self;
    [pc setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [pc setModalPresentationStyle:UIModalPresentationFullScreen];
    [pc setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [pc setAllowsEditing:YES];
    [self presentViewController:pc animated:YES completion:nil];
}


// 选中照片

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info

{
    
    _image_type = info[@"UIImagePickerControllerMediaType"];
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    int a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%d.jpg", a];//／／转为字符型
    _imageFileName = timeString;
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    //    UIImage *image2 = [UIImage imagewithImage:image];
    _touimageView.image = image;
    //    [self.tableView reloadData];
    
    
    [self shangData];
}


// 取消相册
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)shangData{
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,uploadURL];
    
    [SVProgressHUD showWithStatus:@"图片上传中..."];
    
    
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.requestSerializer = [AFHTTPRequestSerializer serializer];
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [manage POST:URL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //转化为data类型  0.5图片压缩比例 image 图片格式
        NSData *data = UIImageJPEGRepresentation(_touimageView.image, 1);
        
        //PNG图片不需要压缩
        //        NSData *data1 = UIImagePNGRepresentation(image1);
        
        //参数1:: 就是我要上传的data数据
        //参数2: 后台要求的图片名
        //参数3: 图片上传以后的名字
        //参数4: image/jpg 图片是什么格式 就写什么格式
        //            NSString *string = info[@"UIImagePickerControllerMediaType"];
        //            [formData appendPartWithFormData:data name:@"file"];
        
        [formData appendPartWithFileData:data name:[NSString stringWithFormat:@"img%d", 100+1] fileName:[NSString stringWithFormat:@"img%d.jpg", 100+1] mimeType:@"image/jpeg"];
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        NSString *string = [NSString stringWithFormat:@"%@",dic[@"code"]];
        if ([string isEqualToString:@"1"]) {
            self.touString = dic[@"data"][@"img101"][@"url"];
            [SVProgressHUD showSuccessWithStatus:@"图片上传成功"];
            
        }else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误提示" message:@"头像上传失败" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                
            }];
            
            
            [alert addAction:otherAction];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        
        
        [SVProgressHUD dismissWithDelay:1.0];
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        [SVProgressHUD dismissWithDelay:1.0];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误提示" message:@"头像上传失败" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            
            
        }];
        
        
        [alert addAction:otherAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }];
    
    
    
    
}

//隐藏tabBarController
- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    
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

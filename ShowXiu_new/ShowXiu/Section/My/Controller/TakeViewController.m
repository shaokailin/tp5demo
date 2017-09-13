//
//  TakeViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/6/8.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "TakeViewController.h"
#import "XHImageViewer.h"
#import "ArtMicroVideoViewController.h"
@interface TakeViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
//状态 0 待上传 1待审核 2 通过 3 未通过
@property (nonatomic, strong)NSString *typeST;
//图片
@property (nonatomic, strong)UIImageView *tuimmageVeiw;
@property (nonatomic, strong)UIButton *tuButton;
@property (nonatomic, strong)UIButton *tuButton2;
//视频
@property (nonatomic, strong)UIImageView *shiImageView;
@property (nonatomic, strong)UIButton *shiButton;
@property (nonatomic, strong)UIButton *shiButton2;

//女生的提示
@property (nonatomic, strong)UILabel *nvLabel;
//View
@property (nonatomic, strong)UIView *Baview;
@property(nonatomic,strong)MBProgressHUD * MBhud;//网络等待
//数据源
@property (nonatomic, strong)NSDictionary * dataDic;
@property(nonatomic, copy)NSString * image_type;
@property(nonatomic,copy)NSString * imageFileName;
//图片
@property (nonatomic, copy)NSString * touString;
//缩图
@property (nonatomic, copy)NSString *shisuostring;
//视频本地地址
@property (nonatomic, copy)NSString *shiString;
//视频网址
@property (nonatomic, copy)NSString *shiwanSt;

@end

@implementation TakeViewController
- (MBProgressHUD *)MBhud{
    if (!_MBhud) {
        _MBhud = [[MBProgressHUD alloc]init];
        _MBhud.yOffset =  _MBhud.yOffset - 70;
    }
    return _MBhud;
}


//提示框
- (void)mbhudtui:(NSString *)textname numbertime:(int)nuber{
    //提示框
    [self.view addSubview:self.MBhud];
    [self.MBhud show:YES];
    _MBhud.labelText = textname;
    _MBhud.mode = MBProgressHUDModeText;
    [_MBhud showAnimated:YES whileExecutingBlock:^{
        sleep(nuber);
    } completionBlock:^{
        [_MBhud removeFromSuperview];
        _MBhud = nil;
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"视频认证";
    self.view.backgroundColor = ViewRGB;
    UIImage *leimage = [UIImage imageNamed:@"形状16"];
    UIImage *Leimage = [leimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:Leimage style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarLeftitemAction:)];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem11 = [[UIBarButtonItem alloc]initWithTitle:@"上传" style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationshangzhuanAction)];
    rightItem11.tintColor = [UIColor colorWithRed:247.0/255.0 green:48.0/255.0 blue:103.0/255.0 alpha:1];
    self.navigationItem.rightBarButtonItem = rightItem11;
    self.touString = @"";
    self.shiString = @"";
    [self addData];
}
- (void)addView{
    self.Baview = [[UIView alloc]init];
    _Baview.frame = CGRectMake(0, 74, kScreen_w, kScreen_h - 10);
    _Baview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_Baview];
    UILabel *biaoLabel = [[UILabel alloc]init];
    biaoLabel.text = @"拍摄照片";
    biaoLabel.font = [UIFont systemFontOfSize:17];
    biaoLabel.frame = CGRectMake(10, 12, kScreen_w - 24, 20);
    biaoLabel.alpha = 0.8;
    [_Baview addSubview:biaoLabel];
    self.tuimmageVeiw = [UIImageView new];
    _tuimmageVeiw.frame = CGRectMake(10, 40, 100, 100);
    NSString *passSt = self.dataDic[@"pass_img"];
    if([passSt isEqualToString:@""]){
        _tuimmageVeiw.image = [UIImage imageNamed:@"icon_add_pic_"];
    
    }else {
        [_tuimmageVeiw sd_setImageWithURL:[NSURL URLWithString:passSt] placeholderImage:[UIImage imageNamed:zhanImage]];
    }
    [_Baview addSubview:_tuimmageVeiw];
    NSString *pass_status = [NSString stringWithFormat:@"%@",self.dataDic[@"pass_status"]];
    int pass = [pass_status intValue];
    if (pass == 0) {
        self.tuButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _tuButton.frame = CGRectMake(10, 40, 100, 100);
        [_tuButton addTarget:self action:@selector(addtuButton:) forControlEvents:UIControlEventTouchUpInside];
//        [_tuButton setBackgroundImage:[UIImage imageNamed:@"icon-reviewing"] forState:UIControlStateNormal];
        [_Baview addSubview:_tuButton];
    }else if(pass == 1) {
        self.tuButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _tuButton.frame = CGRectMake(10, 40, 100, 100);
        [_tuButton setBackgroundImage:[UIImage imageNamed:@"icon-reviewing"] forState:UIControlStateNormal];
        [_Baview addSubview:_tuButton];
    }else if(pass == 2) {
        self.tuButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _tuButton.frame = CGRectMake(10, 40, 100, 100);
        [_tuButton setBackgroundImage:[UIImage imageNamed:@"icon-pass"] forState:UIControlStateNormal];
        [_Baview addSubview:_tuButton];
    }else if(pass == 3) {
        self.tuButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _tuButton.frame = CGRectMake(10, 40, 100, 100);
        [_tuButton setBackgroundImage:[UIImage imageNamed:@"icon-not-pass"] forState:UIControlStateNormal];
        [_Baview addSubview:_tuButton];
        [self.Baview addSubview:self.tuButton2];
        [self.tuButton2 addTarget:self action:@selector(addtuButton2:) forControlEvents:UIControlEventTouchUpInside];

    }

    UILabel *jianLabel = [UILabel new];
    jianLabel.frame = CGRectMake(10, 150, kScreen_w - 24, 20);
    jianLabel.text = @"*建议在网络良好的状态下上传，注意照片反光";
    jianLabel.font = [UIFont systemFontOfSize:14];
    jianLabel.alpha = 0.6;
    [_Baview addSubview:jianLabel];
    
    UILabel *paLabel = [[UILabel alloc]init];
    paLabel.text = @"拍摄视频";
    paLabel.font = [UIFont systemFontOfSize:17];
    paLabel.frame = CGRectMake(10, 180, kScreen_w - 24, 20);
    paLabel.alpha = 0.8;
    [_Baview addSubview:paLabel];
    self.shiImageView = [UIImageView new];
    _shiImageView.frame = CGRectMake(10, 210, 100, 100);
    NSString *pass_videoSt = [NSString stringWithFormat:@"%@",self.dataDic[@"pass_video"]];
    if ([pass_videoSt isEqualToString:@""]) {
        _shiImageView.image = [UIImage imageNamed:@"icon_add"];
    }else {
        _shiImageView.image = [UIImage imageNamed:pass_videoSt];
    }

    if (pass == 0) {
        self.shiButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _shiButton.frame = CGRectMake(10, 210, 100, 100);
        [_shiButton addTarget:self action:@selector(addshiButton:) forControlEvents:UIControlEventTouchUpInside];
//        _shiButton.backgroundColor = [UIColor redColor];
        //        [_tuButton setBackgroundImage:[UIImage imageNamed:@"icon-reviewing"] forState:UIControlStateNormal];
        [_Baview addSubview:_shiButton];
    }else if(pass == 1) {
        self.shiButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _shiButton.frame = CGRectMake(10, 210, 100, 100);
        [_shiButton setBackgroundImage:[UIImage imageNamed:@"icon-reviewing"] forState:UIControlStateNormal];
        [_Baview addSubview:_shiButton];
    }else if(pass == 2) {
        self.shiButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _shiButton.frame = CGRectMake(10, 210, 100, 100);
        [_shiButton setBackgroundImage:[UIImage imageNamed:@"icon-pass"] forState:UIControlStateNormal];
        [_Baview addSubview:_shiButton];
    }else if(pass == 3) {
        self.shiButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _shiButton.frame = CGRectMake(10, 210, 100, 100);
        [_shiButton setBackgroundImage:[UIImage imageNamed:@"icon-not-pass"] forState:UIControlStateNormal];
        [_Baview addSubview:_shiButton];
        
        [self.Baview addSubview:self.shiButton2];
        [self.shiButton2 addTarget:self action:@selector(addshiButton2:) forControlEvents:UIControlEventTouchUpInside];
    }
    [_Baview addSubview:_shiImageView];
    UILabel *shiLabel = [UILabel new];
    shiLabel.frame = CGRectMake(10, 320, kScreen_w - 24, 20);
    shiLabel.text = @"*请保持正面拍摄5秒钟以上";
    shiLabel.font = [UIFont systemFontOfSize:14];
    shiLabel.alpha = 0.6;
    [_Baview addSubview:shiLabel];
    self.nvLabel = [UILabel new];
    _nvLabel.frame = CGRectMake(10, 350, kScreen_w - 20, 20);
    [_Baview addSubview:_nvLabel];
    
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:sexXB];
    int sex = [uidS intValue];
    if (sex == 2) {
        UILabel *sexlabel = [[UILabel alloc]init];
        sexlabel.frame = CGRectMake(10, 340, kScreen_w - 20, 20);
        sexlabel.text = self.dataDic[@"desc"];
        sexlabel.font = [UIFont systemFontOfSize:14];
        sexlabel.textColor = hong;
        [self.Baview addSubview:sexlabel];
    }
 
}




- (void)handleNavigationshangzhuanAction{
    if ([self.touString isEqualToString:@"" ]||[self.shiString isEqualToString:@""]) {
        [self mbhudtui:@"图片和视频不能为空" numbertime:1];
    }else {
        [self.view addSubview:self.MBhud];
        [self.MBhud show:YES];
        
        [self shangData];
        
    }
    
    


    
    
    
}
#pragma mark -- 数据请求
- (void)addData{
    NSString *str = [NSString stringWithFormat:@"%@%@",AppURL2,API_videopass];
    
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    [HttpUtils postRequestWithURL:str withParameters:@{@"uid":uidS} withResult:^(id result) {
        self.dataDic = result[@"data"];
        [self addView];

    } withError:^(NSString *msg, NSError *error) {
        
    }];
}
- (UIButton *)tuButton2{
    if (!_tuButton2) {
        _tuButton2 = [UIButton buttonWithType:UIButtonTypeSystem];
        _tuButton2.frame = CGRectMake(126, 50, 95, 31);
        [_tuButton2 setBackgroundImage:[UIImage imageNamed:@"btn-reupload"] forState:UIControlStateNormal];


    }
    return _tuButton2;
}
- (UIButton *)shiButton2{
    if (!_shiButton2) {
        _shiButton2 = [UIButton buttonWithType:UIButtonTypeSystem];
        _shiButton2.frame = CGRectMake(126, 220, 95, 31);
        [_shiButton2 setBackgroundImage:[UIImage imageNamed:@"btn-reupload"] forState:UIControlStateNormal];
        
    }
    return _shiButton2;

}
- (void)addtuButton2:(UIButton *)sender{
    UIAlertController *albel = [UIAlertController alertControllerWithTitle:@"亲,上传图片和视频需要通过审核哦~" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *pai = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openCamera];
        //        self.tuiamg = 2;
        
    }];
    UIAlertAction *cong = [UIAlertAction actionWithTitle:@"从手机相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openPics];
        //        self.tuiamg = 1;
        
    }];
    [albel addAction:quxiao];
    [albel addAction:pai];
    [albel addAction:cong];
    [self presentViewController:albel animated:YES completion:nil];

}
- (void)addshiButton2:(UIButton *)sender{
    ArtMicroVideoViewController *ArtMicroVideoView = [[ArtMicroVideoViewController alloc]init];
    UINavigationController *secondNVC = [[UINavigationController alloc]initWithRootViewController:ArtMicroVideoView];
    
    [self showViewController:secondNVC sender:nil];
    ArtMicroVideoView.recordComplete = ^(NSString *aVideoUrl, NSString *aThumUrl) {
        self.shiImageView.image = [UIImage imageNamed:aThumUrl];
        //        [self.shiImageView setBackgroundImage:[UIImage imageNamed:aThumUrl] forState:UIControlStateNormal];
        //        self.imaG = [UIImage imageNamed:aThumUrl];
        self.shiString = aVideoUrl;
        self.shiButton.hidden = YES;
        [self.Baview addSubview:self.shiButton2];
        [self.shiButton2 addTarget:self action:@selector(addshiButton2:) forControlEvents:UIControlEventTouchUpInside];
        


    };

}



//添加照片
- (void)addtuButton:(UIButton *)sender{
    if ([self.touString isEqualToString:@""]) {
        UIAlertController *albel = [UIAlertController alertControllerWithTitle:@"亲,上传图片和视频需要通过审核哦~" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *pai = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self openCamera];
            //        self.tuiamg = 2;
            
        }];
        UIAlertAction *cong = [UIAlertAction actionWithTitle:@"从手机相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self openPics];
            //        self.tuiamg = 1;
            
        }];
        [albel addAction:quxiao];
        [albel addAction:pai];
        [albel addAction:cong];
        [self presentViewController:albel animated:YES completion:nil];
    }else {
        
        NSArray * array = [[NSArray alloc] initWithObjects:self.tuimmageVeiw, nil];
        XHImageViewer * brower  = [[XHImageViewer alloc]init];
        [brower showWithImageViews:array selectedView:self.tuimmageVeiw];
    }

}
//添加视频
- (void)addshiButton:(UIButton *)sender{
    if ([self.shiString isEqualToString:@""]) {
        ArtMicroVideoViewController *ArtMicroVideoView = [[ArtMicroVideoViewController alloc]init];
        UINavigationController *secondNVC = [[UINavigationController alloc]initWithRootViewController:ArtMicroVideoView];
        
        [self showViewController:secondNVC sender:nil];
        ArtMicroVideoView.recordComplete = ^(NSString *aVideoUrl, NSString *aThumUrl) {
            self.shiImageView.image = [UIImage imageNamed:aThumUrl];
            //        [self.shiImageView setBackgroundImage:[UIImage imageNamed:aThumUrl] forState:UIControlStateNormal];
            //        self.imaG = [UIImage imageNamed:aThumUrl];
            self.shiString = aVideoUrl;
            
            [self.Baview addSubview:self.shiButton2];
        };

    }else {
        
    }
    
    
   
}
//相册
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
    _tuimmageVeiw.image = image;
    self.touString = @"111";
    //    [self.tableView reloadData];
    [self.Baview addSubview:self.tuButton2];
    [self.tuButton2 addTarget:self action:@selector(addtuButton2:) forControlEvents:UIControlEventTouchUpInside];
    self.tuButton.hidden = YES;


    
}


// 取消相册
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)shangData{
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,uploadURL];
    
    
    
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.requestSerializer = [AFHTTPRequestSerializer serializer];
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [manage POST:URL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //转化为data类型  0.5图片压缩比例 image 图片格式
        NSData *data = UIImageJPEGRepresentation(_tuimmageVeiw.image, 1);
        
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
            [self addQuebutton];
        }else {
            [self mbhudtui:@"上传失败" numbertime:1];
        }
        
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self mbhudtui:@"上传失败" numbertime:1];
        
    }];
    
    
    
    
}


//UIButton的确定
- (void)addQuebutton{
//    self.hhh = 0;
    
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_upload];
      AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.requestSerializer = [AFHTTPRequestSerializer serializer];
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    //    NSDictionary *dic = @{@"uid":@"21444"};
    [manage POST:URL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *data = UIImageJPEGRepresentation(self.shiImageView.image, 1);
        [formData appendPartWithFileData:data name:@"file[]" fileName:@"image.jpg" mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        NSString *code = dic[@"code"];
        int incode = [code intValue];
        if (incode == 1) {
            NSArray *Array = dic[@"data"];
            self.shisuostring = Array[0][@"url"];
            [self shipingData];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self mbhudtui:@"上传失败" numbertime:1];
    }];
    
}
- (void)shipingData{
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_upload];
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.requestSerializer = [AFHTTPRequestSerializer serializer];
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    //    NSDictionary *dic = @{@"uid":@"21444"};
    [manage POST:URL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *dataVi = [NSData dataWithContentsOfFile:self.shiString];
        [formData appendPartWithFileData:dataVi name:@"file[]" fileName:@"video.mp4" mimeType:@"video/mp4"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        NSString *code = dic[@"code"];
        int incode = [code intValue];
        if (incode == 1) {
            NSArray *Array = dic[@"data"];
            self.shiwanSt = Array[0][@"url"];
            [self addURL];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self mbhudtui:@"上传失败" numbertime:1];
    }];
    
}
- (void)addURL{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *uidS = [defatults objectForKey:uidSG];
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL2,API_submitpass2];
    NSDictionary *dic = @{@"uid":uidS,@"image":self.touString,@"video":self.shiwanSt,@"video_img":self.shisuostring};
    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
        [self mbhudtui:@"上传成功" numbertime:1];
        [self.navigationController popViewControllerAnimated:YES];

    } withError:^(NSString *msg, NSError *error) {
        [self mbhudtui:@"上传失败" numbertime:1];

    }];
}


#pragma mark - 用户交互
- (void)handleNavigationBarLeftitemAction:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//隐藏tabBarController
- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    
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

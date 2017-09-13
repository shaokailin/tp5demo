//
//  PerfectViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/3/2.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "ZhuCeViewController.h"
#import "UIImage+cutImage.h"
#import "NSDate+Helper.h"
#import <AFNetworking.h>
#import "CityChoose.h"
#import "ValuePickerView.h"

@interface ZhuCeViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong)UIImageView *touimageView;

@property(nonatomic,copy)NSString * image_type;
@property(nonatomic,copy)NSString * imageFileName;
@property(nonatomic,strong)UILabel *titleLabel;
//昵称
@property(nonatomic, strong)UITextField *niTextField;
//年龄
@property(nonatomic, strong)UILabel *nianTextFiled;
//城市
@property(nonatomic, strong)UILabel *chengLabel;
//城市的ID
@property(nonatomic, strong)NSString *town;
//男
@property(nonatomic, strong)UIButton *nabutton;
//女
@property(nonatomic, strong)UIButton *nvbutton;
@property(nonatomic, strong)NSString *xingString;
//头像
@property(nonatomic, strong)NSString *touString;

@property (nonatomic, strong) ValuePickerView *pickerView;
//年龄
@property (nonatomic, strong)NSString *nianString;



@end

@implementation ZhuCeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.navigationController setNavigationBarHidden:NO animated:YES];

    self.view.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1];
    
    
    [self addView];
    self.touString = @"";
    [self addNavigation];

}
- (void)addNavigation{
    
    UIButton *button = [UIButton new];
    button.frame = CGRectMake(20, 30, 10, 17);
    UIButton *button2 = [UIButton new];
    button2.frame = CGRectMake(10, 20, 20, 30);
    [self.view addSubview:button2];
    
    UIImage *leimage = [UIImage imageNamed:@"形状16"];
    UIImage *Leimage = [leimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [button setBackgroundImage:Leimage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(handleNavigationBarLeftitemAction:) forControlEvents:UIControlEventTouchUpInside];
    [button2 addTarget:self action:@selector(handleNavigationBarLeftitemAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

//    self.navigationItem.title = @"注册";
//    UIImage *leimage = [UIImage imageNamed:@"形状16"];
//    UIImage *Leimage = [leimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:Leimage style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarLeftitemAction:)];
//    self.navigationItem.leftBarButtonItem = leftItem;
    
}
//布局
- (void)addView{
    UIImageView *BaImageView = [[UIImageView alloc]init];
    BaImageView.frame = CGRectMake(0, 0, kScreen_w, kScreen_h );
    BaImageView.image = [UIImage imageNamed:@"bg-1.jpg"];
    [self.view addSubview:BaImageView];
    
    UIView *imaView =[[UIView alloc]init];
    imaView.frame = CGRectMake(0, 40, kScreen_w, 200);
//    imaView.backgroundColor = [UIColor whiteColor];
    //创建手势对象

    
    self.touimageView = [[UIImageView alloc]init];
    _touimageView.frame = CGRectMake(kScreen_w/2 - 40, 45, 100, 100);
    _touimageView.image = [UIImage imageNamed:@"icon-head"];
    _touimageView.layer.cornerRadius = 50;
    _touimageView.layer.masksToBounds = YES;
    _touimageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    //讲手势添加到指定的视图上
    [_touimageView addGestureRecognizer:tap];
    [self.view addSubview:imaView];
    [imaView addSubview:_touimageView];
    
//    self.titleLabel = [[UILabel alloc]init];
//    _titleLabel.frame = CGRectMake(20, 140, kScreen_w - 20, 40);
//    _titleLabel.text = @"请上传本人的照片";
//    _titleLabel.alpha = 0.5;
//    _titleLabel.textColor = [UIColor whiteColor];
//    _titleLabel.textAlignment = NSTextAlignmentCenter;
//    [imaView addSubview:_titleLabel];
    
    UILabel *miLabel = [[UILabel alloc]init];
    miLabel.text = @"昵称";
    miLabel.textAlignment = NSTextAlignmentCenter;
    miLabel.textColor = [UIColor whiteColor];
    miLabel.alpha = 0.8;
    [self.view addSubview:miLabel];
    UILabel *xianLabel = [[UILabel alloc]init];
    xianLabel.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
    [self.view addSubview:xianLabel];
    
    self.niTextField = [[UITextField alloc]init];
//    _niTextField.backgroundColor =[UIColor whiteColor];
    _niTextField.placeholder = @"请填写昵称";
    _niTextField.textColor = [UIColor whiteColor];
    [self.view addSubview:_niTextField];
    
    UILabel *nianLabel = [[UILabel alloc]init];
    nianLabel.text = @"年龄";
    nianLabel.textAlignment = NSTextAlignmentCenter;
    nianLabel.textColor = [UIColor whiteColor];
//    nianLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nianLabel];
    UILabel *xianLabel1 = [[UILabel alloc]init];
    xianLabel1.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:0.8];
    [self.view addSubview:xianLabel1];
    
    self.nianTextFiled = [[UILabel alloc]init];

    
//    _nianTextFiled.backgroundColor =[UIColor whiteColor];
    _nianTextFiled.text = @"18";
    self.nianString = @"18";
    _nianTextFiled.textColor = [UIColor whiteColor];
    _nianTextFiled.textAlignment = NSTextAlignmentLeft;
//    self.nianTextFiled.userInteractionEnabled = YES;
    [self.view addSubview:_nianTextFiled];

    UIButton *niaButton = [[UIButton alloc]init];
    [niaButton addTarget:self action:@selector(addniaButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:niaButton];

    UILabel *XBLabel = [[UILabel alloc]init];
    XBLabel.text = @"性别";
    XBLabel.textAlignment = NSTextAlignmentCenter;
    XBLabel.textColor = [UIColor whiteColor];
    //    nianLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:XBLabel];
    
    
    
    self.nabutton = [[UIButton alloc]init];
    _nabutton.tag = 1000;
    [_nabutton setTitle:@"男" forState:UIControlStateNormal];
    [_nabutton addTarget:self action:@selector(addNaButton:) forControlEvents:UIControlEventTouchUpInside];
    [_nabutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_nabutton];
    
    self.nvbutton = [[UIButton alloc]init];
    _nvbutton.tag = 1001;
    [_nvbutton setTitle:@"女" forState:UIControlStateNormal];
    [_nvbutton addTarget:self action:@selector(addNaButton:) forControlEvents:UIControlEventTouchUpInside];
    [_nvbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_nvbutton];
    [_nabutton setImage:[UIImage imageNamed:@"形状-17-拷贝"] forState:UIControlStateNormal];
    [_nvbutton setImage:[UIImage imageNamed:@"形状-17"] forState:UIControlStateNormal];
    
    
    UILabel *XBtiLabel = [[UILabel alloc]init];
    XBtiLabel.text = @"*注册后不可更改性别";
    XBtiLabel.font = [UIFont systemFontOfSize:13];
    XBtiLabel.textAlignment = NSTextAlignmentLeft;
    XBtiLabel.textColor = hong;
    //    nianLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:XBtiLabel];

    //立即登录
    UIButton *landingButton = [[UIButton alloc]init];
    [landingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    landingButton.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:49.0/255.0 blue:104.0/255.0 alpha:1];
    landingButton.layer.cornerRadius = 20;
    //    _PaTextField.layer.borderWidth = 1.0;
    [landingButton setTitle:@"立即注册" forState:UIControlStateNormal];
    [landingButton addTarget:self action:@selector(addlandingButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:landingButton];
    
    if (kScreen_w > 400) {
        miLabel.frame = CGRectMake(0, 347, 80, 50);
        _niTextField.frame = CGRectMake(80, 347, kScreen_w - 80, 50);
        xianLabel.frame = CGRectMake(20, 397, kScreen_w - 40, 0.8);

        nianLabel.frame = CGRectMake(0, 398, 80, 50);
        _nianTextFiled.frame = CGRectMake(80, 398, kScreen_w - 80, 50);
        niaButton.frame = CGRectMake(80, 398, kScreen_w - 80, 50);
        xianLabel1.frame = CGRectMake(20, 448, kScreen_w - 40, 1);
        XBLabel.frame = CGRectMake(0, 450, 80, 50);
        _nabutton.frame = CGRectMake(50, 450, 100, 50);
        _nvbutton.frame = CGRectMake(120, 450, 100, 50);
        XBtiLabel.frame = CGRectMake(80, 500, kScreen_w - 50, 20);
        landingButton.frame = CGRectMake(20,550,kScreen_w - 40, 40);


    }else {
        miLabel.frame = CGRectMake(0, 267, 80, 50);
        _niTextField.frame = CGRectMake(80, 267, kScreen_w - 80, 50);
        xianLabel.frame = CGRectMake(20, 317, kScreen_w - 40, 0.8);
        
        nianLabel.frame = CGRectMake(0, 318, 80, 50);
        _nianTextFiled.frame = CGRectMake(80, 318, kScreen_w - 80, 50);
        niaButton.frame = CGRectMake(80, 318, kScreen_w - 80, 50);
        xianLabel1.frame = CGRectMake(20, 368, kScreen_w - 40, 1);
        XBLabel.frame = CGRectMake(0, 370, 80, 50);
        _nabutton.frame = CGRectMake(50, 370, 100, 50);
        _nvbutton.frame = CGRectMake(120, 370, 100, 50);
        XBtiLabel.frame = CGRectMake(80, 420, kScreen_w - 50, 20);
        landingButton.frame = CGRectMake(20,470,kScreen_w - 40, 40);
    }
    
    
    
}

//轻拍事件

-(void)tapAction:(UITapGestureRecognizer *)tap
{
    UIAlertController *albel = [UIAlertController alertControllerWithTitle:@"亲,上传不雅头像会被封账号哦~" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
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
//男
- (void)addNaButton:(UIButton *)sender{
    if (sender.tag == 1000) {
        self.xingString = @"男";
        [_nabutton setImage:[UIImage imageNamed:@"形状-17-拷贝"] forState:UIControlStateNormal];
        [_nvbutton setImage:[UIImage imageNamed:@"形状-17"] forState:UIControlStateNormal];
        
        
    }else{
        self.xingString = @"女";
        [_nabutton setImage:[UIImage imageNamed:@"形状-17"] forState:UIControlStateNormal];
        [_nvbutton setImage:[UIImage imageNamed:@"形状-17-拷贝"] forState:UIControlStateNormal];
        
    }
    
    
}
//完成
- (void)addlandingButton:(UIButton *)sender{
    if ([self.niTextField.text isEqualToString:@""] || [self.nianTextFiled.text isEqualToString:@""]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"昵称不能为空" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            
        }];
        
        
        [alert addAction:otherAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        

        
    }else {
        NSString *sex = @"";
        if ([self.xingString isEqualToString:@"女"]) {
            sex = @"2";
        }else {
            sex = @"1";
        }
        
        NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,register_newURL];
        NSDictionary *dic= @{@"sex":sex,@"nickname":_niTextField.text,@"age":_nianTextFiled.text,@"avatar":self.touString,@"pid":@""};
        
        [HttpUtils postRequestWithURL:API_reg2 withParameters:dic withResult:^(id result) {
            
            [self.navigationController setNavigationBarHidden:NO animated:YES];
            self.tabBarController.tabBar.hidden = NO;
            
            
            NSDictionary *dic = result[@"data"];
            NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
            [defatults setObject:dic[@"age"] forKey:ageNL];
            [defatults setObject:dic[@"avatar"] forKey:avatarIMG];
            [defatults setObject:dic[@"id"] forKey:uidSG];
            [defatults setObject:dic[@"sex"] forKey:sexXB];
            [defatults setObject:dic[@"user_login"] forKey:user_loginZH];
            [defatults setObject:dic[@"user_pass"] forKey:user_passMM];
            [defatults setObject:dic[@"user_rank"] forKey:user_rankVIP];
            [defatults synchronize];
            
            //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:@"InfoNotification" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"addzhiliaoAction" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"addzhiliaoActionLL" object:nil];

            [[NSNotificationCenter defaultCenter] postNotificationName:@"firstFicationAction" object:nil];
            NSString *biaoshi = [defatults objectForKey:user_bioashi];
            if ([biaoshi isEqualToString:@"LLLLL"]) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else {
                UITabBarController *tabbarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
                NSNumber *index = 0;
                [tabbarVc setSelectedIndex:[index intValue]];
                [self.navigationController dismissViewControllerAnimated:YES completion:^{
                    
                    
                    
                } ];
            }


         
            [[NSNotificationCenter defaultCenter] postNotificationName:@"shuxinTableVIew" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"adddengluShuaxin11" object:nil];

            
        } withError:^(NSString *msg, NSError *error) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:msg message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//                self.nianTextFiled.text = @"";
                
                
            }];
            
            
            [alert addAction:otherAction];
            
            [self presentViewController:alert animated:YES completion:nil];
            
            
            
        }];

    }

    
    
}


#pragma mark - 用户交互
- (void)handleNavigationBarLeftitemAction:(UIButton *)sender {


    
    [self.navigationController popViewControllerAnimated:YES];
    
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//隐藏键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [SVProgressHUD dismiss];
}
- (void)addniaButton:(UIButton *)sender{
    self.pickerView = [[ValuePickerView alloc]init];
    NSMutableArray *dARray = [[NSMutableArray alloc]init];
    for (int i = 18; i < 61; i ++ ) {
        NSString *co = [NSString stringWithFormat:@"%d",i];
        [dARray addObject:co];
    }
    
    
    self.pickerView.dataSource = dARray;
    self.pickerView.pickerTitle = @"年龄";
    __weak typeof(self) weakSelf = self;
    self.pickerView.valueDidSelect = ^(NSString *value){
        NSArray * stateArr = [value componentsSeparatedByString:@"/"];
        weakSelf.nianString = stateArr[0];
        weakSelf.nianTextFiled.text = weakSelf.nianString;
    };
    [self.pickerView show];

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

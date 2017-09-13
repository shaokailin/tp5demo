//
//  PerfectViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/3/2.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "PerfectViewController.h"
#import "UIImage+cutImage.h"
#import "NSDate+Helper.h"
#import <AFNetworking.h>
#import "CityChoose.h"

@interface PerfectViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
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
//头像
@property(nonatomic, strong)NSString *touString;

@property (nonatomic, strong) CityChoose *cityChoose;    /** 城市选择 */



@end

@implementation PerfectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1];
    [self addNavigation];
    [self addView];
    
}
- (void)addNavigation{
    self.navigationItem.title = @"完善资料";
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_2.png"] style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarLeftitemAction:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}
//布局
- (void)addView{
    UIView *imaView =[[UIView alloc]init];
    imaView.frame = CGRectMake(0, 40, kScreen_w, 200);
    imaView.backgroundColor = [UIColor whiteColor];
    //创建手势对象
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    //讲手势添加到指定的视图上
    [imaView addGestureRecognizer:tap];
    [self.view addSubview:imaView];
    
    self.touimageView = [[UIImageView alloc]init];
    _touimageView.frame = CGRectMake(kScreen_w/2 - 40, 50, 80, 80);
    _touimageView.image = [UIImage imageNamed:@"timg"];
    _touimageView.layer.cornerRadius = 40;
    _touimageView.layer.masksToBounds = YES;
    [imaView addSubview:_touimageView];
    
    self.titleLabel = [[UILabel alloc]init];
    _titleLabel.frame = CGRectMake(20, 140, kScreen_w - 20, 40);
    _titleLabel.text = @"请上传本人的照片";
    _titleLabel.alpha = 0.3;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [imaView addSubview:_titleLabel];
    
    UILabel *miLabel = [[UILabel alloc]init];
    miLabel.frame = CGRectMake(0, 247, 80, 50);
    miLabel.text = @"昵称";
    miLabel.textAlignment = NSTextAlignmentCenter;
    miLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:miLabel];
    self.niTextField = [[UITextField alloc]init];
    _niTextField.frame = CGRectMake(80, 247, kScreen_w - 80, 50);
    _niTextField.backgroundColor =[UIColor whiteColor];
    _niTextField.placeholder = @"请填写昵称";
    [self.view addSubview:_niTextField];
    
    UILabel *nianLabel = [[UILabel alloc]init];
    nianLabel.frame = CGRectMake(0, 298, 80, 50);
    nianLabel.text = @"年龄";
    nianLabel.textAlignment = NSTextAlignmentCenter;
    nianLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nianLabel];
    
    
    self.nianTextFiled = [[UILabel alloc]init];
    _nianTextFiled.frame = CGRectMake(80, 298, kScreen_w - 80, 50);
    _nianTextFiled.backgroundColor =[UIColor whiteColor];
    _nianTextFiled.text = @"请选择年龄";
    _nianTextFiled.textColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255 alpha:1];
    _nianTextFiled.textAlignment = NSTextAlignmentLeft;
    _nianTextFiled.userInteractionEnabled = YES;
    
    //创建手势对象
    UITapGestureRecognizer *tapA =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapActionA:)];

    tapA.numberOfTapsRequired = 1;//触摸次数
    //讲手势添加到指定的视图上
    [_nianTextFiled addGestureRecognizer:tapA];
    
    [self.view addSubview:_nianTextFiled];
    
    UILabel *cheng = [[UILabel alloc]init];
    cheng.frame = CGRectMake(0, 349, 80, 50);
    cheng.text = @"城市";
    cheng.textAlignment = NSTextAlignmentCenter;
    cheng.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:cheng];
    
    self.chengLabel = [[UILabel alloc]init];
    _chengLabel.frame = CGRectMake(80, 349, kScreen_w - 80, 50);
    _chengLabel.backgroundColor =[UIColor whiteColor];
    _chengLabel.text = @"厦门";
    _chengLabel.textColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255 alpha:1];
    _chengLabel.textAlignment = NSTextAlignmentLeft;
    _chengLabel.userInteractionEnabled = YES;
    //创建手势对象
    UITapGestureRecognizer *tapC =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapActionC:)];
    //讲手势添加到指定的视图上
    [_chengLabel addGestureRecognizer:tapC];
    
    [self.view addSubview:_chengLabel];
    

    
    
    UIView *xinView = [[UIView alloc]init];
    xinView.frame = CGRectMake(0, 400, kScreen_w, 50);
    xinView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:xinView];
    
    UILabel *xinLabel = [[UILabel alloc]init];
    xinLabel.frame = CGRectMake(0, 0, 80, 50);
    xinLabel.text = @"性别";
    xinLabel.textAlignment = NSTextAlignmentCenter;
    xinLabel.backgroundColor = [UIColor whiteColor];
    [xinView addSubview:xinLabel];
    
    self.nabutton = [[UIButton alloc]init];
    _nabutton.frame = CGRectMake(80, 0, 100, 50);
    _nabutton.tag = 1000;
    [_nabutton setTitle:@"男" forState:UIControlStateNormal];
    [_nabutton addTarget:self action:@selector(addNaButton:) forControlEvents:UIControlEventTouchUpInside];
    [_nabutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [xinView addSubview:_nabutton];
    
    self.nvbutton = [[UIButton alloc]init];
    _nvbutton.frame = CGRectMake(180, 0, 100, 50);
    _nvbutton.tag = 1001;
    [_nvbutton setTitle:@"女" forState:UIControlStateNormal];
    [_nvbutton addTarget:self action:@selector(addNaButton:) forControlEvents:UIControlEventTouchUpInside];
    [_nvbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [xinView addSubview:_nvbutton];
    if ([self.xingString isEqualToString:@"女"]) {
        [_nabutton setImage:[UIImage imageNamed:@"形状-17"] forState:UIControlStateNormal];
        [_nvbutton setImage:[UIImage imageNamed:@"形状-17-拷贝"] forState:UIControlStateNormal];
    }else {
        [_nabutton setImage:[UIImage imageNamed:@"形状-17-拷贝"] forState:UIControlStateNormal];
        [_nvbutton setImage:[UIImage imageNamed:@"形状-17"] forState:UIControlStateNormal];
    }
    
    
    
    //立即登录
    UIButton *landingButton = [[UIButton alloc]init];
    landingButton.frame = CGRectMake(20,470,kScreen_w - 40, 40);
    [landingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    landingButton.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:49.0/255.0 blue:104.0/255.0 alpha:1];
    landingButton.layer.cornerRadius = 20;
    //    _PaTextField.layer.borderWidth = 1.0;
    [landingButton setTitle:@"完成" forState:UIControlStateNormal];
    [landingButton addTarget:self action:@selector(addlandingButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:landingButton];

    
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
- (void)addBu:(UIButton *)sender{
    //年 月 日
    UIDatePicker *picker = [[UIDatePicker alloc]init];
    picker.datePickerMode = UIDatePickerModeDate;
    
    picker.frame = CGRectMake(0, 40, 320, 200);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择出生日期，会自动算出年龄\n\n\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSDate *date = picker.date;
        
        NSString * shengri = [date stringWithFormat:@"yyyy-MM-dd"];
        
        //年龄
        NSString *birth = shengri;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        //生日
        NSDate *birthDay = [dateFormatter dateFromString:birth];
        //当前时间
        NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
        NSDate *currentDate = [dateFormatter dateFromString:currentDateStr];
        NSTimeInterval time=[currentDate timeIntervalSinceDate:birthDay];
        int age = ((int)time)/(3600*24*365);
        if (age > 0){
            self.nianTextFiled.text = [NSString stringWithFormat:@"%d岁",age];
            //[self.tableView reloadData];
            
            //            //            //星座
            //            NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
            //            NSString *astroFormat = @"102123444543";
            //            //月份
            //            NSString *month = [self.shengri substringWithRange:NSMakeRange(5, 2)];
            //            int m = [month intValue];
            //            //日
            //            NSString *day = [self.shengri substringWithRange:NSMakeRange(8, 2)];
            //            int d = [day intValue];
            //
            //            //字符串总长
            //            // NSUInteger length = [self.shengri length];
            //            NSString *result=[NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(m * 2-(d < [[astroFormat substringWithRange:NSMakeRange((m -1), 1)] intValue] - (-19))*2,2)]];
            //            self.xingzuo = result;
            
        }else{
            
            
            //[self mbhud:@"生日不正确" numbertime:1];
            self.nianTextFiled.text = @"";
            
        }
        
        
    }];
    [alertController.view addSubview:picker];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];

    
}

//点击年龄
-(void)tapActionA:(UITapGestureRecognizer *)tap
{
    //年 月 日
    UIDatePicker *picker = [[UIDatePicker alloc]init];
    picker.datePickerMode = UIDatePickerModeDate;
    
    picker.frame = CGRectMake(0, 40, 320, 200);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择出生日期，会自动算出年龄\n\n\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSDate *date = picker.date;
        
        NSString * shengri = [date stringWithFormat:@"yyyy-MM-dd"];
        
        //年龄
        NSString *birth = shengri;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        //生日
        NSDate *birthDay = [dateFormatter dateFromString:birth];
        //当前时间
        NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
        NSDate *currentDate = [dateFormatter dateFromString:currentDateStr];
        NSTimeInterval time=[currentDate timeIntervalSinceDate:birthDay];
        int age = ((int)time)/(3600*24*365);
        if (age > 0){
            self.nianTextFiled.text = [NSString stringWithFormat:@"%d岁",age];
            //[self.tableView reloadData];
            
//            //            //星座
//            NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
//            NSString *astroFormat = @"102123444543";
//            //月份
//            NSString *month = [self.shengri substringWithRange:NSMakeRange(5, 2)];
//            int m = [month intValue];
//            //日
//            NSString *day = [self.shengri substringWithRange:NSMakeRange(8, 2)];
//            int d = [day intValue];
//            
//            //字符串总长
//            // NSUInteger length = [self.shengri length];
//            NSString *result=[NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(m * 2-(d < [[astroFormat substringWithRange:NSMakeRange((m -1), 1)] intValue] - (-19))*2,2)]];
//            self.xingzuo = result;
        
        }else{
            
            
            //[self mbhud:@"生日不正确" numbertime:1];
            self.nianTextFiled.text = @"";

        }
        
        
    }];
    [alertController.view addSubview:picker];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];

    
}
//城市
-(void)tapActionC:(UITapGestureRecognizer *)tap
{
    self.cityChoose = [[CityChoose alloc] init];
    __weak typeof(self) weakSelf = self;
    self.cityChoose.config = ^(NSString *province, NSString *city, NSString *town,NSString *shenID){
        weakSelf.chengLabel.text = [NSString stringWithFormat:@"%@-%@",province,city];
        _town = town;
    };
    [self.view addSubview:self.cityChoose];
    
    
    
    
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
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,bindingURL];
    NSDictionary *dic= @{@"uid":dic[@"id"],@"nickname":_niTextField.text,@"birthday":_nianTextFiled.text,@"city":@"",@"sex":self.xingString,@"avatar":self.touString};
    
    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
        
    } withError:^(NSString *msg, NSError *error) {
        
    }];
    


    
    
    
}


#pragma mark - 用户交互
- (void)handleNavigationBarLeftitemAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
    UIImage *image2 = [UIImage imagewithImage:image];
    _touimageView.image = image2;
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
        if ([dic[@"code"] isEqualToString:@"1"]) {
            self.touString = dic[@"data"][@"url"];
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




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

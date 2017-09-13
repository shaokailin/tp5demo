//
//  MyShiPingViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/4/24.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "MyShiPingViewController.h"
#import "ArtMicroVideoViewController.h"
@interface MyShiPingViewController ()<UITextViewDelegate>
@property (nonatomic, strong)UITextView *textView;
@property (nonatomic, strong)UILabel *ziLabel;
@property (nonatomic, strong)UIButton *imView;
//视频本地地址
@property (nonatomic, copy)NSString *shiString;
@property (nonatomic, strong)UIImage *imaG;

//返回的地址 URL
@property (nonatomic, copy)NSString *imaURL;
@property (nonatomic, copy)NSString *videoURL;
@property (nonatomic, assign)NSInteger hhh;
@end

@implementation MyShiPingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ViewRGB;
    self.navigationItem.title = @"我的小视频";
    
    UIImage *leimage = [UIImage imageNamed:@"形状16"];
    UIImage *Leimage = [leimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:Leimage style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarLeftitemAction:)];

    self.navigationItem.leftBarButtonItem = leftItem;
    [self addView];

}
- (void)addView{
    UIView *baView = [[UIView alloc]init];
    baView.frame = CGRectMake(0, 70, kScreen_w, 260);
    baView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baView];
    
    self.textView = [[UITextView alloc]init];
    _textView.frame = CGRectMake(12, 5, kScreen_w - 24, 150);
//    _textView.text = @"这一刻的想法";
    _textView.scrollEnabled = NO;
    _textView.font = [UIFont systemFontOfSize:14.0];
    
    _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _textView.delegate = self;
     self.automaticallyAdjustsScrollViewInsets = NO;
    [baView addSubview:_textView];
    
    self.ziLabel = [[UILabel alloc]init];
    _ziLabel.frame = CGRectMake(12, 10, kScreen_w - 24, 20);
    _ziLabel.text = @"这一刻的想法.....";
    _ziLabel.enabled = NO;
    _ziLabel.textColor = [UIColor blackColor];
    _ziLabel.font = [UIFont systemFontOfSize:15.0];
    _ziLabel.alpha = 0.6;
//    _ziLabel.backgroundColor = [UIColor redColor];
    [baView addSubview:_ziLabel];
    
    self.imView = [[UIButton alloc]init];
    self.imView.frame = CGRectMake(12, 150, 100, 100);
    [self.imView setBackgroundImage:[UIImage imageNamed:@"icon_add"] forState:UIControlStateNormal];
    [self.imView addTarget:self action:@selector(addButton:) forControlEvents:UIControlEventTouchUpInside];
    [baView addSubview:_imView];
    
    UIView *tiView = [[UIView alloc]init];
    tiView.frame = CGRectMake(0, 340, kScreen_w, kScreen_h - 270);
    tiView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tiView];
    
    UILabel *tiLabel = [[UILabel alloc]init];
    tiLabel.frame = CGRectMake(12, 5, kScreen_w - 24, 20);
    tiLabel.text = @"特别提醒";
    tiLabel.textColor = [UIColor redColor];
    tiLabel.font = [UIFont systemFontOfSize:15];
    tiLabel.alpha = 0.8;
    [tiView addSubview:tiLabel];
    
    NSString *wenString = @"视频大小不大于50M\n视频时间为5-10分钟左右较为合适\n每天上传一个视频可得5金币，10个封顶\n禁止上传淫秽色情及非自拍视频，一经发现将扣除收益直至封停账号!";
    CGFloat collectionView_h = [HelperClass calculationHeightWithTextsize:15.0 LabelWidth:kScreen_w - 80 WithText:wenString LineSpacing:0];
    
    UILabel *neiLabel = [[UILabel alloc]init];
    neiLabel.frame = CGRectMake(12, 25, kScreen_w - 24, collectionView_h);
    neiLabel.text = wenString;
    neiLabel.numberOfLines = 0;
    neiLabel.font = [UIFont systemFontOfSize:15.0];
    neiLabel.alpha = 0.6;
    [tiView addSubview:neiLabel];
    
    UIButton *queButton = [[UIButton alloc]init];
    queButton.frame = CGRectMake(20, collectionView_h + 45, kScreen_w - 40, 40);
    [queButton addTarget:self action:@selector(addQuebutton) forControlEvents:UIControlEventTouchUpInside];
    [queButton setTitle:@"确定" forState:UIControlStateNormal];
    queButton.layer.cornerRadius = 20;
    queButton.layer.masksToBounds = YES;
    queButton.titleLabel.font = [UIFont systemFontOfSize:15];
    queButton.alpha = 0.8;
    queButton.backgroundColor = hong;
    [tiView addSubview:queButton];
    
    
    
    
    
    
    
    
}
#pragma mark - UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView  {
//    self.examineText =  textView.text;
    if (textView.text.length == 0) {
        _ziLabel.text = @"这一刻的想法.....";
    }else {
        _ziLabel.text = @"";
    }
    
    if (textView.text.length > 150) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"字数不能超过150个字符！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark - 用户交互
- (void)handleNavigationBarLeftitemAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//点击视频
- (void)addButton:(UIButton *)sender{
    

    ArtMicroVideoViewController *ArtMicroVideoView = [[ArtMicroVideoViewController alloc]init];
    UINavigationController *secondNVC = [[UINavigationController alloc]initWithRootViewController:ArtMicroVideoView];
    
    [self showViewController:secondNVC sender:nil];
    ArtMicroVideoView.recordComplete = ^(NSString *aVideoUrl, NSString *aThumUrl) {
        [self.imView setBackgroundImage:[UIImage imageNamed:aThumUrl] forState:UIControlStateNormal];
        self.imaG = [UIImage imageNamed:aThumUrl];
        self.shiString = aVideoUrl;
    };
}
//UIButton的确定
- (void)addQuebutton{
    self.hhh = 0;
    
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_upload];
    
    [SVProgressHUD showWithStatus:@"视频上传中..."];
    
    
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.requestSerializer = [AFHTTPRequestSerializer serializer];
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    //    NSDictionary *dic = @{@"uid":@"21444"};
    [manage POST:URL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    
            NSData *data = UIImageJPEGRepresentation(self.imaG, 1);
            [formData appendPartWithFileData:data name:@"file[]" fileName:@"image.jpg" mimeType:@"image/jpeg"];
           } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        NSString *code = dic[@"code"];
        int incode = [code intValue];
        if (incode == 1) {
            NSArray *Array = dic[@"data"];
            self.imaURL = Array[0][@"url"];
            [self shipingData];
        }
        
        [SVProgressHUD dismissWithDelay:1.0];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        [SVProgressHUD dismissWithDelay:1.0];
    }];

}
- (void)shipingData{
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_upload];
    [SVProgressHUD showWithStatus:@"视频上传中..."];
    
    
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
            self.videoURL = Array[0][@"url"];
            [self addURL];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        [SVProgressHUD dismissWithDelay:1.0];
      
    }];

    
}


//拿着网址上传
- (void)addURL{
    NSString *strringURL = [NSString stringWithFormat:@"%@%@",AppURL,API_MY_UpVideo];
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    NSDictionary *dic = @{@"uid":uidS,@"title":self.textView.text,@"image":self.imaURL,@"mp4":self.videoURL};
    
    
    [HttpUtils postRequestWithURL:strringURL withParameters:dic withResult:^(id result) {
        [SVProgressHUD showSuccessWithStatus:@"上传成功"];
        [SVProgressHUD dismissWithDelay:1.0];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"adddengluShuaxin11" object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addImViodView" object:nil];


        [self.navigationController popViewControllerAnimated:YES];

    } withError:^(NSString *msg, NSError *error) {
        [SVProgressHUD showErrorWithStatus:msg];
        [SVProgressHUD dismissWithDelay:1.0];
        
    }];
}



//点击屏幕空白处
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //回收键盘，两者方式
    //UITextView *textView = (UITextView*)[self.view viewWithTag:1001];
    //[textView resignFirstResponder];
    [self.view endEditing:YES];
    NSLog(@"touch");
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

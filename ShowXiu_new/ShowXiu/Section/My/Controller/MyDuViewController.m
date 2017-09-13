//
//  MyDuViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/3/15.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "MyDuViewController.h"
#import "UITextView+Placeholder.h"

@interface MyDuViewController ()<UITextViewDelegate>
@property (nonatomic, strong)UITextView *taxtView;
@property (nonatomic, strong)UILabel *numberLabel;
@property (nonatomic, copy)NSString *sujuString;
@end

@implementation MyDuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
    self.navigationItem.title = @"内心独白";


    
    UIImage *leimage = [UIImage imageNamed:@"形状16"];
    UIImage *Leimage = [leimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:Leimage style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarLeftitemAction:)];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem11 = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarrightAction:)];
    rightItem11.tintColor = [UIColor colorWithRed:247.0/255.0 green:48.0/255.0 blue:103.0/255.0 alpha:1];
    self.navigationItem.rightBarButtonItem = rightItem11;

    UIView *viewLI = [[UIView alloc]init];
    viewLI.frame = CGRectMake(0, 66, kScreen_w, 150);
    viewLI.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewLI];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.taxtView = [[UITextView alloc]init];
    _taxtView.frame = CGRectMake(10, 6, kScreen_w - 20, 120);
    _taxtView.delegate = self;
    _taxtView.placeholder = @"说点什么吧";
    _taxtView.font = [UIFont systemFontOfSize:15];
    _taxtView.alpha = 0.6;
    self.taxtView.placeholderColor = [UIColor lightGrayColor];

    [viewLI addSubview:_taxtView];
    
    self.numberLabel = [[UILabel alloc]init];
    _numberLabel.frame = CGRectMake(kScreen_w - 80, 120, 60, 20);
    _numberLabel.text = @"150";
    _numberLabel.textAlignment = NSTextAlignmentLeft;
    _numberLabel.textColor = [UIColor blackColor];
    _numberLabel.font = [UIFont systemFontOfSize:14];
    _numberLabel.alpha = 0.6;
    [viewLI addSubview:_numberLabel];
    
    UIButton *suijiButton = [[UIButton alloc]init];
    suijiButton.frame = CGRectMake(kScreen_w - 40 , 120, 20, 18);
    [suijiButton setBackgroundImage:[UIImage imageNamed:@"inner_get_sys"] forState:UIControlStateNormal];
    [suijiButton addTarget:self action:@selector(addsuijiButton:) forControlEvents:UIControlEventTouchUpInside];
    [viewLI addSubview:suijiButton];
    
    
    [self loadData];
//    [self suijiData];

}
- (void)addsuijiButton:(UIButton *)sender{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_My_getSjTitle];
    NSDictionary *dic= @{@"uid":uidS,@"type":@"2"};
    
    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
        self.taxtView.text = result[@"data"][@"monolog"];
        self.sujuString = result[@"data"][@"monolog"];
        
    } withError:^(NSString *msg, NSError *error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSLog(@"确定执行");
            
        }];
        
        
        [alert addAction:otherAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }];
    

}

#pragma mark -- 数据
//获取自己的独白
- (void)loadData{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_My_mologShow];
    NSDictionary *dic= @{@"uid":uidS};
    
    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
        self.taxtView.text = result[@"data"][@"monolog"];
        
        
    } withError:^(NSString *msg, NSError *error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSLog(@"确定执行");
            
        }];
        
        
        [alert addAction:otherAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }];
    
    

}


#pragma mark - 用户交互
//返回
- (void)handleNavigationBarLeftitemAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//完成
- (void)handleNavigationBarrightAction:(UIBarButtonItem *)sender{
    NSInteger number = [self.taxtView.text length];
    if (number == 0 ) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"输入内容不能为空" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *seqing = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        
        [alert addAction:seqing];
        [self presentViewController:alert animated:YES completion:nil];
        
    }else {
        NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
        
        NSString *uidS = [defatults objectForKey:uidSG];
        
        NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_My_mologAdd];
        NSString *typeString = @"";
        if ([self.sujuString isEqualToString:self.taxtView.text]) {
            typeString = @"2";
        }else {
            typeString = @"1";
        }
        NSDictionary *dic= @{@"uid":uidS,@"molog":self.taxtView.text,@"type":typeString};
        
        [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
            [SVProgressHUD showSuccessWithStatus:result[@"msg"]];
            [SVProgressHUD dismissWithDelay:1.0];
            
            
        } withError:^(NSString *msg, NSError *error) {
            [SVProgressHUD showErrorWithStatus:msg];
            [SVProgressHUD dismissWithDelay:1.0];
        }];
    }
}
-(void)textViewDidChange:(UITextView *)textView
{
    
    NSInteger number = [textView.text length];
    if (number > 150) {
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"字符个数不能大于150" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *seqing = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        
        [alert addAction:seqing];
        
        [self presentViewController:alert animated:YES completion:nil];
        textView.text = [textView.text substringToIndex:50];
        number = 50;
    }
    self.numberLabel.text = [NSString stringWithFormat:@"%ld/150",(long)number];
    
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

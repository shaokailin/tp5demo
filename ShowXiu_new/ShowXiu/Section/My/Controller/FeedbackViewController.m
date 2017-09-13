//
//  FeedbackViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/5/17.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "FeedbackViewController.h"
#import "UITextView+Placeholder.h"

@interface FeedbackViewController ()<UITextViewDelegate>
@property (nonatomic, strong)UITextView *taxtView;
@property (nonatomic, strong)UILabel *numberLabel;
@property (nonatomic, copy)NSString *sujuString;
@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
    self.navigationItem.title = @"意见反馈";
    
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
    _taxtView.placeholder = @"给我们留言";
    _taxtView.font = [UIFont systemFontOfSize:15];
    _taxtView.alpha = 0.6;
    self.taxtView.placeholderColor = [UIColor lightGrayColor];
    
    [viewLI addSubview:_taxtView];
    
    self.numberLabel = [[UILabel alloc]init];
    _numberLabel.frame = CGRectMake(kScreen_w - 80, 120, 60, 20);
    _numberLabel.text = @"200";
    _numberLabel.textAlignment = NSTextAlignmentLeft;
    _numberLabel.textColor = [UIColor blackColor];
    _numberLabel.font = [UIFont systemFontOfSize:14];
    _numberLabel.alpha = 0.6;
    [viewLI addSubview:_numberLabel];
    

    
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
        
        NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_My_feedback];
     
        NSDictionary *dic= @{@"uid":uidS,@"phoneType":@"ios",@"content":self.taxtView.text};
        
        [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
            [SVProgressHUD showSuccessWithStatus:result[@"msg"]];
            [SVProgressHUD dismissWithDelay:1.0];
            [self dismissViewControllerAnimated:YES completion:nil];

            
        } withError:^(NSString *msg, NSError *error) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                NSLog(@"确定执行");
                
            }];
            
            
            [alert addAction:otherAction];
            
            [self presentViewController:alert animated:YES completion:nil];
            
        }];
        
        
        
        
        
        
    }
    
    
    
}
-(void)textViewDidChange:(UITextView *)textView
{
    
    NSInteger number = [textView.text length];
    if (number > 150) {
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"字符个数不能大于200" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *seqing = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        
        [alert addAction:seqing];
        
        [self presentViewController:alert animated:YES completion:nil];
        textView.text = [textView.text substringToIndex:50];
        number = 50;
    }
    self.numberLabel.text = [NSString stringWithFormat:@"%ld/200",(long)number];
    
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

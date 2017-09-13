//
//  MyNameViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/4/14.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "MyNameViewController.h"

@interface MyNameViewController ()<UITextFieldDelegate>
@property (nonatomic, strong)UITextField *texf;

@end

@implementation MyNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改昵称";
    self.view.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1];
    
    // 跳转播放按钮
//    UIBarButtonItem *playingItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_media.png"] style:UIBarButtonItemStyleDone target:self action:@selector(handlePlayingButtonItemAction:)];
    
    UIImage *leimage = [UIImage imageNamed:@"形状16"];
    UIImage *Leimage = [leimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:Leimage style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationItenLeftItemAction:)];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    UIBarButtonItem *wanItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(handlePlayingButtonItemAction:)];
    wanItem.tintColor = [UIColor colorWithRed:247.0/255.0 green:48.0/255.0 blue:103.0/255.0 alpha:1];

    self.navigationItem.rightBarButtonItem = wanItem;
    
    //添加返回
//    [self addNavigtion];
    
    self.texf = [[UITextField alloc] init];
    _texf.frame = CGRectMake(12, 80, kScreen_w - 24, 45);
    //_texf.backgroundColor = [UIColor blueColor];
    _texf.placeholder = @"请输入昵称,4-24个字符";
    //设置输入框的边框样式
    _texf.borderStyle = UITextBorderStyleRoundedRect;
    _texf.delegate = self;
    _texf.text = _nameString;
    // 当输入框开始编辑时,清除输入框中文字
    // _texf.clearsOnBeginEditing = YES;
    //设置输入框的清除按键模式
    //_texf.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_texf];

    
    
    
}
- (void)handlePlayingButtonItemAction:(UIBarButtonItem *)sender {
    self.tabBarController.tabBar.hidden = NO;
    
    [self.navigationController popViewControllerAnimated:YES];

    self.nameString = self.texf.text;
    
    [_delegate sendValue:self.texf.text];
}




- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location > 24){
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"字符个数不能大于24,或小与2!" preferredStyle:UIAlertControllerStyleAlert];
        //2.创建action按钮
        //取消样式
        UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {}];
        UIAlertAction *seqing = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:quxiao];
        [alert addAction:seqing];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        return NO;
    }else{
        return YES;
        
    }
    
}
#pragma mark - 用户交互
- (void)handleNavigationItenLeftItemAction:(UIBarButtonItem *)sender {
    self.tabBarController.tabBar.hidden = NO;
    
    [self.navigationController popViewControllerAnimated:YES];
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

//
//  MyManyViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/3/15.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "MyManyViewController.h"
#import "IncomesViewController.h"
#import "WithdrawalViewController.h"
@interface MyManyViewController ()
@property (nonatomic, strong) NSDictionary *dataDic;
@end

@implementation MyManyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ViewRGB;
    self.navigationItem.title = @"我的钱包";
    

    

    
    
    UIImage *leimage = [UIImage imageNamed:@"形状16"];
    UIImage *Leimage = [leimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:Leimage style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarLeftitemAction:)];
    self.navigationItem.leftBarButtonItem = leftItem;

    
    //    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_2"] style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarLeftitemAction
    [self loadData];

}
- (void)addHaerView{
    UIView *haerView = [[UIView alloc]init];
    haerView.frame = CGRectMake(0, 64, kScreen_w, 210);
    [self.view addSubview:haerView];
    
    
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *uidS = [defatults objectForKey:uidSG];
    if ([uidS isEqualToString:@"257555"]) {
        UILabel *zhifu = [[UILabel alloc]init];
        zhifu.text = @"  支出明细";
        zhifu.backgroundColor = [UIColor whiteColor];
        zhifu.alpha = 0.6;
        zhifu.font = [UIFont systemFontOfSize:15];
        zhifu.frame = CGRectMake(0, 64, kScreen_w, 40);
        [self.view addSubview:zhifu];
        
        UIButton *bur11 = [[UIButton alloc]init];
        bur11.frame = CGRectMake(0, 64, kScreen_w, 40);
        [bur11 addTarget:self action:@selector(addbur11:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bur11];
        
    }else {
        haerView.backgroundColor = hong;

        UILabel *shouyiLabel = [[UILabel alloc]init];
        shouyiLabel.text = @"我的收益(秀币)";
        shouyiLabel.frame = CGRectMake(12, 10, kScreen_w- 24, 20);
        shouyiLabel.textColor = [UIColor whiteColor];
        shouyiLabel.font = [UIFont systemFontOfSize:15];
        shouyiLabel.alpha = 0.6;
        [haerView addSubview:shouyiLabel];
        
        
        
        UILabel *monyiLabel = [[UILabel alloc]init];
        monyiLabel.frame = CGRectMake(12, 30, kScreen_w- 24, 30);
        monyiLabel.textColor = [UIColor whiteColor];
        monyiLabel.text = self.dataDic[@"money"];
        monyiLabel.font = [UIFont systemFontOfSize:24];
        monyiLabel.alpha = 0.8;
        monyiLabel.textAlignment = NSTextAlignmentCenter;
        [haerView addSubview:monyiLabel];
        
        UILabel *zhaomonyiLabel = [[UILabel alloc]init];
        zhaomonyiLabel.frame = CGRectMake(0, 70, kScreen_w / 2, 35);
        zhaomonyiLabel.textColor = [UIColor whiteColor];
        zhaomonyiLabel.text = self.dataDic[@"photofmoney"];
        zhaomonyiLabel.font = [UIFont systemFontOfSize:22];
        zhaomonyiLabel.alpha = 0.8;
        zhaomonyiLabel.textAlignment = NSTextAlignmentCenter;
        [haerView addSubview:zhaomonyiLabel];
        
        UILabel *zhaoLabel = [[UILabel alloc]init];
        zhaoLabel.frame = CGRectMake(0, 105, kScreen_w / 2, 35);
        zhaoLabel.textColor = [UIColor whiteColor];
        zhaoLabel.text = @"照片的累计收益";
        zhaoLabel.font = [UIFont systemFontOfSize:15];
        zhaoLabel.alpha = 0.6;
        zhaoLabel.textAlignment = NSTextAlignmentCenter;
        [haerView addSubview:zhaoLabel];
        
        UILabel *xianLabel1 = [[UILabel alloc]init];
        xianLabel1.frame = CGRectMake(0, 140, kScreen_w , 1);
        xianLabel1.backgroundColor = [UIColor whiteColor];
        [haerView addSubview:xianLabel1];
        
        UILabel *xianLabel2 = [[UILabel alloc]init];
        xianLabel2.frame = CGRectMake(kScreen_w/2, 70, 1 , 150);
        xianLabel2.backgroundColor = [UIColor whiteColor];
        [haerView addSubview:xianLabel2];
        
        UILabel *yaomonyiLabel = [[UILabel alloc]init];
        yaomonyiLabel.frame = CGRectMake(kScreen_w / 2, 70, kScreen_w / 2, 35);
        yaomonyiLabel.textColor = [UIColor whiteColor];
        yaomonyiLabel.text = self.dataDic[@"yqmoney"];
        yaomonyiLabel.font = [UIFont systemFontOfSize:22];
        yaomonyiLabel.alpha = 0.8;
        yaomonyiLabel.textAlignment = NSTextAlignmentCenter;
        [haerView addSubview:yaomonyiLabel];
        
        UILabel *yaoLabel = [[UILabel alloc]init];
        yaoLabel.frame = CGRectMake(kScreen_w / 2, 105, kScreen_w / 2, 35);
        yaoLabel.textColor = [UIColor whiteColor];
        yaoLabel.text = @"邀请的累计收益";
        yaoLabel.font = [UIFont systemFontOfSize:15];
        yaoLabel.alpha = 0.6;
        yaoLabel.textAlignment = NSTextAlignmentCenter;
        [haerView addSubview:yaoLabel];
        
        UILabel *liaomonyiLabel = [[UILabel alloc]init];
        liaomonyiLabel.frame = CGRectMake(kScreen_w / 2, 140, kScreen_w / 2, 35);
        liaomonyiLabel.textColor = [UIColor whiteColor];
        liaomonyiLabel.text = self.dataDic[@"ltfmoney"];
        liaomonyiLabel.font = [UIFont systemFontOfSize:22];
        liaomonyiLabel.alpha = 0.8;
        liaomonyiLabel.textAlignment = NSTextAlignmentCenter;
        [haerView addSubview:liaomonyiLabel];
        
        UILabel *liaoLabel = [[UILabel alloc]init];
        liaoLabel.frame = CGRectMake(kScreen_w / 2, 175, kScreen_w / 2, 35);
        liaoLabel.textColor = [UIColor whiteColor];
        liaoLabel.text = @"聊天的累计收益";
        liaoLabel.font = [UIFont systemFontOfSize:15];
        liaoLabel.alpha = 0.6;
        liaoLabel.textAlignment = NSTextAlignmentCenter;
        [haerView addSubview:liaoLabel];
        
        UILabel *shoumonyiLabel = [[UILabel alloc]init];
        shoumonyiLabel.frame = CGRectMake(0, 140, kScreen_w / 2, 35);
        shoumonyiLabel.textColor = [UIColor whiteColor];
        shoumonyiLabel.text = self.dataDic[@"giftmoney"];
        shoumonyiLabel.font = [UIFont systemFontOfSize:22];
        shoumonyiLabel.alpha = 0.8;
        shoumonyiLabel.textAlignment = NSTextAlignmentCenter;
        [haerView addSubview:shoumonyiLabel];
        
        UILabel *shouLabel = [[UILabel alloc]init];
        shouLabel.frame = CGRectMake(0, 175, kScreen_w / 2, 35);
        shouLabel.textColor = [UIColor whiteColor];
        shouLabel.text = @"收礼的累计收益";
        shouLabel.font = [UIFont systemFontOfSize:15];
        shouLabel.alpha = 0.6;
        shouLabel.textAlignment = NSTextAlignmentCenter;
        [haerView addSubview:shouLabel];
        
        UILabel *shuoru = [[UILabel alloc]init];
        shuoru.text = @"  收入明细";
        shuoru.backgroundColor = [UIColor whiteColor];
        shuoru.frame = CGRectMake(0, 284, kScreen_w, 40);
        shuoru.alpha = 0.6;
        shuoru.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:shuoru];
        UIButton *bur = [[UIButton alloc]init];
        bur.frame = CGRectMake(0, 284, kScreen_w, 40);
        [bur addTarget:self action:@selector(addbur:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bur];
        
        UILabel *zhifu = [[UILabel alloc]init];
        zhifu.text = @"  支出明细";
        zhifu.backgroundColor = [UIColor whiteColor];
        zhifu.alpha = 0.6;
        zhifu.font = [UIFont systemFontOfSize:15];
        zhifu.frame = CGRectMake(0, 330, kScreen_w, 40);
        [self.view addSubview:zhifu];
        
        UIButton *bur11 = [[UIButton alloc]init];
        bur11.frame = CGRectMake(0, 330, kScreen_w, 40);
        [bur11 addTarget:self action:@selector(addbur11:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bur11];
        
        NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
        
        NSString *sex = [defatults objectForKey:sexXB];
        int XB = [sex intValue];
        if (XB == 2) {
            UILabel *tixian = [[UILabel alloc]init];
            tixian.text = @"  提   现";
            tixian.backgroundColor = [UIColor whiteColor];
            tixian.alpha = 0.6;
            tixian.font = [UIFont systemFontOfSize:15];
            tixian.frame = CGRectMake(0, 376, kScreen_w, 40);
            [self.view addSubview:tixian];
            
            UIButton *tixianbutton = [[UIButton alloc]init];
            tixianbutton.frame = CGRectMake(0, 376, kScreen_w, 40);
            [tixianbutton addTarget:self action:@selector(addtixianbutton:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:tixianbutton];
        }

        
    }

    
    
    
  
    
}
#pragma mark -- 请求数据
- (void)loadData{
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_MY_Money];
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    [HttpUtils postRequestWithURL:URL withParameters:@{@"uid":uidS} withResult:^(id result) {
     
        self.dataDic = result[@"data"];
        [self addHaerView];

        
        
    } withError:^(NSString *msg, NSError *error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            
        }];
        
        
        [alert addAction:otherAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }];

}

#pragma mark - 用户交互
- (void)handleNavigationBarLeftitemAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


//收入
- (void)addbur:(UIButton *)sender{
    IncomesViewController *IncomesView = [[IncomesViewController alloc]init];
    IncomesView.typeString = @"200";
    [self.navigationController pushViewController:IncomesView animated:nil];
}

- (void)addbur11:(UIButton *)sender{
    IncomesViewController *IncomesView = [[IncomesViewController alloc]init];
    IncomesView.typeString = @"300";
    [self.navigationController pushViewController:IncomesView animated:nil];

}
//提现
- (void)addtixianbutton:(UIButton *)sender{
    WithdrawalViewController *RankingView = [[WithdrawalViewController alloc]init];
//    self.navigationController.navigationBarHidden = NO;
    
    [self.navigationController pushViewController:RankingView animated:nil];
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

//
//  SetViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/3/14.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "SetViewController.h"
#import "MyTableViewCell.h"
#import "MyTableViewCell.h"
#import "StartTheView.h"
#import "RootViewController.h"
#import "ZhuCeViewController.h"
#import "BangViewController.h"
#import "GaiMiViewController.h"
@interface SetViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)StartTheView *startView;

@end

@implementation SetViewController
- (StartTheView *)startView{
    if (!_startView) {
        NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"StartTheView" owner:nil options:nil];
        
        // Find the view among nib contents (not too hard assuming there is only one view in it).
        _startView = [nibContents lastObject];
        _startView.frame = CGRectMake(0, 0, kScreen_w, kScreen_h);
    }
    return  _startView;
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]initWithObjects:@"绑定手机",@"修改密码",@"注销登陆",nil];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"账号设置";
    
    UIImage *leimage = [UIImage imageNamed:@"形状16"];
    UIImage *Leimage = [leimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:Leimage style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarLeftitemAction:)];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    

    [self addTabeleView];
    
}
#pragma mark - 用户交互
- (void)handleNavigationBarLeftitemAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}




- (void)addTabeleView{
    self.tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, 0, kScreen_w, kScreen_h);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [_tableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyTableViewCell"];
    [self.view addSubview:_tableView];
    
}
#pragma make ------ UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
 
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTableViewCell" forIndexPath:indexPath];
    cell.nameLabel.text = self.dataArray[indexPath.row];
    cell.neiLabel.alpha = 0;

    return cell;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else {
        return 10;
        
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0){
        BangViewController *BangView = [[BangViewController alloc]init];
        [self.navigationController pushViewController:BangView animated:nil];
    }else if(indexPath.row == 1) {
        NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
        NSString *user_loginZHSTT = [defatults objectForKey:user_loginZH];
        BOOL HH = [HelperClass isPhoneNumberWith:user_loginZHSTT];
        if(HH){
            GaiMiViewController *GaiMiView = [[GaiMiViewController alloc]init];
            [self.navigationController pushViewController:GaiMiView animated:nil];
        }else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请先绑定手机号" message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
            }];
            
            
            [alert addAction:otherAction];
            
            [self presentViewController:alert animated:YES completion:nil];

        }

       
        
        
    }else if(indexPath.row == 2){
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        self.tabBarController.tabBar.hidden = YES;

        NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
        [defatults setObject:@"" forKey:ageNL];
        [defatults setObject:@"" forKey:avatarIMG];
        [defatults setObject:@"" forKey:uidSG];
        [defatults setObject:@"" forKey:sexXB];
        [defatults setObject:@"" forKey:user_bioashi];
     
        int a = 0;
        
        [UIApplication sharedApplication].applicationIconBadgeNumber = a;
        NSString * st = [NSString stringWithFormat:@"%d",a];
        [defatults setObject:st forKey:user_icon];

        [defatults synchronize];
        
        
        
        [self.view addSubview:self.startView];
        
        [self.startView.nanButton addTarget:self action:@selector(addnanButton:) forControlEvents:UIControlEventTouchUpInside];
        [_startView.nvButton addTarget:self action:@selector(addnvButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addzhiliaoActionLL:) name:@"addzhiliaoActionLL" object:nil];
    }
}
-(void)addzhiliaoActionLL:(NSNotification *)obj{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    [defatults setObject:@"LL" forKey:user_bioashi];
    
    [defatults synchronize];
    
//    [[NSNotificationCenter defaultCenter] removeObserver:@"addzhiliaoAction" name:nil object:self];
    self.startView.hidden = YES;
    
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    self.tabBarController.tabBar.hidden = NO;
       
    
}


#pragma mark --- 已有账号 点此登录

//登录
- (void)addnanButton:(UIButton *)sender{
    
    
    RootViewController *RoVi = [[RootViewController alloc]init];
    [self.navigationController pushViewController:RoVi animated:nil];
    
    //    [self.navigationController presentViewController:RoVi animated:YES completion:nil];
}
//注册
- (void)addnvButton:(UIButton *)sender{
    ZhuCeViewController *zhuceView = [[ZhuCeViewController alloc]init];
    [self.navigationController pushViewController:zhuceView animated:nil];
    
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

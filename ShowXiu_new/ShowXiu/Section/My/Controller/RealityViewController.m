//
//  RealityViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/6/7.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "RealityViewController.h"
#import "MyTableViewCell.h"
#import "BangViewController.h"
#import "TakeViewController.h"
@interface RealityViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tabelView;

@end

@implementation RealityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"真人认证";
    self.view.backgroundColor = ViewRGB;
    UIImage *leimage = [UIImage imageNamed:@"形状16"];
    UIImage *Leimage = [leimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:Leimage style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarLeftitemAction:)];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    [self addView];
}
#pragma mark - 用户交互
- (void)handleNavigationBarLeftitemAction:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)addView{
    self.tabelView = [[UITableView alloc]init];
    _tabelView.frame = CGRectMake(0, 10, kScreen_w, kScreen_h);
    _tabelView.tableFooterView = [UIView new];
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    [self.view addSubview:_tabelView];
    [self.tabelView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyTableViewCell"];

}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //联系方式
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTableViewCell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.nameLabel.text = @"手机认证";
    }else {
        cell.nameLabel.text = @"视频认证";
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        BangViewController *BangView = [[BangViewController alloc]init];
        [self.navigationController pushViewController:BangView animated:nil];
    }else {
        TakeViewController *TakeView = [[TakeViewController alloc]init];
        [self.navigationController pushViewController:TakeView animated:nil];
    }
    

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

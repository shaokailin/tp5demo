//
//  MyXinViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/3/15.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "MyXinViewController.h"
#import "MyXinTableViewCell.h"
#import "CustomerViewController.h"
#import "PrivilegeViewController.h"
#import "InstructionsViewController.h"
#import "ZuanqianViewController.h"
@interface MyXinViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;


@end

@implementation MyXinViewController
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"新手教程";
    
    UIImage *leimage = [UIImage imageNamed:@"形状16"];
    UIImage *Leimage = [leimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:Leimage style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarLeftitemAction:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self addtableView];
    [self loadData];

}
- (void)addtableView{
    self.tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, 0, kScreen_w, kScreen_h - 64);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"MyXinTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyXinTableViewCell"];
    _tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableView];
 
    
}
#pragma mark -- 数据请求
- (void)loadData{
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_MY_NewbieGuide];
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    [HttpUtils postRequestWithURL:URL withParameters:@{@"uid":uidS} withResult:^(id result) {
        [self.dataArray removeAllObjects];
        self.dataArray = result[@"data"];
        
        [self.tableView reloadData];
    } withError:^(NSString *msg, NSError *error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            
        }];
        
        
        [alert addAction:otherAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }];
}

#pragma make ------ UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyXinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyXinTableViewCell" forIndexPath:indexPath];
    NSDictionary *dic = self.dataArray[indexPath.row];
    cell.nameLabel.text = dic[@"title"];
//    if (indexPath.row == 0) {
//        cell.nameLabel.text = @"客服QQ" ;
//    }else if(indexPath.row == 1){
//        cell.nameLabel.text = @"VIP特权说明" ;
//    }else if(indexPath.row == 2){
//        cell.nameLabel.text = @"同城秀秀使用教程";
//    }else if(indexPath.row == 3){
//        cell.nameLabel.text = @"如何赚取金币";
//    }
    
   
    
    return cell;
 
 

    
   
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     NSDictionary *dic = self.dataArray[indexPath.row];
    CustomerViewController *CustomerView = [[CustomerViewController alloc]init];
    CustomerView.dataDic = dic;
    [self.navigationController pushViewController:CustomerView animated:nil];
    
//    
//    if (indexPath.row == 0) {
//        CustomerViewController *CustomerView = [[CustomerViewController alloc]init];
//        CustomerView.dataDic = self.dataArray[1];
//        [self.navigationController pushViewController:CustomerView animated:nil];
//    }else if(indexPath.row == 1){
//        PrivilegeViewController *PrivilegeView = [[PrivilegeViewController alloc]init];
//        PrivilegeView.dataDIc = self.dataArray[3];
//        [self.navigationController pushViewController:PrivilegeView animated:nil];
//    }else if(indexPath.row == 2){
//        InstructionsViewController *InstructionsView = [[InstructionsViewController alloc]init];
//        InstructionsView.dataDIc = self.dataArray[2];
//        [self.navigationController pushViewController:InstructionsView animated:nil];
//    }else {
//        ZuanqianViewController *InstructionsView = [[ZuanqianViewController alloc]init];
//        InstructionsView.dataDIc = self.dataArray[3];
//        [self.navigationController pushViewController:InstructionsView animated:nil];
//    }
}


#pragma mark - 用户交互
- (void)handleNavigationBarLeftitemAction:(UIBarButtonItem *)sender {
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
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

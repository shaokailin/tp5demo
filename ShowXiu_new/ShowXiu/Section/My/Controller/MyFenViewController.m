//
//  MyFenViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/3/15.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "MyFenViewController.h"
#import "MyfenTableViewCell.h"
#import "MyFenModel.h"
#import "MainXiuViewController.h"
@interface MyFenViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, assign)NSInteger page;
@end

@implementation MyFenViewController
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
    self.navigationItem.title = @"我的粉丝";
    UIImage *leimage = [UIImage imageNamed:@"形状16"];
    UIImage *Leimage = [leimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:Leimage style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarLeftitemAction:)];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    [self addTableView];
    
}
- (void)addTableView{
    self.tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, 0, kScreen_w, kScreen_h);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    __weak typeof(self) ws = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [ws refreshData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [ws loadData];
    }];
    [ws refreshData];
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyfenTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyfenTableViewCell"];
    [self.view addSubview:_tableView];
}
#pragma mark - 下拉刷新 上拉加载
- (void)refreshData {
    self.page = 1;
    [self.tableView.mj_footer endRefreshing];
    [self requestListData];
}

- (void)loadData {
    self.page ++ ;
    [self.tableView.mj_header endRefreshing];
    [self requestListData];
}
#pragma mark ------- 获取数据
- (void)requestListData{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_MY_Myfans];
    
    NSString *string = [NSString stringWithFormat:@"%ld",(long)self.page];
    
    NSDictionary *dic = @{@"uid":uidS,@"p":string};
 
    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
        if (self.page == 1) {
            [self.dataArray removeAllObjects];
        }
        NSArray *array = result[@"data"];
        for (NSDictionary *dic in array) {
            MyFenModel *model = [[MyFenModel alloc]initWithDictionary:dic error:nil];
            [self.dataArray addObject:model];
        }
        
        [self.tableView reloadData];
        if (self.page == 1) [self.tableView.mj_header endRefreshing];
        if (self.page != 1) [self.tableView.mj_footer endRefreshing];
    } withError:^(NSString *msg, NSError *error) {
        if (self.page == 1) [self.tableView.mj_header endRefreshing];
        if (self.page != 1) [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
}





#pragma make ------ UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyFenModel *model = self.dataArray[indexPath.row];
    MyfenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyfenTableViewCell" forIndexPath:indexPath];
    [cell.touImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:zhantuImage]];
    cell.nameLabel.text = model.user_nicename;
    cell.neiLabel.text = model.monolog;
    NSString *user_rank = [NSString stringWithFormat:@"%@",model.user_rank];
    int a = [user_rank intValue];
    if (a == 1) {
        cell.VIBButton.hidden = NO;
    }else {
        cell.VIBButton.hidden = YES;
    }
    return cell;

    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 74;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//        return 0;
//    }else {
//        return 10;
//        
//    }
//    
//}
//celldianji
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyFenModel *model = _dataArray[indexPath.row];
    MainXiuViewController *MainView = [[MainXiuViewController alloc]init];
    MainView.name = model.user_nicename;
    MainView.UID = model.ID;
    UINavigationController *tgirNVC = [[UINavigationController alloc]initWithRootViewController:MainView];
    
    [self showViewController:tgirNVC sender:nil];
}


#pragma mark - 用户交互
- (void)handleNavigationBarLeftitemAction:(UIBarButtonItem *)sender {
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

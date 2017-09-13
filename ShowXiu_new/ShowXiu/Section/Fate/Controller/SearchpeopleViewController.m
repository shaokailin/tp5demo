//
//  SearchpeopleViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/5/12.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "SearchpeopleViewController.h"
#import "SePeModel.h"
#import "SePeTableViewCell.h"
#import "MainXiuViewController.h"
@interface SearchpeopleViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;
}

@property (nonatomic, strong)UITableView *tableView;
@end

@implementation SearchpeopleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ViewRGB;
    UIImage *leimage = [UIImage imageNamed:@"形状16"];
    UIImage *Leimage = [leimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:Leimage style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarLeftitemAction:)];
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:leftItem, nil];

    [self addTableView];
}

#pragma mark - 下拉刷新 上拉加载
- (void)refreshData {
    page = 1;
    [self.tableView.mj_footer endRefreshing];
    [self addData];
}

- (void)loadData {
    page ++ ;
    [self.tableView.mj_header endRefreshing];
    [self addData];
}

- (void)addTableView{
    self.tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, 0, kScreen_w, kScreen_h);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]init];
    [self.tableView registerNib:[UINib nibWithNibName:@"SePeTableViewCell" bundle:nil] forCellReuseIdentifier:@"SePeTableViewCell"];
    __weak typeof(self) ws = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [ws refreshData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [ws loadData];
    }];
    
    
    [self.view addSubview:_tableView];
}
- (void)addData{
    NSString *stURL = [NSString stringWithFormat:@"%@%@",AppURL,homesearchURL];
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *uidS = [defatults objectForKey:uidSG];
    NSString *string = [NSString stringWithFormat:@"%ld",(long)page];

    [HttpUtils postRequestWithURL:stURL withParameters:@{@"keyword":self.name,@"uid":uidS,@"p":string} withResult:^(id result) {
        if ([string isEqualToString:@"1"]){
            [self.dataArray removeAllObjects];
        }
        
        NSArray *diArray = result[@"data"];
        NSString *code = [NSString stringWithFormat:@"%@",result[@"code"]];
        int a = [code intValue];
        if (a == 1 && diArray.count > 0) {
            for (NSDictionary *dic in diArray) {
                SePeModel *model = [[SePeModel alloc]initWithDictionary:dic error:nil];
                [self.dataArray addObject:model];
            }
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
    
        
        
    } withError:^(NSString *msg, NSError *error) {
       
        
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
    SePeModel *model = self.dataArray[indexPath.row];
    SePeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SePeTableViewCell" forIndexPath:indexPath];
    [cell.touImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:zhantuImage]];
    cell.nameLabel.text = model.user_nicename;
    cell.neiLabel.text = model.monolog;
//    NSString *user_rank = [NSString stringWithFormat:@"%@",model.user_rank];

    return cell;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
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
    SePeModel *model = self.dataArray[indexPath.row];
    MainXiuViewController *MainView = [[MainXiuViewController alloc]init];
    MainView.name = model.user_nicename;
    MainView.UID = model.ID;
    UINavigationController *tgirNVC = [[UINavigationController alloc]initWithRootViewController:MainView];
    
    [self showViewController:tgirNVC sender:nil];
}

#pragma mark - 用户交互
- (void)handleNavigationBarLeftitemAction:(UIBarButtonItem *)sender {
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

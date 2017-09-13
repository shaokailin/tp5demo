//
//  SystemViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/4/27.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "SystemViewController.h"
#import "SystemTableViewCell.h"
#import "SystemModel.h"
@interface SystemViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;
    
}
@property (nonatomic, strong)UITableView *tabelView;
@property (nonatomic, strong)NSMutableArray *dataSuArray;

@end

@implementation SystemViewController
- (NSMutableArray *)dataSuArray{
    if (!_dataSuArray) {
        _dataSuArray = [[NSMutableArray alloc]init];
    }
    return _dataSuArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ViewRGB;
    self.title = @"系统消息";
    
    [self addUItableView];
    
    UIImage *leimage = [UIImage imageNamed:@"形状16"];
    UIImage *Leimage = [leimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:Leimage style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarLeftitemAction:)];
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:leftItem, nil];
}

#pragma mark - 用户交互
- (void)handleNavigationBarLeftitemAction:(UIBarButtonItem *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shuxinTableVIew" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)addUItableView{
    self.tabelView = [[UITableView alloc]init];
    _tabelView.frame = CGRectMake(0, 10, kScreen_w, kScreen_h - 10);
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    [self.view addSubview:_tabelView];
    __weak typeof(self) ws = self;
    _tabelView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [ws refreshData];
    }];
    _tabelView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        [ws loadData];
    }];
    [self.tabelView registerNib:[UINib nibWithNibName:@"SystemTableViewCell" bundle:nil] forCellReuseIdentifier:@"SystemTableViewCell"];
    _tabelView.tableFooterView = [[UIView alloc]init];
    [self loadData];
    
    
}
#pragma mark - 下拉刷新 上拉加载
- (void)refreshData {
    page = 1;
    [self.tabelView.mj_footer endRefreshing];
    [self addData];
}

- (void)loadData {
    page ++ ;
    [self.tabelView.mj_header endRefreshing];
    [self addData];
}

#pragma mark -- 数据
- (void)addData{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *uidS = [defatults objectForKey:uidSG];
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,systemURL];
    NSString *string = [NSString stringWithFormat:@"%ld",(long)page];
    NSDictionary *dic= @{@"uid":uidS,@"p":string};
    
    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
        NSArray *dataArray = result[@"data"];
        if (page == 1) {
            [self.dataSuArray removeAllObjects];
        }
        
        for (NSDictionary *dic in dataArray) {
            SystemModel *model = [[SystemModel alloc]initWithDictionary:dic error:nil];
            [self.dataSuArray addObject:model];
        }
        
        
        [self.tabelView reloadData];
        [_tabelView.mj_header endRefreshing];
        [_tabelView.mj_footer endRefreshing];
        if (dataArray.count == 0 && page == 1) {
            UIView *view = [[UIView alloc]init];
            view.frame = CGRectMake(0, 0, kScreen_w, kScreen_h);
            view.backgroundColor = [UIColor whiteColor];
            UILabel *Label = [[UILabel alloc]init];
            Label.frame = CGRectMake(0, kScreen_h / 2 - 80, kScreen_w, 30);
            Label.text = @"暂无数据";
            Label.textAlignment = NSTextAlignmentCenter;
            Label.textColor = [UIColor blackColor];
            [view addSubview:Label];
            
            [self.view addSubview:view];
        }
        

        
        
    } withError:^(NSString *msg, NSError *error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSLog(@"确定执行");
            
        }];
        
        
        [alert addAction:otherAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        [_tabelView.mj_header endRefreshing];
        [_tabelView.mj_footer endRefreshing];
    }];
    
}
#pragma mark -----UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSuArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SystemModel *model = self.dataSuArray[indexPath.row];
    SystemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SystemTableViewCell" forIndexPath:indexPath];
    cell.typeLabel.text = model.type;
    cell.timeLabel.text = model.time;
    cell.titleLabel.text = model.msg_content;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SystemModel *model = self.dataSuArray[indexPath.row];
    CGFloat content_h = [HelperClass calculationHeightWithTextsize:15.0 LabelWidth:kScreen_w - 84 WithText:model.msg_content LineSpacing:0];
    return content_h + 66;
}


//cell点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
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

//
//  FocusViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/4/27.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "FocusViewController.h"
#import "SiXinTableViewCell.h"
#import "FocusModel.h"
#import "MainXiuViewController.h"
@interface FocusViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;
    
}
@property (nonatomic, strong)UITableView *tabelView;
@property (nonatomic, strong)NSMutableArray *dataSuArray;
@end

@implementation FocusViewController
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
    [self addUItableView];
    [self refreshData];
    
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
    _tabelView.frame = CGRectMake(0, 1, kScreen_w, kScreen_h);
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    [self.view addSubview:_tabelView];
    __weak typeof(self) ws = self;
    _tabelView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [ws refreshData];
    }];
    _tabelView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [ws loadData];
    }];
    _tabelView.tableFooterView = [[UIView alloc]init];
    [self.tabelView registerNib:[UINib nibWithNibName:@"SiXinTableViewCell" bundle:nil] forCellReuseIdentifier:@"SiXinTableViewCell"];

    
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
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,sublistURL];
    NSString *string = [NSString stringWithFormat:@"%ld",(long)page];
    NSDictionary *dic= @{@"uid":uidS,@"p":string};
    
    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
        if (page == 1) {
            [self.dataSuArray removeAllObjects];
        }
        NSArray *dataArray = result[@"data"];
        for (NSDictionary *dic in dataArray) {
            FocusModel *model = [[FocusModel alloc]initWithDictionary:dic error:nil];
            [self.dataSuArray addObject:model];
        }
        
        if (dataArray.count == 0  && page == 1) {
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
        
        [self.tabelView reloadData];
        [_tabelView.mj_header endRefreshing];
        [_tabelView.mj_footer endRefreshing];
     

        
        
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
    FocusModel *model = self.dataSuArray[indexPath.row];
    SiXinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SiXinTableViewCell" forIndexPath:indexPath];
    [cell.touimagevIew sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:zhantuImage]];
    cell.nameLabel.text = model.user_nicename;
    if ([model.user_rank isEqualToString:@"0"]) {
        cell.VIBButton.hidden = 1;
    }else {
        cell.VIBButton.hidden = 0;
    }
    cell.bianButton.hidden = 1;

    NSString *sting = [NSString stringWithFormat:@"%@关注了你",model.user_nicename];
    cell.titleLabel.text = sting;
    NSString *tiST =[HelperClass timeStampIsConvertedToTime:model.time formatter:@"yyyy-MM-dd HH:mm:ss"];
    cell.timeLabel.text = tiST;
    cell.selectionStyle = UITableViewCellSelectionStyleNone; 
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 74;
}


//cell点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FocusModel *model = _dataSuArray[indexPath.row];
    MainXiuViewController *MainView = [[MainXiuViewController alloc]init];
    MainView.name = model.user_nicename;
    MainView.UID = model.ID;
    UINavigationController *tgirNVC = [[UINavigationController alloc]initWithRootViewController:MainView];
    [self showViewController:tgirNVC sender:nil];
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

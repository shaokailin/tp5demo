//
//  GiftViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/5/24.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "GiftViewController.h"
#import "AcceptTableViewCell.h"
#import "AcceptModel.h"
@interface GiftViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    NSInteger page;
    
}
@property (nonatomic, strong)UITableView *tabelView;
@property (nonatomic, strong)NSMutableArray *dataSuArray;
@end

@implementation GiftViewController
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
    UIImage *leimage = [UIImage imageNamed:@"形状16"];
    UIImage *Leimage = [leimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:Leimage style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarLeftitemAction:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}
- (void)addUItableView{
    self.tabelView = [[UITableView alloc]init];
    _tabelView.frame = CGRectMake(0, 1, kScreen_w, kScreen_h - 1);
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
    [self.tabelView registerNib:[UINib nibWithNibName:@"AcceptTableViewCell" bundle:nil] forCellReuseIdentifier:@"AcceptTableViewCell"];
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
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,listgiftURL];
    NSString *string = [NSString stringWithFormat:@"%ld",(long)page];
    NSDictionary *dic= @{@"uid":self.uid,@"p":string};
    
    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
        if (page == 1) {
            [self.dataSuArray removeAllObjects];
        }
        
        NSArray *dataArray = result[@"data"];
        for (NSDictionary *dic in dataArray) {
            AcceptModel *model = [[AcceptModel alloc]initWithDictionary:dic error:nil];
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
            Label.font = [UIFont systemFontOfSize:15];
            Label.alpha = 0.8;
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
    AcceptModel *model = self.dataSuArray[indexPath.row];
    AcceptTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AcceptTableViewCell" forIndexPath:indexPath];
    [cell.touImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:zhantuImage]];
    cell.nameLanel.text = model.user_nicename;
    if ([model.user_rank isEqualToString:@"0"]) {
        cell.VIPButton.hidden = 1;
    }else {
        cell.VIPButton.hidden = 0;
    }
    NSString *string = [NSString stringWithFormat:@"消费%@金币 x%@",model.gift_price,model.giftnum];
    cell.monyLabel.text = string;
    NSString *tiST =[HelperClass timeStampIsConvertedToTime:model.time formatter:@"yyyy-MM-dd HH:mm:ss"];
    cell.timeLaebl.text = tiST;
    [cell.liImageview sd_setImageWithURL:[NSURL URLWithString:model.gift_image] placeholderImage:
     [UIImage imageNamed:zhanImage]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 84;
}


//cell点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - 用户交互
- (void)handleNavigationBarLeftitemAction:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:nil];
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

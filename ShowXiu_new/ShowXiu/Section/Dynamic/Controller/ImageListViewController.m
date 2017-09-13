//
//  ImageListViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/6/8.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "ImageListViewController.h"
#import "MyImageViewCollectionViewCell.h"
#import "MyImageViewModel.h"
//#import "PersonalImageViewController.h"
#import "PoIMViewController.h"
#import "MyPaiViewController.h"
@interface ImageListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSInteger page;
}
@property (nonatomic, strong)UICollectionViewLayout *customLayout;
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation ImageListViewController
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
    self.navigationItem.title = @"我的照片";
    
    UIImage *leimage = [UIImage imageNamed:@"形状16"];
    UIImage *Leimage = [leimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:Leimage style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarLeftitemAction:)];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
   
    
    [self addCollectionView];
    [self refreshData];
    
}
#pragma mark - 用户交互
- (void)handleNavigationBarLeftitemAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)addCollectionView{
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
    ;
    //设置cell大小
    flowlayout.itemSize = CGSizeMake(kScreen_w /3 - 5, kScreen_w /3 - 5);
    flowlayout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2);
    flowlayout.minimumLineSpacing = 5;
    flowlayout.minimumInteritemSpacing = 5;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreen_w, kScreen_h ) collectionViewLayout:flowlayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    __weak typeof(self) ws = self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [ws refreshData];
    }];
    self.collectionView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        [ws loadData];
    }];
    
    //注册
    //    [self.collectionView registerClass:[PictureCollectionViewCell class] forCellWithReuseIdentifier:@"PictureCollectionViewCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyImageViewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MyImageViewCollectionViewCell"];
    [self.view addSubview:self.collectionView];
    
}

#pragma mark ------ UICollectionViewDataSource
//设置分区item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MyImageViewCollectionViewCell *pictCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyImageViewCollectionViewCell" forIndexPath:indexPath];
    MyImageViewModel *model = self.dataArray[indexPath.row];
    
    [pictCell.imageView sd_setImageWithURL:[NSURL URLWithString:model.uploadfiles] placeholderImage:[UIImage imageNamed:zhanImage]];
    return pictCell;
    
}
#pragma mark - 下拉刷新 上拉加载
- (void)refreshData {
    page = 1;
    [self.collectionView.mj_footer endRefreshing];
    [self addData];
}

- (void)loadData {
    page ++ ;
    [self.collectionView.mj_header endRefreshing];
    [self addData];
}
#pragma mark -- 数据请求
//数据
- (void)addData{
 
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_MY_opephoto];
    NSString *string = [NSString stringWithFormat:@"%ld",(long)page];
    NSDictionary *dic= @{@"uid":self.UID,@"p":string};
    
    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
        
        if ([string isEqualToString:@"1"]){
            [self.dataArray removeAllObjects];
        }
        
        NSArray *array = result[@"data"];
        for (NSDictionary *dic in array) {
            MyImageViewModel *model = [[MyImageViewModel alloc]initWithDictionary:dic error:nil];
            [self.dataArray addObject:model];
        }
        [self.collectionView reloadData];
        [_collectionView.mj_header endRefreshing];
        [_collectionView.mj_footer endRefreshing];
        
        
    } withError:^(NSString *msg, NSError *error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSLog(@"确定执行");
            
        }];
        
        
        [alert addAction:otherAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        [_collectionView.mj_header endRefreshing];
        [_collectionView.mj_footer endRefreshing];
    }];
    
    
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    MyImageViewModel *model = self.dataArray[indexPath.row];
    PoIMViewController  *PersonalImageView  = [[PoIMViewController alloc]init];
    PersonalImageView.HHKK = indexPath.row;
    PersonalImageView.photoidArray = self.dataArray;
    [self.navigationController pushViewController:PersonalImageView animated:nil];
    //    [self.navigationController pushViewController:MainView animated:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)InfoNotificationAction:(NSNotification *)notification{
    [self refreshData];
    
    
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

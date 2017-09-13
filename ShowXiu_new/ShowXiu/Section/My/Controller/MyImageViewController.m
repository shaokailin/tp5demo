//
//  MyImageViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/3/14.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "MyImageViewController.h"
#import "MyImageViewCollectionViewCell.h"
#import "MyImageViewModel.h"
//#import "PersonalImageViewController.h"
#import "PoIMViewController.h"
#import "MyPaiViewController.h"
@interface MyImageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSInteger page;
}
@property (nonatomic, strong)UICollectionViewLayout *customLayout;
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)MBProgressHUD *MBhud;
@property (nonatomic, strong)UIView *tiView;

@end

@implementation MyImageViewController
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
- (UIView *)tiView{
    if (!_tiView) {
        _tiView = [[UIView alloc]init];
        _tiView.frame = CGRectMake(0, 0, kScreen_w, kScreen_h);
        _tiView.backgroundColor = [UIColor whiteColor];
        UILabel *Label = [[UILabel alloc]init];
        Label.frame = CGRectMake(0, kScreen_h / 2 - 80, kScreen_w, 30);
        Label.text = @"暂无数据";
        Label.textAlignment = NSTextAlignmentCenter;
        Label.textColor = [UIColor blackColor];
        [_tiView addSubview:Label];
        
        
    }
    return _tiView;
    
}

- (MBProgressHUD *)MBhud{
    if (!_MBhud) {
        _MBhud = [[MBProgressHUD alloc]init];
        
    }
    return _MBhud;
}


//提示框
- (void)mbhudtui:(NSString *)textname numbertime:(int)nuber{
    //提示框
    [self.view addSubview:self.MBhud];
    [self.MBhud show:YES];
    _MBhud.labelText = textname;
    _MBhud.mode = MBProgressHUDModeText;
    [_MBhud showAnimated:YES whileExecutingBlock:^{
        sleep(nuber);
    } completionBlock:^{
        [_MBhud removeFromSuperview];
        _MBhud = nil;
    }];
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
    
    UIImage *reimage = [UIImage imageNamed:@"ic_photo"];
    UIImage *Reimage = [reimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *lReftItem = [[UIBarButtonItem alloc] initWithImage:Reimage style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarRightBarButtonItem:)];
    
    self.navigationItem.rightBarButtonItem = lReftItem;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:@"addImgView" object:nil];
    
    [self addCollectionView];
    [self refreshData];
    
}
#pragma mark - 用户交互
- (void)handleNavigationBarLeftitemAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)handleNavigationBarRightBarButtonItem:(UIBarButtonItem *)sender{
    MyPaiViewController *MyPaTuView = [[MyPaiViewController alloc]init];
    MyPaTuView.uptype = @"0";
    [self.navigationController pushViewController:MyPaTuView animated:nil];
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
    NSString *zhaungSt = [NSString stringWithFormat:@"%@",model.flag];
    int ZHin =[zhaungSt intValue];
    
    if (ZHin == 0) {
        [pictCell.imaButton setBackgroundImage:[UIImage imageNamed:@"icon-reviewing"] forState:UIControlStateNormal];
    }else if(ZHin == 2){
        [pictCell.imaButton setBackgroundImage:[UIImage imageNamed:@"icon-not-pass"] forState:UIControlStateNormal];
    }
    [pictCell.imaButton addTarget:self action:@selector(addimabutton:) forControlEvents:UIControlEventTouchUpInside];
    [pictCell.shanButton addTarget:self action:@selector(addshanbutton:) forControlEvents:UIControlEventTouchUpInside];
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
    [self.view addSubview:self.MBhud];
    [self.MBhud show:YES];
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_MY_opephoto];
    NSString *string = [NSString stringWithFormat:@"%ld",(long)page];
    NSDictionary *dic= @{@"uid":uidS,@"p":string};
    
    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
     
        if ([string isEqualToString:@"1"]){
            [self.dataArray removeAllObjects];
        }
        
        NSArray *array = result[@"data"];
        for (NSDictionary *dic in array) {
            MyImageViewModel *model = [[MyImageViewModel alloc]initWithDictionary:dic error:nil];
            [self.dataArray addObject:model];
        }
        if (self.dataArray.count == 0  && page == 1) {
            [self.view addSubview:self.tiView];
        }else {
            [self.tiView removeFromSuperview];
        }
        [self.MBhud hide:YES];

        [self.collectionView reloadData];
        [_collectionView.mj_header endRefreshing];
        [_collectionView.mj_footer endRefreshing];
        
        
    } withError:^(NSString *msg, NSError *error) {
        [self mbhudtui:msg numbertime:1];

        [_collectionView.mj_header endRefreshing];
        [_collectionView.mj_footer endRefreshing];
    }];

    
}
- (void)addimabutton:(UIButton *)sender{
    UICollectionViewCell *cell = (UICollectionViewCell *)[[sender superview] superview];//获取cell
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];//获取
    PoIMViewController  *PersonalImageView  = [[PoIMViewController alloc]init];
    PersonalImageView.HHKK = indexPath.row;
    PersonalImageView.photoidArray = self.dataArray;
    [self.navigationController pushViewController:PersonalImageView animated:nil];
    
    
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
//删除
- (void)addshanbutton:(UIButton *)sender{
    UICollectionViewCell *cell = (UICollectionViewCell *)[[sender superview] superview];//获取cell
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];//获取
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否删除" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self shanchuImag:indexPath];

    }];
    UIAlertAction *quxiaoAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
        
    }];
    [alert addAction:quxiaoAction];
    [alert addAction:otherAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
    


}
- (void)shanchuImag:(NSIndexPath *)indeP{
    MyImageViewModel *model = self.dataArray[indeP.row];
    
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_MY_opephoto];
    NSDictionary *dic= @{@"uid":uidS,@"photoids":model.photoid};
    
    [HttpUtils postRequestWithURL:API_delphoto2 withParameters:dic withResult:^(id result) {
        [self mbhudtui:result[@"mag"] numbertime:1];
        [self refreshData];
    } withError:^(NSString *msg, NSError *error) {
        [self mbhudtui:msg numbertime:1];
    }];
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

//
//  ShiImaViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/6/8.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "ShiImaViewController.h"
#import "MyImageViewCollectionViewCell.h"
#import "SiImaModel.h"
#import "MyPaiViewController.h"
#import "PoIMViewController.h"
#import "VideoPlaybackViewController.h"
@interface ShiImaViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSInteger page;
}
@property (nonatomic, strong)UICollectionViewLayout *customLayout;
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UIView *baView;
@property (nonatomic, strong)UIView *diView;

@property (nonatomic, copy)NSString *needxb;
@property(nonatomic,strong)MBProgressHUD * MBhud;//网络等待


@end

@implementation ShiImaViewController
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
- (MBProgressHUD *)MBhud{
    if (!_MBhud) {
        _MBhud = [[MBProgressHUD alloc]init];
        _MBhud.yOffset =  _MBhud.yOffset - 70;
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
    self.navigationItem.title = @"我的私房照";
    
    UIImage *leimage = [UIImage imageNamed:@"形状16"];
    UIImage *Leimage = [leimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:Leimage style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarLeftitemAction:)];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    [self addCollectionView];
    
}
- (void)simizhaoXIUXIUAction{
    [self addData];
}


#pragma mark - 用户交互
- (void)handleNavigationBarLeftitemAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)addCollectionView{
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat a = kScreen_w - 20;
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
    [self refreshData];
    
}

#pragma mark ------ UICollectionViewDataSource
//设置分区item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyImageViewCollectionViewCell *pictCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyImageViewCollectionViewCell" forIndexPath:indexPath];
    pictCell.shanButton.hidden = YES;
    [pictCell.imaButton addTarget:self action:@selector(addimabutton:) forControlEvents:UIControlEventTouchUpInside];
    SiImaModel *model = self.dataArray[indexPath.row];
    NSString *see_status = [NSString stringWithFormat:@"%@",model.see_status];
    pictCell.imageView.userInteractionEnabled = YES;
    int SEE = [see_status intValue];
    if (SEE == 0) {
        [pictCell.imageView sd_setImageWithURL:[NSURL URLWithString:model.uploadfiles] placeholderImage:[UIImage imageNamed:zhanImage]];
        
        pictCell.imaButton.alpha = 1;
        [pictCell.imaButton setBackgroundImage:[UIImage imageNamed:@"icon-media"] forState:UIControlStateNormal];
    }else {
        [pictCell.imageView sd_setImageWithURL:[NSURL URLWithString:model.uploadfiles] placeholderImage:[UIImage imageNamed:zhanImage]];
        pictCell.imaButton.alpha = 0;
        
    }
    
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
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_MY_priphoto];
    NSString *string = [NSString stringWithFormat:@"%ld",(long)page];
    NSDictionary *dic= @{@"fromuid":uidS,@"touid":self.UID,@"photoType":@"2"};
    
    [HttpUtils postRequestWithURL:API_photolist2 withParameters:dic withResult:^(id result) {
        
        if ([string isEqualToString:@"1"]){
            [self.dataArray removeAllObjects];
        }
        
        self.needxb = result[@"data"][@"needxb"];
        NSArray *array = result[@"data"][@"photolist"];
        for (NSDictionary *dic in array) {
            SiImaModel *model = [[SiImaModel alloc]initWithDictionary:dic error:nil];
            [self.dataArray addObject:model];
        }
        if (self.dataArray.count == 0  && page == 1) {
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
- (void)addimabutton:(UIButton *)sender
{
    UICollectionViewCell *cell = (UICollectionViewCell *)[[sender superview] superview];//获取cell
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];//获取
    SiImaModel *model = self.dataArray[indexPath.row];
    NSString *st =[NSString stringWithFormat:@"%@",model.see_status];
    int SEE = [st intValue];
    if (SEE == 0) {
        NSString *string = [NSString stringWithFormat:@"是否话费%@秀币查看？",self.needxb];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:string message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *seqing = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //            MyChongViewController *mychong = [[MyChongViewController alloc]init];
            //            UINavigationController *mychongNVC =[[UINavigationController alloc]initWithRootViewController:mychong];
            //            [self showViewController:mychongNVC sender:nil];
            //            //                [self presentViewController:mychongNVC animated:YES completion:nil];
            [self hufeiUID:model.photoid];
            //
        }];
        [alert addAction:seqing];
        [alert addAction:quxiao];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }else {
        PoIMViewController  *PersonalImageView  = [[PoIMViewController alloc]init];
        PersonalImageView.HHKK = indexPath.row;
        PersonalImageView.photoidArray = self.dataArray;
        [self.navigationController pushViewController:PersonalImageView animated:nil];
        
        
    }
    
}


#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SiImaModel *model = self.dataArray[indexPath.row];
    NSString *st =[NSString stringWithFormat:@"%@",model.see_status];
    int SEE = [st intValue];
    if (SEE == 0) {
        NSString *string = [NSString stringWithFormat:@"是否话费%@秀币查看？"];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:string message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *seqing = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //            MyChongViewController *mychong = [[MyChongViewController alloc]init];
            //            UINavigationController *mychongNVC =[[UINavigationController alloc]initWithRootViewController:mychong];
            //            [self showViewController:mychongNVC sender:nil];
            //            //                [self presentViewController:mychongNVC animated:YES completion:nil];
            [self hufeiUID:model.photoid];
            //
        }];
        [alert addAction:seqing];
        [alert addAction:quxiao];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }else {
        
        VideoPlaybackViewController *MainView = [[VideoPlaybackViewController alloc]init];
        MainView.name = @"";
        MainView.UID = self.UID;
        MainView.mp4 = model.mp4;
        MainView.photoid = model.photoid;
        MainView.mp4imag = model.uploadfiles;
        UINavigationController *tgirNVC = [[UINavigationController alloc]initWithRootViewController:MainView];
        
        [self showViewController:tgirNVC sender:nil];
        
    }
    
    
    //    MyImageViewModel *model = self.dataArray[indexPath.row];
    
    //    [self.navigationController pushViewController:MainView animated:nil];
}
//付费查看
- (void)hufeiUID:(NSString *)UID{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_MY_priphoto];
    NSString *string = [NSString stringWithFormat:@"%ld",(long)page];
    NSDictionary *dic= @{@"fromuid":uidS,@"touid":self.UID,@"photoType":@"1",@"photoid":UID};
    
    [HttpUtils postRequestWithURL:API_see_photo_pay2 withParameters:dic withResult:^(id result) {
        [self mbhudtui:@"已获得查看权限" numbertime:1];
        [self addData];
        
        
    } withError:^(NSString *msg, NSError *error) {
        [self mbhudtui:msg numbertime:1];
        
        
    }];
    
    
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

//
//  RecommendedViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/4/24.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "RecommendedViewController.h"
#import "RecommeModel.h"
#import "PictureSCollectionViewCell.h"
#import "MainXiuViewController.h"
#import "MyChongViewController.h"
@interface RecommendedViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSInteger page;
    
}
@property (nonatomic, strong)UICollectionViewLayout *customLayout;
@property (nonatomic, strong)UICollectionView *collectionView;
//判断现在的 状态 推荐0 附近1 视频3
@property (nonatomic, strong)NSString *urlID;
//@property (nonatomic, strong)StartView *startView;
@property(nonatomic,strong)MBProgressHUD * MBhud;//网络等待
@property (nonatomic, assign)int HLI;


@property (nonatomic, copy)NSString *uidHH;
@property (nonatomic, copy)NSString *xingHH;
@property (nonatomic, copy)NSString *shiID;
@property (nonatomic, copy)NSString *ageHH;

//数据
@property (nonatomic, strong)NSMutableArray *dataArray;
//打招呼的数据
@property (nonatomic, strong)NSMutableArray *SayArray;

@end

@implementation RecommendedViewController
- (NSMutableArray *)SayArray{
    if (!_SayArray) {
        _SayArray = [[NSMutableArray alloc]init];
    }
    return _SayArray;
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


- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    
    NSString *uidS = [defatults objectForKey:uidSG];
    NSString *xing = [defatults objectForKey:sexXB];
    self.uidHH = uidS;
    if ([xing isEqualToString:@"2"]) {
        xing = @"1";
    }else {
        xing = @"2";
    }
    self.HLI = 0;

    self.xingHH = xing;
    self.ageHH = @"";
    self.shiID = @"";
    [self addCollectionView];
    [self addData];
    [self Addhello];

     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:@"InfoNotificationLI" object:nil];
}
//一键打招呼
- (void)Addhello{
    UIButton *zhFU = [UIButton buttonWithType:UIButtonTypeSystem];
    zhFU.frame = CGRectMake(30, kScreen_h -  220, kScreen_w - 60, 45);
    [zhFU addTarget:self action:@selector(addzhFu:) forControlEvents:UIControlEventTouchUpInside];
//    [zhFU setImage:[UIImage imageNamed:@"icon-onebuttonsayhi-1"] forState:UIControlStateNormal];
    [zhFU setBackgroundImage:[UIImage imageNamed:@"icon-onebuttonsayhi-1"] forState:UIControlStateNormal];
    
//    zhFU.backgroundColor = [UIColor redColor];
    [self.view addSubview:zhFU];

}
- (void)addzhFu:(UIButton *)sender{
    NSArray *arr = self.collectionView.indexPathsForVisibleItems;
    
    NSString *str = @"";
    for (NSIndexPath *kk in arr) {
        RecommeModel *model = self.dataArray[kk.row];
        str = [NSString stringWithFormat:@"%@%@,",str,model.ID];
    }
    
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *uidS = [defatults objectForKey:uidSG];
    
 
    NSDictionary *dic = @{@"fromuid":uidS,@"touids":str};
    [HttpUtils postRequestWithURL:API_sendqdzh withParameters:dic withResult:^(id result) {
        [self mbhudtui:@"一键全撩成功！" numbertime:1];
        for (NSIndexPath *kk in arr) {
            RecommeModel *model = self.dataArray[kk.row];
            model.dzh = @"1";
            [self.dataArray replaceObjectAtIndex:kk.row withObject:model];

        }
        [self.collectionView reloadData];

//        [self addData];
        
        
    } withError:^(NSString *msg, NSError *error) {
        NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
        NSString *uidS = [defatults objectForKey:uidSG];
        if ([uidS isEqualToString:@"257555"]) {
            [self mbhudtui:@"一键全撩成功！" numbertime:1];

        }else {
            if ([msg isEqualToString:@"您的打招呼数已超限，购买vip可无限打招呼！"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:msg message:nil preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *seqing = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    
                }];
                UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"去开通" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    MyChongViewController *mychong = [[MyChongViewController alloc]init];
                    UINavigationController *mychongNVC =[[UINavigationController alloc]initWithRootViewController:mychong];
                    [self showViewController:mychongNVC sender:nil];
                    //                [self presentViewController:mychongNVC animated:YES completion:nil];
                    
                }];
                [alert addAction:seqing];
                [alert addAction:quxiao];
                
                [self presentViewController:alert animated:YES completion:nil];
            }else {
                [self mbhudtui:msg numbertime:1];
            }
            

            
        }
        


        
        
        
        
    }];

    
}


- (void)addCollectionView{
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
    //设置cell大小
    flowlayout.itemSize = CGSizeMake(kScreen_w/2-0.5, kScreen_w/2-0.5);
    flowlayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowlayout.minimumLineSpacing = 1;
    flowlayout.minimumInteritemSpacing = 1;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 1, kScreen_w, kScreen_h - 140) collectionViewLayout:flowlayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    __weak typeof(self) ws = self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [ws refreshData];
    }];
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [ws loadData];
    }];
    
    //注册
    //    [self.collectionView registerClass:[PictureCollectionViewCell class] forCellWithReuseIdentifier:@"PictureCollectionViewCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"PictureSCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PictureSCollectionViewCell"];
    [self.view addSubview:self.collectionView];
    
}
//数据
- (void)addData{
    if (_HLI == 0) {
        [self.view addSubview:self.MBhud];
        [self.MBhud show:YES];
    }
    
    
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];

//    NSString *uidS = [defatults objectForKey:uidSG];
//    NSString *sex = [defatults objectForKey:sexXB];
    NSString *la = [defatults objectForKey:lationString];
    NSString *lo = [defatults objectForKey:longtionString];
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,nearbyURL];
    NSString *string = [NSString stringWithFormat:@"%ld",(long)page];
    
    
    NSDictionary *dic= @{@"uid":self.uidHH,@"sex":self.xingHH,@"age":self.ageHH,@"provinceid":@"",@"cityid":self.shiID,@"p":string,@"lat":la,@"lng":lo};
    
    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
        if ([string isEqualToString:@"1"]){
            [self.dataArray removeAllObjects];
        }
        [self.SayArray removeAllObjects];
        NSArray *array = result[@"data"];
        for (NSDictionary *dic in array) {
            RecommeModel *model = [[RecommeModel alloc]initWithDictionary:dic error:nil];
            [self.dataArray addObject:model];
        }
        if (_HLI == 0) {
            [self.MBhud hide:YES];
            _HLI = _HLI + 1;
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
#pragma mark ------ UICollectionViewDataSource




//设置分区item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PictureSCollectionViewCell *pictCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PictureSCollectionViewCell" forIndexPath:indexPath];
    RecommeModel *model = _dataArray[indexPath.row];
//    ima getI
    [pictCell.TuimageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:zhanImage]];
//    pictCell.TuimageView.image = [self getImageFromUrl:[NSURL URLWithString:model.avatar] imgViewWidth:(kScreen_w - 5) / 2 imgViewHeight:(kScreen_w - 5) / 2];

    
    [pictCell.TuimageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:zhanImage]];
    
    NSString *dzh = [NSString stringWithFormat:@"%@",model.dzh];
    int HH = [dzh intValue];
    if (HH == 0 ) {
        pictCell.shiLabel.text = @"打招呼";
        pictCell.shiLabel.textColor = hong;
        [pictCell.shiButton addTarget:self action:@selector(addshiButton:) forControlEvents:UIControlEventTouchUpInside];
    }else {
        pictCell.shiLabel.text = @"已打招呼";
        pictCell.shiLabel.textColor = [UIColor blackColor];
        
    }
    int XB = [model.sex intValue];
    int age = [model.age intValue];
    NSString *ageST = @"";
    if (age == 0 || age > 1000 || age < -1000) {
        ageST = @"18";
    }else{
        ageST = [NSString stringWithFormat:@"%d",age];
    }
    
    if (XB == 1) {
        [pictCell.xingButton setImage:[UIImage imageNamed:@"icon-manX"] forState:UIControlStateNormal];
        [pictCell.xingButton setTitleColor:blueC forState:UIControlStateNormal];
        [pictCell.xingButton setTitle:ageST forState:UIControlStateNormal];
    }else {
        [pictCell.xingButton setImage:[UIImage imageNamed:@"icon-womanX"] forState:UIControlStateNormal];
        [pictCell.xingButton setTitleColor:hong forState:UIControlStateNormal];
        [pictCell.xingButton setTitle:ageST forState:UIControlStateNormal];
    }

    
    
    [pictCell.shiButton addTarget:self action:@selector(addshiButton:) forControlEvents:UIControlEventTouchUpInside];

    pictCell.juLabel.alpha = 1;
    NSString *nameSt = model.user_nicename;
    if ([nameSt length] > 5) {
        NSString *results2 = [nameSt substringToIndex:5];
        nameSt = [NSString stringWithFormat:@"%@…",results2];
    }
    pictCell.nameLabel.text = nameSt;
    
    NSString *KMString = [NSString stringWithFormat:@"%@km",model.km];
    pictCell.juLabel.text = KMString;
    return pictCell;
    
}
- (void)addshiButton:(UIButton *)sender{
    PictureSCollectionViewCell *cell = (PictureSCollectionViewCell *)[[sender superview] superview];//获取cell
    NSIndexPath *indexPathAll = [self.collectionView indexPathForCell:cell];//获取cell对应的section
    RecommeModel *model = _dataArray[indexPathAll.row];
    
    //    NSString *string = [NSString stringWithFormat:@"跟%@打招呼成功",model.user_nicename];
    NSDictionary *dic = @{@"fromuid":self.uidHH,@"touid":model.ID};
    [HttpUtils postRequestWithURL:API_sendzh withParameters:dic withResult:^(id result) {
        cell.shiLabel.text = @"已打招呼";
        cell.shiLabel.textColor = [UIColor blackColor];
        //        [self addData];
        //        sender.
    } withError:^(NSString *msg, NSError *error) {
        
    }];
    
    
    
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// 2.实现收到通知触发的方法

- (void)InfoNotificationAction:(NSNotification *)notification{
    //    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    //    [defatults setObject:self.xingsex forKey:@"shaisex"];
    //    [defatults setObject:self.nian forKey:@"shuanian"];
    //    [defatults setObject:self.shenID forKey:@"shuashenID"];
    //    [defatults setObject:self.shiID forKey:@"shuashiID"];
    
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    self.xingHH = [defatults objectForKey:@"shaisex"];
    self.ageHH = [defatults objectForKey:@"shuanian"];
    self.shiID = [defatults objectForKey:@"shuashiID"];
    [self refreshData];
    
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    RecommeModel *model = _dataArray[indexPath.row];
    MainXiuViewController *MainView = [[MainXiuViewController alloc]init];
    MainView.name = model.user_nicename;
    MainView.UID = model.ID;
    UINavigationController *tgirNVC = [[UINavigationController alloc]initWithRootViewController:MainView];
    
    [self showViewController:tgirNVC sender:nil];
    //    [self.navigationController pushViewController:MainView animated:nil];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
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

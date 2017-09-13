//
//  VideoViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/4/24.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "VideoViewController.h"
#import "VideoModel.h"
#import "PictureCollectionViewCell.h"
#import "VideoPlaybackViewController.h"
#import "MyChongViewController.h"
@interface VideoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSInteger page;
    
}
@property (nonatomic, strong)UICollectionViewLayout *customLayout;
@property (nonatomic, strong)UICollectionView *collectionView;
//判断现在的 状态 推荐0 附近1 视频3
@property (nonatomic, strong)NSString *urlID;
//@property (nonatomic, strong)StartView *startView;
@property (nonatomic, copy)NSString *uidHH;
@property (nonatomic, copy)NSString *xingHH;
@property (nonatomic, copy)NSString *shiID;
@property (nonatomic, copy)NSString *ageHH;
@property (nonatomic, assign)int HLI;
@property(nonatomic,strong)MBProgressHUD * MBhud;//网络等待
//数据
@property (nonatomic, strong)NSMutableArray *dataArray;
@end

@implementation VideoViewController
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
    [self addCollectionView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:@"InfoNotificationLI" object:nil];
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
    [self refreshData];

}

- (void)addCollectionView{
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
    //设置cell大小
    flowlayout.itemSize = CGSizeMake(kScreen_w/2 - 0.5, kScreen_w/2 - 0.5);
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
    [self.collectionView registerNib:[UINib nibWithNibName:@"PictureCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PictureCollectionViewCell"];
    [self.view addSubview:self.collectionView];
    
}
//数据
- (void)addData{
    if (_HLI == 0) {
        [self.view addSubview:self.MBhud];
        [self.MBhud show:YES];
    }
    
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    NSString *sex = [defatults objectForKey:sexXB];
    NSString *la = [defatults objectForKey:lationString];
    NSString *lo = [defatults objectForKey:longtionString];
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,indexVideoURL];
    NSString *string = [NSString stringWithFormat:@"%ld",(long)page];
    //1男 2女
    if([sex isEqualToString:@"1"]){
        sex = @"2";
    }else {
        sex = @"1";
    }
    NSDictionary *dic= @{@"uid":self.uidHH,@"sex":self.xingHH,@"age":self.ageHH,@"cityid":self.shiID,@"lat":la,@"lng":lo,@"p":string};
    
    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
        if ([string isEqualToString:@"1"]){
            [self.dataArray removeAllObjects];
        }
        
        
        NSArray *array = result[@"data"];
        for (NSDictionary *dic in array) {
            VideoModel *model = [[VideoModel alloc]initWithDictionary:dic error:nil];
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
        [self mbhudtui:msg numbertime:1];
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
    PictureCollectionViewCell *pictCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PictureCollectionViewCell" forIndexPath:indexPath];
    VideoModel *model = _dataArray[indexPath.row];
    [pictCell.TuimageView sd_setImageWithURL:[NSURL URLWithString:model.uploadfiles] placeholderImage:[UIImage imageNamed:zhanImage]];
    
    int XB = [model.sex intValue];
    int age = [model.age intValue];
    NSString *ageST = @"";
    if (age == 0 || age > 1000 || age < -1000) {
        ageST = @"18";
    }else{
        ageST = [NSString stringWithFormat:@"%d",age];
    }
    
    if (XB == 1) {
        [pictCell.xingB setImage:[UIImage imageNamed:@"icon-manX"] forState:UIControlStateNormal];
        [pictCell.xingB setTitleColor:blueC forState:UIControlStateNormal];
        [pictCell.xingB setTitle:ageST forState:UIControlStateNormal];
    }else {
        [pictCell.xingB setImage:[UIImage imageNamed:@"icon-womanX"] forState:UIControlStateNormal];
        [pictCell.xingB setTitleColor:hong forState:UIControlStateNormal];
        [pictCell.xingB setTitle:ageST forState:UIControlStateNormal];
    }
    [pictCell.anniuButton addTarget:self action:@selector(addanniuButton:) forControlEvents:UIControlEventTouchUpInside];
    pictCell.shiLabel.layer.borderWidth = 1;
    pictCell.shiLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    pictCell.shiLabel.alpha = 0.3;
    pictCell.juLabel.alpha = 0;
    NSString *nameSt = model.user_nicename;
    if ([nameSt length] > 5) {
        NSString *results2 = [nameSt substringToIndex:5];
        nameSt = [NSString stringWithFormat:@"%@…",results2];
    }
    pictCell.nameLabel.text = nameSt;
    return pictCell;
    
}
- (void)addanniuButton:(UIButton *)sender{
    [self.view addSubview:self.MBhud];
    [self.MBhud show:YES];
    


    
    
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    [HttpUtils postRequestWithURL:API_showVideo2 withParameters:@{@"uid":uidS} withResult:^(id result) {
        [self.MBhud hide:YES];

        UICollectionViewCell *cell = (UICollectionViewCell *)[[sender superview] superview];//获取cell
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];//获取
        VideoModel *model = _dataArray[indexPath.row];
        
        VideoPlaybackViewController *MainView = [[VideoPlaybackViewController alloc]init];
        MainView.name = model.user_nicename;
        MainView.UID = model.uid;
        MainView.mp4 = model.mp4;
        MainView.photoid = model.photoid;
        MainView.mp4imag = model.uploadfiles;
        UINavigationController *tgirNVC = [[UINavigationController alloc]initWithRootViewController:MainView];
        
        [self showViewController:tgirNVC sender:nil];
        
    } withError:^(NSString *msg, NSError *error) {
        [self.MBhud hide:YES];

        if ([msg isEqualToString:@"请购买vip"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"你现在还不是VIP，不能查看，是否充值！" message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *seqing = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                
            }];
            UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"去充值" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
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
        
        
    }];
    
    
   

    
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    VideoModel *model = _dataArray[indexPath.row];

    VideoPlaybackViewController *MainView = [[VideoPlaybackViewController alloc]init];
    MainView.name = model.user_nicename;
    MainView.UID = model.uid;
    MainView.mp4 = model.mp4;
    MainView.photoid = model.photoid;
    MainView.mp4imag = model.uploadfiles;
    UINavigationController *tgirNVC = [[UINavigationController alloc]initWithRootViewController:MainView];
    
    [self showViewController:tgirNVC sender:nil];
    //    [self.navigationController pushViewController:MainView animated:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 2.实现收到通知触发的方法

- (void)InfoNotificationAction:(NSNotification *)notification{
    
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    self.xingHH = [defatults objectForKey:@"shaisex"];
    self.ageHH = [defatults objectForKey:@"shuanian"];
    self.shiID = [defatults objectForKey:@"shuashiID"];
    [self refreshData];
    
}
//隐藏tabBarController
- (void)viewWillAppear:(BOOL)animated{
    [self.MBhud hide:YES];
    
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

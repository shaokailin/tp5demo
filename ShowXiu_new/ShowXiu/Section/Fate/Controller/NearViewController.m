//
//  NearViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/4/24.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "NearViewController.h"
#import "FateModel.h"
#import "PictureSCollectionViewCell.h"
#import <CoreLocation/CoreLocation.h>
#import "SignView.h"
#import "MainXiuViewController.h"
#import "NSString+MD5.h"
#import "JPUSHService.h"
#import "ThroughViewController.h"
//一键撩吧
#import "LiaoSisterView.h"
#import "MyChongViewController.h"

@interface NearViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,CLLocationManagerDelegate>
{
    NSInteger page;
    CLLocationManager *locationManager;
    NSString * Strlation; //经度
    NSString * Strlongtion; //维度
    NSDictionary *dataDic;

    
}

@property (nonatomic, strong)UICollectionViewLayout *customLayout;
@property (nonatomic, strong)UICollectionView *collectionView;
//判断现在的 状态 推荐0 附近1 视频3
@property (nonatomic, strong)NSString *urlID;
//@property (nonatomic, strong)StartView *startView;

//数据
@property (nonatomic, strong)NSMutableArray *dataArray;

@property (nonatomic, strong)SignView *qiandView;
@property (nonatomic, strong)UIView *baView;

@property (nonatomic, copy)NSString *uidHH;
@property (nonatomic, copy)NSString *xingHH;
@property (nonatomic, copy)NSString *shiID;
@property (nonatomic, copy)NSString *ageHH;
@property (nonatomic, assign)int HLI;
@property(nonatomic,strong)MBProgressHUD * MBhud;//网络等待
@property (nonatomic, copy)NSString *sendql;
@property (nonatomic, strong)NSDictionary *appversionDic;
@property (nonatomic, copy)NSString *avatar;//头像审核未通过
//签到
@property (nonatomic, copy)NSString *isqdString;
@end

@implementation NearViewController
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
    Strlation = @"";
    Strlongtion = @"";
    self.HLI = 0;
    
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    NSString *xing = [defatults objectForKey:sexXB];
    self.uidHH = uidS;
    
    NSString *uids = [NSString stringWithFormat:@"%@",uidS];
    //注册推送的别名
    [JPUSHService setTags:nil alias:uids callbackSelector:nil object:nil];
    if ([xing isEqualToString:@"2"]) {
        xing = @"1";
    }else {
        xing = @"2";
    }
    
    self.xingHH = xing;
    self.ageHH = @"";
    self.shiID = @"";
    if ([uids isEqualToString:@"257555"] || [uids isEqualToString:@""]) {
        
    }else {
        //经纬度
        [self lacatemap];
    }
    

    

    self.view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
        [self addCollectionView];
        [self addData];
    
    //[self Addhello];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(firstFicationAction) name:@"firstFicationAction" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(adddetectionXIUXIULI) name:@"detectionXIUXIULI" object:nil];

}
//刷新页面
- (void)firstFicationAction{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    NSString *xing = [defatults objectForKey:sexXB];
    self.uidHH = uidS;
    NSString *uids = [NSString stringWithFormat:@"%@",uidS];
    if ([xing isEqualToString:@"2"]) {
        xing = @"1";
    }else {
        xing = @"2";
    }
    
    self.xingHH = xing;
    self.ageHH = @"";
    self.shiID = @"";

    //注册推送的别名
    [JPUSHService setTags:nil alias:uids callbackSelector:nil object:nil];
    
    [self refreshData];
}


//撩玩返回
- (void)adddetectionXIUXIULI{
    if (![self.avatar isEqualToString:@""]){
        ThroughViewController *ThroughView = [[ThroughViewController alloc]init];
        UINavigationController *tgirNVC = [[UINavigationController alloc]initWithRootViewController:ThroughView];
        ThroughView.araet = self.avatar;
        [self showViewController:tgirNVC sender:nil];
    }else {
        if ([self.isqdString isEqualToString:@"0"]){
            [self qiandaoData];
            
            
        }
    }

}


//一键打招呼
- (void)Addhello{
    UIButton *zhFU = [UIButton new];
    zhFU.frame = CGRectMake(kScreen_w - 70, kScreen_h - 220, 60, 60);
    zhFU.alpha = 1;
    [zhFU addTarget:self action:@selector(addzhFu:) forControlEvents:UIControlEventTouchUpInside];
    [zhFU setImage:[UIImage imageNamed:@"全部打招呼"] forState:UIControlStateNormal];
    [self.view addSubview:zhFU];
    
}
- (void)addzhFu:(UIButton *)sender{
    ThroughViewController *ThroughView = [[ThroughViewController alloc]init];
    UINavigationController *tgirNVC = [[UINavigationController alloc]initWithRootViewController:ThroughView];
    [self showViewController:tgirNVC sender:nil];
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
    [self.collectionView registerNib:[UINib nibWithNibName:@"PictureSCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PictureSCollectionViewCell"];
    [self.view addSubview:self.collectionView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:@"InfoNotificationLI" object:nil];
    
}
//数据
- (void)addData{
    if (_HLI == 0) {
        [self.view addSubview:self.MBhud];
        [self.MBhud show:YES];
    }
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,wxprovingURL];
    NSString *string = [NSString stringWithFormat:@"%ld",(long)page];
    
    NSDictionary *dic= @{@"uid":self.uidHH,@"sex":self.xingHH,@"age":self.ageHH,@"provinceid":@"",@"cityid":@"",@"p":string,@"lat":Strlation,@"lng":Strlongtion,@"type":@"ios",@"version":@"20170603"};
    
    [HttpUtils postRequestWithURL:API_groomUser2 withParameters:dic withResult:^(id result) {
        //签到
        self.isqdString = [NSString stringWithFormat:@"%@",result[@"data"][@"isqd"]];
        //一键全撩
        self.sendql = [NSString stringWithFormat:@"%@",result[@"data"][@"sendql"]];
        //升级
        self.appversionDic = result[@"data"][@"appversion"];
        //审核头像
        self.avatar = result[@"data"][@"avatar"];
        
        [self judgeView];
        
        if ([string isEqualToString:@"1"]){
            [self.dataArray removeAllObjects];
        }
        NSArray *array = result[@"data"][@"list"];
        for (NSDictionary *dic in array) {
            FateModel *model = [[FateModel alloc]initWithDictionary:dic error:nil];
            [self.dataArray addObject:model];
        }
        [self.collectionView reloadData];
        if (_HLI == 0) {
            [self.MBhud hide:YES];
            _HLI = _HLI + 1;
        }
        [_collectionView.mj_header endRefreshing];
        [_collectionView.mj_footer endRefreshing];
        
    } withError:^(NSString *msg, NSError *error) {
//        [self.MBhud hide:YES];
        [self mbhudtui:msg numbertime:1];
        [_collectionView.mj_header endRefreshing];
        [_collectionView.mj_footer endRefreshing];
    }];

}
#pragma mark -- 判断哪个页面先出来
- (void)judgeView{//[[dic objectForkey:key] count]
    
    int Sint = [self.sendql intValue];
    if ([self.appversionDic count]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"需要升级" message:_appversionDic[@"upinfo"] preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *seqing = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            NSString *str = _appversionDic[@"downurl"];
            NSURL * url = [NSURL URLWithString:str];
            
            if ([[UIApplication sharedApplication] canOpenURL:url]){
                [[UIApplication sharedApplication] openURL:url];
            }else{
            }
        }];
        [alert addAction:seqing];
        [self presentViewController:alert animated:YES completion:nil];
        
    }else {
        if(Sint == 0){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LiaoSisterViewXiuXiu" object:nil];
            
            
        }else {
            if (![self.avatar isEqualToString:@""]){
                ThroughViewController *ThroughView = [[ThroughViewController alloc]init];
                UINavigationController *tgirNVC = [[UINavigationController alloc]initWithRootViewController:ThroughView];
                ThroughView.araet = self.avatar;
                [self showViewController:tgirNVC sender:nil];
            }else {
                if ([self.isqdString isEqualToString:@"0"]){
                    [self qiandaoData];
                    

            }
        }
        }

    }
}

#pragma mark -- 签到数据
- (void)qiandaoData{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *uidS = [defatults objectForKey:uidSG];
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,qdshowURL];
    [HttpUtils postRequestWithURL:URL withParameters:@{@"uid":uidS} withResult:^(id result) {
        dataDic = result[@"data"];
        [self qiandaoView];
    } withError:^(NSString *msg, NSError *error) {
        
    }];
    
    
}
#pragma mark - 签到页面
- (void)qiandaoView{
    if (self.qiandView) {
        self.baView.hidden = NO;
        self.qiandView.hidden = NO;
    }else {
    
    self.baView = [[UIView alloc]init];
    _baView.frame = CGRectMake(0, - 103, kScreen_w, kScreen_h);
    _baView.backgroundColor = [UIColor blackColor];
    _baView.alpha = 0.6;
    [self.view addSubview:_baView];
    
    
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"SignView" owner:nil options:nil];
    // Find the view among nib contents (not too hard assuming there is only one view in it).
    self.qiandView = [nibContents lastObject];
    _qiandView.frame = CGRectMake(kScreen_w/2 - 137, kScreen_h/ 2 - 225, 275, 310);
    _qiandView.backgroundColor = [UIColor whiteColor];
    _qiandView.layer.cornerRadius = 5;
    _qiandView.layer.masksToBounds = 1;
    [self.view addSubview:_qiandView];
    
    [_qiandView.XButton addTarget:self action:@selector(addXButton:) forControlEvents:UIControlEventTouchUpInside];
    NSString *qdinfoSTring = dataDic[@"qdinfo"];
    NSArray *rewordsArray = dataDic[@"rewords"];
    if (rewordsArray.count == 7) {
        _qiandView.eightButton.hidden = 1;
        _qiandView.eightLabel.hidden = 1;
        NSArray *array = dataDic[@"rewords"];
        _qiandView.oneLabel.text = [NSString stringWithFormat:@"获得%@秀币",array[0][@"day"]];
        _qiandView.twoLabel.text = [NSString stringWithFormat:@"获得%@秀币",array[1][@"day"]];
        _qiandView.threelabel.text = [NSString stringWithFormat:@"获得%@秀币",array[2][@"day"]];
        _qiandView.fourlabel.text = [NSString stringWithFormat:@"获得%@秀币",array[3][@"day"]];
        _qiandView.fiveLabel.text = [NSString stringWithFormat:@"获得%@秀币",array[4][@"day"]];
        _qiandView.sixLabel.text = [NSString stringWithFormat:@"获得%@秀币",array[5][@"day"]];
        _qiandView.sevelabel.text = [NSString stringWithFormat:@"获得%@秀币",array[6][@"day"]];
    }else if (rewordsArray.count == 6){
        _qiandView.eightButton.hidden = 1;
        _qiandView.eightLabel.hidden = 1;
        _qiandView.seveButton.hidden = 1;
        _qiandView.sevelabel.hidden = 1;
        NSArray *array = dataDic[@"rewords"];
        _qiandView.oneLabel.text = [NSString stringWithFormat:@"获得%@秀币",array[0][@"day"]];
        _qiandView.twoLabel.text = [NSString stringWithFormat:@"获得%@秀币",array[1][@"day"]];
        _qiandView.threelabel.text = [NSString stringWithFormat:@"获得%@秀币",array[2][@"day"]];
        _qiandView.fourlabel.text = [NSString stringWithFormat:@"获得%@秀币",array[3][@"day"]];
        _qiandView.fiveLabel.text = [NSString stringWithFormat:@"获得%@秀币",array[4][@"day"]];
        _qiandView.sixLabel.text = [NSString stringWithFormat:@"获得%@秀币",array[5][@"day"]];
  
    }else {
        NSArray *array = dataDic[@"rewords"];
        _qiandView.oneLabel.text = [NSString stringWithFormat:@"获得%@秀币",array[0][@"day"]];
        _qiandView.twoLabel.text = [NSString stringWithFormat:@"获得%@秀币",array[1][@"day"]];
        _qiandView.threelabel.text = [NSString stringWithFormat:@"获得%@秀币",array[2][@"day"]];
        _qiandView.fourlabel.text = [NSString stringWithFormat:@"获得%@秀币",array[3][@"day"]];
        _qiandView.fiveLabel.text = [NSString stringWithFormat:@"获得%@秀币",array[4][@"day"]];
        _qiandView.sixLabel.text = [NSString stringWithFormat:@"获得%@秀币",array[5][@"day"]];
        _qiandView.sevelabel.text = [NSString stringWithFormat:@"获得%@秀币",array[6][@"day"]];
        _qiandView.eightLabel.text = [NSString stringWithFormat:@"h获取%@秀币",array[7][@"day"]];
    }
    int a = [qdinfoSTring intValue];
    if (a > rewordsArray.count) {
        if (rewordsArray.count == 7) {
            [_qiandView.oneButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.oneButton setTitle:@"" forState:UIControlStateNormal];
            _qiandView.oneLabel.textColor = [UIColor redColor];
            [_qiandView.twoButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            _qiandView.twoLabel.textColor = [UIColor redColor];
            [_qiandView.ThreeButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.ThreeButton setTitle:@"" forState:UIControlStateNormal];
            _qiandView.threelabel.textColor = [UIColor redColor];
            [_qiandView.FourButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.FourButton setTitle:@"" forState:UIControlStateNormal];
            _qiandView.fourlabel.textColor = [UIColor redColor];
            [_qiandView.fiveButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.fiveButton setTitle:@"" forState:UIControlStateNormal];

            _qiandView.fiveLabel.textColor = [UIColor redColor];
            [_qiandView.sixButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.sixButton setTitle:@"" forState:UIControlStateNormal];
            _qiandView.sixLabel.textColor = [UIColor redColor];
            [_qiandView.seveButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.seveButton setTitle:@"" forState:UIControlStateNormal];
            _qiandView.sevelabel.textColor = [UIColor redColor];
            NSArray *array = dataDic[@"rewords"];
            NSString *st = [NSString stringWithFormat:@"恭喜你获得%@秀币，明日签到可得%@秀币",array[6][@"day"],array[6][@"day"]];
            _qiandView.titleLabel.text = st;
            

        }else if(rewordsArray.count == 8){
            [_qiandView.oneButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.oneButton setTitle:@"" forState:UIControlStateNormal];
            _qiandView.oneLabel.textColor = [UIColor redColor];
            [_qiandView.twoButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.twoButton setTitle:@"" forState:UIControlStateNormal];
            _qiandView.twoLabel.textColor = [UIColor redColor];
            [_qiandView.ThreeButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.ThreeButton setTitle:@"" forState:UIControlStateNormal];
            _qiandView.threelabel.textColor = [UIColor redColor];
            [_qiandView.FourButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.FourButton setTitle:@"" forState:UIControlStateNormal];
            _qiandView.fourlabel.textColor = [UIColor redColor];
            [_qiandView.fiveButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.fiveButton setTitle:@"" forState:UIControlStateNormal];
            _qiandView.fiveLabel.textColor = [UIColor redColor];
            [_qiandView.sixButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.sixButton setTitle:@"" forState:UIControlStateNormal];
            _qiandView.sixLabel.textColor = [UIColor redColor];
            [_qiandView.seveButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.seveButton setTitle:@"" forState:UIControlStateNormal];
            _qiandView.sevelabel.textColor = [UIColor redColor];
            [_qiandView.eightButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.eightButton setTitle:@"" forState:UIControlStateNormal];
            _qiandView.eightLabel.textColor = [UIColor redColor];
            NSArray *array = dataDic[@"rewords"];
            NSString *st = [NSString stringWithFormat:@"恭喜你获得%@秀币，明日签到可得%@秀币",array[7][@"day"],array[7][@"day"]];
            _qiandView.titleLabel.text = st;

        }else if(rewordsArray.count == 6){
            [_qiandView.oneButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.oneButton setTitle:@"" forState:UIControlStateNormal];
            _qiandView.oneLabel.textColor = [UIColor redColor];
            [_qiandView.twoButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.twoButton setTitle:@"" forState:UIControlStateNormal];
            _qiandView.twoLabel.textColor = [UIColor redColor];
            [_qiandView.ThreeButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.ThreeButton setTitle:@"" forState:UIControlStateNormal];
            _qiandView.threelabel.textColor = [UIColor redColor];
            [_qiandView.FourButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.FourButton setTitle:@"" forState:UIControlStateNormal];
            _qiandView.fourlabel.textColor = [UIColor redColor];
            [_qiandView.fiveButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.fiveButton setTitle:@"" forState:UIControlStateNormal];
            _qiandView.fiveLabel.textColor = [UIColor redColor];
            [_qiandView.sixButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.sixButton setTitle:@"" forState:UIControlStateNormal];
            _qiandView.sixLabel.textColor = [UIColor redColor];
            NSArray *array = dataDic[@"rewords"];
            NSString *st = [NSString stringWithFormat:@"恭喜你获得%@秀币，明日签到可得%@秀币",array[5][@"day"],array[5][@"day"]];
            _qiandView.titleLabel.text = st;
          
        }
        
        
    }else if (a < rewordsArray.count){
        if(a == 0){
            NSArray *array = dataDic[@"rewords"];
            NSString *st = [NSString stringWithFormat:@"恭喜你获得%@秀币，明日签到可得%@秀币",array[0][@"day"],array[1][@"day"]];
            _qiandView.titleLabel.text = st;
        }else if(a == 1){
            [_qiandView.oneButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.oneButton setTitle:@"" forState:UIControlStateNormal];

            _qiandView.oneLabel.textColor = [UIColor redColor];
            NSArray *array = dataDic[@"rewords"];
            NSString *st = [NSString stringWithFormat:@"恭喜你获得%@秀币，明日签到可得%@秀币",array[1][@"day"],array[2][@"day"]];
            _qiandView.titleLabel.text = st;
            
        }else if(a == 2){
            [_qiandView.oneButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.oneButton setTitle:@"" forState:UIControlStateNormal];

            _qiandView.oneLabel.textColor = [UIColor redColor];
            [_qiandView.twoButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.twoButton setTitle:@"" forState:UIControlStateNormal];
            _qiandView.twoLabel.textColor = [UIColor redColor];
            _qiandView.oneLabel.textColor = [UIColor redColor];
            NSArray *array = dataDic[@"rewords"];
            NSString *st = [NSString stringWithFormat:@"恭喜你获得%@秀币，明日签到可得%@秀币",array[2][@"day"],array[3][@"day"]];
            _qiandView.titleLabel.text = st;
        }else if (a == 3){
            [_qiandView.oneButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];

            _qiandView.oneLabel.textColor = [UIColor redColor];
            [_qiandView.twoButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.twoButton setTitle:@"" forState:UIControlStateNormal];

            _qiandView.twoLabel.textColor = [UIColor redColor];
            [_qiandView.ThreeButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.ThreeButton setTitle:@"" forState:UIControlStateNormal];

            _qiandView.threelabel.textColor = [UIColor redColor];
            NSArray *array = dataDic[@"rewords"];
            NSString *st = [NSString stringWithFormat:@"恭喜你获得%@秀币，明日签到可得%@秀币",array[3][@"day"],array[4][@"day"]];
            _qiandView.titleLabel.text = st;

        }else if (a == 4){
            [_qiandView.oneButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.oneButton setTitle:@"" forState:UIControlStateNormal];

            _qiandView.oneLabel.textColor = [UIColor redColor];
            [_qiandView.twoButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.twoButton setTitle:@"" forState:UIControlStateNormal];

            _qiandView.twoLabel.textColor = [UIColor redColor];
            [_qiandView.ThreeButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.ThreeButton setTitle:@"" forState:UIControlStateNormal];
            _qiandView.threelabel.textColor = [UIColor redColor];
            [_qiandView.FourButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.FourButton setTitle:@"" forState:UIControlStateNormal];
            _qiandView.fourlabel.textColor = [UIColor redColor];
            NSArray *array = dataDic[@"rewords"];
            NSString *st = [NSString stringWithFormat:@"恭喜你获得%@秀币，明日签到可得%@秀币",array[4][@"day"],array[5][@"day"]];
            _qiandView.titleLabel.text = st;
            
        }else if (a == 5){
            [_qiandView.oneButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.oneButton setTitle:@"" forState:UIControlStateNormal];
            _qiandView.oneLabel.textColor = [UIColor redColor];
            [_qiandView.twoButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.twoButton setTitle:@"" forState:UIControlStateNormal];

            _qiandView.twoLabel.textColor = [UIColor redColor];
            [_qiandView.ThreeButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.ThreeButton setTitle:@"" forState:UIControlStateNormal];

            _qiandView.threelabel.textColor = [UIColor redColor];
            [_qiandView.FourButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.FourButton setTitle:@"" forState:UIControlStateNormal];
            _qiandView.fourlabel.textColor = [UIColor redColor];
            [_qiandView.fiveButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.fiveButton setTitle:@"" forState:UIControlStateNormal];
            _qiandView.fiveLabel.textColor = [UIColor redColor];
            NSArray *array = dataDic[@"rewords"];
            NSString *st = [NSString stringWithFormat:@"恭喜你获得%@秀币，明日签到可得%@秀币",array[5][@"day"],array[5][@"day"]];
            _qiandView.titleLabel.text = st;
        }else if (a == 6){
            [_qiandView.oneButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.oneButton setTitle:@"" forState:UIControlStateNormal];

            _qiandView.oneLabel.textColor = [UIColor redColor];
            [_qiandView.twoButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.twoButton setTitle:@"" forState:UIControlStateNormal];

            _qiandView.twoLabel.textColor = [UIColor redColor];
            [_qiandView.ThreeButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.ThreeButton setTitle:@"" forState:UIControlStateNormal];

            _qiandView.threelabel.textColor = [UIColor redColor];
            [_qiandView.FourButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.FourButton setTitle:@"" forState:UIControlStateNormal];

            _qiandView.fourlabel.textColor = [UIColor redColor];
            [_qiandView.fiveButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.fiveButton setTitle:@"" forState:UIControlStateNormal];

            _qiandView.fiveLabel.textColor = [UIColor redColor];
            [_qiandView.sixButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.sixButton setTitle:@"" forState:UIControlStateNormal];

            _qiandView.sixLabel.textColor = [UIColor redColor];
            NSArray *array = dataDic[@"rewords"];
            NSString *st = [NSString stringWithFormat:@"恭喜你获得%@秀币，明日签到可得%@秀币",array[5][@"day"],array[5][@"day"]];
            _qiandView.titleLabel.text = st;
            
            
        }else if (a == 7){
            [_qiandView.oneButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.oneButton setTitle:@"" forState:UIControlStateNormal];

            _qiandView.oneLabel.textColor = [UIColor redColor];
            [_qiandView.twoButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.twoButton setTitle:@"" forState:UIControlStateNormal];

            _qiandView.twoLabel.textColor = [UIColor redColor];
            [_qiandView.ThreeButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.ThreeButton setTitle:@"" forState:UIControlStateNormal];

            _qiandView.threelabel.textColor = [UIColor redColor];
            [_qiandView.FourButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.FourButton setTitle:@"" forState:UIControlStateNormal];

            _qiandView.fourlabel.textColor = [UIColor redColor];
            [_qiandView.fiveButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.fiveButton setTitle:@"" forState:UIControlStateNormal];

            _qiandView.fiveLabel.textColor = [UIColor redColor];
            [_qiandView.sixButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.sixButton setTitle:@"" forState:UIControlStateNormal];

            _qiandView.sixLabel.textColor = [UIColor redColor];
            [_qiandView.seveButton setBackgroundImage:[UIImage imageNamed:@"sign_sel"] forState:UIControlStateNormal];
            [_qiandView.seveButton setTitle:@"" forState:UIControlStateNormal];
            _qiandView.sevelabel.textColor = [UIColor redColor];
            NSArray *array = dataDic[@"rewords"];
            NSString *st = [NSString stringWithFormat:@"恭喜你获得%@秀币，明日签到可得%@秀币",array[6][@"day"],array[6][@"day"]];
            _qiandView.titleLabel.text = st;
            
        }

        
    }
    
    [_qiandView.qiandaoButton addTarget:self action:@selector(addqianButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
 
    
    
    
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
    FateModel *model = _dataArray[indexPath.row];
    
    [pictCell.TuimageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:zhanImage]];
    pictCell.TuimageView.userInteractionEnabled = YES;
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

    pictCell.juLabel.alpha = 0;
    NSString *nameSt = model.user_nicename;
    if ([nameSt length] > 5) {
        NSString *results2 = [nameSt substringToIndex:5];
        nameSt = [NSString stringWithFormat:@"%@…",results2];
    }
    pictCell.nameLabel.text = nameSt;
    return pictCell;

}
- (void)addshiButton:(UIButton *)sender{
    PictureSCollectionViewCell *cell = (PictureSCollectionViewCell *)[[sender superview] superview];//获取cell
    NSIndexPath *indexPathAll = [self.collectionView indexPathForCell:cell];//获取cell对应的section
    FateModel *model = _dataArray[indexPathAll.row];
    
//    NSString *string = [NSString stringWithFormat:@"跟%@打招呼成功",model.user_nicename];
    NSDictionary *dic = @{@"fromuid":self.uidHH,@"touid":model.ID};
    [HttpUtils postRequestWithURL:API_sendzh withParameters:dic withResult:^(id result) {
        FateModel *mdoel = model;
        mdoel.dzh = @"1";
        [self.dataArray replaceObjectAtIndex:indexPathAll.row withObject:mdoel];
        [self.collectionView reloadData];
//        cell.shiLabel.text = @"已打招呼";
//        cell.shiLabel.textColor = [UIColor blackColor];
//        [self addData];
//        sender.
    } withError:^(NSString *msg, NSError *error) {
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
        }

        
    }];
    
    
    
}


#pragma mark - 经纬度
- (void)lacatemap{
    //判断定位是否打开
    if ([CLLocationManager locationServicesEnabled]){
        locationManager = [[CLLocationManager alloc]init];
        locationManager.delegate = self;
        [locationManager requestAlwaysAuthorization];
        [locationManager requestWhenInUseAuthorization];
        //设置寻找经度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = 5.0;
        [locationManager startUpdatingLocation];
    }
    
}
//定位失败 执行此代理方法
//定位失败弹出提示框，点击“打开定位”按钮，会打开系统设置，提示打开定位服务
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    //设置提示打开定位服务
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"定位失败" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *OK = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开定位设置
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:settingsURL];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancel];
    [alertController addAction:OK];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [locationManager stopUpdatingLocation];
    //旧值
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    NSString *lationSt = [NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
    Strlation = lationSt;
    NSString *longSt = [NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
    Strlongtion = longSt;
    //打印当前的经纬度
    NSLog(@"%f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    [defatults setObject:lationSt forKey:lationString];
    [defatults setObject:longSt forKey:longtionString];
//    [defatults setObject:@"21444" forKey:uidSG];
//    [defatults setObject:@"1" forKey:sexXB];
//    [defatults synchronize];
    


}

#pragma mark -- 签到的点击事件
//点击
- (void)addXButton:(UIButton *)sender{
    self.baView.hidden = YES;
    self.qiandView.hidden = YES;
    
}
//点击签到
- (void)addqianButton:(UIButton *)sender{
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,signURL];
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    
    [HttpUtils postRequestWithURL:URL withParameters:@{@"uid":uidS} withResult:^(id result) {
        self.qiandView.hidden = YES;
        self.baView.hidden = YES;


//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"签到成功！明天不见不散~" message:nil preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//            
//        }];
//        
//        
//        [alert addAction:otherAction];
//        
//        [self presentViewController:alert animated:YES completion:nil];
//
//        self.baView.hidden = 1;
        [self mbhudtui:@"签到成功！明天不见不散~" numbertime:1];
        
        
    } withError:^(NSString *msg, NSError *error) {
        self.qiandView.alpha = 0;
        self.baView.hidden = YES;
        [self mbhudtui:msg numbertime:1];

        
    }];
    
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FateModel *model = _dataArray[indexPath.row];
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


//隐藏tabBarController
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden = NO;
    
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

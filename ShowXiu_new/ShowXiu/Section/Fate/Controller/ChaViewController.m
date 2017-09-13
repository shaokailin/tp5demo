//
//  ChaViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/3/22.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "ChaViewController.h"
#import "MainXiuViewController.h"
#import "XHCollectionViewCell.h"
#import "XHModel.h"
#import "SearchpeopleViewController.h"
#import "SePeModel.h"
@interface ChaViewController ()<UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)UISearchBar *searchBar;
@property (nonatomic, strong)UIButton *oneButton;
@property (nonatomic, strong)UIButton *twoButton;
@property (nonatomic, strong)UIButton *threeButton;
@property (nonatomic, strong)UIView *souView;

@property (nonatomic, strong)UICollectionViewLayout *customLayout;
@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSMutableArray *shuoArray;
@property (nonatomic, strong)NSArray *lishiArray;
@property(nonatomic,strong)MBProgressHUD * MBhud;//网络等待


@end

@implementation ChaViewController
- (MBProgressHUD *)MBhud{
    if (!_MBhud) {
        _MBhud = [[MBProgressHUD alloc]init];
        _MBhud.yOffset =  _MBhud.yOffset - 70;
    }
    return _MBhud;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
- (NSMutableArray *)shuoArray
{
    if (!_shuoArray) {
        _shuoArray = [[NSMutableArray alloc]init];
    }
    return _shuoArray;


}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ViewRGB;

    UIImage *leimage = [UIImage imageNamed:@"形状16"];
    UIImage *Leimage = [leimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:Leimage style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarLeftitemAction:)];

    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:leftItem, nil];

    [self addSearchControlle];
    //搜索历史
    [self souliView];
    //你可能喜欢
    [self xihuanView];
    //加载历史数据
    [self histitleData];
    //加载可能喜欢
    [self lovembData];
    
    
}
- (void)addSearchControlle{
    // 创建搜索框
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(20, 7, kScreen_w-64-40, 30)];
//    titleView.backgroundColor = [UIColor colorWithRed:237.0/255.0 green:237.0/255.0 blue:237.0/255.0 alpha:1];
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, titleView.frame.size.width, 30)];
    [searchBar setBackgroundColor:[UIColor colorWithRed:237.0/255.0 green:237.0/255.0 blue:237.0/255.0 alpha:1]];
    searchBar.placeholder = @"输入用户昵称或者用户ID";
    searchBar.delegate = self;
    searchBar.layer.cornerRadius = 12;
    searchBar.layer.masksToBounds = YES;
    [searchBar.layer setBorderWidth:8];
    [searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];
    [titleView addSubview:searchBar];
    self.searchBar = searchBar;
    self.navigationItem.titleView = titleView;
    

    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarRinghtAction:)];
    rightItem.tintColor = [UIColor colorWithRed:247.0/255.0 green:48.0/255.0 blue:103.0/255.0 alpha:1];
    self.navigationItem.rightBarButtonItem = rightItem;

}
- (void)souliView{
    self.souView = [[UIView alloc]init];
    _souView.frame = CGRectMake(0, 65, kScreen_w, 100);
    _souView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_souView];
    
    UILabel *souliLabel = [[UILabel alloc]init];
    souliLabel.frame = CGRectMake(12, 20, 100, 20);
    souliLabel.text = @"搜索历史";
    souliLabel.textColor = [UIColor blackColor];
    souliLabel.font = [UIFont systemFontOfSize:15];
    souliLabel.alpha = 0.8;
    [_souView addSubview:souliLabel];
    
    self.oneButton = [[UIButton alloc]init];
    _oneButton.frame = CGRectMake(12, 50, (kScreen_w - 44) / 3, 24);
    _oneButton.layer.cornerRadius = 12;
    _oneButton.layer.masksToBounds = YES;
    _oneButton.layer.borderWidth = 1.0;
    _oneButton.layer.borderColor = [UIColor grayColor].CGColor;
    [_oneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _oneButton.tag = 1000;
    [_oneButton addTarget:self action:@selector(addlishiButton:) forControlEvents:UIControlEventTouchUpInside];
    _oneButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_souView addSubview:_oneButton];
    
    self.twoButton = [[UIButton alloc]init];
    _twoButton.frame = CGRectMake(22 + (kScreen_w - 44) / 3 , 50, (kScreen_w - 44) / 3, 24);
    _twoButton.layer.cornerRadius = 12;
    _twoButton.layer.masksToBounds = YES;
    _twoButton.layer.borderWidth = 1.0;
    _twoButton.layer.borderColor = [UIColor grayColor].CGColor;
    [_twoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _twoButton.tag = 1001;
    _twoButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_twoButton addTarget:self action:@selector(addlishiButton:) forControlEvents:UIControlEventTouchUpInside];
    [_souView addSubview:_twoButton];
    
    self.threeButton = [[UIButton alloc]init];
    _threeButton.frame = CGRectMake(32 + (kScreen_w - 44) / 3 * 2, 50, (kScreen_w - 44) / 3, 24);
    _threeButton.layer.cornerRadius = 12;
    _threeButton.layer.masksToBounds = YES;
    _threeButton.layer.borderWidth = 1.0;
    _threeButton.layer.borderColor = [UIColor grayColor].CGColor;
    [_threeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _threeButton.tag = 1002;
    _threeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_threeButton addTarget:self action:@selector(addlishiButton:) forControlEvents:UIControlEventTouchUpInside];
    [_souView addSubview:_threeButton];
    
    
    UIButton *qinButton = [[UIButton alloc]init];
    qinButton.frame = CGRectMake(kScreen_w - 120, 20, 108, 20);
    [qinButton setTitle:@"清空历史记录" forState:UIControlStateNormal];
    [qinButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [qinButton addTarget:self action:@selector(addqinButton:) forControlEvents:UIControlEventTouchUpInside];
    qinButton.titleLabel.font = [UIFont systemFontOfSize:14];
    qinButton.alpha = 0.8;
    [_souView addSubview:qinButton];
}
- (void)xihuanView{
    UIView *xiView = [[UIView alloc]init];
    xiView.frame = CGRectMake(0, 170, kScreen_w, 200);
    xiView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:xiView];
    
    UILabel *Label = [[UILabel alloc]init];
    Label.frame = CGRectMake(12, 12, 120, 20);
    Label.text = @"你可能喜欢";
    Label.textColor = [UIColor blackColor];
    Label.font = [UIFont systemFontOfSize:15];
    Label.alpha = 0.8;
    [xiView addSubview:Label];
    
    UIButton *qinButton = [[UIButton alloc]init];
    qinButton.frame = CGRectMake(kScreen_w - 50, 20, 40, 10);
    [qinButton setTitle:@"更多" forState:UIControlStateNormal];
    [qinButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    qinButton.titleLabel.font = [UIFont systemFontOfSize:14];
    qinButton.alpha = 0.8;
    [qinButton addTarget:self action:@selector(addxiButton:) forControlEvents:UIControlEventTouchUpInside];
    [xiView addSubview:qinButton];
    
}

//返回
- (void)handleNavigationBarLeftitemAction:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];

}
//搜索
- (void)handleNavigationBarRinghtAction:(UIBarButtonItem *)sender{
    [self HomeData];
}

#pragma make --- UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];

    [self HomeData];
    
    
}
- (void)dataView{
    

}

- (void)ladData{
    
}
///清空历史记录
- (void)addqinButton:(UIButton *)sender{
    [self clearhisData];
}
///更多
- (void)addxiButton:(UIButton *)sender{
    [self moreloveData];
}
- (void)addlishiButton:(UIButton *)sender{
    if (sender.tag == 1000) {
        self.searchBar.text = self.lishiArray[0][@"title"];
        [self HomeData];

    }else if(sender.tag == 1001){
        self.searchBar.text = self.lishiArray[1][@"title"];
        [self HomeData];
    }else {
        self.searchBar.text = self.lishiArray[2][@"title"];
        [self HomeData];
    }
    
    

}

#pragma mark -- 数据请求
//搜索
- (void)HomeData{
    [self.view addSubview:self.MBhud];
    [self.MBhud show:YES];
    
    NSString *stURL = [NSString stringWithFormat:@"%@%@",AppURL,homesearchURL];
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *uidS = [defatults objectForKey:uidSG];


    [HttpUtils postRequestWithURL:stURL withParameters:@{@"keyword":self.searchBar.text,@"uid":uidS,@"p":@""} withResult:^(id result) {
        
        [self.MBhud hide:YES];

        [self.shuoArray removeAllObjects];
        NSArray *diArray = result[@"data"];
        NSString *code = [NSString stringWithFormat:@"%@",result[@"code"]];
        int a = [code intValue];
        if (a == 1 && diArray.count > 0) {
            for (NSDictionary *dic in diArray) {
                SePeModel *model = [[SePeModel alloc]initWithDictionary:dic error:nil];
                [self.shuoArray addObject:model];
            }
            
        
            SearchpeopleViewController *SearchpeopleView = [[SearchpeopleViewController  alloc]init];
            SearchpeopleView.name = self.searchBar.text;
            SearchpeopleView.dataArray = self.shuoArray;
            [self.navigationController pushViewController:SearchpeopleView animated:nil];

        }else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"没有搜到相关内容" message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                
                
            }];
            
            
            [alert addAction:otherAction];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        
        
        
    } withError:^(NSString *msg, NSError *error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSLog(@"确定执行");
            
        }];
        
        
        [alert addAction:otherAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }];
}
//历史搜索
- (void)histitleData{
    [self.view addSubview:self.MBhud];
    [self.MBhud show:YES];
    
    
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *uidS = [defatults objectForKey:uidSG];
    NSString *hisURL = [NSString stringWithFormat:@"%@%@",AppURL,histitleURL];
    [HttpUtils postRequestWithURL:hisURL withParameters:@{@"uid":uidS} withResult:^(id result) {
        NSArray *array = result[@"data"];
        self.lishiArray = array;
        NSString *code = [NSString stringWithFormat:@"%@",result[@"code"]];
        int a = [code intValue];
        [self.MBhud hide:YES];

        if (a == 1) {
            if (array.count == 0) {
                _oneButton.hidden = YES;
                _twoButton.hidden = YES;
                _threeButton.hidden = YES;
                UILabel *Label = [[UILabel alloc]init];
                Label.frame =  CGRectMake(12, 50, (kScreen_w - 44), 30);
                Label.text = @"你还没有历史记录，快去查查吧！";
                Label.alpha = 0.6;
                [_souView addSubview:Label];
            }else if(array.count == 1){
                _oneButton.hidden = NO;
                NSDictionary *onedic = array[0];
                [_oneButton setTitle:onedic[@"title"] forState:UIControlStateNormal];
                _twoButton.hidden = YES;
                _threeButton.hidden = YES;
            }else if (array.count == 2){
                _oneButton.hidden = NO;
                NSDictionary *onedic = array[0];
                [_oneButton setTitle:onedic[@"title"] forState:UIControlStateNormal];
                _twoButton.hidden = NO;
                NSDictionary *twodic = array[1];
                [_twoButton setTitle:twodic[@"title"] forState:UIControlStateNormal];
                _threeButton.hidden = YES;
            }else {
                _oneButton.hidden = NO;
                NSDictionary *onedic = array[0];
                [_oneButton setTitle:onedic[@"title"] forState:UIControlStateNormal];
                _twoButton.hidden = NO;
                NSDictionary *twodic = array[1];
                [_twoButton setTitle:twodic[@"title"] forState:UIControlStateNormal];
                _threeButton.hidden = NO;
                NSDictionary *threedic = array[2];
                [_threeButton setTitle:threedic[@"title"] forState:UIControlStateNormal];
                
            }
        }
        
    } withError:^(NSString *msg, NSError *error) {
        
    }];
    
}
//清空历史
- (void)clearhisData{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *uidS = [defatults objectForKey:uidSG];
    NSString *hisURL = [NSString stringWithFormat:@"%@%@",AppURL,clearhisURL];
    [HttpUtils postRequestWithURL:hisURL withParameters:@{@"uid":uidS} withResult:^(id result) {
        [self histitleData];
    } withError:^(NSString *msg, NSError *error) {
        
    }];
}
//可能喜欢
- (void)lovembData{
    [self.view addSubview:self.MBhud];
    [self.MBhud show:YES];
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *uidS = [defatults objectForKey:uidSG];
    NSString *hisURL = [NSString stringWithFormat:@"%@%@",AppURL,lovembURL];
    [HttpUtils postRequestWithURL:hisURL withParameters:@{@"uid":uidS} withResult:^(id result) {
        NSArray *array = result[@"data"];
        NSString *code = [NSString stringWithFormat:@"%@",result[@"code"]];
        int a = [code intValue];
        if (a == 1) {
            for (NSDictionary *dic in array) {
                XHModel *model = [[XHModel alloc]initWithDictionary:dic error:nil];
                [self.dataArray addObject:model];
            }
            [self addCollectionView];
        }
        [self.MBhud hide:YES];

        
    } withError:^(NSString *msg, NSError *error) {
        
    }];
    
}
//更多
- (void)moreloveData{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *uidS = [defatults objectForKey:uidSG];
    NSString *hisURL = [NSString stringWithFormat:@"%@%@",AppURL,moreloveURL];
    [HttpUtils postRequestWithURL:hisURL withParameters:@{@"uid":uidS} withResult:^(id result) {
        NSArray *array = result[@"data"];
        NSString *code = [NSString stringWithFormat:@"%@",result[@"code"]];
        int a = [code intValue];
        if (a == 1) {
            for (NSDictionary *dic in array) {
                XHModel *model = [[XHModel alloc]initWithDictionary:dic error:nil];
                [self.dataArray addObject:model];
            }
            [self addCollectionView];
        }

        
    } withError:^(NSString *msg, NSError *error) {
        
    }];

    
}
#pragma mark -- UICollectionView
- (void)addCollectionView{
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
    //设置cell大小
    flowlayout.itemSize = CGSizeMake(kScreen_w/3-5, kScreen_w/3-5 + 30);
    flowlayout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2);
    flowlayout.minimumLineSpacing = 5;
    flowlayout.minimumInteritemSpacing = 5;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 220, kScreen_w, kScreen_h - 200) collectionViewLayout:flowlayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = ViewRGB;
    
    //注册
    //    [self.collectionView registerClass:[PictureCollectionViewCell class] forCellWithReuseIdentifier:@"PictureCollectionViewCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"XHCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"XHCollectionViewCell"];
    [self.view addSubview:self.collectionView];
    
}
#pragma mark ------ UICollectionViewDataSource
//设置分区item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XHCollectionViewCell *pictCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XHCollectionViewCell" forIndexPath:indexPath];
    XHModel *model = _dataArray[indexPath.row];
    [pictCell.tuimagVeiw sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:zhanImage]];
    pictCell.tuimagVeiw.layer.masksToBounds = YES;
    pictCell.zanLabel.text = model.zan;
    pictCell.namelabel.text = model.user_nicename;
    pictCell.backgroundColor = [UIColor whiteColor];
    return pictCell;
    
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
 
    
    
    XHModel *model = _dataArray[indexPath.row];
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



//隐藏tabBarController
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

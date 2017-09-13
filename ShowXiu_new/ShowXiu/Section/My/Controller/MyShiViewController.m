//
//  MyShiViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/3/14.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "MyShiViewController.h"
#import "MyshipingCollectionViewCell.h"
#import "MyShiPingViewController.h"
#import "VideoModel.h"
#import "VideoPlaybackViewController.h"
@interface MyShiViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSInteger page;
    
}
@property (nonatomic, strong)UICollectionViewLayout *customLayout;
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *dataArray;

@property (nonatomic, strong)UIView *baView;
@property (nonatomic, strong)UIView *diView;
@property (nonatomic, strong)UITextField *qinTextField;
@property (nonatomic, strong)UITextField *xiuTextField;
@property(nonatomic,strong)MBProgressHUD * MBhud;//网络等待
@property (nonatomic, strong)UIView *tiView;

@end

@implementation MyShiViewController
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
    self.navigationItem.title = @"我的小视频";
    

    UIImage *leimage = [UIImage imageNamed:@"形状16"];
    UIImage *Leimage = [leimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:Leimage style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarLeftitemAction:)];
   
    UIImage *leimage1 = [UIImage imageNamed:@"plus"];
    UIImage *Leimage1 = [leimage1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem1 = [[UIBarButtonItem alloc] initWithImage:Leimage1 style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarLeftitemONeAction:)];
    
    UIImage *shezhiimage = [UIImage imageNamed:@"ic_setting_pri"];
    UIImage *RshezhiimageR = [shezhiimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *lRSeftItem = [[UIBarButtonItem alloc] initWithImage:RshezhiimageR style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarSheRightBarButtonItem:)];
    
    
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItems = @[leftItem1,lRSeftItem];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoViodNotificationAction) name:@"addImViodView" object:nil];

    [self addCollectionView];
    [self addCent];
    [self refreshData];

}
- (void)InfoViodNotificationAction{
    [self refreshData];
}


//设置
- (void)handleNavigationBarSheRightBarButtonItem:(UIBarButtonItem *)sender{
    [self.baView removeFromSuperview];
    [self.diView removeFromSuperview];
    
    self.baView = [[UIView alloc]init];
    _baView.backgroundColor = [UIColor blackColor];
    _baView.frame = CGRectMake(0, 0, kScreen_w, kScreen_h);
    _baView.alpha = 0.3;
    [self.view addSubview:_baView];
    //创建手势对象
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapActionbaView:)];
    
    //讲手势添加到指定的视图上
    [_baView addGestureRecognizer:tap];
    
    self.diView = [[UIView alloc]init];
    _diView.backgroundColor = ViewRGB;
    _diView.frame = CGRectMake(0, kScreen_h - 120, kScreen_w, 120);
    [self.view addSubview:_diView];
    
    UILabel *tiLabe = [[UILabel alloc]init];
    tiLabe.text = @"视频谁能看见(任一满足即可查看)";
    tiLabe.frame =CGRectMake(10, 10, kScreen_w - 20, 30);
    tiLabe.textColor = hong;
    tiLabe.font = [UIFont systemFontOfSize:15];
    [_diView addSubview:tiLabe];
    
    UIView *qinView =[[UIView alloc]init];
    qinView.backgroundColor = [UIColor whiteColor];
    qinView.frame = CGRectMake(10, 40, kScreen_w - 20, 40);
    qinView.layer.cornerRadius = 5;
    qinView.layer.masksToBounds = YES;
    [_diView addSubview:qinView];
    
//    UILabel *qinLabel = [[UILabel alloc]init];
//    qinLabel.frame = CGRectMake(10, 0, 60, 40);
//    qinLabel.text = @"亲密度:";
//    qinLabel.font = [UIFont systemFontOfSize:15];
//    qinLabel.textAlignment = NSTextAlignmentCenter;
//    [qinView addSubview:qinLabel];
//    
//    self.qinTextField = [[UITextField alloc]init];
//    _qinTextField.frame = CGRectMake(80, 0, kScreen_w - 90, 40);
//    _qinTextField.placeholder = @"设置可看私密照(不填默认100)";
//    _qinTextField.font = [UIFont systemFontOfSize:15];
//    [qinView addSubview:_qinTextField];
    
    UILabel *xian = [[UILabel alloc]init];
    xian.frame = CGRectMake(0, 0, kScreen_w - 20, 1);
    xian.backgroundColor = ViewRGB;
    [qinView addSubview:xian];
    
    UILabel *xiuLabel = [[UILabel alloc]init];
    xiuLabel.frame = CGRectMake(10, 1, 60, 39);
    xiuLabel.text = @"秀  币:";
    xiuLabel.font = [UIFont systemFontOfSize:14];
    xiuLabel.textAlignment = NSTextAlignmentCenter;
    [qinView addSubview:xiuLabel];
    
    self.xiuTextField = [[UITextField alloc]init];
    _xiuTextField.frame = CGRectMake(80, 1, kScreen_w - 90, 39);
    _xiuTextField.placeholder = @"花费多少可看(不填默认为200)";
    _xiuTextField.font = [UIFont systemFontOfSize:15];
    [qinView addSubview:_xiuTextField];
    
    UIButton *quButton = [[UIButton alloc]init];
    quButton.frame = CGRectMake(40, 80, 60, 40);
    [quButton setTitle:@"取消" forState:UIControlStateNormal];
    quButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [quButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [quButton addTarget:self action:@selector(addqunaButton:) forControlEvents:UIControlEventTouchUpInside];
    [_diView addSubview:quButton];
    
    
    UIButton *queButton = [[UIButton alloc]init];
    queButton.frame = CGRectMake(kScreen_w - 100, 80, 60, 40);
    [queButton setTitle:@"确定" forState:UIControlStateNormal];
    queButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [queButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [queButton addTarget:self action:@selector(addqunaButtonLi:) forControlEvents:UIControlEventTouchUpInside];
    [_diView addSubview:queButton];
    
    
}
//点击阴影View
- (void)tapActionbaView:(UITapGestureRecognizer *)trap{
    [self.baView removeFromSuperview];
    [self.diView removeFromSuperview];
}
//取消
- (void)addqunaButton:(UIButton *)sender{
    [self.baView removeFromSuperview];
    [self.diView removeFromSuperview];
}
//确定
- (void)addqunaButtonLi:(UIButton *)sender{
    [self.view addSubview:self.MBhud];
    [self.MBhud show:YES];
    [self.baView removeFromSuperview];
    [self.diView removeFromSuperview];
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_My_setPhotoConfig];
    if (self.qinTextField.text == nil) {
        self.qinTextField.text = @"";
    }
    if (self.xiuTextField.text == nil) {
        self.xiuTextField.text = @"";
    }
    
    NSDictionary *dic= @{@"uid":uidS,@"qmd":@"",@"xiubi":self.xiuTextField.text};
    
    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
        [self mbhudtui:@"设置成功" numbertime:1];

        
    } withError:^(NSString *msg, NSError *error) {
        [self mbhudtui:msg numbertime:1];

        
    }];
    
    
    
}


#pragma mark -- 监听
//监听键盘状态
- (void)addCent{
    
    //弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //收起
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

//健谈将要弹出调用的方法
- (void)keyboardWillShow:(NSNotification *)aNotification{
    NSDictionary * userInFo = [aNotification userInfo];
    NSValue * aValue = [userInFo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyBoardRect = [aValue CGRectValue];
    int HH = keyBoardRect.size.height;
    //添加动画改变
    [UIView animateWithDuration:0.1 animations:^{
        [_diView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(kScreen_h-HH-120, 0, HH, 0));
        }];
        //        [_tabelView mas_updateConstraints:^(MASConstraintMaker *make) {
        //            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, _messHeight+50, 0));
        //        }];
        //告诉self.view约束改变重新计算，否则无动画
        [self.view layoutIfNeeded];
    }];
}
//键盘将要收起时调用
- (void)keyboardWillHide:(NSNotification *)aNotification{
    
    //添加动画改变
    [UIView animateWithDuration:0.1 animations:^{
        //mas_updateConstraints 更改约束的值
        [_diView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(kScreen_h-120, 0, 0, 0));
        }];
        //        [_tabelView mas_updateConstraints:^(MASConstraintMaker *make) {
        //            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 50, 0));
        //        }];
        
        //告诉self.view约束改变重新计算，否则无动画
        [self.view layoutIfNeeded];
    }];}

//table滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
    
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



#pragma mark - 数据
- (void)addData{
    [self.view addSubview:self.MBhud];
    [self.MBhud show:YES];
    
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_MY_videoList];
    NSString *pageString = [NSString stringWithFormat:@"%ld",(long)page];
    NSDictionary *dic = @{@"uid":uidS,@"p":pageString};
    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
        [self.MBhud hide:YES];

        if (page == 1) {
            [self.dataArray removeAllObjects];
        }
        NSArray *array = result[@"data"];
        for (NSDictionary *dic  in array) {
            VideoModel *model = [[VideoModel alloc]initWithDictionary:dic error:nil];
            [self.dataArray addObject:model];
        }
        if (self.dataArray.count == 0  && page == 1) {
            [self.view addSubview:self.tiView];
        }else {
            [self.tiView removeFromSuperview];
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


#pragma mark - 用户交互
- (void)handleNavigationBarLeftitemAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)handleNavigationBarLeftitemONeAction:(UIBarButtonItem *)sender{
    
    MyShiPingViewController *MyShiPingView = [[MyShiPingViewController alloc]init];
    [self.navigationController pushViewController:MyShiPingView animated:nil];
    
    
    
}


- (void)addCollectionView{
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
    //设置cell大小
    flowlayout.itemSize = CGSizeMake(kScreen_w /3 - 5, kScreen_w /3 - 5);
    flowlayout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2);
    flowlayout.minimumLineSpacing = 5;
    flowlayout.minimumInteritemSpacing = 5;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreen_w, kScreen_h ) collectionViewLayout:flowlayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    __weak typeof (self) ws = self;
    self.collectionView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [ws refreshData];
    }];
    self.collectionView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        [ws loadData];
    }];
    
    //注册
    //    [self.collectionView registerClass:[PictureCollectionViewCell class] forCellWithReuseIdentifier:@"PictureCollectionViewCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyshipingCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MyshipingCollectionViewCell"];
    [self.view addSubview:self.collectionView];
    
}

#pragma mark ------ UICollectionViewDataSource
//设置分区item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    VideoModel *mode = self.dataArray[indexPath.row];
    MyshipingCollectionViewCell *pictCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyshipingCollectionViewCell" forIndexPath:indexPath];
    [pictCell.imageVeiw sd_setImageWithURL:[NSURL URLWithString:mode.uploadfiles] placeholderImage:[UIImage imageNamed:zhanImage]];
    [pictCell.boButton addTarget:self action:@selector(addbobutton:) forControlEvents:UIControlEventTouchUpInside];
    [pictCell.quanButton addTarget:self action:@selector(addbobutton:) forControlEvents:UIControlEventTouchUpInside];
    int ZHin =[mode.flag intValue];
    if (ZHin == 0) {
        pictCell.quanButton.hidden = NO;
        [pictCell.quanButton setBackgroundImage:[UIImage imageNamed:@"icon-reviewing"] forState:UIControlStateNormal];
    }else if(ZHin == 2){
        pictCell.quanButton.hidden = NO;
        [pictCell.quanButton setBackgroundImage:[UIImage imageNamed:@"icon-not-pass"] forState:UIControlStateNormal];
    }else {
        pictCell.quanButton.hidden = YES;
        [pictCell.boButton setBackgroundImage:[UIImage imageNamed:@"plays"] forState:UIControlStateNormal];

    }
    [pictCell.shanchuButton addTarget:self action:@selector(addshanbutton:) forControlEvents:UIControlEventTouchUpInside];


    
    return pictCell;
    
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    VideoModel *mode = self.dataArray[indexPath.row];

    VideoPlaybackViewController *MainView = [[VideoPlaybackViewController alloc]init];
    MainView.name = @"";
    MainView.UID = mode.uid;
    MainView.mp4 = mode.mp4;
    MainView.photoid = mode.photoid;
    UINavigationController *tgirNVC = [[UINavigationController alloc]initWithRootViewController:MainView];
    [self showViewController:tgirNVC sender:nil];
}
- (void)addbobutton:(UIButton *)sender{
    UICollectionViewCell *cell = (UICollectionViewCell *)[[sender superview] superview];//获取cell
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];//获取
    VideoModel *mode = self.dataArray[indexPath.row];
    
    VideoPlaybackViewController *MainView = [[VideoPlaybackViewController alloc]init];
    MainView.name = @"";
    MainView.UID = mode.uid;
    MainView.mp4 = mode.mp4;
    MainView.photoid = mode.photoid;
    UINavigationController *tgirNVC = [[UINavigationController alloc]initWithRootViewController:MainView];
    [self showViewController:tgirNVC sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    VideoModel *model = self.dataArray[indeP.row];
    
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

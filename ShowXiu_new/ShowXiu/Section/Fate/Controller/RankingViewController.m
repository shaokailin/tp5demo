//
//  RankingViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/4/26.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "RankingViewController.h"
#import "ChatMlistModel.h"
#import "RaTableViewCell.h"
#import "MainXiuViewController.h"
#import "RaSTableViewCell.h"
@interface RankingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;
}
@property (nonatomic, strong)UITableView *tabelView;
@property (nonatomic, strong)NSMutableArray *dataArray;


//数据类型 1总财富榜 2总魅力榜 3周财富榜 4周魅力榜
@property (nonatomic, copy)NSString *typeString;
@property (nonatomic, copy)NSString *zhoutype;
//heView
//@property (nonatomic, strong)UIImageView *touImageView;
//@property (nonatomic, strong)UIView *hearView;
//@property (nonatomic, strong)UIImageView *tiamgeView;
//@property (nonatomic, strong)UITextView *nameTextView;
//@property (nonatomic, strong)UILabel *caifuLabel;
@property (nonatomic, assign)int HLI;
@property (nonatomic, assign)int QMLI;
@property (nonatomic, copy)NSString *tyString;

@property(nonatomic,strong)MBProgressHUD * MBhud;//网络等待


@end

@implementation RankingViewController
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
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
    UIImage *leimage = [UIImage imageNamed:@"形状16"];
    UIImage *Leimage = [leimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:Leimage style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarLeftitemAction:)];
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:leftItem, nil];
    self.typeString = @"周榜";
    self.zhoutype = @"1";

    [self addView];
    
    [self addUITabelView];
    self.HLI = 0;
    self.QMLI = 0;

    [self addAddhelloView];
    [self refreshData];


    
}
// //icon-all-rank 总 icon-week-rank 周
- (void)addAddhelloView{
    self.tyString = @"周榜";
    UIButton *zhFU = [UIButton buttonWithType:UIButtonTypeSystem];
    zhFU.frame = CGRectMake(kScreen_w - 80, kScreen_h -  220, 60, 60);
    [zhFU addTarget:self action:@selector(addbangdan:) forControlEvents:UIControlEventTouchUpInside];
    //    [zhFU setImage:[UIImage imageNamed:@"icon-onebuttonsayhi-1"] forState:UIControlStateNormal];
    [zhFU setBackgroundImage:[UIImage imageNamed:@"icon-week-rank"] forState:UIControlStateNormal];
    
    //    zhFU.backgroundColor = [UIColor redColor];
    [self.view addSubview:zhFU];
    
}
- (void)addbangdan:(UIButton *)sender{
    if ([self.tyString isEqualToString:@"周榜"]) {
        [sender setBackgroundImage:[UIImage imageNamed:@"icon-all-rank"] forState:UIControlStateNormal];
        page = 1;
        self.tyString = @"总榜";
        [self addData];
        
    }else {
         [sender setBackgroundImage:[UIImage imageNamed:@"icon-week-rank"] forState:UIControlStateNormal];
        page = 1;
        self.tyString = @"周榜";
        [self addData];

    }
    
    
    
}


- (void)addView{
    UILabel * Label = [[UILabel alloc]init];
    Label.frame = CGRectMake(0, 0, kScreen_w, 1);
    Label.backgroundColor = ViewRGB;
    [self.view addSubview:Label];

    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(kScreen_w / 2 - 80, 15, 160, 30)];
    UISegmentedControl *segContontrol = [[UISegmentedControl alloc] initWithItems:@[@"财富榜",@"魅力榜"]];
    
    segContontrol.frame = CGRectMake(0, 0,titleView.frame.size.width, 30);
    segContontrol.layer.masksToBounds = YES;
    segContontrol.layer.cornerRadius = 15.0;
    segContontrol.layer.borderWidth = 1.0;
    segContontrol.layer.borderColor = [UIColor redColor].CGColor;
    
    // 设置UISegmentedControl选中的图片
    [segContontrol setBackgroundImage:[UIImage imageNamed:@"CPArenaSegmentSelectedBG"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    
    // 正常的图片
    [segContontrol setBackgroundImage:[UIImage imageNamed:@"CPArenaSegmentBG"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [segContontrol setTintColor:[UIColor colorWithRed:246.0/255.0 green:49.0/255.0 blue:109.0/255.0 alpha:1]];
    
    // 设置选中的文字颜色
    [segContontrol setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateSelected];
    segContontrol.selectedSegmentIndex = 0;
    [segContontrol addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [titleView addSubview:segContontrol];
    [self.view addSubview:titleView];

}
- (void)addUITabelView{
    UILabel *xian = [[UILabel alloc]init];
    xian.backgroundColor = ViewRGB;
    xian.frame = CGRectMake(0, 59, kScreen_w, 1);
    [self.view addSubview:xian];
    
    
    self.tabelView = [[UITableView alloc]init];
    _tabelView.frame = CGRectMake(0, 60, kScreen_w, kScreen_h - 200);
    _tabelView.dataSource = self;
    _tabelView.delegate = self;
    _tabelView.tableFooterView = [[UIView alloc]init];

    __weak typeof(self) ws = self;
    _tabelView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [ws refreshData];
    }];
    _tabelView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [ws loadData];
    }];
    [self.view addSubview:_tabelView];
    [self.tabelView registerNib:[UINib nibWithNibName:@"RaTableViewCell" bundle:nil] forCellReuseIdentifier:@"RaTableViewCell"];
    [self.tabelView registerNib:[UINib nibWithNibName:@"RaSTableViewCell" bundle:nil] forCellReuseIdentifier:@"RaSTableViewCell"];


    
}



#pragma make ------ UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    return self.dataArray.count ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 3) {
        ChatMlistModel *model = self.dataArray[indexPath.row ];
        RaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RaTableViewCell" forIndexPath:indexPath];
        if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2) {
            cell.hangImageView.hidden = NO;
        }else {
            cell.hangImageView.hidden = YES;;
        }
        NSString *user_rank = [NSString stringWithFormat:@"%@",model.user_rank];
        int a = [user_rank intValue];
        if (a == 1) {
            cell.VIP.hidden = NO;
        }else {
            cell.VIP.hidden = YES;
        }
        [cell.touImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:zhanImage]];
        NSString *nameSt = model.user_nicename;
        if ([nameSt length] > 5) {
            NSString *results2 = [nameSt substringToIndex:5];
            nameSt = [NSString stringWithFormat:@"%@…",results2];
        }
        cell.nameLabel.text = nameSt;
        
        if([self.typeString isEqualToString:@"1"]){
            NSString *string = [NSString stringWithFormat:@"%@ 礼物",model.sumgift];
            cell.caifuLabel.text = string;
        }else {
            NSString *string = [NSString stringWithFormat:@"%@ 礼物",model.sumgift];
            cell.caifuLabel.text = string;
        }
        NSString *sex = [NSString stringWithFormat:@"%@",model.sex];
        cell.xingButton.layer.cornerRadius = 3;
        cell.xingButton.layer.masksToBounds = YES;
        NSString *age = [NSString stringWithFormat:@"%@",model.age];
        int sexIn = [sex intValue];
        if (sexIn == 1) {
            UIImage *loginImg = [UIImage imageNamed:@"icon-manXB"];
            loginImg = [loginImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
            [cell.xingButton setImage:loginImg forState:UIControlStateNormal];
            [cell.xingButton setTitle:age forState:UIControlStateNormal];
            [cell.xingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            cell.xingButton.backgroundColor = [UIColor colorWithRed:88.0/255.0 green:183.0/255.0 blue:241.0/255.0 alpha:1];
            
        }else {
            UIImage *loginImg = [UIImage imageNamed:@"womanXBXIUXIU"];
            loginImg = [loginImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
            [cell.xingButton setImage:loginImg forState:UIControlStateNormal];
            [cell.xingButton setTitle:age forState:UIControlStateNormal];
            [cell.xingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            cell.xingButton.backgroundColor = hong;
        }

        if ([self.zhoutype isEqualToString:@"1"]) {
            NSString *caimeiST = [NSString stringWithFormat:@" %@财富",model.jifen];
            NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:12]};
            CGSize size=[caimeiST sizeWithAttributes:attrs];
            UILabel *label = [[UILabel alloc]init];
            label.frame = CGRectMake(134, 43, size.width +3, 12);
            label.layer.cornerRadius = 3;
            label.layer.masksToBounds = YES;
            label.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:160.0/255.0 blue:0 alpha:1];
            label.text = caimeiST;
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = [UIColor whiteColor];
            [cell.contentView addSubview:label];
            cell.songLabel.text = @"送出:";
        }else {
            cell.songLabel.text = @"收礼:";
            NSString *caimeiST = [NSString stringWithFormat:@" %@魅力",model.jifen];
            NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:12]};
            CGSize size=[caimeiST sizeWithAttributes:attrs];
            UILabel *label = [[UILabel alloc]init];
            label.frame = CGRectMake(134, 43, size.width +3, 12);
            label.layer.cornerRadius = 3;
            label.layer.masksToBounds = YES;
            label.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:160.0/255.0 blue:0 alpha:1];
            label.text = caimeiST;
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = [UIColor whiteColor];
            [cell.contentView addSubview:label];
            
        }
        
        
        
        NSString *miString = [NSString stringWithFormat:@"%ld",(long)indexPath.row + 1];
        cell.mingciLabel.text = miString;
        NSString *kM = [NSString stringWithFormat:@"%@km",model.km];
        int KMX = [kM intValue];
        if (KMX == 0 || KMX > 1000) {
            
        }else {
            UILabel *juLiLabel = [[UILabel alloc]init];
            //    NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:16]};
            //    CGSize size=[self.name sizeWithAttributes:attrs];
            juLiLabel.frame = CGRectMake(133, 43, 46, 12);
            juLiLabel.font = [UIFont systemFontOfSize:12];
            juLiLabel.backgroundColor = [UIColor  colorWithRed:227.0/255.0 green:186.0/255.0 blue:139.0/255.0 alpha:1];
            juLiLabel.textColor = [UIColor whiteColor];
            juLiLabel.text = kM;
            juLiLabel.layer.cornerRadius = 3;
            juLiLabel.layer.masksToBounds = YES;
            juLiLabel.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:juLiLabel];
        }
        
        
        
        
        return cell;

    }else {
        ChatMlistModel *model = self.dataArray[indexPath.row ];
        RaSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RaSTableViewCell" forIndexPath:indexPath];
        if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2) {
            cell.hangImageView.hidden = NO;
        }else {
            cell.hangImageView.hidden = YES;;
        }
        NSString *user_rank = [NSString stringWithFormat:@"%@",model.user_rank];
        int a = [user_rank intValue];
        if (a == 1) {
            cell.VIP.hidden = NO;
        }else {
            cell.VIP.hidden = YES;
        }
        [cell.touImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:zhanImage]];
        cell.nameLabel.text = model.user_nicename;
        
        if([self.typeString isEqualToString:@"1"]){
            NSString *string = [NSString stringWithFormat:@"%@ 礼物",model.sumgift];
            cell.caifuLabel.text = string;
        }else {
            NSString *string = [NSString stringWithFormat:@"%@ 礼物",model.sumgift];
            cell.caifuLabel.text = string;
        }
        NSString *sex = [NSString stringWithFormat:@"%@",model.sex];
        cell.xingButton.layer.cornerRadius = 3;
        cell.xingButton.layer.masksToBounds = YES;
        NSString *age = [NSString stringWithFormat:@"%@",model.age];
        int sexIn = [sex intValue];
        if (sexIn == 1) {
            UIImage *loginImg = [UIImage imageNamed:@"icon-manXB"];
            loginImg = [loginImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
            [cell.xingButton setImage:loginImg forState:UIControlStateNormal];
            [cell.xingButton setTitle:age forState:UIControlStateNormal];
            [cell.xingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            cell.xingButton.backgroundColor = [UIColor colorWithRed:88.0/255.0 green:183.0/255.0 blue:241.0/255.0 alpha:1];
            
        }else {
            UIImage *loginImg = [UIImage imageNamed:@"womanXBXIUXIU"];
            loginImg = [loginImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
            [cell.xingButton setImage:loginImg forState:UIControlStateNormal];
            [cell.xingButton setTitle:age forState:UIControlStateNormal];
            [cell.xingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            cell.xingButton.backgroundColor = hong;
        }
        if ([self.zhoutype isEqualToString:@"1"]) {
            NSString *caimeiST = [NSString stringWithFormat:@" %@财富",model.jifen];
            NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:12]};
            CGSize size=[caimeiST sizeWithAttributes:attrs];
            UILabel *label = [[UILabel alloc]init];
            label.frame = CGRectMake(134, 43, size.width +3, 12);
            label.layer.cornerRadius = 3;
            label.layer.masksToBounds = YES;
            label.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:160.0/255.0 blue:0 alpha:1];
            label.text = caimeiST;
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = [UIColor whiteColor];
            [cell.contentView addSubview:label];
            cell.songLabel.text = @"送出:";
        }else {
            cell.songLabel.text = @"收礼:";
            NSString *caimeiST = [NSString stringWithFormat:@" %@魅力",model.jifen];
            NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:12]};
            CGSize size=[caimeiST sizeWithAttributes:attrs];
            UILabel *label = [[UILabel alloc]init];
            label.frame = CGRectMake(134, 43, size.width +3, 12);
            label.layer.cornerRadius = 3;
            label.layer.masksToBounds = YES;
            label.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:160.0/255.0 blue:0 alpha:1];
            label.text = caimeiST;
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = [UIColor whiteColor];
            [cell.contentView addSubview:label];
            
        }
        
        
        
        
        NSString *miString = [NSString stringWithFormat:@"%ld",(long)indexPath.row + 1];
        cell.mingciLabel.text = miString;
        NSString *kM = [NSString stringWithFormat:@"%@km",model.km];
        int KMX = [kM intValue];
        if (KMX == 0 || KMX > 1000) {
            
        }else {
            UILabel *juLiLabel = [[UILabel alloc]init];
            //    NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:16]};
            //    CGSize size=[self.name sizeWithAttributes:attrs];
            juLiLabel.frame = CGRectMake(133, 43, 46, 12);
            juLiLabel.font = [UIFont systemFontOfSize:12];
            juLiLabel.backgroundColor = [UIColor  colorWithRed:227.0/255.0 green:186.0/255.0 blue:139.0/255.0 alpha:1];
            juLiLabel.textColor = [UIColor whiteColor];
            juLiLabel.text = kM;
            juLiLabel.layer.cornerRadius = 3;
            juLiLabel.layer.masksToBounds = YES;
            juLiLabel.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:juLiLabel];
        }
        
        
        
        
        return cell;

        
    }
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else {
        return 10;
        
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatMlistModel *model = _dataArray[indexPath.row];
    MainXiuViewController *MainView = [[MainXiuViewController alloc]init];
    MainView.name = model.user_nicename;
    MainView.UID = model.ID;
    UINavigationController *tgirNVC = [[UINavigationController alloc]initWithRootViewController:MainView];
    
    [self showViewController:tgirNVC sender:nil];
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
#pragma mark - 数据请求
- (void)addData{
//    if (_HLI == 0) {
        [self.view addSubview:self.MBhud];
        [self.MBhud show:YES];
//    }
    NSString *tyzz = @"";
    if ([self.tyString isEqualToString:@"周榜"]) {
        if ([self.zhoutype isEqualToString:@"1"]) {
            tyzz = @"3";
        }else {
            tyzz = @"4";

        }
    }else {
        if ([self.zhoutype isEqualToString:@"1"]) {
            tyzz = @"1";
        }else {
            tyzz = @"2";
            
        }
    }
    

    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_Charmlist2];
    NSString *string = [NSString stringWithFormat:@"%ld",(long)page];
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *uidS = [defatults objectForKey:uidSG];
    NSString *lat = [NSString stringWithFormat:@"%@",[defatults objectForKey:lationString]];
    NSString *lng = [NSString stringWithFormat:@"%@",[defatults objectForKey:longtionString]];
    
    NSDictionary *dic= @{@"p":string,@"type":tyzz,@"uid":uidS,@"lat":lat,@"lng":lng};
    [HttpUtils postRequestWithURL:API_Charmlist2 withParameters:dic withResult:^(id result) {
        if (page == 1) {
            [self.dataArray removeAllObjects];
        }
        NSArray *array = result[@"data"];
        for (NSDictionary *dic in array) {
            ChatMlistModel *model = [[ChatMlistModel alloc]initWithDictionary:dic error:nil];
            [self.dataArray addObject:model];
        }
//        if (_HLI == 0) {
            [self.MBhud hide:YES];
//            _HLI = _HLI + 1;
//        }
        
        [self.tabelView reloadData];

        [self.tabelView.mj_header endRefreshing];
        [self.tabelView.mj_footer endRefreshing];
        
        
    } withError:^(NSString *msg, NSError *error) {
        [self mbhudtui:msg numbertime:1];

        [self.tabelView.mj_header endRefreshing];
        [self.tabelView.mj_footer endRefreshing];
        
    }];
//
    
    
}


//具体委托方法实例

-(void)segmentAction:(UISegmentedControl *)Seg{
    
    NSInteger Index = Seg.selectedSegmentIndex;
    
    
    switch (Index) {
            
        case 0:
             self.zhoutype = @"1";
            page = 1;
          
            [self addData];
            break;
            
        case 1:
        
            self.zhoutype = @"2";
            page = 1;
        
            [self addData];
            break;
            
        default:
            
            break;
            
    }
    
}

//返回
- (void)handleNavigationBarLeftitemAction:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
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

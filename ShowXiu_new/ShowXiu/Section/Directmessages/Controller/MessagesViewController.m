//
//  MessagesViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/4/27.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "MessagesViewController.h"
#import "MessagesModel.h"
#import "SiXinTableViewCell.h"
#import "ChatViewController.h"
#import "FocusViewController.h"
#import "AcceptViewController.h"
#import "SystemViewController.h"
#import "SmallChatViewController.h"
@interface MessagesViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tabeleView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UIView *viewLi;
@property(nonatomic,strong)MBProgressHUD * MBhud;//网络等待
@property (nonatomic, assign)int HLI;

@end

@implementation MessagesViewController
- (MBProgressHUD *)MBhud{
    if (!_MBhud) {
        _MBhud = [[MBProgressHUD alloc]init];
        _MBhud.yOffset =  _MBhud.yOffset;

    }
    return _MBhud;
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

    
    
    self.view.backgroundColor = ViewRGB;
    self.navigationItem.title = @"私信";

    [self addUITableView];
    [self loadData];
    self.HLI = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationActionLi:) name:@"shuxinTableVIew" object:nil];
    
}
// 2.实现收到通知触发的方法

- (void)InfoNotificationActionLi:(NSNotification *)notification{
    [self loadData];
    
}
- (void)addUITableView{
    self.tabeleView = [[UITableView alloc]init];
    _tabeleView.backgroundColor = [UIColor whiteColor];
    _tabeleView.frame = CGRectMake(0, 2, kScreen_w , kScreen_h);
    _tabeleView.delegate = self;
    _tabeleView.dataSource = self;
    [self.tabeleView registerNib:[UINib nibWithNibName:@"SiXinTableViewCell" bundle:nil] forCellReuseIdentifier:@"SiXinTableViewCell"];
    _tabeleView.tableFooterView = [[UIView alloc]init];
    __weak typeof(self) ws = self;

    _tabeleView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [ws loadData];
    }];
    [self.view addSubview:_tabeleView];
    
    UILabel *Label = [[UILabel alloc]init];
    Label.backgroundColor = ViewRGB;
    Label.frame = CGRectMake(0, 64, kScreen_w, 10);
    [self.view addSubview:Label];
    
}

#pragma mark --- 数据
- (void)loadData{
    if (_HLI == 0) {
        [self.view addSubview:self.MBhud];
        [self.MBhud show:YES];
    }
    
    
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
//    NSString *sex = [defatults objectForKey:sexXB];
//    NSString *la = [defatults objectForKey:lationString];
//    NSString *lo = [defatults objectForKey:longtionString];
    
//    NSString *stringURL = [NSString stringWithFormat:@"%@%@",AppURL,sxlistURL];
    NSDictionary *dic = @{@"uid":uidS};
    [HttpUtils postRequestWithURL:API_msglist2 withParameters:dic withResult:^(id result) {
        [self.dataArray removeAllObjects];
        NSArray *array = result[@"data"];
        for (NSDictionary *dic in array) {
            MessagesModel *model = [[MessagesModel alloc]initWithDictionary:dic error:nil];
            [self.dataArray addObject:model];
        }
        if (_HLI == 0) {
            [self.MBhud hide:YES];
            _HLI = _HLI + 1;
        }
        
        [self.tabeleView reloadData];
        [self.viewLi removeFromSuperview];
        if (array.count == 0 ) {
            self.viewLi = [[UIView alloc]init];
            _viewLi.frame = CGRectMake(0, 0, kScreen_w, kScreen_h);
            _viewLi.backgroundColor = [UIColor whiteColor];
            //创建手势对象
            UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self    action:@selector(tapActionXIuXIu)];
            //讲手势添加到指定的视图上
            [_viewLi addGestureRecognizer:tap];
            
            UILabel *Label = [[UILabel alloc]init];
            Label.frame = CGRectMake(0, kScreen_h / 2 - 80, kScreen_w, 30);
            Label.text = @"暂无数据";
            Label.textAlignment = NSTextAlignmentCenter;
            Label.textColor = [UIColor blackColor];
            [_viewLi addSubview:Label];
            
            [self.view addSubview:_viewLi];
        }
        [_tabeleView.mj_header endRefreshing];
        int a = 0;
        for (MessagesModel *mdoel in self.dataArray) {
            int b = [mdoel.unread intValue];
            a = a + b;
        }
        if (a == 0) {
            [self.tabBarItem setBadgeValue:nil];

            NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
            
            [defatults setObject:[NSString stringWithFormat:@"%d",a] forKey:user_icon];
            [defatults synchronize];
//            [UIApplication sharedApplication].applicationIconBadgeNumber  =  a;

        }else {
            [self.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d",a]];
            NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
            
            [defatults setObject:[NSString stringWithFormat:@"%d",a] forKey:user_icon];
            [defatults synchronize];
//            [UIApplication sharedApplication].applicationIconBadgeNumber  =  a;
        }
        
 

    } withError:^(NSString *msg, NSError *error) {
        [_tabeleView.mj_header endRefreshing];

    }];
}
- (void)tapActionXIuXIu{
    [self loadData];
}

#pragma mark -----UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessagesModel *model = self.dataArray[indexPath.row];
    NSString *notice_type = [NSString stringWithFormat:@"%@",model.notice_type];
    int TY = [notice_type intValue];
    SiXinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SiXinTableViewCell" forIndexPath:indexPath];
    if (TY == 1) {
        //关注
        cell.touimagevIew.image = [UIImage imageNamed:@"icon-heart"];
        NSString *sting = [NSString stringWithFormat:@"%@",model.content];
        cell.titleLabel.text = sting;
    }else if (TY == 2){
        //收礼
        cell.touimagevIew.image = [UIImage imageNamed:@"icon-gift-1"];
        NSString *sting = [NSString stringWithFormat:@"%@",model.content];
        cell.titleLabel.text = sting;
        
    }else if (TY == 3){
        //系统
        cell.touimagevIew.image = [UIImage imageNamed:@"icon-ring"];
        cell.nameLabel.text = @"系统消息";
        NSString *sting = [NSString stringWithFormat:@"%@",model.content];
        cell.titleLabel.text = sting;
    }else if (TY == 4){
        //生活小蜜
        cell.touimagevIew.image = [UIImage imageNamed:@"head-custom-service"];
        cell.nameLabel.text = @"小秘书";
        NSString *sting = [NSString stringWithFormat:@"%@",model.content];
        cell.titleLabel.text = sting;

    }else {
        [cell.touimagevIew sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:zhantuImage]];
        NSString *msg_type = [NSString stringWithFormat:@"%@",model.msg_type];
        cell.nameLabel.text = model.user_nicename;

        int MSg = [msg_type intValue];
        if (MSg == 0 || MSg == 2 || MSg == 10) {
            NSString *sting = [NSString stringWithFormat:@"%@",model.content];
            cell.titleLabel.text = sting;
        }else if (MSg == 20){
            cell.titleLabel.text = @"图片";
        }else if (MSg == 1 || MSg == 30){
            cell.titleLabel.text = @"语音";
        }
        
        
        
    }
    
    
    if ([model.user_rank isEqualToString:@"0"]) {
        cell.VIBButton.hidden = 1;
    }else {
        cell.VIBButton.hidden = 0;
    }
   
    NSString *dianstring = [NSString stringWithFormat:@"%@",model.unread];
    if ([dianstring isEqualToString:@"0"]){
        cell.bianButton.hidden = YES;
    }else {
        cell.bianButton.hidden = NO;
        [cell.bianButton setTitle:dianstring forState:UIControlStateNormal];
        
    }
    
    NSString *tiST =[HelperClass timeStampIsConvertedToTime:model.uptime formatter:@"yyyyy-MM-dd HH:mm:ss.SSS"];
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSDate *timeDate = [dateFormatter dateFromString:tiST];

    
    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    //标准时间和北京时间差8个小时
    timeInterval = timeInterval ;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    cell.timeLabel.text = result;
    
    return cell;

    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 74;
}

//- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    // 添加一个删除按钮
//    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//        
//        NSLog(@"点击了删除");
//    }];
//    
////    // 添加一个更多按钮
////    UITableViewRowAction *moreRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"更多" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
////        
////        NSLog(@"点击了更多");
////        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
////    }];
////    
////    moreRowAction.backgroundColor = [UIColor orangeColor];
//    
//    return @[deleteRowAction];
//}


//cell点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *uidS = [defatults objectForKey:uidSG];
    MessagesModel *model = self.dataArray[indexPath.row];
    
    NSString *notice_type = [NSString stringWithFormat:@"%@",model.notice_type];
    int TY = [notice_type intValue];
    if (TY == 1) {
        //关注
        FocusViewController *FocusView  = [[FocusViewController alloc]init];
        [self.navigationController pushViewController:FocusView animated:NO];
        
    }else if (TY == 2){
        //收礼
        AcceptViewController *AcceptView = [[AcceptViewController alloc]init];
        [self.navigationController pushViewController:AcceptView animated:NO];
        
    }else if (TY == 3){
        //系统
        SystemViewController *SystemView  = [[SystemViewController alloc]init];
        [self.navigationController pushViewController:SystemView animated:NO];
        
    }else if (TY == 4) {
        SmallChatViewController *SmallChatView = [[SmallChatViewController  alloc]init];
        SmallChatView.name = @"小秘书";
        
        UINavigationController *SmallChatViewNVC = [[UINavigationController alloc]initWithRootViewController:SmallChatView];
        
        [self showViewController:SmallChatViewNVC sender:nil];
    }else {
        ChatViewController *ChatView = [[ChatViewController alloc]init];
//            if ([model.fromuid isEqualToString:uidS]) {
//                ChatView.TOID = model.touid;
//            }else {
//                ChatView.TOID = model.fromuid;
//        
//            }
        ChatView.TOID = model.uid;
        ChatView.name = model.user_nicename;
        UINavigationController *ChatViewNVC = [[UINavigationController alloc]initWithRootViewController:ChatView];
        
        [self showViewController:ChatViewNVC sender:nil];
        
    }
    
    


    
 
//    [self.navigationController pushViewController:ChatView animated:nil];
}
- (void)viewWillAppear:(BOOL)animated{
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

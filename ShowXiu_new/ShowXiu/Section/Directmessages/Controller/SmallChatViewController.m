//
//  ChatViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/5/3.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "SmallChatViewController.h"
#import "MessageSSModel.h"
#import "MessTxtContentTableViewCell.h"
#import "MessImageTableViewCell.h"
#import "MessVoideTableViewCell.h"
#import "MainXiuViewController.h"
#import "XiaoMessModel.h"
#import <YYLabel.h>
#import "NSAttributedString+YYText.h"
#import "UIImage+Extension.h"
#import "DataViewController.h"
#import "BangViewController.h"
@interface SmallChatViewController ()<UITableViewDelegate,UITableViewDataSource>
//顶部视图
@property (nonatomic, strong)UIButton *guanButton;
@property (nonatomic, strong)UIButton *yueButton;
@property (nonatomic, strong)UITableView *tabelView;
@property (nonatomic, strong)NSMutableArray *chudataArray;


@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UIView *BView;



//底部View
@property (nonatomic, strong)UIView *lasView;
@property(nonatomic,assign)int messHeight;//键盘高度
@property(nonatomic, strong)UIButton *yuYin;
@property(nonatomic,assign)BOOL isYuYin;//语音
@property (nonatomic,assign) BOOL switchingKeybaord;//键盘切换判断
@property(nonatomic,strong)UIView * yuView;//语音uiview
@property (strong, nonatomic) AVAudioPlayer *avPlay;//播放录制语音
@property(nonatomic,strong)UIImageView * yuYinImageView;//语音提示图片
@property(nonatomic, strong)UITextField *yuyinTextField; //语音输入框
@property(nonatomic,strong) UILabel *labelemotion;//textview文字
@property(nonatomic, strong)UIButton *liwuButton;//礼物
@property(nonatomic, strong)UIButton *fasongButton;//发送按钮
@property(nonatomic, copy)NSString *msgid;//消息ID




@property(nonatomic, strong)UIView *CView;
@property(nonatomic, copy)NSString *tyString;
@property(nonatomic, copy)NSString *tyTableView;
@property (nonatomic, strong)NSDictionary *uinfoDic;
@property(nonatomic, strong)UITableView * zhitabelView;
@property(nonatomic, strong)UIButton *WEILButton;
@property(nonatomic, strong)UIButton *zhiButton;
@property (nonatomic, strong)NSString *qianstring;
@property (nonatomic, strong)NSDictionary *weiDic;
@property(nonatomic, strong)NSString *accountId;
@property (nonatomic, strong)NSMutableArray *dataArrayTwo;

@property (nonatomic, strong)NSString *accountTypeST;
//金币TabelView
@property (nonatomic, strong)UITableView *jinTabelView;
//加号
@property (nonatomic, strong)UIView * jiahaoView;

@property (nonatomic, copy)NSString *str1;
@property (nonatomic, copy)NSString *str2;
@property (nonatomic, copy)NSString *str3;
@property (nonatomic, copy)NSString *str4;
@property (nonatomic, copy)NSString *congSt;
@property (nonatomic, strong)UIImageView *wenziImageView;
@property (nonatomic, strong)YYLabel *wenLabel;
@property(nonatomic,strong)MBProgressHUD * MBhud;//网络等待

@end

@implementation SmallChatViewController
- (UIView *)jiahaoView{
    if (_jiahaoView) {
        _jiahaoView = [[UIView alloc]init];
        _jiahaoView.frame = CGRectMake(0, kScreen_h - 200, kScreen_w, 120);
        
        UIButton *tuButton = [UIButton new];
        tuButton.frame = CGRectMake(30, 30, 60, 60);
        [tuButton setBackgroundImage:[UIImage imageNamed:@"加载占位图"] forState:UIControlStateNormal];
        [tuButton addTarget:self action:@selector(addtuButton:) forControlEvents:UIControlEventTouchUpInside];
        [_jiahaoView addSubview:tuButton];
        
    }
    return _jiahaoView;
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
- (NSMutableArray *)dataArrayTwo{
    if (!_dataArrayTwo) {
        _dataArrayTwo = [[NSMutableArray alloc]init];
    }
    return _dataArrayTwo;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ViewRGB;
    self.msgid = @"0";
    //数据请求
    [self wechat_msgData];
    [self mishuView];
    
    
    
    [self configureNavigationView];
//    [self addUITableView];
//    [self addUIView];
//    //添加  监听键盘状态
//    [self addCent];
    
    
}
- (void)mishuView{
    UIImageView *tuiamgeView = [[UIImageView alloc]init];
    tuiamgeView.frame = CGRectMake(20, 76, 50, 50);
    tuiamgeView.image = [UIImage imageNamed:@"head-custom-service"];
    [self.view addSubview:tuiamgeView];
    
    self.wenziImageView = [[UIImageView alloc]init];
    _wenziImageView.image = [UIImage resizableImageWithName:@"dialog_box_white11"];
    _wenziImageView.userInteractionEnabled = YES;
//    _wenziImageView.image = [UIImage imageNamed:@"dialog_box_white"];

    [self.view addSubview:_wenziImageView];
    self.wenLabel = [[YYLabel alloc]init];
    _wenLabel.userInteractionEnabled = YES;
    [self.wenziImageView addSubview:_wenLabel];

}


#pragma mark - 初始化视图
- (void)configureNavigationView {
    self.navigationItem.title = self.name;
    UIImage *leimage = [UIImage imageNamed:@"形状16"];
    UIImage *Leimage = [leimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:Leimage style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarLeftitemAction:)];
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:leftItem, nil];
 
}
- (void)addUITableView{
    self.tabelView = [[UITableView alloc]init];
    _tabelView.dataSource = self;
    _tabelView.delegate = self;
    _tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tabelView.allowsSelection = NO;
    _tabelView.showsVerticalScrollIndicator = NO;
    _tabelView.frame = CGRectMake(0, 100, kScreen_w, kScreen_h - 150);
    __weak typeof(self) ws = self;
    _tabelView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [ws refreshData];
    }];
    _tabelView.backgroundColor = ViewRGB;
    [self.view addSubview:_tabelView];
}
#pragma mark - 下拉刷新 上拉加载
- (void)refreshData {
    if (self.dataArrayTwo.count) {
        MessageSSModel *model = self.dataArrayTwo[0];
        self.msgid = model.msgid;
        
        
    }else {
        
    }
    
    [self wechat_msgData];
}

//添加评论框
- (void)addUIView{
    _lasView = [[UIView alloc] init];
    _lasView.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
    [self.view addSubview:_lasView];
    _lasView.frame = CGRectMake(0, kScreen_h-50, kScreen_w, 50);
    //    _lasView.backgroundColor = [UIColor redColor];
    
    //    //添加约束
    //    [_lasView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.mas_equalTo(UIEdgeInsetsMake(kScreen_w-50, 0, 0, 0));
    //    }];
    
    //    [self addYuYin];//添加label
    [self addTextField];//添加textFile
    //    [self addYuYin];//语音
    [self fasongUIButton];//发送
    [self jiahaoUIbutton];//加好；
    //    [self addBiaoQing];//添加button
    //    [self addJiaHao];//添加发送
    //    [self addYuinBtn];//语音UIView按钮
    //    [self addBtnMessView];//添加底部功能按钮
    
}
//输入框
- (void)addTextField{
    _yuyinTextField = [[UITextField alloc]init];
    _yuyinTextField.frame = CGRectMake(50, 10, kScreen_w - 110, 30);
    _yuyinTextField.placeholder = @" 文明畅聊！";
    _yuyinTextField.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1];
    _yuyinTextField.layer.cornerRadius = 15;
    _yuyinTextField.layer.masksToBounds = YES;
    UIImageView *imageViewPwdq=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 18, 40)];
    
    _yuyinTextField.leftView = imageViewPwdq;
    _yuyinTextField.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
    
    [_lasView addSubview:_yuyinTextField];
}


//发送
- (void)fasongUIButton{
    _fasongButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreen_w - 50, 10, 40, 30)];
    [_fasongButton setTitle:@"发送" forState:UIControlStateNormal];
    [_fasongButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _fasongButton.layer.cornerRadius = 15;
    _fasongButton.layer.masksToBounds = YES;
    _fasongButton.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:62.0/255.0 blue:94.0/255.0 alpha:1];
    _fasongButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_fasongButton addTarget:self action:@selector(addfasongButton:) forControlEvents:UIControlEventTouchUpInside];
    [_lasView addSubview:_fasongButton];
    
}
//加好
- (void)jiahaoUIbutton{
    UIButton *jiahaoButton = [UIButton new];
    jiahaoButton.frame = CGRectMake(12, 10, 30, 30);
    [jiahaoButton setBackgroundImage:[UIImage imageNamed:@"icon-gift-1"] forState:UIControlStateNormal];
    [jiahaoButton addTarget:self action:@selector(addjiahaoButton:) forControlEvents:UIControlEventTouchUpInside];
    [_lasView addSubview:jiahaoButton];
    
    
}
- (void)addjiahaoButton:(UIButton *)sender{
    //    [_lasView mas_updateConstraints:^(MASConstraintMaker *make) {
    //        make.edges.mas_equalTo(UIEdgeInsetsMake(kScreen_h-180, 0, _messHeight, 0));
    //    }];
    self.jiahaoView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.jiahaoView
     ];
    
    [self.view layoutIfNeeded];
}


#pragma mark -- 监听
//监听键盘状态
- (void)addCent{
    //    // 表情选中的通知
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelect:) name:HWEmotionDidSelectNotification object:nil];
    //    // 删除文字的通知
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidDelete) name:HWEmotionDidDeleteNotification object:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidInput) name:@"JHEmotionDidInputNotification" object:nil];
    //弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //收起
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - 数据请求
//发送消息接口
- (void)sendmsgData{
    if ([self.yuyinTextField.text isEqualToString:@""] || self.yuyinTextField.text == nil) {
        [SVProgressHUD showErrorWithStatus:@"聊天内容不能为空"];
        [SVProgressHUD dismissWithDelay:1];
    }else {
        NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
        NSString *uidS = [defatults objectForKey:uidSG];
        
        NSString *stringURL = [NSString stringWithFormat:@"%@%@",AppURL,sendmsgURL];
        NSDictionary *dic = @{@"fromuid":uidS,@"touid":self.TOID,@"content":self.yuyinTextField.text,@"msg_type":@"0",@"voice_time":@""};
        
        AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
        manage.requestSerializer = [AFHTTPRequestSerializer serializer];
        manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
        
        
        [manage POST:stringURL parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
            
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            _yuyinTextField.text = @"";
            NSDictionary *daDic = responseObject;
            NSString *codeSt = [NSString stringWithFormat:@"%@",daDic[@"code"]];
            [self.dataArrayTwo removeAllObjects];
            [self wechat_msgData];
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
    }
    
    
}



//私信窗口消息接口
- (void)wechat_msgData{
    [self.view addSubview:self.MBhud];
    [self.MBhud show:YES];
    
    NSString *stringURL = [NSString stringWithFormat:@"%@%@",AppURL,wechat_msgURL];
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *uidS = [defatults objectForKey:uidSG];
    
    [HttpUtils postRequestWithURL:API_miss_list2 withParameters:@{@"uid":uidS,@"msgid":self.msgid} withResult:^(id result) {
        self.str1 = [NSString stringWithFormat:@"%@",result[@"data"][0][@"content_arr"][@"start"]];
        self.str2 = [NSString stringWithFormat:@"%@",result[@"data"][0][@"content_arr"][@"middle"][0][@"content"]];
        self.str3 = [NSString stringWithFormat:@"%@",result[@"data"][0][@"content_arr"][@"middle"][1][@"content"]];
        self.str4 = [NSString stringWithFormat:@"%@",result[@"data"][0][@"content_arr"][@"middle"][2][@"content"]];
        NSString *endST = [NSString stringWithFormat:@"%@",result[@"data"][0][@"content_arr"][@"end"]];
        self.congSt = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@",_str1,_str2,_str3,_str4,endST];
        CGFloat content_h = [HelperClass calculationHeightWithTextsize:16.0 LabelWidth:kScreen_w - 150 WithText:_congSt LineSpacing:0];
        self.wenziImageView.frame = CGRectMake(90, 80, kScreen_w - 110, content_h + 30);
        self.wenLabel.frame = CGRectMake(20, 15, kScreen_w - 150, content_h);
        self.wenLabel.numberOfLines = 0;
        _wenLabel.alpha = 0.6;
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:_congSt];
        text.font = [UIFont boldSystemFontOfSize:16.0f];
        text.color = [UIColor blackColor];
        NSInteger le1 = [_str1 length];
        NSInteger le2 = [_str2 length];
        NSInteger le3 = [_str3 length];
        NSInteger le4 = [_str4 length];
        
        [text setColor:[UIColor redColor] range:NSMakeRange(le1 + 1, le2 )];
        [text setTextHighlightRange:NSMakeRange(le1 + 1, le2) color:hong backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            DataViewController *dataView = [[DataViewController alloc]init];
            self.navigationController.navigationBarHidden = NO;
            
            [self.navigationController pushViewController:dataView animated:nil];
        }];
        [text setColor:[UIColor redColor] range:NSMakeRange(le1 + le2 + 2, le3 )];
        [text setTextHighlightRange:NSMakeRange(le1 + le2 + 2, le3 ) color:hong backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            DataViewController *dataView = [[DataViewController alloc]init];
            self.navigationController.navigationBarHidden = NO;
            
            [self.navigationController pushViewController:dataView animated:nil];
        }];
        [text setColor:[UIColor redColor] range:NSMakeRange(le1 + le2 + le3 + 3, le4 )];
        [text setTextHighlightRange:NSMakeRange(le1 + le2 + le3 + 3, le4 ) color:hong backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            BangViewController *BangView = [[BangViewController alloc]init];
            [self.navigationController pushViewController:BangView animated:nil];
        }];
        
        
        _wenLabel.attributedText = text;




        [self.MBhud hide:YES];

        
        
        [self.tabelView reloadData];
        [self.tabelView.mj_header endRefreshing];
        
    } withError:^(NSString *msg, NSError *error) {
        [self.tabelView.mj_header endRefreshing];
        [self mbhudtui:msg numbertime:1];

        
    }];
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
        return self.dataArrayTwo.count;
        
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [MessTxtContentTableViewCell heightOfTxtCellWithMessage:@"" nstime:@""];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        MessageSSModel *model = self.dataArrayTwo[indexPath.row];
        NSString *msg_type = model.msg_type;
        int a = [msg_type intValue];
        //图片
        if (a == 20) {
            MessImageTableViewCell *cell = [MessImageTableViewCell cellWithImageTableView:tableView];
            cell.messFriendModel = self.dataArrayTwo[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.headBtn addTarget:self action:@selector(addHeadportraita:) forControlEvents:UIControlEventTouchUpInside];
            //        [cell.deleBbbtn addTarget:self action:@selector(shanchule:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
            
            //语音
        }if (a == 1 || a== 30 ){
            MessVoideTableViewCell *cell = [MessVoideTableViewCell cellWithVoideTableView:tableView];
            cell.messFriendModel = self.dataArrayTwo[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.headBtn addTarget:self action:@selector(addHeadportraita:) forControlEvents:UIControlEventTouchUpInside];
            //        [cell.deleBbbtn addTarget:self action:@selector(shanchule:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
            
            //文字
        }else {
            
            MessTxtContentTableViewCell *cell = [MessTxtContentTableViewCell cellWithTxtTableView:tableView];
            cell.messFriendModel = self.dataArrayTwo[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.headBtn addTarget:self action:@selector(addHeadportraita:) forControlEvents:UIControlEventTouchUpInside];
            //        [cell.headBtn addTarget:self action:@selector(headKongjian:) forControlEvents:UIControlEventTouchUpInside];
            //
            //        return cell;
            return cell;
        }
}

            
     
- (void)addHeadportraita:(UIButton *)sender{
    UITableViewCell * cell = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath * path = [self.tabelView indexPathForCell:cell];//获取cell对应的section
    MessageSSModel *model = self.dataArrayTwo[path.row];
    MainXiuViewController *MainView = [[MainXiuViewController alloc]init];
    MainView.name = self.name;
    MainView.UID = model.fromuid;
    UINavigationController *tgirNVC = [[UINavigationController alloc]initWithRootViewController:MainView];
    
    [self showViewController:tgirNVC sender:nil];
}




//健谈将要弹出调用的方法
- (void)keyboardWillShow:(NSNotification *)aNotification{
    NSDictionary * userInFo = [aNotification userInfo];
    NSValue * aValue = [userInFo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyBoardRect = [aValue CGRectValue];
    _messHeight = keyBoardRect.size.height;
    //添加动画改变
    [UIView animateWithDuration:0.1 animations:^{
        [_lasView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(kScreen_h-_messHeight-50, 0, _messHeight, 0));
        }];
        [_tabelView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(100, 0, _messHeight+50, 0));
        }];
        //告诉self.view约束改变重新计算，否则无动画
        [self.view layoutIfNeeded];
    }];
}
//键盘将要收起时调用
- (void)keyboardWillHide:(NSNotification *)aNotification{
    
    //添加动画改变
    [UIView animateWithDuration:0.1 animations:^{
        //mas_updateConstraints 更改约束的值
        _lasView.backgroundColor = [UIColor yellowColor];
        [_lasView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(kScreen_h-50, 0, 0, 0));
        }];
        [_tabelView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(100, 0, 50, 0));
        }];
        
        //告诉self.view约束改变重新计算，否则无动画
        [self.view layoutIfNeeded];
    }];}
#pragma mark - 消息的发送
- (void)addfasongButton:(UIButton *)sender{
    [self.view endEditing:YES];
    [self sendmsgData];
}
//table滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
    
}

#pragma mark - 用户交互
- (void)handleNavigationBarLeftitemAction:(UIBarButtonItem *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shuxinTableVIew" object:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 键盘隐藏
//点击tableview手势
- (void)addTap{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    tap.numberOfTapsRequired = 1;
    tap.cancelsTouchesInView = NO;
    [_tabelView addGestureRecognizer:tap];
}

//手势调用
- (void)tap{
    [self.view endEditing:YES];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}





//加好里面图片
- (void)addtuButton:(UIButton *)sender{
    
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

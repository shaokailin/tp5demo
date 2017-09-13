//
//  MyViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/2/28.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "MyViewController.h"
#import "MyTableViewCell.h"
#import "MyOneTableViewCell.h"
#import "MyFootView.h"
#import "SetViewController.h"
#import "MyImageViewController.h"
#import "MySiViewController.h"
#import "MyShiViewController.h"
#import "MyDuViewController.h"
#import "MyContactViewController.h"
#import "MyFenViewController.h"
#import "MyGuanViewController.h"
#import "MyChongViewController.h"
#import "MyManyViewController.h"
#import "MyYaoViewController.h"
#import "MyXinViewController.h"
#import "DataViewController.h"
#import "RankingViewController.h"
#import "WithdrawalViewController.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "UIImage+cutImage.h"
#import "FeedbackViewController.h"
#import "RealityViewController.h"
#import "PingPayViewController.h"

@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIView *Herview;
@property (nonatomic, strong)MyFootView *myfootView;
@property (nonatomic, strong)NSArray *dataArray;

@property (nonatomic, strong)NSMutableArray *shuOneArray;
@property (nonatomic, strong)NSMutableArray *shuthreeArray;
@property (nonatomic, strong)NSMutableArray *shuArray;
/** 分页页码 **/
@property (nonatomic, assign) NSInteger page;

//余额
@property (nonatomic, strong) NSDictionary *shuDic;
//分享得数据
@property (nonatomic, strong) NSDictionary *fenDic;

@property(nonatomic,copy)NSString * image_type;
@property(nonatomic,copy)NSString * imageFileName;
//选着的图片
@property(nonatomic, strong)UIImageView *tuiamgView;
@property(nonatomic, strong)UILabel *WNEZILabel;
@property(nonatomic, strong)UIButton *xiangimageVIew;
@property(nonatomic, strong)UIImageView *VIBImageVIew;
@property (nonatomic, assign)int HLI;
@property(nonatomic,strong)MBProgressHUD * MBhud;//网络等待
@property (nonatomic, strong) UIVisualEffectView *effectView;
@property (nonatomic, copy)NSString *touxiangST;

@end

@implementation MyViewController
- (UIImageView *)tuiamgView{
    if (!_tuiamgView) {
        _tuiamgView = [[UIImageView alloc]init];
    }
    return _tuiamgView;
}
- (UIView *)Herview{
    if (!_Herview) {
        NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"MyFootView" owner:nil options:nil];
        
        // Find the view among nib contents (not too hard assuming there is only one view in it).
        _Herview = [nibContents lastObject];
    
        _Herview.frame = CGRectMake(0, 0, kScreen_w, 220);
        
    }
    return _Herview;
}
- (MyFootView *)myfootView{
    if (!_myfootView) {
        NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"MyFootView" owner:nil options:nil];

        _myfootView = [nibContents lastObject];
        _myfootView.frame = CGRectMake(0, 0, kScreen_w, 300);
        

    }
    return _myfootView;
}


- (NSArray *)dataArray{
    if (!_dataArray) {
        NSArray *oneArray = [[NSArray alloc]initWithObjects:@"我的照片",@"我的私房照",@"我的小视频",nil];
        NSArray *twoArray = [[NSArray alloc]initWithObjects:@"内心独白",@"联系方式",@"我的粉丝",@"我的关注", nil];
        
        NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
        NSString *uidS = [defatults objectForKey:uidSG];
        
      
        if ([uidS isEqualToString:@"257555"]) {
            NSArray *fourArray = [[NSArray alloc]initWithObjects:@"我的钱包",@"新手教程",@"账号设置",@"意见反馈", nil];
            _dataArray = [[NSArray alloc]initWithObjects:oneArray,twoArray,fourArray,nil];
        }else {
            NSArray *fourArray = [[NSArray alloc]initWithObjects:@"充值中心",@"我的钱包",@"新手教程",@"账号设置",@"意见反馈", nil];
            _dataArray = [[NSArray alloc]initWithObjects:oneArray,twoArray,fourArray,nil];

            
        }
   
        
    }
    return _dataArray;
}
- (NSMutableArray *)shuOneArray{
    if (!_shuOneArray) {
        _shuOneArray = [[NSMutableArray alloc]init];

    }
    return _shuOneArray;
}
- (NSMutableArray *)shuthreeArray{
    if (!_shuthreeArray) {
        _shuthreeArray = [[NSMutableArray alloc]init];
//        _shuthreeArray = [[NSMutableArray alloc]initWithObjects:@"",@"",@"3899",@"12", nil];
    }
    return _shuthreeArray;
}
- (NSMutableArray *)shuArray{
    if (!_shuArray) {
        _shuArray = [[NSMutableArray alloc]init];
    
     
    }
    return _shuArray;
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
    [self addView];
    [self addtableView];
    [self refreshData];
    [self fengxiangData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addzhiliaoAction:) name:@"adddengluShuaxin11" object:nil];


}

-(void)addzhiliaoAction:(NSNotification *)obj{
//    [[NSNotificationCenter defaultCenter] removeObserver:@"adddengluShuaxin" name:nil object:self];
    
    [self requestListData];

    
    
}

- (void)addView{
    [self.view addSubview:self.myfootView];
    
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *sexXBSt = [defatults objectForKey:sexXB];
    int SE = [sexXBSt intValue];
    if (SE == 2) {
        NSString *uidS = [defatults objectForKey:uidSG];
        if ([uidS isEqualToString:@"257555"]) {
            _myfootView.VIPTextView.text = @" ";

        }else {
            _myfootView.VIPTextView.text = @"提  现";

        }

        
    }else {
        _myfootView.VIPTextView.text = @"充值秀币  ";
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithAttributedString:_myfootView.VIPTextView.attributedText];
        NSTextAttachment *textAttachment = [[NSTextAttachment alloc] initWithData:nil ofType:nil] ;
//        textAttachment.image = [UIImage imageNamed:@"圆角矩形1"]; //要添加的图片
        
        NSAttributedString *textAttachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment] ;
        [string insertAttributedString:textAttachmentString atIndex:_myfootView.VIPTextView.selectedRange.location];//index为用户指定要插入图片的位置
        _myfootView.VIPTextView.attributedText = string;
        _myfootView.VIPTextView.textColor = hong;
        _myfootView.VIPTextView.font = [UIFont systemFontOfSize:16];
        [_myfootView.VIPTextView setEditable:NO];
        _myfootView.VIPTextView.userInteractionEnabled = YES;
        
    }
    _myfootView.ZRTextView.text = @"真人认证  ";
    NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc] initWithAttributedString:_myfootView.ZRTextView.attributedText];
    NSTextAttachment *textAttachment1 = [[NSTextAttachment alloc] initWithData:nil ofType:nil] ;
    textAttachment1.image = [UIImage imageNamed:@"认证"]; //要添加的图片
    
    NSAttributedString *textAttachmentString1 = [NSAttributedString attributedStringWithAttachment:textAttachment1] ;
    [string1 insertAttributedString:textAttachmentString1 atIndex:_myfootView.ZRTextView.selectedRange.location];//index为用户指定要插入图片的位置
    _myfootView.ZRTextView.attributedText = string1;
    _myfootView.ZRTextView.textColor = hong;
    _myfootView.ZRTextView.font = [UIFont systemFontOfSize:16];
    [_myfootView.ZRTextView setEditable:NO];
    _myfootView.ZRTextView.userInteractionEnabled = YES;

    //修改头像
    [_myfootView.touimagView addTarget:self action:@selector(addtouimagView:) forControlEvents:UIControlEventTouchUpInside];
    //签到
    [_myfootView.riButton addTarget:self action:@selector(addriButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //修改资料
    [_myfootView.bianButton addTarget:self action:@selector(addBianButton:) forControlEvents:UIControlEventTouchUpInside];
    //皇冠
    [_myfootView.dengButton addTarget:self action:@selector(addDengButton:) forControlEvents:UIControlEventTouchUpInside];
    //分享
    [_myfootView.fenButton addTarget:self action:@selector(addFenButton:) forControlEvents:UIControlEventTouchUpInside];

}



- (void)addtableView{
    self.tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, 300, kScreen_w, kScreen_h - 300 - 50);
    _tableView.delegate = self;
    _tableView.dataSource = self;

    [self.tableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyTableViewCell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"MyOneTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyOneTableViewCell"];
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [self requestListData];

    }];
    [self.view addSubview:_tableView];


    
}
#pragma mark - 下拉刷新 上拉加载
- (void)refreshData {
    self.page = 1;
    [self.tableView.mj_footer endRefreshing];
    [self requestListData];
}

- (void)loadData {
    self.page ++ ;
    [self.tableView.mj_header endRefreshing];
    [self requestListData];
}


#pragma make ------ UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = self.dataArray[section];
    return arr.count;


    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTableViewCell" forIndexPath:indexPath];
        NSArray *arr = self.dataArray[indexPath.section];
        cell.nameLabel.text = arr[indexPath.row];
        if (self.shuArray.count == 3){
            NSArray *array = self.shuArray[indexPath.section];
            cell.neiLabel.text = array[indexPath.row];
        }else {
            
        }

        
        return cell;
        
   // }
    
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 10;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //我的照片
            MyImageViewController *myInageView = [[MyImageViewController alloc]init];
            UINavigationController *myImagNVC = [[UINavigationController alloc]initWithRootViewController:myInageView];
            [self presentViewController:myImagNVC animated:YES completion:nil];
            
        }else if (indexPath.row == 1){
            //我的私房照
            MySiViewController *mySiView = [[MySiViewController alloc]init];
            UINavigationController *mySiViewNVC = [[UINavigationController alloc]initWithRootViewController:mySiView];
            [self presentViewController:mySiViewNVC animated:YES completion:nil];

            
        }else {
            //我的小视频
            MyShiViewController *mySiView = [[MyShiViewController alloc]init];
            UINavigationController *mySiViewNVC = [[UINavigationController alloc]initWithRootViewController:mySiView];
            [self presentViewController:mySiViewNVC animated:YES completion:nil];
            
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0){
            //内心独白
            MyDuViewController * MyDuView = [[MyDuViewController alloc]init];
            UINavigationController *myDuViewNVC = [[UINavigationController alloc]initWithRootViewController:MyDuView];
            [self presentViewController:myDuViewNVC animated:YES completion:nil];
            
        }else if (indexPath.row == 1){
            //联系方式
            MyContactViewController *MyContact = [[MyContactViewController alloc]init];
            UINavigationController *MyContactNVC  = [[UINavigationController alloc]initWithRootViewController:MyContact];
            [self presentViewController:MyContactNVC animated:YES completion:nil];
            
        }else if (indexPath.row == 2){
            //我的粉丝
            MyFenViewController *myfen = [[MyFenViewController alloc]init];
            UINavigationController *myfenNVC = [[UINavigationController alloc]initWithRootViewController:myfen];
            [self presentViewController:myfenNVC animated:YES completion:nil];
        }else {
            //我的关注
            MyGuanViewController *myguan = [[MyGuanViewController alloc]init];
            UINavigationController *mygunaNVC = [[UINavigationController alloc]initWithRootViewController:myguan];
            [self presentViewController:mygunaNVC animated:YES completion:nil];
        }
        
        
    }else if (indexPath.section == 2){
        NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
        NSString *uidS = [defatults objectForKey:uidSG];
        if ([uidS isEqualToString:@"257555"]) {
            if (indexPath.row == 0){
                //我的钱包
                MyManyViewController *mymany = [[MyManyViewController alloc]init];
                UINavigationController *mymanyNVC = [[UINavigationController alloc]initWithRootViewController:mymany];
                [self presentViewController:mymanyNVC animated:YES completion:nil];
                
            }else if(indexPath.row == 1){
                //新手礼包
                MyXinViewController *myxin = [[MyXinViewController alloc]init];
                UINavigationController *myxinNVC = [[UINavigationController alloc]initWithRootViewController:myxin];
                [self presentViewController:myxinNVC animated:YES completion:nil];
            }else if(indexPath.row == 2){
                //账号设置
                SetViewController *setViewController = [[SetViewController alloc]init];
                UINavigationController *setNVC = [[UINavigationController alloc]initWithRootViewController:setViewController];
                [self presentViewController:setNVC animated:YES completion:nil];
                
            }else {
                FeedbackViewController *FeedbackView = [[FeedbackViewController alloc]init];
                UINavigationController *FeedbackViewNVC = [[UINavigationController alloc]initWithRootViewController:FeedbackView];
                [self presentViewController:FeedbackViewNVC animated:YES completion:nil];
            }
            

            
            
            
        }else {
            if (indexPath.row == 0){
                //充值中心
                MyChongViewController *mychong = [[MyChongViewController alloc]init];
                mychong.touxaingST = self.touxiangST;
                UINavigationController *mychongNVC =[[UINavigationController alloc]initWithRootViewController:mychong];
                [self presentViewController:mychongNVC animated:YES completion:nil];
                
                
            }else if (indexPath.row == 1){
                //我的钱包
                MyManyViewController *mymany = [[MyManyViewController alloc]init];
                UINavigationController *mymanyNVC = [[UINavigationController alloc]initWithRootViewController:mymany];
                [self presentViewController:mymanyNVC animated:YES completion:nil];
                
            }else if(indexPath.row == 2){
                //新手礼包
                MyXinViewController *myxin = [[MyXinViewController alloc]init];
                UINavigationController *myxinNVC = [[UINavigationController alloc]initWithRootViewController:myxin];
                [self presentViewController:myxinNVC animated:YES completion:nil];
            }else if(indexPath.row == 3){
                //账号设置
                SetViewController *setViewController = [[SetViewController alloc]init];
                UINavigationController *setNVC = [[UINavigationController alloc]initWithRootViewController:setViewController];
                [self presentViewController:setNVC animated:YES completion:nil];
                
            }else {
                FeedbackViewController *FeedbackView = [[FeedbackViewController alloc]init];
                UINavigationController *FeedbackViewNVC = [[UINavigationController alloc]initWithRootViewController:FeedbackView];
                [self presentViewController:FeedbackViewNVC animated:YES completion:nil];
            }
            

            
        }
        
        
        
    }

}
//签到
- (void)addriButton:(UIButton *)sender{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,signURL];
    NSDictionary *dic = @{@"uid":uidS};
    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
        [SVProgressHUD showSuccessWithStatus:result[@"msg"]];
        [SVProgressHUD dismissWithDelay:1.0];
        
        } withError:^(NSString *msg, NSError *error) {
        [SVProgressHUD showInfoWithStatus:msg];
        [SVProgressHUD dismissWithDelay:1.0];
    }];
    

}

//修改资料
- (void)addBianButton:(UIButton *)sender{
//    PingPayViewController *pingView = [[PingPayViewController alloc]init];
//    [self.navigationController pushViewController:pingView animated:YES];
    
    DataViewController *dataView = [[DataViewController alloc]init];
    self.navigationController.navigationBarHidden = NO;

    [self.navigationController pushViewController:dataView animated:nil];
    
}

//分享
- (void)addFenButton:(UIButton *)sender{
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    
    
    NSArray* imageArray = @[self.fenDic[@"icon"]];
    [shareParams SSDKSetupShareParamsByText:self.fenDic[@"desc"]
                                     images:imageArray
                                        url:[NSURL URLWithString:self.fenDic[@"url"]]
                                      title:self.fenDic[@"title"]
                                       type:SSDKContentTypeAuto];
    //优先使用平台客户端分享
    [shareParams SSDKEnableUseClientShare];
    //设置微博使用高级接口
    //2017年6月30日后需申请高级权限
//    [shareParams SSDKEnableAdvancedInterfaceShare];
    //设置显示平台 只能分享视频的YouTube MeiPai 不显示
    NSArray *items = @[
                       @(SSDKPlatformTypeQQ),
                       @(SSDKPlatformTypeWechat),
                       @(SSDKPlatformTypeSinaWeibo)
                       ];
    
    [ShareSDK showShareActionSheet:self.view
                             items:items
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state) {
                           
                       case SSDKResponseStateBegin:
                       {
                           //设置UI等操作
                           break;
                       }
                       case SSDKResponseStateSuccess:
                       {
                           //Instagram、Line等平台捕获不到分享成功或失败的状态，最合适的方式就是对这些平台区别对待
                           if (platformType == SSDKPlatformTypeInstagram)
                           {
                               break;
                           }
                           
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                           message:[NSString stringWithFormat:@"%@",error]
                                                                          delegate:nil
                                                                 cancelButtonTitle:@"OK"
                                                                 otherButtonTitles:nil, nil];
                           [alert show];
                           break;
                       }
                       case SSDKResponseStateCancel:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       default:
                           break;
                   }
               }];
}






//真人认证
- (void)addtiButton:(UIButton *)sender{
    
    RealityViewController *RankingView = [[RealityViewController alloc]init];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:RankingView animated:nil];
    

}
//余额
- (void)addyuButton:(UIButton *)sender{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *sexXBSt = [defatults objectForKey:sexXB];
    NSString *uidS = [defatults objectForKey:uidSG];

    int SE = [sexXBSt intValue];
    if (SE == 2) {
        if ([uidS isEqualToString:@"257555"]) {
            //我的钱包
//            MyChongViewController *mychong = [[MyChongViewController alloc]init];
//            UINavigationController *mychongNVC =[[UINavigationController alloc]initWithRootViewController:mychong];
//            [self presentViewController:mychongNVC animated:YES completion:nil];
            

        }else {
            WithdrawalViewController *RankingView = [[WithdrawalViewController alloc]init];
            self.navigationController.navigationBarHidden = NO;
            
            [self.navigationController pushViewController:RankingView animated:nil];
            
        }
        


    }else {
        //我的钱包
        MyChongViewController *mychong = [[MyChongViewController alloc]init];
        UINavigationController *mychongNVC =[[UINavigationController alloc]initWithRootViewController:mychong];
        [self presentViewController:mychongNVC animated:YES completion:nil];

    }
    
    
}


#pragma mark ------- 获取数据
- (void)requestListData{
    if (_HLI == 0) {
        [self.view addSubview:self.MBhud];
        [self.MBhud show:YES];
    }
    

    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_MY_perShow];
    NSString *sexST = [defatults objectForKey:sexXB];
    NSDictionary *dic = @{@"uid":uidS};
    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
        NSDictionary *dic = result[@"data"];

        NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
        [defatults setObject:dic[@"age"] forKey:ageNL];
        [defatults setObject:dic[@"avatar"] forKey:avatarIMG];
        [defatults setObject:dic[@"sex"] forKey:sexXB];
        [defatults setObject:dic[@"user_rank"] forKey:user_rankVIP];
        [defatults synchronize];

        
        [defatults setObject:dic[@"user_rank"] forKey:user_rankVIP];
        [defatults synchronize];
        self.touxiangST = result[@"data"][@"avatar"];
    
        [_myfootView.touiamView sd_setImageWithURL:[NSURL URLWithString:result[@"data"][@"avatar"]] placeholderImage:[UIImage imageNamed:zhantuImage]];
        NSString *diquST = [NSString stringWithFormat:@"%@  %@",dic[@"area"],dic[@"constellation"]];
        _myfootView.diquLabel.text =diquST;
        NSString *mony = [NSString stringWithFormat:@"秀币%@",dic[@"money"]];
        _myfootView.meiliLabel.text = [NSString stringWithFormat:@"魅力 %@",dic[@"jifen"]];
        
        NSString *zanString = [NSString stringWithFormat:@"点赞 %@",result[@"data"][@"zan"]];
        
        NSString *uidS = [defatults objectForKey:uidSG];
            if ([uidS isEqualToString:@"257555"]) {
                _myfootView.zanLabel.text = @"";

            }else {
                _myfootView.zanLabel.text = mony;

            }
        
        
        NSString *liString = [NSString stringWithFormat:@"收礼 %@",result[@"data"][@"sumgift"]];
        _myfootView.liLabel.text = liString;
        _myfootView.monyLabel.text = zanString;

        
        if ([result[@"data"][@"avatar"] isEqualToString:@""]) {
            _myfootView.BYImageView.image = [UIImage imageNamed:@"bg-title"];
        }else{
            [_myfootView.BYImageView sd_setImageWithURL:[NSURL URLWithString:result[@"data"][@"avatar"]] placeholderImage:[UIImage imageNamed:zhantuImage]];
            if (_effectView) {
                
            }else {
                _myfootView.BYImageView.userInteractionEnabled = YES;
                UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
                // 毛玻璃view 视图
                _effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
                //添加到要有毛玻璃特效的控件中
                _effectView.frame = CGRectMake(0, 0, _myfootView.BYImageView.frame.size.width,_myfootView.BYImageView.frame.size.height);
                [_myfootView.BYImageView addSubview:_effectView];
                //设置模糊透明度
                _effectView.alpha = 0.99;
            }
        }
        
       
      

        NSString *nameSt = result[@"data"][@"user_nicename"];
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:16]};
        CGSize size=[nameSt sizeWithAttributes:attrs];
        if (self.WNEZILabel) {
            self.WNEZILabel.text = nameSt;
            _WNEZILabel.frame = CGRectMake((kScreen_w - size.width - 56) / 2 , 0, size.width , 20);
            self.WNEZILabel.textColor = [UIColor whiteColor];
            self.WNEZILabel.font = [UIFont systemFontOfSize:16];
            self.xiangimageVIew.frame = CGRectMake((kScreen_w - size.width - 56) / 2 + size.width + 4, 4, 30, 12);
            int ST = [dic[@"sex"] intValue];
            if (ST == 1){
                [_xiangimageVIew setImage:[UIImage imageNamed:@"icon-manX"] forState:UIControlStateNormal];
                NSString *age = [NSString stringWithFormat:@"%@",result[@"data"][@"age"]];
                [_xiangimageVIew setTitle:age forState:UIControlStateNormal];
                [_xiangimageVIew setTitleColor:blueC forState:UIControlStateNormal];
//                _xiangimageVIew.image = [UIImage imageNamed:@"icon-man2"]; //要添加的图片
            }else{
                [_xiangimageVIew setImage:[UIImage imageNamed:@"icon-womanX"] forState:UIControlStateNormal];
                
                NSString *age = [NSString stringWithFormat:@"%@",result[@"data"][@"age"]];
                [_xiangimageVIew setTitleColor:hong forState:UIControlStateNormal];
                [_xiangimageVIew setTitle:age forState:UIControlStateNormal];
            }
            self.VIBImageVIew.frame = CGRectMake((kScreen_w - size.width - 56) / 2 + size.width + 46, 4, 22, 12);
            NSString *user_rank = [NSString stringWithFormat:@"%@",result[@"data"][@"user_rank"]];
            
            int RK = [user_rank intValue];
            if (RK == 1) {
                _VIBImageVIew.image = [UIImage imageNamed:@"圆角矩形1"]; //要添加的图片
                
            }

        }else {
            self.WNEZILabel = [[UILabel alloc]init];
//            CGFloat *KK = size.width + 56.0;
            _WNEZILabel.frame = CGRectMake((kScreen_w - size.width - 56) / 2 , 0, size.width , 20);
            self.WNEZILabel.text = nameSt;
            self.WNEZILabel.textColor = [UIColor whiteColor];
            self.WNEZILabel.font = [UIFont systemFontOfSize:16];

            self.xiangimageVIew = [[UIButton alloc]init];
            self.xiangimageVIew.titleLabel.font = [UIFont systemFontOfSize:12];
            self.xiangimageVIew.frame = CGRectMake((kScreen_w - size.width - 56) / 2 + size.width + 4, 4, 30, 12);
            self.xiangimageVIew.backgroundColor = [UIColor whiteColor];
            self.xiangimageVIew.layer.cornerRadius = 3;
            self.xiangimageVIew.layer.masksToBounds = YES;
            int ST = [sexST intValue];
            if (ST == 1){
                [_xiangimageVIew setImage:[UIImage imageNamed:@"icon-manX"] forState:UIControlStateNormal];
                NSString *age = [NSString stringWithFormat:@"%@",result[@"data"][@"age"]];
                [_xiangimageVIew setTitleColor:blueC forState:UIControlStateNormal];

                [_xiangimageVIew setTitle:age forState:UIControlStateNormal];
                //                _xiangimageVIew.image = [UIImage imageNamed:@"icon-man2"]; //要添加的图片
            }else{
                [_xiangimageVIew setImage:[UIImage imageNamed:@"icon-womanX"] forState:UIControlStateNormal];
                NSString *age = [NSString stringWithFormat:@"%@",result[@"data"][@"age"]];
                [_xiangimageVIew setTitleColor:hong forState:UIControlStateNormal];

                [_xiangimageVIew setTitle:age forState:UIControlStateNormal];
            }
            self.VIBImageVIew = [[UIImageView alloc]init];
            self.VIBImageVIew.frame = CGRectMake((kScreen_w - size.width - 56) / 2 + size.width + 46, 4, 22, 12);
            NSString *user_rank = [NSString stringWithFormat:@"%@",result[@"data"][@"user_rank"]];

            int RK = [user_rank intValue];
            if (RK == 1) {
                _VIBImageVIew.image = [UIImage imageNamed:@"圆角矩形1"]; //要添加的图片
            
            }
            [self.myfootView.WTTView addSubview:self.WNEZILabel];
            [self.myfootView.WTTView addSubview:_xiangimageVIew];
            [self.myfootView.WTTView addSubview:_VIBImageVIew];
            
        }

//        int HH = [avatarstatus intValue];
//        if (HH == 1) {
//            _myfootView.zhuangTaiLabel.hidden = YES;
//        }else if(HH == 0){
//            _myfootView.zhuangTaiLabel.hidden = NO;
//            _myfootView.zhuangTaiLabel.text = @"待审核";
//        }else {
//            _myfootView.zhuangTaiLabel.hidden = NO;
//            _myfootView.zhuangTaiLabel.text = @"未通过";
//        }
        _myfootView.zhuangTaiLabel.hidden = YES;
   
//        NSString *liaotiaoST = [NSString stringWithFormat:@"聊天 %@",result[@"data"][@"sumgift"]]
        
        self.shuDic = result[@"data"];
        NSString *photonum = [NSString stringWithFormat:@"%@",result[@"data"][@"photonum"]];
        NSString *smnum = [NSString stringWithFormat:@"%@",result[@"data"][@"smnum"]];
        NSString *spnum = [NSString stringWithFormat:@"%@",result[@"data"][@"spnum"]];
        
        
        self.shuOneArray = [[NSMutableArray alloc]initWithObjects:photonum,smnum,spnum, nil];
        NSString *fansnum = [NSString stringWithFormat:@"%@",result[@"data"][@"fansnum"]];
        NSString *gznum = [NSString stringWithFormat:@"%@",result[@"data"][@"gznum"]];
        self.shuthreeArray = [[NSMutableArray alloc]initWithObjects:@"",@"",fansnum,gznum, nil];
        NSArray *fourArray = [[NSArray alloc]initWithObjects:@"",@"",@"",@"",@"", nil];
        
        self.shuArray = [[NSMutableArray alloc]initWithObjects:_shuOneArray,_shuthreeArray,fourArray,nil];
        
        [_myfootView.tixianButton addTarget:self action:@selector(addtiButton:) forControlEvents:UIControlEventTouchUpInside];
//        NSString *yu = [NSString stringWithFormat:@"余额: %@",self.shuDic[@"money"]];
//        NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
        
//        NSString *sex = [defatults objectForKey:sexXB];
//        if ([sex isEqualToString:@"1"]) {
//            [_myfootView.tixianButton setTitle:@"点击充值" forState:UIControlStateNormal];
//        }else {
//            [_myfootView.tixianButton setTitle:@"点击提现" forState:UIControlStateNormal];
//        }
        
//        [_myfootView.yuEButton setTitle:yu forState:UIControlStateNormal];
        [_myfootView.yuEButton addTarget:self action:@selector(addyuButton:) forControlEvents:UIControlEventTouchUpInside];

        if (_HLI == 0) {
            [self.MBhud hide:YES];
            _HLI = _HLI + 1;
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } withError:^(NSString *msg, NSError *error) {
        [self mbhudtui:msg numbertime:1];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];

    }];
    
    
}
//分享
- (void)fengxiangData{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_MY_share];
    NSDictionary *dic = @{@"uid":uidS};
    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
        self.fenDic = result[@"data"];
        
    } withError:^(NSString *msg, NSError *error) {
      
        
    }];

    
}
//头像
- (void)addtouimagView:(UIButton *)sender{
    UIAlertController *albel = [UIAlertController alertControllerWithTitle:@"亲,上传不雅头像会被封账号哦~" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *pai = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openCamera];
        
    }];
    UIAlertAction *cong = [UIAlertAction actionWithTitle:@"从手机相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openPics];
        
    }];
    [albel addAction:quxiao];
    [albel addAction:pai];
    [albel addAction:cong];
    [self presentViewController:albel animated:YES completion:nil];
    
    

}

#pragma mark - 视图出现时机
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 在这里隐藏导航条
    self.navigationController.navigationBarHidden = YES;
    
     [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.tabBarController.tabBar.hidden = NO;

}

// 打开相机
- (void)openCamera {
    // UIImagePickerControllerCameraDeviceRear 后置摄像头
    // UIImagePickerControllerCameraDeviceFront 前置摄像头
    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    if (!isCamera) {
        //        [self mbhud:@"摄像头调取失败" numbertime:1];
        return ;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    // 编辑模式
    imagePicker.allowsEditing = YES;
    
    [self  presentViewController:imagePicker animated:YES completion:^{
    }];
    
    
}

// 打开相册
- (void)openPics {
    
    UIImagePickerController *pc = [[UIImagePickerController alloc]init];
    pc.delegate = self;
    [pc setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [pc setModalPresentationStyle:UIModalPresentationFullScreen];
    [pc setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [pc setAllowsEditing:YES];
    [self presentViewController:pc animated:YES completion:nil];
}


// 选中照片

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info

{
    
    _image_type = info[@"UIImagePickerControllerMediaType"];
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    int a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%d.jpg", a];//／／转为字符型
    _imageFileName = timeString;
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
//    UIImage *image2 = [UIImage imagewithImage:image];
    self.tuiamgView.image = image;
    //    _touimageView.image = image2;
    //        [self.tableView reloadData];
    
    //图片上传
    [self shangData];
}
- (void)shangData{
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_upload];
    
    [SVProgressHUD showWithStatus:@"图片上传中..."];
    
    
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.requestSerializer = [AFHTTPRequestSerializer serializer];
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    //    NSDictionary *dic = @{@"uid":@"21444"};
    [manage POST:URL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //转化为data类型  0.5图片压缩比例 image 图片格式
        NSData *data = UIImageJPEGRepresentation(self.tuiamgView.image, 1);
        
        //PNG图片不需要压缩
        //        NSData *data1 = UIImagePNGRepresentation(image1);
        
        //参数1:: 就是我要上传的data数据
        //参数2: 后台要求的图片名
        //参数3: 图片上传以后的名字
        //参数4: image/jpg 图片是什么格式 就写什么格式
        //            NSString *string = info[@"UIImagePickerControllerMediaType"];
        //            [formData appendPartWithFormData:data name:@"file"];
        
        [formData appendPartWithFileData:data name:[NSString stringWithFormat:@"img%d", 100+1] fileName:[NSString stringWithFormat:@"img%d.jpg", 100+1] mimeType:@"image/jpeg"];
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        NSString *code = dic[@"code"];
        int incode = [code intValue];
        if (incode == 1) {
            
            [self dataImagViewString:dic[@"data"][@"img101"][@"url"]];
            [SVProgressHUD showSuccessWithStatus:@"图片上传成功"];
            [self requestListData];
        }
        
        
        
        [SVProgressHUD dismissWithDelay:1.0];
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        [SVProgressHUD dismissWithDelay:1.0];
        
        
    }];

    
}
- (void)dataImagViewString:(NSString *)imagViewString{
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_MY_UpAvatar];
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    
    NSDictionary *dic = @{@"uid":uidS,@"image":imagViewString};
    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
        NSString *code = [NSString stringWithFormat:@"%@",result[@"code"]];
        if ([code isEqualToString:@"1"]) {
            [SVProgressHUD showSuccessWithStatus:@"头像上传成功"];
            [SVProgressHUD dismissWithDelay:1.0];
            [self requestListData];

        }
    } withError:^(NSString *msg, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"头像上传失败"];
        [SVProgressHUD dismissWithDelay:1.0];
    }];
}


// 取消相册
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
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

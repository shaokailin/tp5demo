//
//  DynamicViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/2/28.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "DynamicViewController.h"
#import "DynamicTableViewCell.h"
#import "DYFindModel.h"
#import "MainXiuViewController.h"
#import "PersonalImageViewController.h"
#import "VideoPlaybackViewController.h"

#import <YYLabel.h>
#import "NSAttributedString+YYText.h"
#import "SingleViewController.h"
#import "MyChongViewController.h"
#import "PoIMViewController.h"
@interface DynamicViewController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    NSString * Strlation; //经度
    NSString * Strlongtion; //维度
}

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) int Hli;
@property(nonatomic,strong)MBProgressHUD * MBhud;//网络等待

@end

@implementation DynamicViewController
- (NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (MBProgressHUD *)MBhud{
    if (!_MBhud) {
        _MBhud = [[MBProgressHUD alloc]init];
//        _MBhud.yOffset =  _MBhud.yOffset ;
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
    self.view.backgroundColor = ViewRGB;
    self.navigationItem.title = @"动态圈";
    self.Hli = 0;
    
    [self addtableView];
   

    
}
- (void)addtableView{
    self.tableView = [[UITableView alloc]init];
//    _tableView.frame = CGRectMake(0, 0, kScreen_w, kScreen_h);
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 6, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"DynamicTableViewCell" bundle:nil] forCellReuseIdentifier:@"DynamicTableViewCell"];
    __weak typeof(self) ws = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [ws refreshData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [ws loadData];
    }];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;

    
    [self.view addSubview:_tableView];
    [self refreshData];

    
}
#pragma make ------ UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DYFindModel *model = self.dataArray[indexPath.section];
    DynamicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DynamicTableViewCell"];
    [cell.touImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:zhanImage]];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(celltouImageView:)];
    
    [cell.touImageView  addGestureRecognizer:tap];
    
    cell.nameLabel.text = model.user_nicename;
    int a = [model.user_rank intValue];
    if (a == 1) {
        cell.VIPButton.hidden = NO;
    }else {
        cell.VIPButton.hidden = YES;
    }
    int sexIn = [model.sex intValue];
    if (sexIn == 1) {
        UIImage *loginImg = [UIImage imageNamed:@"icon-manXB"];
        loginImg = [loginImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [cell.XBButton setImage:loginImg forState:UIControlStateNormal];
        [cell.XBButton setTitle:model.age forState:UIControlStateNormal];
        [cell.XBButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cell.XBButton.backgroundColor = [UIColor colorWithRed:88.0/255.0 green:183.0/255.0 blue:241.0/255.0 alpha:1];
        
    }else {
        UIImage *loginImg = [UIImage imageNamed:@"womanXBXIUXIU"];
        loginImg = [loginImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [cell.XBButton setImage:loginImg forState:UIControlStateNormal];
        [cell.XBButton setTitle:model.age forState:UIControlStateNormal];
        [cell.XBButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cell.XBButton.backgroundColor = hong;
    }
    if ([model.title isEqualToString:@""]) {
        cell.neiLabel.hidden = 1;
    }else {
        cell.neiLabel.hidden = 0;
        cell.neiLabel.text = model.title;
    }
    [cell.contionView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UITapGestureRecognizer * tapView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cellcontionView:)];
    
    
    [cell.contionView  addGestureRecognizer:tapView];
    
    //布局图片
    if (model.thumbfiles.count == 0) {
        cell.contionView.hidden = 1;
    }else if (model.thumbfiles.count == 1){
        cell.contionView.hidden = 0;
        NSDictionary *dic = model.thumbfiles[0];
        UIImageView *imaview1 = [[UIImageView alloc]init];
        imaview1.contentMode = UIViewContentModeScaleAspectFill;
//        CGFloat cocoHH = [HelperClass getImageSizeWithURL:dic[@"thumbfiles"]].height;
        CGFloat WHH = [model.imagWW floatValue];
        CGFloat HHH = [model.imagHH floatValue];

        
        imaview1.frame = CGRectMake(0, 0, WHH, HHH);
        imaview1.layer.masksToBounds = YES;
        [imaview1 sd_setImageWithURL:[NSURL URLWithString:dic[@"thumbfiles"]] placeholderImage:[UIImage imageNamed:zhanImage]];


        
//        if ([HelperClass getImageSizeWithURL:dic[@"thumbfiles"]].width > (kScreen_w - 80)) {
//            if ([HelperClass getImageSizeWithURL:dic[@"thumbfiles"]].width / 2 > (kScreen_w - 80) ) {
//                if ([HelperClass getImageSizeWithURL:dic[@"thumbfiles"]].width / 4 > (kScreen_w - 80)) {
//                    if ([HelperClass getImageSizeWithURL:dic[@"thumbfiles"]].width / 8 >  (kScreen_w - 80)) {
//                        imaview1.frame = CGRectMake(0, 0,200,200);
//                    }else {
//                        if (cocoHH < 0 || cocoHH == 0) {
//                            imaview1.frame = CGRectMake(0, 0, [HelperClass getImageSizeWithURL:dic[@"thumbfiles"]].width / 8 , [HelperClass getImageSizeWithURL:dic[@"thumbfiles"]].width / 8);
//                        }else {
//                            imaview1.frame = CGRectMake(0, 0, [HelperClass getImageSizeWithURL:dic[@"thumbfiles"]].width / 8 , [HelperClass getImageSizeWithURL:dic[@"thumbfiles"]].height / 8);
//                            
//                        }
//                    }
//                    imaview1.layer.masksToBounds = YES;
//                }else {
//                    if (cocoHH < 0 || cocoHH == 0) {
//                         imaview1.frame = CGRectMake(0, 0, [HelperClass getImageSizeWithURL:dic[@"thumbfiles"]].width / 4 , [HelperClass getImageSizeWithURL:dic[@"thumbfiles"]].width / 4);
//                    }else {
//                         imaview1.frame = CGRectMake(0, 0, [HelperClass getImageSizeWithURL:dic[@"thumbfiles"]].width / 4 , [HelperClass getImageSizeWithURL:dic[@"thumbfiles"]].height / 4);
//                    }
//                    
//                    imaview1.layer.masksToBounds = YES;
//
//                    [imaview1 sd_setImageWithURL:[NSURL URLWithString:dic[@"thumbfiles"]] placeholderImage:[UIImage imageNamed:zhanImage]];
//                }
//                
//            }else{
//                if (cocoHH < 0 || cocoHH == 0) {
//                    imaview1.frame = CGRectMake(0, 0, [HelperClass getImageSizeWithURL:dic[@"thumbfiles"]].width / 2 , [HelperClass getImageSizeWithURL:dic[@"thumbfiles"]].width / 2);
//
//                }else {
//                    imaview1.frame = CGRectMake(0, 0, [HelperClass getImageSizeWithURL:dic[@"thumbfiles"]].width / 2 , [HelperClass getImageSizeWithURL:dic[@"thumbfiles"]].height / 2);
//
//                    
//                }
//                imaview1.layer.masksToBounds = YES;
//
//                [imaview1 sd_setImageWithURL:[NSURL URLWithString:dic[@"thumbfiles"]] placeholderImage:[UIImage imageNamed:zhanImage]];
//                
//            }
//            
//        }else {
//            [imaview1 sd_setImageWithURL:[NSURL URLWithString:dic[@"thumbfiles"]] placeholderImage:[UIImage imageNamed:zhanImage]];
//            imaview1.frame = CGRectMake(0,0, [HelperClass getImageSizeWithURL:dic[@"thumbfiles"]].width, [HelperClass getImageSizeWithURL:dic[@"thumbfiles"]].height);
//            if([HelperClass getImageSizeWithURL:dic[@"thumbfiles"]].width == 0 || [HelperClass getImageSizeWithURL:dic[@"thumbfiles"]].width < 0){
//                imaview1.frame = CGRectMake(0, 0, 200, 200);
//                imaview1.layer.masksToBounds = YES;
//
//            }
//            
//            
//        }
        
        if ([dic[@"mp4"] isEqual:[NSNull null]]) {
            
        }else {
            if (![dic[@"mp4"] isEqualToString:@""] ) {
                
                UIImageView *image = [[UIImageView alloc]init];
                image.frame = CGRectMake(imaview1.frame.size.width / 2 - 25, imaview1.frame.size.height/2 - 25, 50, 50);
                image.image = [UIImage imageNamed:@"plays"];
                [imaview1 addSubview:image];
            }

        }

        [cell.contionView addSubview:imaview1];
    }else if (model.thumbfiles.count > 1 && model.thumbfiles.count <= 3){
        cell.contionView.hidden = 0;
        for (int i = 0; i< model.thumbfiles.count; i++) {
            NSDictionary *dic = model.thumbfiles[i];
            UIImageView *imaview = [[UIImageView alloc]init];
            imaview.contentMode = UIViewContentModeScaleAspectFill;
            imaview.layer.masksToBounds = YES;
            imaview.frame = CGRectMake((kScreen_w - 80) / 3.0 * i, 0, (kScreen_w - 80) / 3.0 - 1.5, (kScreen_w - 80) / 3.0 - 1.5);
            [imaview sd_setImageWithURL:[NSURL URLWithString:dic[@"thumbfiles"]] placeholderImage:[UIImage imageNamed:zhanImage]];
            UIButton *imabutton = [UIButton new];
            imabutton.frame = imaview.frame;
            [imabutton addTarget:self action:@selector(addimabutton:) forControlEvents:UIControlEventTouchUpInside];
            imabutton.tag = 1000 + i;
            [cell.contionView addSubview:imabutton];
            [cell.contionView addSubview:imaview];
        }
    }else if (model.thumbfiles.count > 3 && model.thumbfiles.count <= 6){
        cell.contionView.hidden = 0;
    
        for (int i = 0; i< model.thumbfiles.count; i++) {
            if (i < 3) {
                NSDictionary *dic = model.thumbfiles[i];
                UIImageView *imaview = [[UIImageView alloc]init];
                imaview.contentMode = UIViewContentModeScaleAspectFill;
                imaview.layer.masksToBounds = YES;
                imaview.frame = CGRectMake((kScreen_w - 80) / 3.0 * i, 0, (kScreen_w - 80) / 3.0- 1.5, (kScreen_w - 80) / 3.0 - 1.5);
                [imaview sd_setImageWithURL:[NSURL URLWithString:dic[@"thumbfiles"]] placeholderImage:[UIImage imageNamed:zhanImage]];
                UIButton *imabutton = [UIButton new];
                imabutton.frame = imaview.frame;
                [imabutton addTarget:self action:@selector(addimabutton:) forControlEvents:UIControlEventTouchUpInside];
                imabutton.tag = 1000 + i;
                [cell.contionView addSubview:imabutton];
                
                [cell.contionView addSubview:imaview];

            }else {
                NSDictionary *dic = model.thumbfiles[i];
                UIImageView *imaview = [[UIImageView alloc]init];
                imaview.contentMode = UIViewContentModeScaleAspectFill;
                imaview.layer.masksToBounds = YES;
                imaview.frame = CGRectMake((kScreen_w - 80) / 3.0 * (i - 3), (kScreen_w - 80) / 3, (kScreen_w - 80) / 3.0 - 1.5, (kScreen_w - 80) / 3.0 - 1.5);
                [imaview sd_setImageWithURL:[NSURL URLWithString:dic[@"thumbfiles"]] placeholderImage:[UIImage imageNamed:zhanImage]];
                UIButton *imabutton = [UIButton new];
                imabutton.frame = imaview.frame;
                [imabutton addTarget:self action:@selector(addimabutton:) forControlEvents:UIControlEventTouchUpInside];
                imabutton.tag = 1000 + i;
                [cell.contionView addSubview:imabutton];
                [cell.contionView addSubview:imaview];
            }

        }
    }else {
        cell.contionView.hidden = 0;
        
        for (int i = 0; i< model.thumbfiles.count; i++) {
            if (i < 3) {
                NSDictionary *dic = model.thumbfiles[i];
                UIImageView *imaview = [[UIImageView alloc]init];
                imaview.contentMode = UIViewContentModeScaleAspectFill;
                imaview.layer.masksToBounds = YES;
                imaview.frame = CGRectMake((kScreen_w - 80) / 3.0 * i, 0, (kScreen_w - 80) / 3.0- 1.5, (kScreen_w - 80) / 3.0 -1.5 );
                [imaview sd_setImageWithURL:[NSURL URLWithString:dic[@"thumbfiles"]] placeholderImage:[UIImage imageNamed:zhanImage]];
                UIButton *imabutton = [UIButton new];
                imabutton.frame = imaview.frame;
                [imabutton addTarget:self action:@selector(addimabutton:) forControlEvents:UIControlEventTouchUpInside];
                imabutton.tag = 1000 + i;
                [cell.contionView addSubview:imabutton];
                [cell.contionView addSubview:imaview];
                
            }else if(i >= 3 && i < 6){
                NSDictionary *dic = model.thumbfiles[i];
                UIImageView *imaview = [[UIImageView alloc]init];
                imaview.contentMode = UIViewContentModeScaleAspectFill;
                imaview.layer.masksToBounds = YES;
                imaview.frame = CGRectMake((kScreen_w - 80) / 3.0 * (i - 3), (kScreen_w - 80) / 3 , (kScreen_w - 80) / 3.0 - 1.5, (kScreen_w - 80) / 3.0 - 1.5);
                [imaview sd_setImageWithURL:[NSURL URLWithString:dic[@"thumbfiles"]] placeholderImage:[UIImage imageNamed:zhanImage]];
                UIButton *imabutton = [UIButton new];
                imabutton.frame = imaview.frame;
                [imabutton addTarget:self action:@selector(addimabutton:) forControlEvents:UIControlEventTouchUpInside];
                imabutton.tag = 1000 + i;
                [cell.contionView addSubview:imabutton];
                [cell.contionView addSubview:imaview];
            }else {
                NSDictionary *dic = model.thumbfiles[i];
                UIImageView *imaview = [[UIImageView alloc]init];
                imaview.contentMode = UIViewContentModeScaleAspectFill;
                imaview.layer.masksToBounds = YES;
                imaview.frame = CGRectMake((kScreen_w - 80) / 3.0 * (i - 6), (kScreen_w - 80) / 3 * 2, (kScreen_w - 80) / 3.0 - 1.5, (kScreen_w - 80) / 3.0 -1.5 );
                [imaview sd_setImageWithURL:[NSURL URLWithString:dic[@"thumbfiles"]] placeholderImage:[UIImage imageNamed:zhanImage]];
                UIButton *imabutton = [UIButton new];
                imabutton.frame = imaview.frame;
                [imabutton addTarget:self action:@selector(addimabutton:) forControlEvents:UIControlEventTouchUpInside];
                imabutton.tag = 1000 + i;
                [cell.contionView addSubview:imabutton];
                [cell.contionView addSubview:imaview];

            }
 
        }
    }
    NSString *str = [HelperClass timeStampIsConvertedToTime:model.timeline formatter:@"yyyy-MM-dd"];
    cell.timeLabel.text = str;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    DYFindModel *model = self.dataArray[indexPath.section];
    CGFloat HH = [model.cellHH floatValue];
    return HH;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    DYFindModel *model = self.dataArray[section];
    UIView *Fooview = [[UIView alloc] init];
    Fooview.frame = CGRectMake(0, 0, kScreen_w, 0);
    Fooview.backgroundColor = [UIColor whiteColor];

    if (model.comment.count == 0) {
        
    }else {
        if (model.comment.count > 5) {
            int HH = 7;
            for (int i = 0; i < 5; i++) {
                NSDictionary *dic = model.comment[i];
                NSString *string = [NSString stringWithFormat:@"%@:%@",dic[@"user_nicename"],dic[@"content"]];
                CGFloat content_h = [HelperClass calculationHeightWithTextsize:14.0 LabelWidth:kScreen_w - 80 WithText:string LineSpacing:0];
                YYLabel *label = [YYLabel new];
                label.frame = CGRectMake(68, HH, kScreen_w - 80, content_h);
                label.numberOfLines = 0;
                label.alpha = 0.4;
                [Fooview addSubview:label];
                HH = HH + content_h + 3;
                
                //属性字符串 简单实用
                NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:string];
                text.font = [UIFont boldSystemFontOfSize:14.0f];
                text.color = [UIColor blackColor];
                NSInteger le = [dic[@"user_nicename"] length];
                [text setColor:[UIColor redColor] range:NSMakeRange(0, le + 1)];
                [text setTextHighlightRange:NSMakeRange(0, le + 1) color:hong backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                    MainXiuViewController *MainView = [[MainXiuViewController alloc]init];
                    MainView.name = dic[@"user_nicename"];
                    MainView.UID = dic[@"id"];
                    UINavigationController *tgirNVC = [[UINavigationController alloc]initWithRootViewController:MainView];
                    
                    [self showViewController:tgirNVC sender:nil];
                }];
                NSInteger le1 = [dic[@"content"] length];
                [text setTextHighlightRange:NSMakeRange(le + 1, le1) color:[UIColor blackColor] backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                    NSArray * arr = @[dic[@"photoid"]];
                    SingleViewController *SingleView  = [[SingleViewController alloc]init];
                    SingleView.HHKK = 0;
                    SingleView.photoidArray = arr;
                    [self.navigationController pushViewController:SingleView animated:nil];
                }];
                
                
                label.attributedText = text;
                
                
                
            }
            

            
        }else {
            int HH = 7;
            for (int i = 0; i < model.comment.count; i++) {
                NSDictionary *dic = model.comment[i];
                NSString *string = [NSString stringWithFormat:@"%@:%@",dic[@"user_nicename"],dic[@"content"]];
                CGFloat content_h = [HelperClass calculationHeightWithTextsize:14.0 LabelWidth:kScreen_w - 80 WithText:string LineSpacing:0];
                YYLabel *label = [YYLabel new];
                label.frame = CGRectMake(68, HH, kScreen_w - 80, content_h);
                label.numberOfLines = 0;
                label.alpha = 0.4;
                [Fooview addSubview:label];
                HH = HH + content_h + 3;
                
                //属性字符串 简单实用
                NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:string];
                text.font = [UIFont boldSystemFontOfSize:14.0f];
                text.color = [UIColor blackColor];
                NSInteger le = [dic[@"user_nicename"] length];
                [text setColor:[UIColor redColor] range:NSMakeRange(0, le + 1)];
                [text setTextHighlightRange:NSMakeRange(0, le + 1) color:hong backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                    MainXiuViewController *MainView = [[MainXiuViewController alloc]init];
                    MainView.name = dic[@"user_nicename"];
                    MainView.UID = dic[@"id"];
                    UINavigationController *tgirNVC = [[UINavigationController alloc]initWithRootViewController:MainView];
                    
                    [self showViewController:tgirNVC sender:nil];
                }];
                NSInteger le1 = [dic[@"content"] length];
                [text setTextHighlightRange:NSMakeRange(le + 1, le1) color:[UIColor blackColor] backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                    NSArray * arr = @[dic[@"photoid"]];
                    SingleViewController *SingleView  = [[SingleViewController alloc]init];
                    SingleView.HHKK = 0;
                    SingleView.photoidArray = arr;
                    [self.navigationController pushViewController:SingleView animated:nil];
                }];
                
                
                label.attributedText = text;
                


            }
            
        }
        

    }
    
    
 
    return Fooview;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{
    DYFindModel *model = self.dataArray[section];
    CGFloat HH = [model.ViewHH floatValue];
    return HH;
//    if (model.comment.count == 0) {
//        return 12;
//    }else {
//        if (model.comment.count > 5) {
//            int HH = 12;
//            for (int i = 0; i < 5; i++) {
//                NSDictionary *dic = model.comment[i];
//                NSString *string = [NSString stringWithFormat:@"%@:%@",dic[@"user_nicename"],dic[@"content"]];
//                CGFloat content_h = [HelperClass calculationHeightWithTextsize:14.0 LabelWidth:kScreen_w - 80 WithText:string LineSpacing:0];
//          
//                HH = HH + content_h + 3;
//            }
//            return HH + 12;
//            
//        }else {
//            int HH = 12;
//            for (int i = 0; i < model.comment.count; i++) {
//                NSDictionary *dic = model.comment[i];
//                NSString *string = [NSString stringWithFormat:@"%@:%@",dic[@"user_nicename"],dic[@"content"]];
//                CGFloat content_h = [HelperClass calculationHeightWithTextsize:14.0 LabelWidth:kScreen_w - 80 WithText:string LineSpacing:0];
//                
//                HH = HH + content_h + 3;
//            }
//            return HH + 12;
//        }
//        
//        
//    
//    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1.0f;
}


#pragma mark - 下拉刷新 上拉加载
- (void)refreshData {
    self.page = 1;
    [self.tableView.mj_footer endRefreshing];
    [self ladata];
}

- (void)loadData {
    self.page ++ ;
    [self.tableView.mj_header endRefreshing];
    [self ladata];
}

#pragma mark ---- 数据
- (void)ladata{
    if (_Hli == 0) {
        [self.view addSubview:self.MBhud];
        [self.MBhud show:YES];
    }

    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
//    NSString *la = [defatults objectForKey:lationString];
//    NSString *lo = [defatults objectForKey:longtionString];

    
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_Dynamic];
    NSString *string = [NSString stringWithFormat:@"%ld",(long)self.page];
    NSDictionary *dic = @{@"uid":uidS,@"p":string};
    [HttpUtils postRequestWithURL:API_hot2 withParameters:dic withResult:^(id result) {
        NSInteger code = [result[@"code"] integerValue];
        if (self.page == 1) {
            [self.dataArray removeAllObjects];
        }
        
        if (code == 1){
            NSArray * array = result[@"data"];
            for (NSDictionary *dicy in array) {
//                DYFindModel *model = [[DYFindModel alloc]initWithDictionary:dicy error:nil];
                DYFindModel *model = [DYFindModel modelWithDict:dicy];
                [self.dataArray addObject:model];
            }
            
        }
        if (_Hli == 0) {
            [self.MBhud hide:YES];

            _Hli = _Hli + 1;
        }
      
        [self.tableView reloadData];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];

    } withError:^(NSString *msg, NSError *error) {
        [self.MBhud hide:YES];
        [self mbhudtui:msg numbertime:1];

        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        
    }];
}



- (void)celltouImageView:(UITapGestureRecognizer *)sender{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:((UITableViewCell *)sender.view.superview.superview)];
    DYFindModel *model = self.dataArray[indexPath.section];
    MainXiuViewController *MainView = [[MainXiuViewController alloc]init];
    MainView.name = model.user_nicename;
    MainView.UID = model.uid;
    UINavigationController *tgirNVC = [[UINavigationController alloc]initWithRootViewController:MainView];
    
    [self showViewController:tgirNVC sender:nil];
    
  
}
- (void)cellcontionView:(UITapGestureRecognizer *)sender{

    NSIndexPath *indexPath = [self.tableView indexPathForCell:((UITableViewCell *)sender.view.superview.superview)];
    DYFindModel *model = self.dataArray[indexPath.section];
    NSDictionary *dic = model.thumbfiles[0];
    if (![dic[@"mp4"] isEqualToString:@""]) {
        
        VideoPlaybackViewController *MainView = [[VideoPlaybackViewController alloc]init];
        MainView.name = model.user_nicename;
        MainView.UID = model.uid;
        MainView.mp4 = dic[@"mp4"];
        MainView.photoid = dic[@"photoid"];
        MainView.mp4imag = dic[@"uploadfiles"];
        UINavigationController *tgirNVC = [[UINavigationController alloc]initWithRootViewController:MainView];
        
        [self showViewController:tgirNVC sender:nil];
        
    }else {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:((UITableViewCell *)sender.view.superview.superview)];
        DYFindModel *model = self.dataArray[indexPath.section];
        PersonalImageViewController  *PersonalImageView  = [[PersonalImageViewController alloc]init];
        PersonalImageView.photoidArray = model.thumbfiles;
        PersonalImageView.HHKK = 0;
        [self.navigationController pushViewController:PersonalImageView animated:nil];
    }

}
- (void)addimabutton:(UIButton *)sender{
    DynamicTableViewCell *cell = (DynamicTableViewCell *)[[[sender superview] superview] superview];//获取cell
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];//获取
    DYFindModel *model = self.dataArray[indexPath.section];
    NSInteger a = sender.tag - 1000;
    PersonalImageViewController  *PersonalImageView  = [[PersonalImageViewController alloc]init];
    PersonalImageView.photoidArray = model.thumbfiles;
    PersonalImageView.HHKK = a;
    [self.navigationController pushViewController:PersonalImageView animated:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;

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

//
//  DataViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/3/27.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "DataViewController.h"
#import "MyTableViewCell.h"
#import "MyDatTableViewCell.h"
#import "MyImageTableViewCell.h"
#import "MyXBTableViewCell.h"
#import "CityChoose.h"
#import "MyNameViewController.h"
#import "UIImage+cutImage.h"
#import "NSDate+Helper.h"
#import "ValuePickerView.h"


@interface DataViewController ()<UITableViewDelegate, UITableViewDataSource,MyNameViewControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSInteger page;
}
@property (nonatomic, strong) CityChoose *cityChoose;    /** 城市选择 */

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong)UITableView *tableView;
///头像
@property (nonatomic, strong)NSString *avatar;
///头像的状态
@property (nonatomic, strong)NSString *typeString;
///名字
@property (nonatomic, strong)NSString *user_nicename;
//性别
@property (nonatomic, strong)NSString *sex;
//省ID
@property (nonatomic, strong)NSString *provinceid;
//市ID
@property (nonatomic, strong)NSString *cityid;
//生日
@property (nonatomic, strong)NSString *birthday;
//星座
@property (nonatomic, strong)NSString *astro;
//交友目的
@property (nonatomic, strong)NSString *code1;
//对情感的态度
@property (nonatomic, strong)NSString *code2;
//
@property (nonatomic, strong)NSString *code3;
//婚姻状况
@property (nonatomic, strong)NSString *code4;
//城市
@property (nonatomic, strong)NSString *CSString;
//城市的ID
@property(nonatomic, strong)NSString *town;
//省的ID
@property(nonatomic, strong)NSString *provinceIDLI;

@property(nonatomic,copy)NSString * image_type;
@property(nonatomic,copy)NSString * imageFileName;
//选着的图片
@property(nonatomic, strong)UIImageView *tuiamgView;
@property (nonatomic, strong) ValuePickerView *pickerView;
@property(nonatomic,strong)MBProgressHUD * MBhud;//网络等待

@end

@implementation DataViewController

- (UIImageView *)tuiamgView{
    if (!_tuiamgView) {
        _tuiamgView = [[UIImageView alloc]init];
    }
    return _tuiamgView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1];
    self.CSString = @"";
    [self configureNavigationView];
    [self initTableView];
    
}

#pragma mark - 初始化视图
- (void)configureNavigationView {
    self.navigationItem.title = @"完善资料";
    UIImage *leimage = [UIImage imageNamed:@"形状16"];
    UIImage *Leimage = [leimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:Leimage style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationItenLeftItemAction:)];
    self.navigationItem.leftBarButtonItem = leftItem;
   
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationItenRightItemAction:)];
    rightItem.tintColor = [UIColor colorWithRed:247.0/255.0 green:48.0/255.0 blue:103.0/255.0 alpha:1];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)initTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_w, kScreen_h)];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyDatTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyDatTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyImageTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyImageTableViewCell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"MyXBTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyXBTableViewCell"];

    self.tableView.estimatedRowHeight = 70;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    [self requestData];
//    [self.tableView.mj_header beginRefreshing];
}


#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 6;
    }else {
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    CGFloat h = [HelperClass calculationHeightWithTextsize:12.0 LabelWidth:kScreen_w - 75 WithText:self.dataArray[indexPath.row][@"remark"] LineSpacing:0];
//    if (h > 40) {
//        return UITableViewAutomaticDimension;
//    }else {
//        return 70;
//    }
    if (indexPath.section == 0){
        if (indexPath.row == 0) {
            return 65;
        }else {
            return 45;
        }
        
    }else {
        return 45;
    }
    
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0){
            MyImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyImageTableViewCell"];
            [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.avatar] placeholderImage:[UIImage imageNamed:zhantuImage]];
//            int HH = [self.typeString intValue];
//            if(HH == 0){
//                cell.typeLabel.alpha = 1;
//                cell.typeLabel.text = @"待审核";
//            }else if(HH == 2) {
//                cell.typeLabel.alpha = 1;
//                cell.typeLabel.text = @"不通过";
//            }else{
//                cell.typeLabel.alpha = 0;
//            }
            cell.typeLabel.alpha = 0;

            return cell;
            
        }else if(indexPath.row == 1){
            MyDatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyDatTableViewCell"];
            cell.nameLabel.text = @"昵称";
            cell.neiLabel.text = self.user_nicename;
            return cell;
        }else if (indexPath.row == 2){
            MyDatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyDatTableViewCell"];
            cell.nameLabel.text = @"生日";
            cell.neiLabel.text = self.birthday;
            return cell;
        }else if (indexPath.row == 3){
            MyDatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyDatTableViewCell"];
            cell.nameLabel.text = @"星座";
            int a = [self.astro intValue];
            switch (a) {
                case 1:
                    cell.neiLabel.text = @"白羊座";
                    break;
                case 2:
                    cell.neiLabel.text = @"金牛座";
                    break;
                case 3:
                    cell.neiLabel.text = @"双子座";
                    break;
                case 4:
                    cell.neiLabel.text = @"巨蟹座";
                    break;
                case 5:
                    cell.neiLabel.text = @"狮子座";
                    break;
                case 6:
                    cell.neiLabel.text = @"处女座";
                    break;
                case 7:
                    cell.neiLabel.text = @"天秤座";
                    break;
                case 8:
                    cell.neiLabel.text = @"天蝎座";
                    break;
                case 9:
                    cell.neiLabel.text = @"射手座";
                    break;
                case 10:
                    cell.neiLabel.text = @"摩羯座";
                    break;
                case 11:
                    cell.neiLabel.text = @"水瓶座";
                    break;
                case 12:
                    cell.neiLabel.text = @"双鱼座";
                    break;
                case 0:
                    cell.neiLabel.text = @"请选着星座";
                    break;
                default:
                    break;
            }
            return cell;
        }else if(indexPath.row == 4){
            MyDatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyDatTableViewCell"];
            cell.nameLabel.text = @"城市";
            NSString *str = [NSString stringWithFormat:@"%@",self.provinceid];
            NSString *ctr = [NSString stringWithFormat:@"%@",self.town];
            if ([str isEqualToString:@""] && [ctr isEqualToString:@""]) {
                if ([self.CSString isEqualToString:@""]) {
                    self.CSString = @"请选择城市";
                }
            }else {
                if ([self.CSString isEqualToString:@""]) {
                    NSString *path = [[NSBundle mainBundle] pathForResource:@"country" ofType:@"plist"];
                    NSArray *array = [NSArray arrayWithContentsOfFile:path][0];
                    
                    NSString *shenSTring = @"";
                    NSString *chengshiString = @"";
                    for (NSDictionary *dic in array) {
                        if ([dic[@"areaid"] isEqualToString:self.provinceid]) {
                            shenSTring = dic[@"areaname"];
                        }
                        if([dic[@"areaid"] isEqualToString:self.town]){
                            chengshiString = dic[@"areaname"];
                        }
                        
                    }
                    self.CSString = [NSString stringWithFormat:@"%@%@",shenSTring,chengshiString];
                }
        }
            
            
            cell.neiLabel.text = self.CSString;
            
            return cell;
        }else if (indexPath.row == 5){
            MyXBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyXBTableViewCell"];
            int serInt = [self.sex intValue];
            if (serInt == 2) {
               
                [cell.nanButton setImage:[UIImage imageNamed:@"形状-17"] forState:UIControlStateNormal];
                [cell.nanButton addTarget:self action:@selector(addnanButton:) forControlEvents:UIControlEventTouchUpInside];
                [cell.nvButton setImage:[UIImage imageNamed:@"形状-17-拷贝"] forState:UIControlStateNormal];
            }else if(serInt == 1) {
                [cell.nanButton setImage:[UIImage imageNamed:@"形状-17-拷贝"] forState:UIControlStateNormal];
                [cell.nvButton setImage:[UIImage imageNamed:@"形状-17"] forState:UIControlStateNormal];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        
            return cell;
            
            
        }else {
            MyDatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyDatTableViewCell"];
            cell.nameLabel.text = @"城市";
            cell.neiLabel.text = self.birthday;
            return cell;
            
        }

    }else {
        if (indexPath.row == 0) {
            MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTableViewCell"];
            cell.nameLabel.text = @"交友目的";
            if ([self.code1 isEqualToString:@""]) {
                cell.neiLabel.text = @"请选择";
            }else {
                int code = [self.code1 intValue];
                switch (code) {
                    case 0:
                        cell.neiLabel.text = @"请选择";
                        break;
                    case 1:
                        cell.neiLabel.text = @"结婚";
                        break;
                    case 2:
                        cell.neiLabel.text = @"交男女朋友";
                        break;
                    case 3:
                        cell.neiLabel.text = @"排解寂寞";
                        break;
                    case 4:
                        cell.neiLabel.text = @"纯友谊";
                        break;
                    case 5:
                        cell.neiLabel.text = @"找合适的人做合适的事";
                        break;
                    case 6:
                        cell.neiLabel.text = @"短期恋爱";
                        break;
                    case 7:
                        cell.neiLabel.text = @"聊友";
                        break;
                    case 8:
                        cell.neiLabel.text = @"长期约饭友";
                        break;
                    case 9:
                        cell.neiLabel.text = @"寻求刺激";
                        break;
                    default:
                        break;
                }
                
            }
            return cell;

        }else if (indexPath.row == 1){
            MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTableViewCell"];
            cell.nameLabel.text = @"对待感情的态度";
            if ([self.code2 isEqualToString:@""]) {
                cell.neiLabel.text = @"请选择";
            }else {
                if ([self.code2 isEqualToString:@""]) {
                    cell.neiLabel.text = @"请选择";
                }else {
                    int code = [self.code2 intValue];
                    switch (code) {
                        case 0:
                            cell.neiLabel.text = @"请选择";
                            break;
                        case 1:
                            cell.neiLabel.text = @"经历过许多，现在只想简单";
                            break;
                        case 2:
                            cell.neiLabel.text = @"顺其自然";
                            break;
                        case 3:
                            cell.neiLabel.text = @"可接受开放式关系";
                            break;
                        case 4:
                            cell.neiLabel.text = @"希望找一个成熟异性";
                            break;
                        case 5:
                            cell.neiLabel.text = @"不想认真，随便谈谈";
                            break;
                        case 6:
                            cell.neiLabel.text = @"只接受以结婚为目的的感情";
                            break;
                        case 7:
                            cell.neiLabel.text = @"换个人重新开始才能忘记过去";
                            break;
                        case 8:
                            cell.neiLabel.text = @"只想多尝试多经历";
                            break;
                       
                        default:
                            break;
                    }
                    

                }
            }
            
            return cell;

        }else {
            MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTableViewCell"];
            cell.nameLabel.text = @"婚姻状况";
            if ([self.code4 isEqualToString:@""]) {
                cell.neiLabel.text = @"请选择";
            }else {
                int code = [self.code4 intValue];
                switch (code) {
                    case 0:
                        cell.neiLabel.text = @"请选择";
                        break;
                    case 1:
                        cell.neiLabel.text = @"未婚";
                        break;
                    case 2:
                        cell.neiLabel.text = @"丧偶";
                        break;
                    case 3:
                        cell.neiLabel.text = @"离异";
                        break;
                        
                    default:
                        break;
                }
            }
            
            return cell;

        }
        

    }
    
    
    
//    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTableViewCell"];
////    [cell.headIconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", PIC_SERVER_ADDRESS, self.dataArray[indexPath.row][@"imgUrl"]]] placeholderImage:[UIImage imageNamed:@"banner.png"]];
////    cell.nameLabel.text = self.dataArray[indexPath.row][@"musicUserName"];
////    cell.introduceLabel.text = self.dataArray[indexPath.row][@"remark"];
//    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UIAlertController *albel = [UIAlertController alertControllerWithTitle:@"亲,上传不雅头像会被封账号哦~" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *pai = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self openCamera];
                //        self.tuiamg = 2;
                
            }];
            UIAlertAction *cong = [UIAlertAction actionWithTitle:@"从手机相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self openPics];
                //        self.tuiamg = 1;
                
            }];
            [albel addAction:quxiao];
            [albel addAction:pai];
            [albel addAction:cong];
            [self presentViewController:albel animated:YES completion:nil];
            

            
        }else if (indexPath.row == 1){
            MyNameViewController *MyNameView = [[MyNameViewController alloc]init];
            MyNameView.delegate = self;
            [self.navigationController pushViewController:MyNameView animated:YES];
            
        }else if (indexPath.row == 2){
            [self shengri];
        }else if (indexPath.row == 3){
            [self percentvaluechanggeEvent];
            
        }else if (indexPath.row == 4){
            self.cityChoose = [[CityChoose alloc] init];
            __weak typeof(self) weakSelf = self;
            self.cityChoose.config = ^(NSString *province, NSString *city, NSString *town, NSString *shenID){
                weakSelf.CSString = [NSString stringWithFormat:@"%@-%@",province,city];
                _town = town;
                _provinceid = shenID;
                [weakSelf.tableView reloadData];
            };
            [self.view addSubview:self.cityChoose];
            
        }else {
            
        }
    }else {
        if (indexPath.row == 0) {
            UIAlertController *alet = [UIAlertController alertControllerWithTitle:@"交友目的" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *pai = [UIAlertAction actionWithTitle:@"结婚" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.code1 = @"1";
                [self.tableView reloadData];
                
            }];
            UIAlertAction *cong = [UIAlertAction actionWithTitle:@"交男女朋友" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.code1 = @"2";
                [self.tableView reloadData];
                
                
            }];
            UIAlertAction *bai = [UIAlertAction actionWithTitle:@"排解寂寞" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.code1 = @"3";
                [self.tableView reloadData];
                
                
            }];
            UIAlertAction *hei = [UIAlertAction actionWithTitle:@"纯友谊" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.code1 = @"4";
                [self.tableView reloadData];
                
                
            }];
            UIAlertAction *nv = [UIAlertAction actionWithTitle:@"找合适的人做合适的事" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.code1 = @"5";
                [self.tableView reloadData];
            }];
            
            UIAlertAction *lb = [UIAlertAction actionWithTitle:@"短期恋爱" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.code1 = @"6";
                [self.tableView reloadData];
            }];
            
            UIAlertAction *jld = [UIAlertAction actionWithTitle:@"聊天" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.code1 = @"7";
                [self.tableView reloadData];
            }];
            UIAlertAction *jld2 = [UIAlertAction actionWithTitle:@"长期约饭友" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.code1 = @"8";
                [self.tableView reloadData];
            }];
            UIAlertAction *jld3 = [UIAlertAction actionWithTitle:@"寻找刺激" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.code1 = @"9";
                [self.tableView reloadData];
            }];
            
            
            [alet addAction:quxiao];
            [alet addAction:pai];
            [alet addAction:cong];
            [alet addAction:bai];
            [alet addAction:hei];
            [alet addAction:nv];
            [alet addAction:lb];
            [alet addAction:jld];
            [alet addAction:jld2];
            [alet addAction:jld3];

            [self presentViewController:alet animated:YES completion:nil];
            

            
        }else if (indexPath.row == 1){
                UIAlertController *alet = [UIAlertController alertControllerWithTitle:@"对待感情的态度" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                
                UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                UIAlertAction *pai = [UIAlertAction actionWithTitle:@"经历过许多，现在只想简单" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    self.code2 = @"1";
                    [self.tableView reloadData];
                    
                }];
                UIAlertAction *cong = [UIAlertAction actionWithTitle:@"顺其自然" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    self.code2 = @"2";
                    [self.tableView reloadData];
                    
                    
                }];
                UIAlertAction *bai = [UIAlertAction actionWithTitle:@"可接受开放式关系" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    self.code2 = @"3";
                    [self.tableView reloadData];
                    
                    
                }];
                UIAlertAction *hei = [UIAlertAction actionWithTitle:@"希望找一个成熟异性" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    self.code2 = @"4";
                    [self.tableView reloadData];
                    
                    
                }];
                UIAlertAction *nv = [UIAlertAction actionWithTitle:@"不想认真，随便谈谈" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    self.code2 = @"5";
                    [self.tableView reloadData];
                }];
                
                UIAlertAction *lb = [UIAlertAction actionWithTitle:@"只接受以结婚为目的的感情" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    self.code2 = @"6";
                    [self.tableView reloadData];
                }];
                
                UIAlertAction *jld = [UIAlertAction actionWithTitle:@"换个人重新开始才能忘记过去" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    self.code2 = @"7";
                    [self.tableView reloadData];
                }];
                UIAlertAction *jld2 = [UIAlertAction actionWithTitle:@"只想多尝试多经历" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    self.code2 = @"8";
                    [self.tableView reloadData];
                }];
            
                
                
                [alet addAction:quxiao];
                [alet addAction:pai];
                [alet addAction:cong];
                [alet addAction:bai];
                [alet addAction:hei];
                [alet addAction:nv];
                [alet addAction:lb];
                [alet addAction:jld];
                [alet addAction:jld2];
            
                [self presentViewController:alet animated:YES completion:nil];
                

            
        }else {
            UIAlertController *Alert = [UIAlertController alertControllerWithTitle:@"婚姻状况" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *cong = [UIAlertAction actionWithTitle:@"未婚" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.code4 = @"1";
                [self.tableView reloadData];
                
            }];
            UIAlertAction *pai = [UIAlertAction actionWithTitle:@"丧偶" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.code4 = @"2";
                [self.tableView reloadData];
                
            }];
            
            UIAlertAction *baomi = [UIAlertAction actionWithTitle:@"离异" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.code4 = @"3";
                [self.tableView reloadData];
            }];
            [Alert addAction:quxiao];
            [Alert addAction:cong];
            [Alert addAction:pai];
            
            [Alert addAction:baomi];
            [self presentViewController:Alert animated:YES completion:nil];

            
        }
        }
}

#pragma mark - 请求数据
- (void)requestData {
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *uidS = [defatults objectForKey:uidSG];
    NSString *url = [NSString stringWithFormat:@"%@%@",AppURL,API_MY_usershow];
    
    [HttpUtils postRequestWithURL:url withParameters:@{@"uid":uidS} withResult:^(id result) {
        NSInteger code = [result[@"code"] integerValue];
        if (code == 1 && (result[@"data"] != [NSNull null])) {
            NSDictionary *dic = result[@"data"];
            self.user_nicename = dic[@"user_nicename"];
            self.sex = dic[@"sex"];
            self.avatar = dic[@"avatar"];
            self.provinceid = dic[@"provinceid"];
            self.cityid = dic[@"cityid"];
            self.town = self.cityid;
            self.birthday = dic[@"birthday"];
            self.astro = dic[@"astro"];
            self.code1 = dic[@"code1"];
            self.code2 = dic[@"code2"];
            self.code3 = dic[@"code3"];
            self.code4 = dic[@"code4"];
            self.typeString = dic[@"avatarstatus"];
            [self.tableView reloadData];
        }
        if (page == 1) [self.tableView.mj_header endRefreshing];
        else [self.tableView.mj_footer endRefreshing];
    } withError:^(NSString *msg, NSError *error) {
        if (page == 1) [self.tableView.mj_header endRefreshing];
        else [self.tableView.mj_footer endRefreshing];
    }];
}
#pragma mark --- MyNameViewControllerDelegate
- (void)sendValue:(NSString *)value{
    self.user_nicename = value;
    [self.tableView reloadData];
}

#pragma mark - 用户交互
- (void)handleNavigationItenLeftItemAction:(UIBarButtonItem *)sender {
    self.tabBarController.tabBar.hidden = NO;

    [self.navigationController popViewControllerAnimated:YES];
}


//完成
- (void)handleNavigationItenRightItemAction:(UIBarButtonItem *)sender{
    [SVProgressHUD showWithStatus:@"正在保存中..."];

    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_MY_useredit];
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    if(self.town == nil){
        self.town = @"";
    }

    if (self.birthday == nil) {
        self.birthday = @"";
    }
    if (self.astro == nil) {
        self.astro = @"";
    }
    if (_code1 == nil) {
        self.code1 = @"";
    }
    if (_code2 == nil) {
        self.code2 = @"";
    }
    if (_code4 == nil) {
        self.code4 = @"";
    }
    if (_provinceid == nil) {
        self.provinceid = @"";
    }
    
    
    NSDictionary *dic = @{@"uid":uidS,@"avatar":self.avatar,@"nickname":self.user_nicename,@"birthday":self.birthday,@"astro":self.astro,@"provinceid":self.provinceid,@"cityid":self.town,@"sex":self.sex,@"code1":_code1,@"code2":_code2,@"code4":_code4};
    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
        
        
        [SVProgressHUD showSuccessWithStatus:@"保存成功！资料正在审核中！"];
        [SVProgressHUD dismissWithDelay:1.0];
        NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
        [defatults setObject:self.sex forKey:sexXB];
        [defatults synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"adddengluShuaxin11" object:nil];

        self.tabBarController.tabBar.hidden = NO;
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } withError:^(NSString *msg, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
        [SVProgressHUD dismissWithDelay:1.0];
    }];
    
    
    
}


#pragma mark --- 生日
- (void)shengri{
    //年 月 日
    UIDatePicker *picker = [[UIDatePicker alloc]init];
    picker.datePickerMode = UIDatePickerModeDate;
    
    picker.frame = CGRectMake(0, 40, 320, 200);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择出生日期，会自动算出年龄\n\n\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSDate *date = picker.date;
        
        NSString * shengri = [date stringWithFormat:@"yyyy-MM-dd"];
        
        //年龄
        NSString *birth = shengri;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        //生日
        NSDate *birthDay = [dateFormatter dateFromString:birth];
        //当前时间
        NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
        NSDate *currentDate = [dateFormatter dateFromString:currentDateStr];
        NSTimeInterval time=[currentDate timeIntervalSinceDate:birthDay];
        int age = ((int)time)/(3600*24*365);
        if (age > 0){
//            self.nianTextFiled.text = [NSString stringWithFormat:@"%d岁",age];
            //[self.tableView reloadData];
            
            
            self.birthday = birth;
            [self.tableView reloadData];


            
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"出生年月日不能大于当前的时间" message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *seqing = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alert addAction:seqing];
            [self presentViewController:alert animated:YES completion:nil];
            
//            [self mbhud:@"生日不正确" numbertime:1];
//            self.nianTextFiled.text = @"";
            
        }
        
        
    }];
    [alertController.view addSubview:picker];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];

}
//星座
- (void)percentvaluechanggeEvent {
    self.pickerView = [[ValuePickerView alloc]init];

    self.pickerView.dataSource = @[@"白羊座", @"金牛座", @"双子座", @"巨蟹座", @"狮子座", @"处女座", @"天秤座",@"天蝎座",@"射手座",@"摩羯座",@"水瓶座",@"双鱼座"];
    self.pickerView.pickerTitle = @"星座";
    __weak typeof(self) weakSelf = self;
    self.pickerView.defaultStr = @"50%/5";
    self.pickerView.valueDidSelect = ^(NSString *value){
        NSArray * stateArr = [value componentsSeparatedByString:@"/"];
        weakSelf.astro = stateArr[1];
        [weakSelf.tableView reloadData];
    };
    [self.pickerView show];
    
}

#pragma mark - getter
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


//隐藏tabBarController
- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    
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
        }
        
        
//        if ([dic[@"code"] isEqualToString:@"1"]) {
//            self.touString = dic[@"data"][@"url"];
//            [SVProgressHUD showSuccessWithStatus:@"图片上传成功"];
//            
//        }else {
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误提示" message:@"头像上传失败" preferredStyle:UIAlertControllerStyleAlert];
//            
//            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//                
//                
//                
//            }];
//            
//            
//            [alert addAction:otherAction];
//            
//            [self presentViewController:alert animated:YES completion:nil];
//        }
//        
        
        
        [SVProgressHUD dismissWithDelay:1.0];
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        [SVProgressHUD dismissWithDelay:1.0];
        

        
        
    }];
    
    
    
    
}
- (void)dataImagViewString:(NSString *)imagViewString{
    self.avatar = imagViewString;
    [self.tableView reloadData];
    
//    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_MY_UpAvatar];
//    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
//    
//    NSString *uidS = [defatults objectForKey:uidSG];
//    
//    NSDictionary *dic = @{@"uid":uidS,@"image":imagViewString};
//    [HttpUtils postRequestWithURL:URL withParameters:dic withResult:^(id result) {
//        NSString *codeSt = [NSString stringWithFormat:@"%@",result[@"code"]];
//        int CI = [codeSt intValue];
//        if (CI == 1) {
////            self.touString = dic[@"data"][@"url"];
//            [SVProgressHUD showSuccessWithStatus:result[@"msg"]];
//            self.avatar = imagViewString;
//            [self.tableView reloadData];
//        }else {
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误提示" message:@"头像上传失败" preferredStyle:UIAlertControllerStyleAlert];
//            
//            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//                
//                
//                
//            }];
//            
//            
//            [alert addAction:otherAction];
//            
//            [self presentViewController:alert animated:YES completion:nil];
//        }
//
//        
//    } withError:^(NSString *msg, NSError *error) {
//        
//    }];
}


// 取消相册
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
//女改男
- (void)addnanButton:(UIButton *)sender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"男性将无法修改性别" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *quxiaoAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
        
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self.sex = @"1";
       

    
        [self.tableView reloadData];
    }];
    [alert addAction:quxiaoAction];
   [alert addAction:otherAction];
   [self presentViewController:alert animated:YES completion:nil];
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

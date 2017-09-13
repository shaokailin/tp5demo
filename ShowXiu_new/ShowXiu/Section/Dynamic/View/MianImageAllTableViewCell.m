//
//  MianImageAllTableViewCell.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/6/10.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "MianImageAllTableViewCell.h"
#import "AllImaCollectionViewCell.h"
#import "MyChongViewController.h"
#import "VideoPlaybackViewController.h"
#import "PotuViewController.h"
@interface MianImageAllTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *dataArry;
@property(nonatomic, strong)MBProgressHUD *MBhud;

@end

@implementation MianImageAllTableViewCell


- (NSMutableArray *)dataArry{
    if (!_dataArry) {
        _dataArry = [[NSMutableArray alloc]init];
    }
    return _dataArry;
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
    [self addSubview:self.MBhud];
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


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self insertSubview];
        [self.contentView addSubview:self.wenziLabel];
        [self.contentView addSubview:self.suzilabel];
        [self.contentView addSubview:self.hengButton];
    }
    return self;
}
- (UILabel *)wenziLabel{
    if (!_wenziLabel) {
        _wenziLabel = [[UILabel alloc]init];
        _wenziLabel.frame = CGRectMake(12, 0, 60, 30);
        _wenziLabel.text = @"我的相册";
        _wenziLabel.font = [UIFont systemFontOfSize:14];
        _wenziLabel.textColor = [UIColor blackColor];
        _wenziLabel.backgroundColor = [UIColor whiteColor];
    }
    return _wenziLabel;
}
- (UILabel *)suzilabel{
    if (!_suzilabel) {
        _suzilabel =[[UILabel alloc]init];
        _suzilabel.frame = CGRectMake(72, 0, 100, 30);
        _suzilabel.font = [UIFont systemFontOfSize:14];
        _suzilabel.textColor = hong;
    }
    return _suzilabel;
}
- (UIButton *)hengButton{
    if (!_hengButton) {
        _hengButton = [UIButton new];
        _hengButton.frame = CGRectMake(kScreen_w - 50, 0, 40, 30);
        _hengButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_hengButton setTitle:@"更多" forState:UIControlStateNormal];
        [_hengButton setTitleColor:hong forState:UIControlStateNormal];
    }
    return _hengButton;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)insertSubview{
    [self.collectionView addSubview:self.wenziLabel];
    
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
    //设置cell大小
    flowlayout.itemSize = CGSizeMake((kScreen_w - 26)/4 - 0.5, (kScreen_w - 26)/4 - 0.5);
    flowlayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowlayout.minimumLineSpacing = 1;
    flowlayout.minimumInteritemSpacing = 1;

    CGFloat HH = self.contentView.frame.size.height;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(12, 30, kScreen_w - 24,HH - 30) collectionViewLayout:flowlayout];

    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"AllImaCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"AllImaCollectionViewCell"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.scrollEnabled = NO;
    [self.contentView addSubview:self.collectionView];
 
}

#pragma mark ------ UICollectionViewDataSource
//设置分区item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.dataMutableArray.count == 0) {
        CGFloat KK = 0.0;
        int LL = (kScreen_w - 26)/ 4 - 0.5;
        int A = 1 % 4;
        float B = 1 / 4;
        int C = (int)B;
        if (A == 0) {
            KK = C * LL ;
        }else {
            KK = (C + 1) * LL;
        }
        
        self.collectionView.frame = CGRectMake(12, 30, kScreen_w - 24, KK);
        
        return 1;
        
    }else {
        CGFloat KK = 0.0;
        int LL = (kScreen_w - 26)/ 4  - 0.5;
        int A = self.dataMutableArray.count % 4;
        float B = self.dataMutableArray.count / 4;
        int C = (int)B;
        if (A == 0) {
            KK = C * LL ;
        }else {
            KK = (C + 1) * LL;
        }
        
        self.collectionView.frame = CGRectMake(12, 30, kScreen_w - 24, KK);
        
        return self.dataMutableArray.count;
        
    }
    
    
  
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataMutableArray.count == 0) {
        AllImaCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AllImaCollectionViewCell" forIndexPath:indexPath];
        //    [cell.imagView sd_setImageWithURL:[NSURL URLWithString:model.uploadfiles] placeholderImage:[UIImage imageNamed:zhanImage];
        cell.imagView.contentMode = UIViewContentModeScaleToFill;
        cell.imagView.image = [UIImage imageNamed:@"icon-invite-copy"];
//        cell.backgroundColor = [UIColor redColor];
        [cell.imaButton addTarget:self action:@selector(addimaButton:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
        
        
    }else {
        AllImaCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AllImaCollectionViewCell" forIndexPath:indexPath];
        cell.imagView.contentMode = UIViewContentModeScaleAspectFill;

        MianAllModel *model = self.dataMutableArray[indexPath.row];
        NSString *see_status = [NSString stringWithFormat:@"%@",model.see_status];
        int SEE = [see_status intValue];
        //    [cell.imagView sd_setImageWithURL:[NSURL URLWithString:model.uploadfiles] placeholderImage:[UIImage imageNamed:zhanImage];
        [cell.imagView sd_setImageWithURL:[NSURL URLWithString:model.uploadfiles] placeholderImage:[UIImage imageNamed:zhanImage]];
        
        
        if (model.mp4 == nil) {
            if (SEE == 0) {
                [cell.imaButton setBackgroundImage:[UIImage imageNamed:@"icon-lock-"] forState:UIControlStateNormal];
                
                UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
                //  毛玻璃view 视图
                UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
                //添加到要有毛玻璃特效的控件中
                effectView.frame = CGRectMake(0, 0, (kScreen_w - 26) / 4 - 0.5, (kScreen_w - 26) / 4 - 0.5);
                [cell.imagView addSubview:effectView];
                //设置模糊透明度
                effectView.alpha = 0.8;
                
            }
        }else {
            [cell.imaButton setBackgroundImage:[UIImage imageNamed:@"icon-media"] forState:UIControlStateNormal];
            
        }
        [cell.imaButton addTarget:self action:@selector(addimaButton:) forControlEvents:UIControlEventTouchUpInside];
        cell.imaButton.hidden = NO;
        
        return cell;
        
        
    }
    
 
}
- (void)addimaButton:(UIButton *)sender{
    UICollectionViewCell *cell = (UICollectionViewCell *)[[sender superview] superview];//获取cell
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];//获取
//    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
//    NSString *user_renk = [defatults objectForKey:user_rankVIP];
//    int userIn = [user_renk intValue];
//    if (userIn == 0) {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"你现在还不是VIP，不能查看，是否充值！" message:nil preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction *seqing = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            
//            
//        }];
//        UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"去充值" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            MyChongViewController *mychong = [[MyChongViewController alloc]init];
//            UINavigationController *mychongNVC =[[UINavigationController alloc]initWithRootViewController:mychong];
//            
//            [self.superVC showViewController:mychongNVC sender:nil];
//            //                [self presentViewController:mychongNVC animated:YES completion:nil];
//            
//        }];
//        [alert addAction:seqing];
//        [alert addAction:quxiao];
//        
//        [_superVC presentViewController:alert animated:YES completion:nil];
//        
//    }else {
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *use = [defatults objectForKey:uidSG];

    if (self.dataMutableArray.count == 0) {
        if ([self.tyst isEqualToString:@"个人相册"]) {
            NSDictionary *dic = @{@"fromuid":use,@"touid":self.UID,@"type":@"1"};
         [HttpUtils postRequestWithURL:API_sendUpMsg withParameters:dic withResult:^(id result) {
             [self mbhudtui:@"已发送邀请" numbertime:1];

         } withError:^(NSString *msg, NSError *error) {
             [self mbhudtui:@"已发送邀请" numbertime:1];

         }];
        }else {
            NSDictionary *dic = @{@"fromuid":use,@"touid":self.UID,@"type":@"2"};
              [HttpUtils postRequestWithURL:API_sendUpMsg withParameters:dic withResult:^(id result) {
                  [self mbhudtui:@"已发送邀请" numbertime:1];

              } withError:^(NSString *msg, NSError *error) {
                  [self mbhudtui:@"已发送邀请" numbertime:1];

              }];

        }
       
        
    }else {
        MianAllModel *model = self.dataMutableArray[indexPath.row];
        NSString *see_status = [NSString stringWithFormat:@"%@",model.see_status];
        int SEE = [see_status intValue];
        
        if (SEE == 0) {
            NSString *string = [NSString stringWithFormat:@"是否花费%@秀币查看？",self.dataDic[@"needxb"]];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:string message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *seqing = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                
            }];
            UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //            MyChongViewController *mychong = [[MyChongViewController alloc]init];
                //            UINavigationController *mychongNVC =[[UINavigationController alloc]initWithRootViewController:mychong];
                //            [self showViewController:mychongNVC sender:nil];
                //            //                [self presentViewController:mychongNVC animated:YES completion:nil];
                [self hufeiUID:indexPath];
                //
            }];
            [alert addAction:seqing];
            [alert addAction:quxiao];
            
            [_superVC presentViewController:alert animated:YES completion:nil];
            
        }else {
            if (model.mp4 == nil) {
                PotuViewController  *PersonalImageView  = [[PotuViewController alloc]init];
                
                PersonalImageView.photoidArray = _xiantuimageArray;
                PersonalImageView.photoid = model.photoid;
                [_superVC.navigationController pushViewController:PersonalImageView animated:nil];
            }else {
                VideoPlaybackViewController *MainView = [[VideoPlaybackViewController alloc]init];
                MainView.name = @"";
                MainView.UID = self.UID;
                MainView.mp4 = model.mp4;
                MainView.photoid = model.photoid;
                MainView.mp4imag = model.uploadfiles;
                UINavigationController *tgirNVC = [[UINavigationController alloc]initWithRootViewController:MainView];
                
                [_superVC showViewController:tgirNVC sender:nil];
                
                
            }
            
            
            
            
            
            
        }
        

        
    }
 
    
    
    
//    }

}


//付费查看
- (void)hufeiUID:(NSIndexPath *)indexPath{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_MY_priphoto];
    MianAllModel *model = self.dataMutableArray[indexPath.row];

    NSDictionary *dic= @{@"fromuid":uidS,@"touid":self.UID,@"photoType":@"1",@"photoid":model.photoid};
    
    [HttpUtils postRequestWithURL:API_see_photo_pay2 withParameters:dic withResult:^(id result) {
        MianAllModel *model = [[MianAllModel alloc]init];
        model = model;
        model.see_status = @"0";
        [self.collectionView reloadData];
        [self mbhudtui:@"已获得查看权限" numbertime:1];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"adddtuXIUXIU" object:nil];
        

        
    } withError:^(NSString *msg, NSError *error) {
        if ([msg isEqualToString:@"余额不足"]) {
            NSString *str = [NSString stringWithFormat:@"%@,是否充值",msg];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:str message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *seqing = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                
            }];
            UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                MyChongViewController *mychong = [[MyChongViewController alloc]init];
                UINavigationController *mychongNVC =[[UINavigationController alloc]initWithRootViewController:mychong];
                [_superVC showViewController:mychongNVC sender:nil];
                            //                [self presentViewController:mychongNVC animated:YES completion:nil];
                [self hufeiUID:indexPath];
                //
            }];
            [alert addAction:seqing];
            [alert addAction:quxiao];
            
            [_superVC presentViewController:alert animated:YES completion:nil];
            

        }
        
        
        
    }];
    
    
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end

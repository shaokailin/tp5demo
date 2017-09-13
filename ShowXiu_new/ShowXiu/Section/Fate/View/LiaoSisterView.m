//
//  LiaoSisterView.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/6/2.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "LiaoSisterView.h"
#import "LiaoCollectionViewCell.h"
#import "LiaoModel.h"
@interface LiaoSisterView () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong)NSMutableArray *dataArray;

@end
@implementation LiaoSisterView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self liwuData];
    [self addcollectionViewXIu];
}


- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
//布局
- (void)addcollectionViewXIu{
    //创建布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake((kScreen_w - 42)/ 3, 110);
    //设置分区的边界距离
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //设置行间距
    flowLayout.minimumLineSpacing  = 6;
    //设置item的距离
    flowLayout.minimumInteritemSpacing = 6;
    self.collectionView.collectionViewLayout = flowLayout;
    [_collectionView registerNib:[UINib nibWithNibName:@"LiaoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"LiaoCollectionViewCell"];
    _collectionView.pagingEnabled = YES;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;

}

//一键全聊
- (void)liwuData{
//    NSString *stringURL = [NSString stringWithFormat:@"%@%@",AppURL,API_shopgift];
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *uidS = [defatults objectForKey:uidSG];
    NSString *lat = [NSString stringWithFormat:@"%@",[defatults objectForKey:lationString]];
    NSString *lng = [NSString stringWithFormat:@"%@",[defatults objectForKey:longtionString]];
    [HttpUtils postRequestWithURL:API_recommendList withParameters:@{@"uid":uidS,@"lat":lat,@"lng":lng} withResult:^(id result) {
        NSArray *giftlist = result[@"data"];
        [self.dataArray removeAllObjects];
        for (NSDictionary *dic in giftlist) {
            LiaoModel *mode = [[LiaoModel alloc]initWithDictionary:dic error:nil];
            [self.dataArray addObject:mode];
        }
        [self.collectionView reloadData];
    } withError:^(NSString *msg, NSError *error) {
        
        
    }];
    
}
#pragma mark ------ UICollectionViewDataSource
//设置分区item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.dataArray.count == 0) {
        return 0;
    }else {
        return 9;
    }
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LiaoModel *model = self.dataArray[indexPath.row];
    LiaoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LiaoCollectionViewCell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.contentView.layer.cornerRadius = 5;
    cell.contentView.layer.masksToBounds = YES;
    [cell.touImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:zhanImage]];
    cell.touImageView.layer.masksToBounds = YES;
    cell.namelabel.text = model.user_nicename;
    cell.diquLabel.text = model.cityname;
    int sex = [model.sex intValue];
    NSString *ndien = @"";
    if (sex == 1) {
        ndien = [NSString stringWithFormat:@"%@ 男",model.age];
    }else {
        ndien = [NSString stringWithFormat:@"%@ 女",model.age];
    }
    cell.nianLabel.text = ndien;

    return cell;
}
#pragma mark ---- UICollectionViewDelegate
//选中item触发的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
}
//一键全撩
- (IBAction)addyijianButton:(id)sender {
//    http://jy.leejia.cn/index.php?s=/Appi/IndexApi/sendqdzh
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *uidS = [defatults objectForKey:uidSG];
  
    LiaoModel *model1 = self.dataArray[0];
    LiaoModel *model2 = self.dataArray[1];
    LiaoModel *model3 = self.dataArray[2];
    LiaoModel *model4 = self.dataArray[3];
    LiaoModel *model5 = self.dataArray[4];
    LiaoModel *model6 = self.dataArray[5];
    LiaoModel *model7 = self.dataArray[6];
    LiaoModel *model8 = self.dataArray[7];
    LiaoModel *model9 = self.dataArray[8];

    
    NSString *str = [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@,%@",model1.ID,model2.ID,model3.ID,model4.ID,model5.ID,model6.ID,model7.ID,model8.ID,model9.ID];
    NSDictionary *dic = @{@"fromuid":uidS,@"touids":str};
    [HttpUtils postRequestWithURL:API_sendqdzh withParameters:dic withResult:^(id result) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LiaoSisterViewXiu" object:nil];

  
    } withError:^(NSString *msg, NSError *error) {

        [[NSNotificationCenter defaultCenter] postNotificationName:@"LiaoSisterViewXiu" object:nil];

        

        
    }];

    
}




@end

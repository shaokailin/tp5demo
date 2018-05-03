//
//  LCGuessUerListCell.h
//  LotteryCharts
//
//  Created by 程磊 on 2018/3/26.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCGuessUerListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *mashiIDLab;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

- (void)setupContentWithPhoto:(NSString *)photo name:(NSString *)name mashiID:(NSString *)mashiID number:(NSString *)number creattime:(NSString *)creattime money:(NSString *)money;
@end

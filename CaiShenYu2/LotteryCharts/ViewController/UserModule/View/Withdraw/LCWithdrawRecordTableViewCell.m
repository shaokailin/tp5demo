//
//  LCWithdrawRecordTableViewCell.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/16.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCWithdrawRecordTableViewCell.h"
@interface LCWithdrawRecordTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *typeLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *moneyLbl;

@end
@implementation LCWithdrawRecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setupContentWithType:(NSString *)type time:(NSString *)time money:(NSString *)money {
    self.typeLbl.text = type;
    self.timeLbl.text = time;
    self.moneyLbl.text = money;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

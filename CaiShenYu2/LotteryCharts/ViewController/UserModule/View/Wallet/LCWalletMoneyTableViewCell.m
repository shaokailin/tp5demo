//
//  LCWalletMoneyTableViewCell.m
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/15.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCWalletMoneyTableViewCell.h"
@interface LCWalletMoneyTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *leftLbl;
@property (weak, nonatomic) IBOutlet UILabel *rightLbl;

@end
@implementation LCWalletMoneyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setupCellContentWithTitle:(NSString *)title money:(NSString *)money {
    self.leftLbl.text = title;
    self.rightLbl.text = money;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

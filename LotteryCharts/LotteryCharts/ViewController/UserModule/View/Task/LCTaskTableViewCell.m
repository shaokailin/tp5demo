//
//  LCTaskTableViewCell.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/17.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCTaskTableViewCell.h"
@interface LCTaskTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *leftLbl;

@property (weak, nonatomic) IBOutlet UILabel *rightLbl;

@end
@implementation LCTaskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setupLeftContent:(NSString *)left right:(NSString *)right {
    self.leftLbl.text = left;
    self.rightLbl.text = right;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

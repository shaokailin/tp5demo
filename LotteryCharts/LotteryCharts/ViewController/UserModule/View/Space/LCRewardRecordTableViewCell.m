//
//  LCRewardRecordTableViewCell.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCRewardRecordTableViewCell.h"
@interface LCRewardRecordTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *countLbl;
@property (weak, nonatomic) IBOutlet UILabel *moneyLbl;

@property (weak, nonatomic) IBOutlet UILabel *postIdLbl;
@end
@implementation LCRewardRecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setupContentWithId:(NSString *)postId time:(NSString *)time count:(NSString *)count money:(NSString *)money {
    self.postIdLbl.text = postId;
    self.timeLbl.text = time;
    self.countLbl.text = NSStringFormat(@"共%@个打赏",count);
    self.moneyLbl.text = money;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

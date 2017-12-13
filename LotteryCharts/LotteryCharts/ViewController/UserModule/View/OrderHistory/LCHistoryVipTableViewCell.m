//
//  LCHistoryVipTableViewCell.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCHistoryVipTableViewCell.h"
@interface LCHistoryVipTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *postIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *moneyLbl;

@end
@implementation LCHistoryVipTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setupCellContent:(NSString *)postId time:(NSString *)time title:(NSString *)title payMoney:(NSString *)money {
    self.postIdLbl.text = NSStringFormat(@"帖子ID:%@",postId);
    self.timeLbl.text = NSStringFormat(@"%@发布",time);
    self.titleLbl.text = title;
    self.moneyLbl.text = NSStringFormat(@"%@金币抢榜",money);
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  LCSpaceGuessTableViewCell.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCSpaceGuessTableViewCell.h"
@interface LCSpaceGuessTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *postIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@end
@implementation LCSpaceGuessTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setupCellContentWithId:(NSString *)postId time:(NSString *)time title:(NSString *)title {
    self.postIdLbl.text = NSStringFormat(@"码师ID:%@",postId);
    self.timeLbl.text = time;
    self.titleLbl.text = title;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

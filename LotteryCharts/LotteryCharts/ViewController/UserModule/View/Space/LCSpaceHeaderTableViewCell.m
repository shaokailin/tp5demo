//
//  LCSpaceHeaderTableViewCell.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCSpaceHeaderTableViewCell.h"
@interface LCSpaceHeaderTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *countLbl;

@end
@implementation LCSpaceHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setupCellContentWithCount:(NSString *)count {
    self.countLbl.text = NSStringFormat(@"全部帖子(共%@则)",count);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

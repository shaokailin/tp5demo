//
//  LCPublicNotice1Cell.m
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/7.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LCPublicNotice1Cell.h"
@interface LCPublicNotice1Cell()
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeWidth;

@end
@implementation LCPublicNotice1Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ViewBoundsRadius(self.timeLbl, 10);
}
- (void)setupCellContent:(NSString *)title detail:(NSString *)detail time:(NSString *)time {
    self.titleLbl.text = title;
    self.contentLbl.text = detail;
    self.timeLbl.text = NSStringFormat(@"   %@   ",time);
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

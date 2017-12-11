//
//  LCPostHeaderTableViewCell.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/22.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCPostHeaderTableViewCell.h"
@interface LCPostHeaderTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *countLbl;

@end
@implementation LCPostHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setupCount:(NSInteger)count type:(NSInteger)type {
    if (type != 0) {
        self.countLbl.textColor = ColorHexadecimal(0xff0000, 0.6);
        self.countLbl.text = NSStringFormat(@"%zd人打赏了我",count);
    }else {
        self.countLbl.text = NSStringFormat(@"共%zd条",count);
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

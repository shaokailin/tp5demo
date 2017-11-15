//
//  LCRewardRecordHeaderTableViewCell.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCRewardRecordHeaderTableViewCell.h"
@interface LCRewardRecordHeaderTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *orderBtn;
@property (weak, nonatomic) IBOutlet UIButton *recordBtn;
@property (weak, nonatomic) IBOutlet UILabel *moneyLbl;
@property (weak, nonatomic) IBOutlet UILabel *countLbl;

@end
@implementation LCRewardRecordHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setupCellContentWithMoney:(NSString *)money count:(NSString *)count {
    self.moneyLbl.text = money;
    self.countLbl.text = NSStringFormat(@"全部帖子(共%@则)",count);
}
- (void)setupState:(NSInteger)type {
    if (type == 0) {
        self.recordBtn.selected = YES;
        self.orderBtn.selected = NO;
    }else {
        self.recordBtn.selected = NO;
        self.orderBtn.selected = YES;
    }
}
- (IBAction)clickEvent:(id)sender {
    UIButton *senerBtn = (UIButton *)sender;
    if (!senerBtn.selected) {
        NSInteger type = 0;
        if (senerBtn == _orderBtn) {
            self.recordBtn.selected = NO;
            type = 1;
        }else {
            self.orderBtn.selected = NO;
            type = 0;
        }
        if (self.headerBlock) {
            self.headerBlock(type);
        }
        senerBtn.selected = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

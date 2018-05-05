//
//  LCNoticeSettingCell.m
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/3.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LCNoticeSettingCell.h"
@interface LCNoticeSettingCell()
{
    BOOL _currentState;
}
@property (weak, nonatomic) IBOutlet UIButton *switchBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@end
@implementation LCNoticeSettingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _currentState = YES;
}
- (void)setupCellContent:(NSString *)title state:(BOOL)state {
    self.titleLbl.text = title;
    [self changeShowBtn:state];
}
- (IBAction)changeClick:(id)sender {
    if (self.clickBlock) {
        self.clickBlock(self,_currentState);
    }
}
- (void)changeShowBtn:(BOOL)state {
    if (state != _currentState) {
        _currentState = state;
        if (state == YES) {
            [self.switchBtn setBackgroundImage:ImageNameInit(@"on") forState:UIControlStateNormal];
        }else {
            [self.switchBtn setBackgroundImage:ImageNameInit(@"off") forState:UIControlStateNormal];
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

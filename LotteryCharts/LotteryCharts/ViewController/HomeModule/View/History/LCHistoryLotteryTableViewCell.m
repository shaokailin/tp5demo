//
//  LCHistoryLotteryTableViewCell.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/19.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCHistoryLotteryTableViewCell.h"
@interface LCHistoryLotteryTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *issueLbl;
@property (weak, nonatomic) IBOutlet UILabel *numberLbl;
@property (weak, nonatomic) IBOutlet UILabel *number1Lbl;
@property (weak, nonatomic) IBOutlet UILabel *number2Lbl;
@property (weak, nonatomic) IBOutlet UILabel *number3Lbl;

@end
@implementation LCHistoryLotteryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ViewBoundsRadius(self.number1Lbl, 10);
    ViewBoundsRadius(self.number2Lbl, 10);
    ViewBoundsRadius(self.number3Lbl, 10);
}
- (void)setupContentWithTime:(NSString *)time issue:(NSString *)issue testRun:(NSString *)testRun number1:(NSString *)number1 number2:(NSString *)number2 number3:(NSString *)number3 {
    self.timeLbl.text = time;
    [self changeIssueData:issue];
    self.numberLbl.text = testRun;
    self.number1Lbl.text = number1;
    self.number2Lbl.text = number2;
    self.number3Lbl.text = number3;
}
- (void)changeIssueData:(NSString *)issue {
    NSString *content = NSStringFormat(@"第  %@  期",issue);
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:content];
    [attributedString addAttribute:NSForegroundColorAttributeName value:ColorHexadecimal(0x01b9fd, 1.0) range:NSMakeRange(3, issue.length)];
    self.issueLbl.attributedText = attributedString;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

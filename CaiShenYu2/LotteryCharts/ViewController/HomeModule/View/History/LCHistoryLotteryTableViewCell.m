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
@property (weak, nonatomic) IBOutlet UIButton *numberLbl;
@property (weak, nonatomic) IBOutlet UIButton *number1Lbl;
@property (weak, nonatomic) IBOutlet UIButton *number2Lbl;
@property (weak, nonatomic) IBOutlet UIButton *number3Lbl;
@property (weak, nonatomic) IBOutlet UIButton *number4Lbl;
@property (weak, nonatomic) IBOutlet UIButton *number5Lbl;
@property (weak, nonatomic) IBOutlet UILabel *testLbl;
@end
@implementation LCHistoryLotteryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setupContentWithTime:(NSString *)time issue:(NSString *)issue number:(NSString *)number number1:(NSString *)number1 number2:(NSString *)number2 number4:(NSString *)number4  number3:(NSString *)number3 number5:(NSString *)number5 {
    self.timeLbl.text = time;
    [self.numberLbl setTitle:number forState:UIControlStateNormal];
    [self.number1Lbl setTitle:number1 forState:UIControlStateNormal];
    [self.number2Lbl setTitle:number2 forState:UIControlStateNormal];
    [self.number3Lbl setTitle:number3 forState:UIControlStateNormal];
    [self.number4Lbl setTitle:number4 forState:UIControlStateNormal];
    [self.number5Lbl setTitle:number5 forState:UIControlStateNormal];
    [self changeIssueData:issue];
}

- (void)changeIssueData:(NSString *)issue {
    NSString *content = NSStringFormat(@"第 %@ 期",issue);
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:content];
    [attributedString addAttribute:NSForegroundColorAttributeName value:ColorHexadecimal(0x01b9fd, 1.0) range:NSMakeRange(2, issue.length)];
    self.issueLbl.attributedText = attributedString;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

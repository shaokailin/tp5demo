//
//  LCLottery3DView.m
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/9.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCLottery3DView.h"
#import "LC3DLotteryModel.h"
@interface LCLottery3DView ()
@property (weak, nonatomic) IBOutlet UILabel *currentVersionLbl;
@property (weak, nonatomic) IBOutlet UILabel *currentOpenLbl;
@property (weak, nonatomic) IBOutlet UIButton *fistNumberBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondNumBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdNumBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *lastVersionLbl;
@property (weak, nonatomic) IBOutlet UIButton *lastNum1;

@property (weak, nonatomic) IBOutlet UIButton *lastNum2;
@property (weak, nonatomic) IBOutlet UIButton *lastNum3;
@property (weak, nonatomic) IBOutlet UIButton *lastNum4;
@property (weak, nonatomic) IBOutlet UIButton *lastNum5;

@end
@implementation LCLottery3DView
- (void)setupLottertMessage:(NSArray *)data {
    if (KJudgeIsArrayAndHasValue(data)) {
        LC3DLotteryModel *currentModel = [data objectAtIndex:0];
        self.currentVersionLbl.text = NSStringFormat(@"第%@期开奖试机号:",currentModel.period_id);
        NSArray *open1 = [currentModel.lottery_result_kill componentsSeparatedByString:@","];
        if (open1.count >= 1) {
            [self.fistNumberBtn setTitle:[open1 objectAtIndex:0] forState:UIControlStateNormal];
        }
        if (open1.count >= 2) {
            [self.secondNumBtn setTitle:[open1 objectAtIndex:1] forState:UIControlStateNormal];
        }
        if (open1.count >= 3) {
            [self.thirdNumBtn setTitle:[open1 objectAtIndex:2] forState:UIControlStateNormal];
        }
        NSString *str =  [currentModel.test_number stringByReplacingOccurrencesOfString:@"," withString:@""];
        self.currentOpenLbl.text = str;//[open1 componentsJoinedByString:@""];
    }
}
- (void)setupLottertFiveMessage:(LCLotteryFiveModel *)model {
    
    self.lastVersionLbl.text = [NSString stringWithFormat:@"第%@期", model.p_name];
    NSArray *open2 = [model.content componentsSeparatedByString:@","];
    if (open2.count >= 1) {
        [self.lastNum1 setTitle:[open2 objectAtIndex:0] forState:UIControlStateNormal];
    }
    if (open2.count >= 2) {
        [self.lastNum2 setTitle:[open2 objectAtIndex:1] forState:UIControlStateNormal];
    }
    if (open2.count >= 3) {
        [self.lastNum3 setTitle:[open2 objectAtIndex:2] forState:UIControlStateNormal];
    }
    if (open2.count >= 4) {
        [self.lastNum4 setTitle:[open2 objectAtIndex:3] forState:UIControlStateNormal];
    }
    if (open2.count >= 5) {
        [self.lastNum5 setTitle:[open2 objectAtIndex:4] forState:UIControlStateNormal];
    }
}
- (IBAction)moreClick:(id)sender {
    if (self.block) {
        self.block(0);
    }
}
- (IBAction)lastMoreClick:(id)sender {
    if (self.block) {
        self.block(1);
    }
}


@end

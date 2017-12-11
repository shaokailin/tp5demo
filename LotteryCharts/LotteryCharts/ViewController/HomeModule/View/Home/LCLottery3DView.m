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
@property (weak, nonatomic) IBOutlet UILabel *lastOpenLbl;

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
        self.currentOpenLbl.text = [open1 componentsJoinedByString:@""];
        if (data.count >= 2) {
            LC3DLotteryModel *lastModel = [data objectAtIndex:1];
            self.lastVersionLbl.text = NSStringFormat(@"第%@期开奖试机号:",lastModel.period_id);
            NSArray *open2 = [lastModel.lottery_result_kill componentsSeparatedByString:@","];
            self.lastOpenLbl.text = [open2 componentsJoinedByString:@""];
        }
    }
}
- (IBAction)moreClick:(id)sender {
    if (self.block) {
        self.block(YES);
    }
}


@end

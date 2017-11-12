//
//  LCLottery3DView.m
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/9.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCLottery3DView.h"
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

- (IBAction)moreClick:(id)sender {
    if (self.block) {
        self.block(YES);
    }
}


@end

//
//  LCRechargePaySureView.m
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/12.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCRechargePaySureView.h"
@interface LCRechargePaySureView ()
@property (weak, nonatomic) IBOutlet UILabel *moneyLbl;
@property (weak, nonatomic) IBOutlet UILabel *moneyDetailLbl;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;

@end
@implementation LCRechargePaySureView
- (void)awakeFromNib {
    [super awakeFromNib];
    ViewRadius(self.sureBtn, 5.0);
    ViewRadius(self.cancleBtn, 5.0);
    ViewBorderLayer(self.cancleBtn, ColorHexadecimal(0xbfbfbf, 1.0), 1.0);
}
- (IBAction)sureClick:(id)sender {
    if (self.clickBlock) {
        self.clickBlock(1);
    }
}

- (IBAction)canclClick:(id)sender {
    if (self.clickBlock) {
        self.clickBlock(0);
    }
}

- (void)setupPayTypeWithMoney:(NSString *)money number:(NSString *)number {
    self.moneyLbl.text = NSStringFormat(@"￥%@",money);
    self.moneyDetailLbl.text = NSStringFormat(@"您将支付%@元充值%@金币",money,number);
}

@end

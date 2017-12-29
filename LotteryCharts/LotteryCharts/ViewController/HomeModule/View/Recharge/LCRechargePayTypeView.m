//
//  LCRechargePayTypeView.m
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/12.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCRechargePayTypeView.h"
@interface LCRechargePayTypeView ()
@property (weak, nonatomic) IBOutlet UILabel *hidenLbl;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UILabel *detailLbl;

@end
@implementation LCRechargePayTypeView
- (void)awakeFromNib {
    [super awakeFromNib];
    _payType = 0;
    _moreBtn.hidden = YES;
}
- (IBAction)moerPayClick:(id)sender {
    if (self.typeBlock) {
        self.typeBlock(self.payType);
    }
}
- (void)setPayType:(NSInteger)payType {
    if (_payType != payType) {
        _payType = payType;
        if (_payType == 0) {
            self.hidenLbl.hidden = NO;
            self.titleLbl.text = @"微信支付";
            self.detailLbl.text = @"微信支付，安全快捷";
            self.iconImage.image = ImageNameInit(@"wxpay");
        }else {
            self.hidenLbl.hidden = YES;
            self.titleLbl.text = @"支付宝支付";
            self.detailLbl.text = @"支付宝支付，安全快捷";
            self.iconImage.image = ImageNameInit(@"alipay");
        }
    }
}
@end

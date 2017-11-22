//
//  LCGuessHeaderView.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/22.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCGuessHeaderView.h"
@interface LCGuessHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *moneyLbl;
@property (weak, nonatomic) IBOutlet UILabel *countLbl;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *sizeBtn;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
@implementation LCGuessHeaderView

- (void)setupContentTitle:(NSString *)title money:(NSString *)money count:(NSString *)count number1:(NSString *)number1 number2:(NSString *)number2 type:(NSInteger)type {
    if (type == 0) {
        self.sizeBtn.hidden = YES;
        self.rightBtn.hidden = NO;
        self.leftBtn.hidden = NO;
        [self.rightBtn setTitle:number2 forState:UIControlStateNormal];
        [self.leftBtn setTitle:number1 forState:UIControlStateNormal];
    }else {
        self.sizeBtn.hidden = NO;
        self.rightBtn.hidden = YES;
        self.leftBtn.hidden = YES;
    }
    self.titleLbl.text = title;
    self.moneyLbl.text = NSStringFormat(@"押注：%@银币",money);
    self.countLbl.text = NSStringFormat(@"剩余：%@份",count);
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    ViewRadius(self.bgView, 5.0);
    ViewBorderLayer(self.bgView, ColorHexadecimal(0xa0a0a0, 1.0), 1.0);
}

- (IBAction)changeSize:(id)sender {
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}
- (IBAction)sureBtn:(id)sender {
    if (self.hederBlock) {
        self.hederBlock(1);
    }
}

@end

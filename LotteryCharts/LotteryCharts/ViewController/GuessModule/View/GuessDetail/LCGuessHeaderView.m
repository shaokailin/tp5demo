//
//  LCGuessHeaderView.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/22.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCGuessHeaderView.h"
@interface LCGuessHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *moneyLbl;
@property (weak, nonatomic) IBOutlet UILabel *countLbl;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *sizeBtn;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic, assign) CGFloat viewHeight;
@property (nonatomic, assign) CGFloat contentHeight1;
@end
@implementation LCGuessHeaderView
- (void)setupContentWithContent:(NSString *)content height:(CGFloat)height {
    self.contentLbl.text = content;
    self.contentHeight1 = height;
    CGFloat viewheight = 272;
    if (height > 45) {
        if (!self.moreBtn.selected) {
            self.contentHeight.constant = 45;
            self.moreBtn.hidden = NO;
            self.lineView.hidden = NO;
             self.topHeight.constant = 50;
            viewheight = 330;
        }else {
            self.contentHeight.constant = height;
            self.moreBtn.hidden = YES;
            self.lineView.hidden = YES;
            self.topHeight.constant = 30;
            viewheight = 272 + height;
        }
    }else {
        self.moreBtn.hidden = YES;
        self.lineView.hidden = YES;
        self.contentHeight.constant = height;
        self.topHeight.constant = 30;
        viewheight = 272 + height;
    }
    if (_viewHeight != viewheight) {
        _viewHeight = viewheight;
        if (self.frameBlock) {
            self.frameBlock(viewheight);
        }
    }
}
- (void)setupContentTitle:(NSString *)title money:(NSString *)money count:(NSInteger)count number1:(NSString *)number1 number2:(NSString *)number2 type:(NSInteger)type {
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
    self.moneyLbl.text = NSStringFormat(@"挑战：%@银币",money);
    self.countLbl.text = NSStringFormat(@"剩余：%zd份",count);
    
}
- (void)changeCount:(NSInteger)count {
    self.countLbl.text = NSStringFormat(@"剩余：%zd份",count);
}
- (void)hidenEventViewWithAuthor:(BOOL)isAuthor {
    if (isAuthor) {
        self.countField.userInteractionEnabled = NO;
    }else {
        self.countField.userInteractionEnabled = YES;
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    _viewHeight = 272;
    ViewRadius(self.bgView, 5.0);
    ViewBorderLayer(self.bgView, ColorHexadecimal(0xa0a0a0, 1.0), 1.0);
    self.countField.delegate = self;
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
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.isBecome = NO;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.isBecome = YES;
    return YES;
}
- (IBAction)moreClick:(id)sender {
    self.moreBtn.selected = YES;
    self.contentHeight.constant = self.contentHeight1;
    self.moreBtn.hidden = YES;
    self.lineView.hidden = YES;
    self.topHeight.constant = 30;
    _viewHeight = 272 + self.contentHeight1;
    if (self.frameBlock) {
        self.frameBlock(_viewHeight);
    }
//    [self setNeedsLayout];
}
@end

//
//  LCPostVoiceView.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/22.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCPostVoiceView.h"
@interface LCPostVoiceView ()
@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;

@end
@implementation LCPostVoiceView

- (void)awakeFromNib {
    [super awakeFromNib];
    ViewRadius(self.voiceBtn, 75 / 2.0);
    UITapGestureRecognizer *tapView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidenView)];
    [self addGestureRecognizer:tapView];
    [self.voiceBtn addTarget:self action:@selector(hidenView) forControlEvents:UIControlEventTouchUpInside];
    //button长按事件
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
    longPress.minimumPressDuration = 3 * 60; //定义按的时间
    [self.voiceBtn addGestureRecognizer:longPress];
}

-(void)btnLong:(UILongPressGestureRecognizer *)gestureRecognizer{
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
    } else if(gestureRecognizer.state == UIGestureRecognizerStateEnded){
         [self hidenView];
        if (self.voiceBlock) {
            self.voiceBlock(@"123");
        }
    }
}
- (void)hidenView {
    [self removeFromSuperview];
}
@end

//
//  PPSSCircleProgress.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/22.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSCircleProgress.h"
#define LINE_WIDTH 6//环形宽度
#define TEXT_FONT 10.f
@interface PPSSCircleProgress()
@property (nonatomic,assign) float      radius;
@property (nonatomic,assign) CGPoint    centerPoint;
@property (nonatomic,strong) CAShapeLayer *lineLayer;
@property (nonatomic,strong) UILabel  *textLbl;
@end
@implementation PPSSCircleProgress
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]) {
        _radius = CGRectGetWidth(frame) / 2.0 - LINE_WIDTH / 2.0;
        _centerPoint = CGPointMake(CGRectGetWidth(frame) / 2.0, CGRectGetWidth(frame) / 2.0);
        [self createBackLine];
        [self createPercentLayer];
        [self addPresentLable];
    }
    return self;
}
- (void)setProgress:(CGFloat)progress {
    if (progress >= 1) {
        _progress = 1;
    }else {
        _progress = progress;
    }
    self.textLbl.text = [NSString stringWithFormat:@"%d%%",(int)(progress * 100)];
    self.lineLayer.strokeEnd = progress;
}

-(void)createBackLine {
    //绘制背景
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineWidth = LINE_WIDTH;
    shapeLayer.strokeColor = [ColorRGBA(246,246,246,1.0) CGColor];
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    UIBezierPath *path = [UIBezierPath new];
    [path addArcWithCenter:self.centerPoint radius:self.radius startAngle:-M_PI / 2.0 endAngle:M_PI / 2 * 3 clockwise:YES];
    shapeLayer.path = path.CGPath;
    [self.layer addSublayer:shapeLayer];
}
- (void)setStrokeColor:(UIColor *)strokeColor {
    _strokeColor = strokeColor;
    self.lineLayer.strokeColor = strokeColor.CGColor;
}
- (void)addPresentLable {
    self.textLbl = [[UILabel alloc]initWithFrame:CGRectMake(LINE_WIDTH, (CGRectGetHeight(self.bounds) - 20) / 2.0, CGRectGetWidth(self.bounds) - LINE_WIDTH * 2, 20)];
    self.textLbl.textAlignment = 1;
    self.textLbl.font = [UIFont systemFontOfSize:TEXT_FONT];
    self.textLbl.textColor = [UIColor redColor];
    [self addSubview:self.textLbl];
}
-(void)createPercentLayer {
    //绘制环形
    self.lineLayer = [CAShapeLayer layer];
    self.lineLayer.lineWidth = LINE_WIDTH;
    self.lineLayer.lineCap = kCALineCapRound;
    self.lineLayer.fillColor = [[UIColor clearColor] CGColor];
    UIBezierPath *path = [UIBezierPath new];
    [path addArcWithCenter:self.centerPoint radius:self.radius startAngle:-M_PI / 2.0 endAngle:M_PI / 2 * 3  clockwise:YES];
    self.lineLayer.path = path.CGPath;
    self.lineLayer.strokeStart = 0;
    self.lineLayer.strokeEnd = 0;
    [self.layer addSublayer:self.lineLayer];
}
@end

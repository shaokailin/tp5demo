//
//  LSKWebProgressView.m
//  SingleStore
//
//  Created by hsPlan on 2017/9/12.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKWebProgressView.h"

@implementation LSKWebProgressView
{
    CAShapeLayer *_shapeLayer;
    CAGradientLayer *_colorLayer;
    BOOL _isHidenProgressView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customMainView];
    }
    return self;
}
-(void)customMainView
{
//    添加颜色的渐变
    _colorLayer = [[CAGradientLayer alloc]init];
    _colorLayer.frame = self.bounds;
    //设置渐变区域的起始和终止位置（范围为0-1），即渐变路径
    _colorLayer.startPoint = CGPointMake(0, 0.0);
    _colorLayer.endPoint = CGPointMake(1.0, 0.0);
    //设置颜色的渐变过程
    NSMutableArray *gradientLayerColors = [NSMutableArray arrayWithArray:@[(__bridge id)(ColorUtilsString(kWebViewProgressStart_Color)).CGColor, (__bridge id)(ColorUtilsString(kWebViewProgressStart_Color)).CGColor]];
    _colorLayer.colors = gradientLayerColors;
    _colorLayer.locations = [NSArray arrayWithObjects:@(0.4),@(0.6), nil];
    
    [self.layer addSublayer:_colorLayer];
//    添加从0-1的滚动变化 图层
    _shapeLayer = [[CAShapeLayer alloc]init];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0,CGRectGetHeight(self.frame))];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    _shapeLayer.path = path.CGPath;
    _shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    _shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    _shapeLayer.lineWidth = CGRectGetHeight(self.frame);
    _shapeLayer.strokeStart = 0.0;
    _shapeLayer.strokeEnd = 0.0;
    _shapeLayer.lineCap = kCALineCapRound;
    _shapeLayer.lineJoin = kCALineJoinRound;
    self.layer.mask = _shapeLayer;
}

- (void)setProgress:(CGFloat)process {
    _shapeLayer.hidden = NO;
    _shapeLayer.strokeEnd = process;
    if (_isHidenProgressView && process != 0) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hiddenProgress) object:nil];
    }
    if (process == 1) {
        _isHidenProgressView = YES;
        [self performSelector:@selector(hiddenProgress) withObject:nil afterDelay:0.25];
    }
}
- (void)hiddenProgress {
    _isHidenProgressView = NO;
    _shapeLayer.hidden = YES;
    _shapeLayer.strokeEnd = 0;
}
@end

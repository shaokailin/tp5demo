//
//  PPSSAppUpdateView.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/27.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSAppUpdateView.h"

@implementation PPSSAppUpdateView
{
    NSString *_title;
    NSString *_content;
    NSInteger _type;
}
- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content type:(NSInteger)type {
    if (self = [super init]) {
        _title = title;
        _content = content;
        _type = type;
        [self customMainView];
    }
    return self;
}
- (void)showInView {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
- (void)customMainView {
    self.backgroundColor = ColorRGBA(0, 0, 0, 0.75);
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    UIView *contentView = [[UIView alloc]init];
    CGFloat contentHeight = 0;
    ViewRadius(contentView, 10);
    contentView.backgroundColor = COLOR_WHITECOLOR;
    contentView.layer.masksToBounds = YES;
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:@"温馨提示" font:16 textColor:ColorHexadecimal(Color_Text_6666, 1.0)  textAlignment:1 backgroundColor:nil];
    [contentView addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).with.offset(18);
        make.centerX.equalTo(contentView);
    }];
    contentHeight += 36;
    
    UILabel *titleLbl1 = [LSKViewFactory initializeLableWithText:_title font:20 textColor:ColorHexadecimal(Color_APP_MAIN, 1.0) textAlignment:0 backgroundColor:nil];
    [contentView addSubview:titleLbl1];
    [titleLbl1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLbl.mas_bottom).with.offset(25);
        make.left.equalTo(contentView).with.offset(15);
    }];
    contentHeight += 58;
    UIScrollView *contentScroller = [[UIScrollView alloc]init];
    contentScroller.backgroundColor = [UIColor clearColor];
    [contentView addSubview:contentScroller];
    [contentScroller mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLbl1.mas_bottom).with.offset(13);
        make.left.equalTo(contentView.mas_left).with.offset(15);
        make.right.equalTo(contentView).with.offset(-15);
        make.bottom.equalTo(contentView.mas_bottom).with.offset(-48 - 1 - 10);
    }];
    
    CGFloat width = 260 - 30;
    if (KJudgeIsNullData(_content)) {
        _content = [_content stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
        _content = [_content stringByReplacingOccurrencesOfString:@"</p>" withString:@"\n"];
        _content = [_content stringByReplacingOccurrencesOfString:@"@n;" withString:@"\n"];
    }
    CGFloat height = [_content calculateTextHeight:15 width:width] ;
    
    UILabel *textView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    textView.font = FontNornalInit(15);
    textView.textColor = ColorHexadecimal(Color_Text_6666, 1.0);
    textView.text = _content;
    textView.numberOfLines = 0;
    textView.backgroundColor = [UIColor clearColor];
    [contentScroller addSubview:textView];
    
    contentScroller.contentSize = CGSizeMake(width, height + 10);
    
    if (height > 150) {
        contentHeight += 150;
    }else if (height < 100){
        contentHeight += 100;
    }else {
        contentHeight += height;
    }
    
    UIView *lineView = [PPSSPublicViewManager initializeLineView];
    [contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(contentScroller.mas_bottom);
        make.height.mas_equalTo(LINEVIEW_WIDTH);
    }];
    
    UIView *lineView1 = [PPSSPublicViewManager initializeLineView];
    [contentView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom);
        make.bottom.equalTo(contentView);
        make.centerX.equalTo(contentView);
        make.width.mas_equalTo(LINEVIEW_WIDTH);
    }];
    
    NSString *leftString = @"稍后升级";
    NSString *rightString = @"现在升级";
    if (_type == 1) {
        leftString = @"取消升级";
    }
    
    UIButton *leftBtn = [LSKViewFactory initializeButtonWithTitle:leftString nornalImage:nil selectedImage:nil target:self action:@selector(btnClick:) textfont:15 textColor:ColorHexadecimal(Color_Text_6666, 1.0) backgroundColor:nil backgroundImage:nil];
    leftBtn.tag = 201;
    [contentView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(contentView);
        make.top.equalTo(lineView.mas_bottom);
        make.right.equalTo(lineView1.mas_left);
    }];
    
    UIButton *rightBtn = [LSKViewFactory initializeButtonWithTitle:rightString nornalImage:nil selectedImage:nil target:self action:@selector(btnClick:) textfont:15 textColor:ColorHexadecimal(Color_Text_6666, 1.0) backgroundColor:nil backgroundImage:nil];
    rightBtn.tag = 202;
    [contentView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(contentView);
        make.top.equalTo(lineView.mas_bottom);
        make.left.equalTo(lineView1.mas_right);
    }];
    
    [self addSubview:contentView];
    contentHeight += 69;
    WS(ws)
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(260);
        make.center.equalTo(ws);
        make.height.mas_equalTo(contentHeight);
    }];

    
}
- (void)btnClick:(UIButton *)btn {
    if (self.clickblock) {
        self.clickblock(btn.tag - 200);
    }
    [self removeFromSuperview];
}
@end

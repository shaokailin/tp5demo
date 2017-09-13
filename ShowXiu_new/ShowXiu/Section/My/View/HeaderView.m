//
//  HeaderView.m
//  LessonUIConllectionView
//
//  Created by lanouhn on 15/11/30.
//  Copyright (c) 2015年 Li Bangqiang. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

//重写初始化方法,在cell上添加控件
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        //添加控件
//        [self addSubview:self.headerimage];
        [self addSubview:self.textViewLi];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (UITextView *)textViewLi{
    if (!_textViewLi) {
        _textViewLi = [[UITextView alloc]init];
        _textViewLi.frame = CGRectMake(12, 12, kScreen_w - 24, 80);


    }
    return _textViewLi;
}











@end

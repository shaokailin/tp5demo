//
//  keyBoardToolView.m
//  keyBoard
//
//  Created by yangyu on 16/7/5.
//  Copyright © 2016年 yangyu. All rights reserved.
//

#import "keyBoardToolView.h"
#import <QuartzCore/QuartzCore.h>


@interface keyBoardToolView()<UITextViewDelegate>
@property (nonatomic, strong)UIView *imView;
@end
@implementation keyBoardToolView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initWithTextView];
    }
    return self;
}

- (void)initWithTextView {
    
    self.imView = [[UIView alloc]init];
    _imView.frame = CGRectMake(12.5, 5,kScreen_w - 25, 32);
    self.imView.layer.cornerRadius = 12;
    _imView.layer.borderWidth = 1.0;
    _imView.layer.borderColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1].CGColor;
    //self.imView.backgroundColor = [UIColor colorWithRed:249.0/255.0 green:249.0/255.0 blue:249.0/255.0 alpha:1];//设置它的背景颜色
    self.imView.backgroundColor = [UIColor redColor];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0,kScreen_w - 25, 32)];
    self.textView.delegate = self;
    //self.textView.backgroundColor = [UIColor whiteColor];
    
   
   // _textView.layer.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];
    self.textView.font = [UIFont fontWithName:@"PingFang SC" size:15.0];//设置字体名字和字体大小
    self.textView.textColor = [UIColor colorWithRed:186.0/255.0 green:186.0/255.0 blue:186.0/255.0 alpha:1];//设置textview里面的字体颜色
   self.textView.text = @"";
    
    _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.hidden = NO;
    _textView.delegate = self;
    //其次在UITextView上面覆盖个UILable,UILable设置为全局变量。
    
    self.wenLabel = [[UILabel alloc]init];
    
    _wenLabel.frame = CGRectMake(8, 0, kScreen_w - 25, 32);
    _wenLabel.backgroundColor = [UIColor redColor];
    //_wenLabel.text = @"请填写详细地址:";
    _wenLabel.enabled = NO;//lable必须设置为不可用
    _wenLabel.backgroundColor = [UIColor clearColor];
    _wenLabel.font = [UIFont fontWithName:@"PingFang SC" size:14.0];
    //_wenLabel.text = self.string;

    
    
    
    self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _button.frame = CGRectMake(kScreen_w - 78, 0, 53, 32);
    
    
    
    _button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_button setTitle:@"评价" forState:UIControlStateNormal];
    [_button setTintColor:[UIColor colorWithRed:48.0/255.0 green:48.0/255.0 blue:48.0/255.0 alpha:1]];
    [_button addTarget:self action:@selector(Button:) forControlEvents:UIControlEventTouchUpInside];
    UILabel * label = [[UILabel alloc] init];
    label.frame = CGRectMake(kScreen_w - 78, 6, 2, 20);
    label.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255.0 alpha:1];
    
    [self.imView addSubview:self.textView];
    [self.imView addSubview:label];
    [self.imView addSubview:_button];
    [self.imView addSubview:_wenLabel];

    
    [self addSubview:self.imView];
}

- (void)Button:(UIButton *)button{
    if ([_delegate respondsToSelector:@selector(keyBoardToolShouldEndEditing:)]) {
        [_delegate keyBoardToolShouldEndEditing:_textView];
    }
}
- (IBAction)del:(id)sender {
    [_textView deleteBackward];
}


-(void)textViewDidChange:(UITextView *)textView
{
    //self.examineText = textView.text;
    if (textView.text.length == 0) {
        _wenLabel.text = self.string;
    }else{
        _wenLabel.text = @"";
    }
}


//- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
//    if ([_delegate respondsToSelector:@selector(keyBoardToolShouldEndEditing:)]) {
//        [_delegate keyBoardToolShouldEndEditing:textView];
//    }
//    return YES;
//}
@end

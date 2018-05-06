//
//  DKSTextView.m
//  DKSChatKeyboard
//
//  Created by aDu on 2017/9/6.
//  Copyright © 2017年 DuKaiShun. All rights reserved.
//

#import "DKSTextView.h"
#import "UIView+FrameTool.h"

static float textFont = 18; //文案字体大小
@interface DKSTextView ()
@property (nonatomic, weak) UILabel *placeholdLbl;
 /**
 文字最大高度
 */
@property (nonatomic, assign) CGFloat maxTextH;

@end

@implementation DKSTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        if (!self.textFont) {
            self.textFont = [UIFont systemFontOfSize:textFont];
        }
        [self setup];
    }
    return self;
}

- (void)setup {
    UILabel *lbl = [LSKViewFactory initializeLableWithText:@"哈哈哈" font:textFont textColor:ColorHexadecimal(0xa0a0a0, 1.0) textAlignment:0 backgroundColor:nil];
    self.placeholdLbl = lbl;
    lbl.frame = CGRectMake(5, 7, 200, textFont);
    [self addSubview:lbl];
    self.scrollEnabled = NO;
    self.scrollsToTop = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.enablesReturnKeyAutomatically = YES;
    //实时监听textView值得改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
}
- (void)setPlaceholdString:(NSString *)placeholdString {
    _placeholdString = placeholdString;
    self.placeholdLbl.text = placeholdString;
}
#pragma mark ====== 计算高度 ======
//UITextViewDelegate代理, 在这里让textView高度自适应, 同时设置最大高度, 类似于QQ微信输入框的效果
- (void)textDidChange {
    self.placeholdLbl.hidden = self.text.length > 0?YES:NO;
    //计算高度
    CGFloat height = ceilf([self sizeThatFits:CGSizeMake(self.frame.size.width, MAXFLOAT)].height) + 2;
    if (height > _maxTextH) {
        height = _maxTextH;
        self.scrollEnabled = YES;   //当textView大于最大高度的时候让其可以滚动
    } else {
        self.scrollEnabled = NO;
        if (_textChangedBlock && self.scrollEnabled == NO) {
            _textChangedBlock(height);
        }
    }
    [self layoutIfNeeded];
}

#pragma mark ====== 设置placeholder ======
- (void)setMaxNumberOfLines:(NSUInteger)maxNumberOfLines {
    _maxNumberOfLines = maxNumberOfLines;
    /**
     *  根据最大的行数计算textView的最大高度
     *  计算最大高度 = (每行高度 * 总行数 + 文字上下间距)
     */
    _maxTextH = ceil(self.font.lineHeight * maxNumberOfLines + self.textContainerInset.top + self.textContainerInset.bottom);
}

#pragma mark ====== 回调 ======
- (void)textValueDidChanged:(TextHeightChangedBlock)block {
    _textChangedBlock = block;
}

#pragma mark ====== 移除监听 ======
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

//
//  UITextView+Extend.m
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/5.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "UITextView+Extend.h"

@implementation UITextView (Extend)
-(void)setPlaceholder:(NSString *)placeholdStr placeholdColor:(UIColor *)placeholdColor
{
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = placeholdStr;
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = placeholdColor;
    placeHolderLabel.font = self.font;
    [placeHolderLabel sizeToFit];
    [self addSubview:placeHolderLabel];
    
    /*
     [self setValue:(nullable id) forKey:(nonnull NSString *)]
     ps: KVC键值编码，对UITextView的私有属性进行修改
     */
    [self setValue:placeHolderLabel forKey:@"_placeholderLabel"];
}
@end

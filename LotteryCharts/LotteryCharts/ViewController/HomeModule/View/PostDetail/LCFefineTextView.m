//
//  LCFefineTextView.m
//  LotteryCharts
//
//  Created by shaokai lin on 2018/2/7.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LCFefineTextView.h"

@implementation LCFefineTextView

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    // 返回NO为禁用，YES为开启
    // 粘贴
    if (action == @selector(paste:)) return NO;
    // 剪切
    if (action == @selector(cut:)) return NO;
    // 复制
    if (action == @selector(copy:)) return YES;
    // 选择
    if (action == @selector(select:)) return NO;
    // 选中全部
    if (action == @selector(selectAll:)) return NO;
    // 删除
    if (action == @selector(delete:)) return NO;
    // 分享
    if (action == @selector(share)) return NO;
    return NO;
    return [super canPerformAction:action withSender:sender];
}

@end

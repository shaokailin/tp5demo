//
//  LCHomeNoticeView.m
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/9.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCHomeNoticeView.h"
#import "LCHomeNoticeModel.h"
@implementation LCHomeNoticeView
{
    UILabel *_contentLbl;
//    LMJScrollTextView2 * _scrollTextView;
}
- (instancetype)init {
    if (self = [super init]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContent:(NSArray *)content {
//    _dataArray = content;
//    [self.dataArray removeAllObjects];
//    [_scrollTextView stop];
    if (KJudgeIsArrayAndHasValue(content)) {
        LCHomeNoticeModel *model = [content objectAtIndex:0];
        NSString *text = [model.content stringByReplacingOccurrencesOfString:@"&gt;" withString:@""];
        text = [text stringByReplacingOccurrencesOfString:@"&lt;" withString:@""];
        text = [text stringByReplacingOccurrencesOfString:@"/p" withString:@""];
        _contentLbl.text = text;
//        for (LCHomeNoticeModel *model in content) {
//            NSString *text = [model.content stringByReplacingOccurrencesOfString:@"&gt;" withString:@""];
//            text = [text stringByReplacingOccurrencesOfString:@"&lt;" withString:@""];
//            text = [text stringByReplacingOccurrencesOfString:@"/p" withString:@""];
//            [self.dataArray addObject:text];
//        }
    }
//    if (self.dataArray.count > 0) {
//        _scrollTextView.textDataArr = self.dataArray;
//        [_scrollTextView startScrollBottomToTop];
//    }
    
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)_layoutMainView {
    UIImageView *arrowImageView = [[UIImageView alloc]initWithImage:ImageNameInit(@"home_notice")];
    [self addSubview:arrowImageView];
    WS(ws)
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(10);
        make.centerY.equalTo(ws);
        make.width.mas_equalTo(17);
    }];
    
    UILabel *titleLble = [LSKViewFactory initializeLableWithText:@"公告:" font:11 textColor:ColorHexadecimal(0x434343, 1.0) textAlignment:0 backgroundColor:nil];
    [self addSubview:titleLble];
    [titleLble mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(arrowImageView.mas_right).with.offset(5);
        make.centerY.equalTo(ws);
    }];
//    _scrollTextView = [[LMJScrollTextView2 alloc] initWithFrame:CGRectMake(65, 0, SCREEN_WIDTH - 115, 30)];
//    _scrollTextView.delegate        = self;
//    _scrollTextView.textColor       = ColorHexadecimal(0x959595, 1.0);
//    _scrollTextView.textFont        = [UIFont systemFontOfSize:11.f];
//    [self addSubview:_scrollTextView];
    _contentLbl = [LSKViewFactory initializeLableWithText:nil font:11 textColor:ColorHexadecimal(0x959595, 1.0) textAlignment:0 backgroundColor:nil];
    [self addSubview:_contentLbl];
    [_contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(65);
        make.right.equalTo(self).with.offset(-50);
        make.centerY.equalTo(self);
    }];
    UIImageView *arrow = [[UIImageView alloc]initWithImage:ImageNameInit(@"arrow_right")];
    [self addSubview:arrow];
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-10);
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(15);
    }];
}

@end

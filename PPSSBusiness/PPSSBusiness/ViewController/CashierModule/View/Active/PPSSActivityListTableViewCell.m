//
//  PPSSActivityListTableViewCell.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/22.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSActivityListTableViewCell.h"
#import "PPSSCircleProgress.h"
@implementation PPSSActivityListTableViewCell
{
    NSInteger _currentType;
    PPSSCircleProgress *_progressView;
    UILabel *_progressLbl;
    UILabel *_titleLbl;
    UILabel *_timeLbl;
    UILabel *_sendMoneyLbl;
    UILabel *_countLbl;
    UILabel *_totalmoneyLbl;
    UILabel *_activityLbl;
    UIView *_lineView;
    UIImageView *_closeImageView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = 0;
        self.backgroundColor = [UIColor whiteColor];
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContentWithTime:(NSString *)time sendMoney:(NSString *)sendMoney count:(NSString *)count money:(NSString *)money activity:(NSString *)activity type:(NSInteger)type progress:(CGFloat)progress title:(NSString *)title isClose:(BOOL)isClose {
    _timeLbl.text = NSStringFormat(@"有限期至%@",time);
    _sendMoneyLbl.text = NSStringFormat(@"发放余额：%@",sendMoney);
    _countLbl.text = NSStringFormat(@"参与人数：%@",count);
    _totalmoneyLbl.text = NSStringFormat(@"活动总额：%@",money);
    _closeImageView.hidden = isClose;
    if (type == 2) {
        _activityLbl.text = NSStringFormat(@"活动折扣：%@",activity);
    }else {
        _activityLbl.text = NSStringFormat(@"实时活动力度：%@",activity);
    }
    _titleLbl.text = title;;
    if (_currentType != type) {
        _currentType = type;
        [self changeStyle];
    }
    _progressView.progress = progress;
}
- (void)changeStyle {
    UIColor *color = [self returnColorWithType:_currentType];
    _lineView.backgroundColor = color;
    _progressLbl.textColor = color;
    _progressView.strokeColor = color;
}
- (void)_layoutMainView {
    _currentType = -1;
    PPSSCircleProgress *progress = [[PPSSCircleProgress alloc]initWithFrame:CGRectMake(37, 21, 43, 43)];
    _progressView = progress;
    [self.contentView addSubview:progress];
    UIView *lineView = [[UIView alloc]init];
    _lineView = lineView;
    [self.contentView addSubview:lineView];
    WS(ws)
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(ws.contentView);
        make.width.mas_equalTo(3);
    }];
    [progress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.contentView).with.offset(21);
        make.left.equalTo(lineView.mas_right).with.offset(18);
        make.size.mas_equalTo(CGSizeMake(43, 43));
    }];
    
    _progressLbl = [PPSSPublicViewManager initLblForColorPink:@"活动进度" textAlignment:0];
    [self.contentView addSubview:_progressLbl];
    [_progressLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.contentView.mas_bottom).with.offset(-13);
        make.centerX.equalTo(progress);
    }];
    
    UIImageView *dotImg = [[UIImageView alloc]initWithImage:ImageNameInit(@"xuxian_ico")];
    [self.contentView addSubview:dotImg];
    [dotImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(progress.mas_right).with.offset(15);
        make.width.mas_equalTo(LINEVIEW_WIDTH / 2.0);
        make.height.mas_equalTo(96 - 8);
        make.centerY.equalTo(ws.contentView);
    }];

    UIView *textView = [self _layoutContentView];
    [self.contentView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(ws.contentView);
        make.left.equalTo(dotImg.mas_right);
        make.right.equalTo(ws.contentView).with.offset(-15);
    }];
    UIImageView *closeView = [[UIImageView alloc]initWithImage:ImageNameInit(@"activity_close")];
    _closeImageView = closeView;
    _closeImageView.hidden = YES;
    [self.contentView addSubview:closeView];
    [closeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView).with.offset(-15);
        make.width.mas_equalTo(145 / 2.0);
        make.centerY.equalTo(ws.contentView);
    }];
}
- (UIView *)_layoutContentView {
    UIView *textView = [[UIView alloc]init];
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:nil font:14 textColor:ColorHexadecimal(0x323232, 1.0) textAlignment:0 backgroundColor:nil];
    _titleLbl = titleLbl;
    [textView addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textView);
        make.left.equalTo(textView).with.offset(10);
        make.height.mas_equalTo(52);
    }];
    
    _timeLbl = [PPSSPublicViewManager initLblForColor9999:nil];
    [textView addSubview:_timeLbl];
    [_timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(titleLbl);
        make.right.equalTo(textView);
    }];
    
    
    UILabel *sendLbl = [PPSSPublicViewManager initLblForColor6666:nil];
    _sendMoneyLbl = sendLbl;
    sendLbl.font = FontNornalInit(10);
    [textView addSubview:sendLbl];
    [sendLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLbl);
        make.bottom.equalTo(textView.mas_bottom).with.offset(-13);
    }];
    
    
    UILabel *countLbl = [PPSSPublicViewManager initLblForColor6666:nil];
    _countLbl = countLbl;
    countLbl.font = FontNornalInit(10);
    [textView addSubview:countLbl];
    [_countLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sendLbl);
        make.bottom.equalTo(sendLbl.mas_top).with.offset(-8);
    }];
    
    
    UILabel *activityLbl = [PPSSPublicViewManager initLblForColor6666:nil];
    _activityLbl = activityLbl;
    activityLbl.font = FontNornalInit(10);
    [textView addSubview:activityLbl];
    [activityLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(sendLbl);
        make.right.equalTo(textView);
    }];
    
    _totalmoneyLbl = [PPSSPublicViewManager initLblForColor6666:nil];
    _totalmoneyLbl.font = FontNornalInit(10);
    [textView addSubview:_totalmoneyLbl];
    [_totalmoneyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(textView);
        make.top.equalTo(countLbl);
    }];
    
    return textView;
}


- (UIColor *)returnColorWithType:(NSInteger)type {
    UIColor *color = nil;
    switch (type) {
        case 0:
        {
            color = ColorHexadecimal(0xffbf00, 1.0);
            break;
        }
        case 1:
        {
            color = ColorHexadecimal(0x88c3fc, 1.0);
            break;
        }
        case 2:
        {
            color = ColorHexadecimal(0xfe4070, 1.0);
            break;
        }
        default:
            break;
    }
    return color;
}

- (NSString *)returnTitleWithType:(NSInteger)type {
    NSString *title = nil;
    switch (type) {
        case 0:
        {
            title = @"大抢单";
            break;
        }
        case 1:
        {
            title = @"抢饭点";
            break;
        }
        case 2:
        {
            title = @"集点";
            break;
        }
        default:
            break;
    }
    return title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

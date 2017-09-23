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
    UILabel *_remarkLbl;
    UILabel *_countLbl;
    UILabel *_moneyLbl;
    UIView *_lineView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = 0;
        self.backgroundColor = [UIColor whiteColor];
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContentWithTime:(NSString *)time remark:(NSString *)remark count:(NSString *)count money:(NSString *)money type:(NSInteger)type progress:(CGFloat)progress {
    _timeLbl.text = NSStringFormat(@"有限期至%@",time);
    _remarkLbl.text = NSStringFormat(@"活动介绍：%@",remark);
    _countLbl.text = NSStringFormat(@"参与人数(人)：%@",count);
    _moneyLbl.text = NSStringFormat(@"总营业额(元)：%@",money);
    if (_currentType != type) {
        _currentType = type;
        [self changeStyle];
    }
    _progressView.progress = progress;
}
- (void)changeStyle {
    UIColor *color = [self returnColorWithType:_currentType];
    _titleLbl.text = [self returnTitleWithType:_currentType];
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
        make.left.equalTo(lineView.mas_right).with.offset(34);
        make.size.mas_equalTo(CGSizeMake(43, 43));
    }];
    
    _progressLbl = [PPSSPublicViewManager initLblForColorPink:@"活动进度" textAlignment:0];
    [self.contentView addSubview:_progressLbl];
    [_progressLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(progress.mas_bottom).with.offset(12);
        make.centerX.equalTo(progress);
    }];
    
    UIImageView *dotImg = [[UIImageView alloc]initWithImage:ImageNameInit(@"xuxian_ico")];
    [self.contentView addSubview:dotImg];
    [dotImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(progress.mas_right).with.offset(34);
        make.width.mas_equalTo(LINEVIEW_WIDTH / 2.0);
        make.height.mas_equalTo(192 / 2.0);
        make.centerY.equalTo(ws.contentView);
    }];
    
    UIView *textView = [self _layoutContentView];
    [self.contentView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(ws.contentView);
        make.left.equalTo(dotImg.mas_right);
        make.right.equalTo(ws.contentView).with.offset(-15);
    }];
}
- (UIView *)_layoutContentView {
    UIView *textView = [[UIView alloc]init];
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:nil font:12 textColor:ColorHexadecimal(0x323232, 1.0) textAlignment:0 backgroundColor:nil];
    _titleLbl = titleLbl;
    [textView addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textView);
        make.left.equalTo(textView).with.offset(10);
        make.height.mas_equalTo(52);
    }];
    
    _timeLbl = [PPSSPublicViewManager initLblForColor6666:nil];
    [textView addSubview:_timeLbl];
    [_timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(titleLbl);
        make.right.equalTo(textView);
    }];
    
    UILabel *remarkLbl = [PPSSPublicViewManager initLblForColor9999:nil];
    remarkLbl.numberOfLines = 2;
    _remarkLbl = remarkLbl;
    [textView addSubview:remarkLbl];
    [remarkLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(textView).with.offset(10);
        make.top.equalTo(titleLbl.mas_bottom);
        make.right.equalTo(textView);
    }];
    UIView *lineView = [PPSSPublicViewManager initializeLineView];
    [textView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(textView);
        make.bottom.equalTo(textView).with.offset(-12.5);
        make.size.mas_equalTo(CGSizeMake(LINEVIEW_WIDTH, 15));
    }];
    
    _countLbl = [PPSSPublicViewManager initLblForColor6666:nil];
    _countLbl.adjustsFontSizeToFitWidth = YES;
    [textView addSubview:_countLbl];
    [_countLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(textView).with.offset(10);
        make.bottom.equalTo(textView).with.offset(-15);
        make.right.lessThanOrEqualTo(lineView.mas_left).with.offset(15);
    }];
    
    _moneyLbl = [PPSSPublicViewManager initLblForColor6666:nil];
    _moneyLbl.adjustsFontSizeToFitWidth = YES;
    [textView addSubview:_moneyLbl];
    [_moneyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(textView);
        make.bottom.equalTo(textView).with.offset(-15);
        make.left.lessThanOrEqualTo(lineView.mas_right).with.offset(15);
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
        case 3:
        {
            color = ColorHexadecimal(0xff4e5b, 1.0);
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
            title = @"限时抢购";
            break;
        }
        case 3:
        {
            title = @"到店红包";
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

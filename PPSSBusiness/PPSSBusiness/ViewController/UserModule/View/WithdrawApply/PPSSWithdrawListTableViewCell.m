//
//  PPSSWithdrawListTableViewCell.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/21.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSWithdrawListTableViewCell.h"

@implementation PPSSWithdrawListTableViewCell
{
    NSInteger _currentType;
    UILabel *_timeLbl;
    UILabel *_moneyLble;
    UILabel *_stateLbl;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = 0;
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContentWithTime:(NSString *)time money:(NSString *)money type:(NSInteger)type {
    _timeLbl.text = time;
    _moneyLble.text = money;
    if (type != _currentType) {
        _currentType = type;
        [self changeTextColor];
        [self changeText];
    }
}
- (void)changeText {
    if (_currentType == 0) {
        _stateLbl.text = @"审核中";
    }else if (_currentType == 1){
        _stateLbl.text = @"提现成功";
    }else {
        _stateLbl.text = @"审核失败";
    }
}
- (void)changeTextColor {
    if (_currentType != 1) {
        _stateLbl.textColor = ColorHexadecimal(Color_Text_6666, 1.0);
    }else {
        _stateLbl.textColor = ColorHexadecimal(Color_Text_Pink, 1.0);
    }
}

- (void)_layoutMainView {
    _currentType = -1;
    UILabel *titleLbl = [PPSSPublicViewManager initLblForColor6666:@"余额提现"];
    titleLbl.font = FontNornalInit(12);
    [self.contentView addSubview:titleLbl];
    WS(ws)
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).with.offset(15);
        make.top.equalTo(ws.contentView).with.offset(14);
    }];
    
    _timeLbl = [PPSSPublicViewManager initLblForColor9999:nil];
    [self.contentView addSubview:_timeLbl];
    [_timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.contentView.mas_bottom).with.offset(-14);
        make.left.equalTo(ws.contentView).with.offset(15);
    }];
    
    _stateLbl = [PPSSPublicViewManager initLblForColor6666:nil];
    [self.contentView addSubview:_stateLbl];
    [_stateLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView).with.offset(-15);
        make.centerY.equalTo(titleLbl);
    }];
    
    _moneyLble = [PPSSPublicViewManager initLblForColorPink:nil textAlignment:0];
    [self.contentView addSubview:_moneyLble];
    [_moneyLble mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView).with.offset(-15);
        make.bottom.equalTo(ws.contentView.mas_bottom).with.offset(-12);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

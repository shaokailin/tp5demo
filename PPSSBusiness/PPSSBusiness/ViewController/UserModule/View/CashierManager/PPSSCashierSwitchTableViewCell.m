//
//  PPSSCashierSwitchTableViewCell.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/21.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSCashierSwitchTableViewCell.h"

@implementation PPSSCashierSwitchTableViewCell
{
    UILabel *_titleLbl;
    UISwitch *_switchBtn;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = 0;
        [self _layoutMainView];
    }
    return self;
}
- (void)setupSwitchContentWithTitle:(NSString *)title isSwitch:(NSInteger)isSwitch {
    if (isSwitch != -1) {
        _switchBtn.on = isSwitch;
    }
    _titleLbl.text = title;
}
- (void)changeSwithWithState:(NSInteger)state {
    _switchBtn.on = state;
}
- (void)_layoutMainView {
    UILabel *titleLbl = [PPSSPublicViewManager initLblForColor3333:nil textAlignment:0];
    _titleLbl = titleLbl;
    [self.contentView addSubview:titleLbl];
    WS(ws)
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).with.offset(15);
        make.centerY.equalTo(ws.contentView);
        make.width.mas_equalTo(80);
    }];
    _switchBtn = [[UISwitch alloc]init];
    _switchBtn.on = YES;
    [_switchBtn addTarget:self action:@selector(changeSwitch) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_switchBtn];
    [_switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView).with.offset(-15);
        make.centerY.equalTo(ws.contentView);
    }];
}
- (void)changeSwitch {
    if (self.switchBlock) {
        self.switchBlock(self, _switchBtn.on);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

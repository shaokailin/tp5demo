//
//  PPSSIncomeMoneyTableViewCell.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/21.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSIncomeMoneyTableViewCell.h"

@implementation PPSSIncomeMoneyTableViewCell
{
    UILabel *_moneyLbl;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = 0;
        self.backgroundColor = [UIColor whiteColor];
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContentWithMoney:(NSString *)money {
    _moneyLbl.text = money;
}
- (void)_layoutMainView {
    UILabel *titleLbl = [PPSSPublicViewManager initLblForColor3333:@"银行入账(元)" textAlignment:0];
    titleLbl.font = FontBoldInit(14);
    [self.contentView addSubview:titleLbl];
    WS(ws)
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).with.offset(15);
        make.top.equalTo(ws.contentView).with.offset(15);
    }];
    _moneyLbl = [LSKViewFactory initializeLableWithText:@"0.00" font:18 textColor:ColorHexadecimal(Color_Text_Pink, 1.0) textAlignment:0 backgroundColor:nil];
    [self.contentView addSubview:_moneyLbl];
    [_moneyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLbl);
        make.bottom.equalTo(ws.contentView).with.offset(-13);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

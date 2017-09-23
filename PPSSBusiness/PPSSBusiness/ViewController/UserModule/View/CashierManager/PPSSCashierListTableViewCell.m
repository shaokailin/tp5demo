//
//  PPSSCashierListTableViewCell.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/21.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSCashierListTableViewCell.h"

@implementation PPSSCashierListTableViewCell
{
    UILabel *_nameLbl;
    UILabel *_phoneLbl;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = 0;
        [self _layoutMainView];
    }
    return self;
}

- (void)setupContentWithName:(NSString *)name phone:(NSString *)phone {
    _nameLbl.text = name;
    _phoneLbl.text = phone;
}
- (void)_layoutMainView {
    _nameLbl = [PPSSPublicViewManager initLblForColor3333:nil textAlignment:0];
    [self.contentView addSubview:_nameLbl];
    WS(ws)
    [_nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).with.offset(15);
        make.centerY.equalTo(ws.contentView);
    }];
    
    UIImageView *arrowImg = [[UIImageView alloc]initWithImage:ImageNameInit(@"arrow_right")];
    [self.contentView addSubview:arrowImg];
    [arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView).with.offset(-15);
        make.centerY.equalTo(ws.contentView);
        make.width.mas_equalTo(7);
    }];
    
    _phoneLbl = [PPSSPublicViewManager initLblForColor6666:nil];
    [self.contentView addSubview:_phoneLbl];
    [_phoneLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(arrowImg.mas_left).with.offset(-8);
        make.centerY.equalTo(ws.contentView);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

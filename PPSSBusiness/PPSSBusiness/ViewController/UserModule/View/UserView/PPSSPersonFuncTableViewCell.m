//
//  PPSSPersonFuncTableViewCell.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/18.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSPersonFuncTableViewCell.h"

@implementation PPSSPersonFuncTableViewCell
{
    UIImageView *_iconImageView;
    UILabel *_titleLbl;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = 0;
        self.backgroundColor = COLOR_WHITECOLOR;
        [self _laoutMainView];
    }
    return self;
}
- (void)setupCellContentWithTitle:(NSString *)title image:(NSString *)icon {
    _iconImageView.image = ImageNameInit(icon);
    _titleLbl.text = title;
}
- (void)_laoutMainView {
    _iconImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:_iconImageView];
    WS(ws)
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).with.offset(15);
        make.centerY.equalTo(ws.contentView).with.offset(-0.5);
        make.width.mas_equalTo(15);
    }];
    
    _titleLbl = [PPSSPublicViewManager initLblForColor3333:nil textAlignment:0];
    [self.contentView addSubview:_titleLbl];
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImageView.mas_right).with.offset(8);
        make.centerY.equalTo(ws.contentView).with.offset(-0.5);
    }];
    UIImageView *arrow = [[UIImageView alloc]initWithImage:ImageNameInit(@"arrow_right")];
    [self.contentView addSubview:arrow];
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView).with.offset(-15);
        make.centerY.equalTo(ws.contentView).with.offset(-0.5);
        make.width.mas_equalTo(7);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

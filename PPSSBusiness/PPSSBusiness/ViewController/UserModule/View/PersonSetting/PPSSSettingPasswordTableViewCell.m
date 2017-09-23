//
//  PPSSSettingPasswordTableViewCell.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/22.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSSettingPasswordTableViewCell.h"

@implementation PPSSSettingPasswordTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = 0;
        [self _layoutMainView];
    }
    return self;
}
- (void)_layoutMainView {
    UILabel *titleLbl = [PPSSPublicViewManager initLblForColor3333:@"修改密码" textAlignment:0];
    [self.contentView addSubview:titleLbl];
    WS(ws)
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    UILabel *detailLbl = [PPSSPublicViewManager initLblForColor6666:@"请输入密码"];
    [self.contentView addSubview:detailLbl];
    [detailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(arrowImg.mas_left).with.offset(-8);
        make.centerY.equalTo(ws.contentView);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

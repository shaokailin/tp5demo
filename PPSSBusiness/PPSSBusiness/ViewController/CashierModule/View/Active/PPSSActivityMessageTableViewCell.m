//
//  PPSSActivityMessageTableViewCell.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/22.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSActivityMessageTableViewCell.h"

@implementation PPSSActivityMessageTableViewCell
{
    UIImageView *_iconImg;
    UILabel *_titleLbl;
    UILabel *_detailLbl;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = 0;
        self.backgroundColor = [UIColor whiteColor];
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContentWithTitle:(NSString *)title detail:(NSString *)detail icon:(NSString *)icon {
    _titleLbl.text = title;
    _detailLbl.text = detail;
    _iconImg.image = ImageNameInit(icon);
}

- (void)_layoutMainView {
    UIImageView *iconImg = [[UIImageView alloc]init];
    _iconImg = iconImg;
    [self.contentView addSubview:iconImg];
    WS(ws)
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).with.offset(15);
        make.centerY.equalTo(ws.contentView);
        make.width.mas_equalTo(40);
    }];
    
    UILabel *titleLbl = [PPSSPublicViewManager initLblForColor3333:nil textAlignment:0];
    _titleLbl = titleLbl;
    [self.contentView addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImg.mas_right).with.offset(8);
        make.top.equalTo(ws.contentView).with.offset(24);
    }];
    
    UIButton *btn = [PPSSPublicViewManager initAPPThemeBtn:@"添加活动" font:10 target:self action:@selector(addActivityAction)];
    ViewRadius(btn, 3.0);
    [self.contentView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView).with.offset(-15);
        make.centerY.equalTo(ws.contentView);
        make.size.mas_equalTo(CGSizeMake(75, 25));
    }];
    
    UILabel *detailLbl = [PPSSPublicViewManager initLblForColor6666:nil];
    detailLbl.numberOfLines = 2;
    _detailLbl = detailLbl;
    [self.contentView addSubview:detailLbl];
    [detailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLbl.mas_left);
        make.top.equalTo(titleLbl.mas_bottom).with.offset(9);
        make.right.mas_equalTo(btn.mas_left).with.offset(-10);
    }];
}
- (void)addActivityAction {
    if (self.addBlock) {
        self.addBlock(self);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  PPSSPPSSActivityDetailHeader2TableViewCell.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/22.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSActivityDetailHeader2TableViewCell.h"

@implementation PPSSActivityDetailHeader2TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = 0;
        self.backgroundColor = [UIColor clearColor];
        [self _layoutMainView];
    }
    return self;
}
- (void)_layoutMainView {
    UIButton *btn = [PPSSPublicViewManager initAPPThemeBtn:@"添加时间段" font:12 target:self action:@selector(addTimeClick)];
    ViewRadius(btn, 3.0);
    [self.contentView addSubview:btn];
    WS(ws)
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).with.offset(15);
        make.centerY.equalTo(ws.contentView);
        make.size.mas_equalTo(CGSizeMake(70, 25));
    }];
}
- (void)addTimeClick {
    if (self.addBlock) {
        self.addBlock(0);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

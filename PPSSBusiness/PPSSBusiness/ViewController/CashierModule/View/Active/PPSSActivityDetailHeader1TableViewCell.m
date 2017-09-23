//
//  PPSSPPSSActivityDetailHeader1TableViewCell.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/22.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSActivityDetailHeader1TableViewCell.h"

@implementation PPSSActivityDetailHeader1TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = 0;
        self.backgroundColor = [UIColor clearColor];
        [self _layoutMainView];
    }
    return self;
}
- (void)_layoutMainView {
    UILabel *titleLbl = [PPSSPublicViewManager initLblForColor9999:@"活动时间"];
    titleLbl.font = FontNornalInit(12);
    [self.contentView addSubview:titleLbl];
    WS(ws)
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).with.offset(15);
        make.centerY.equalTo(ws.contentView);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

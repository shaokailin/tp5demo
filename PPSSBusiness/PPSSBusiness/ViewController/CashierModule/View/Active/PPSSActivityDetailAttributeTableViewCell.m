//
//  PPSSPPSSActivityDetailAttributeTableViewCell.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/22.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSActivityDetailAttributeTableViewCell.h"

@implementation PPSSActivityDetailAttributeTableViewCell
{
    UILabel *_leftLbl;
    UILabel *_rightLbl;
    NSInteger _currentType;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = 0;
        self.backgroundColor = [UIColor whiteColor];
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContentWithSuport:(NSString *)support {
    if (KJudgeIsNullData(support)) {
        _rightLbl.text = support;
    }
}
- (void)setupSuportType:(NSInteger)type {
    if (_currentType != type) {
        _currentType = type;
        if (_currentType == 1) {
            _leftLbl.text = @"活动力度";
        }else {
            _leftLbl.text = @"活动折扣";
        }
    }
}
- (void)_layoutMainView {
    _currentType = -1;
    WS(ws)
    UILabel *leftLble = [PPSSPublicViewManager initLblForColor3333:nil textAlignment:0];
    _leftLbl = leftLble;
    _leftLbl.font = FontBoldInit(12);
    [self.contentView addSubview:_leftLbl];
    [_leftLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.contentView);
        make.left.equalTo(ws.contentView).with.offset(15);
    }];
    
    UIButton *requestBtn = [PPSSPublicViewManager initBtnWithNornalImage:@"question" target:self action:@selector(showRuleClick)];
    [self.contentView addSubview:requestBtn];
    [requestBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftLble.mas_right);
        make.centerY.equalTo(leftLble);
        make.size.mas_equalTo(CGSizeMake(16 + 15, 31));
    }];
    
    UIImageView *arrow = [[UIImageView alloc]initWithImage:ImageNameInit(@"arrow_right")];
    [self.contentView addSubview:arrow];
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView).with.offset(-15);
        make.centerY.equalTo(ws.contentView);
        make.width.mas_equalTo(7);
    }];
    _rightLbl = [PPSSPublicViewManager initLblForColor6666:@"请选择"];
    [self.contentView addSubview:_rightLbl];
    [_rightLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(arrow.mas_left).with.offset(-8);
        make.centerY.equalTo(ws.contentView);
    }];
}
- (void)showRuleClick {
    if (self.intensityBlock) {
        self.intensityBlock(0);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

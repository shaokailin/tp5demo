//
//  PPSSActivityDetailTimeTableViewCell.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/22.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSActivityDetailTimeTableViewCell.h"

@implementation PPSSActivityDetailTimeTableViewCell
{
    UILabel *_titleLbl;
    UIButton *_startBtn;
    UIButton *_endBtn;
    UIButton *_deleteBtn;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = 0;
        self.backgroundColor = [UIColor whiteColor];
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContentWithStart:(NSString *)start end:(NSString *)end isShowDele:(BOOL)isShow index:(NSInteger)index {
    if ([start isHasValue]) {
        [_startBtn setTitle:start forState:UIControlStateNormal];
    }
    if ([end isHasValue]) {
        [_endBtn setTitle:end forState:UIControlStateNormal];
    }
    _deleteBtn.hidden = !isShow;
    _titleLbl.text = NSStringFormat(@"时间段%ld",index);
}
- (void)_layoutMainView {
    UILabel *titleLbl = [PPSSPublicViewManager initLblForColor3333:nil textAlignment:0];
    titleLbl.font = FontBoldInit(12);
    _titleLbl = titleLbl;
    [self.contentView addSubview:titleLbl];
    WS(ws)
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).with.offset(15);
        make.centerY.equalTo(ws.contentView);
    }];
    
    UIButton *startBtn = [PPSSPublicViewManager initAPPThemeBtn:@"开始时间" font:10 target:self action:@selector(selectStartTime)];
    ViewRadius(startBtn, 3.0);
    startBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    startBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
    _startBtn = startBtn;
    [self.contentView addSubview:startBtn];
    [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLbl.mas_right).with.offset(WIDTH_RACE_6S(20));
        make.centerY.equalTo(ws.contentView);
        make.width.mas_equalTo(WIDTH_RACE_6S(100));
        make.height.mas_equalTo(20);
    }];
    
    UILabel *daoLbl = [PPSSPublicViewManager initLblForColor6666:@"到"];
    daoLbl.textAlignment = 1;
    [self.contentView addSubview:daoLbl];
    [daoLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(startBtn.mas_right);
        make.centerY.equalTo(ws.contentView);
        make.width.mas_equalTo(WIDTH_RACE_6S(23));
    }];
    
    UIButton *endBtn = [PPSSPublicViewManager initAPPThemeBtn:@"结束时间" font:10 target:self action:@selector(selectEndTime)];
    ViewRadius(endBtn, 3.0);
    endBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    endBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
    _endBtn = endBtn;
    [self.contentView addSubview:endBtn];
    [endBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(daoLbl.mas_right);
        make.centerY.equalTo(ws.contentView);
        make.width.mas_equalTo(WIDTH_RACE_6S(100));
        make.height.mas_equalTo(20);
    }];
    _deleteBtn = [PPSSPublicViewManager initBtnWithNornalImage:@"jianshijian_ico" target:self action:@selector(deleteTimeClick)];
    [self.contentView addSubview:_deleteBtn];
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView).with.offset(-8);
        make.size.mas_equalTo(CGSizeMake(27, 27));
        make.centerY.equalTo(ws.contentView);
    }];
}
- (void)selectStartTime {
    if (self.exitBlock) {
        self.exitBlock(self,ActivityTimeExitType_Start);
    }
}
- (void)selectEndTime {
    if (self.exitBlock) {
        self.exitBlock(self,ActivityTimeExitType_End);
    }
}
- (void)deleteTimeClick {
    if (self.exitBlock) {
        self.exitBlock(self,ActivityTimeExitType_Delete);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

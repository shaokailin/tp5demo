//
//  PPSSActivitySelectTableViewCell.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/22.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSActivitySelectTableViewCell.h"

@implementation PPSSActivitySelectTableViewCell
{
    NSInteger _currentSelect;
    NSInteger _lastSelect;
    UIView *_lineView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = 0;
        self.backgroundColor = [UIColor clearColor];
        [self _layoutMainView];
    }
    return self;
}
- (void)_layoutMainView {
    _currentSelect = 0;
    _lastSelect = 0;
    UIButton *allBtn = [self customBtn:@"全部" tag:200];
    allBtn.selected = YES;
    [self.contentView addSubview:allBtn];
    UIButton *ingBtn = [self customBtn:@"进行中" tag:201];
    [self.contentView addSubview:ingBtn];
    UIButton *unBtn = [self customBtn:@"未开始" tag:202];
    [self.contentView addSubview:unBtn];
    UIButton *hasBtn = [self customBtn:@"已完成" tag:203];
    [self.contentView addSubview:hasBtn];
    WS(ws)
    [allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(ws.contentView);
        make.top.equalTo(ws.contentView).with.offset(10);
    }];
    
    [ingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(allBtn.mas_right);
        make.top.bottom.width.equalTo(allBtn);
    }];
    [unBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ingBtn.mas_right);
        make.top.bottom.width.equalTo(ingBtn);
    }];
    
    [hasBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(unBtn.mas_right);
        make.top.bottom.width.equalTo(unBtn);
        make.right.equalTo(ws.contentView);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = ColorHexadecimal(Color_APP_MAIN, 1.0);
    _lineView = lineView;
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.contentView);
        make.size.mas_equalTo(CGSizeMake(50, 2));
        make.centerX.equalTo(allBtn.mas_centerX);
    }];
    
}
- (UIButton *)customBtn:(NSString *)title tag:(NSInteger)tag {
    UIButton *btn = [LSKViewFactory initializeButtonWithTitle:title nornalImage:nil selectedImage:nil target:self action:@selector(selectShowAction:) textfont:12 textColor:ColorHexadecimal(Color_Text_6666, 1.0) backgroundColor:COLOR_WHITECOLOR backgroundImage:nil];
    btn.tag = tag;
    return btn;
}
- (void)selectShowAction:(UIButton *)btn {
    if (!btn.selected) {
        _lastSelect = _currentSelect;
        _currentSelect = btn.tag - 200;
        UIButton *otherBtn = [self viewWithTag:_lastSelect + 200];
        if (otherBtn) {
            otherBtn.selected = NO;
        }
        btn.selected = YES;
        if (self.selectBlock) {
            self.selectBlock(_currentSelect);
        }
        [self updateLineCenter];
    }
}
- (void)updateLineCenter {
    UIButton *otherBtn = [self viewWithTag:_currentSelect + 200];
    WS(ws)
    [_lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.contentView);
        make.size.mas_equalTo(CGSizeMake(50, 2));
        make.centerX.equalTo(otherBtn.mas_centerX);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

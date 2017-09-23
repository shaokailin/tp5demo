//
//  PPSSActivityDetailInputTableViewCell.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/22.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSActivityDetailInputTableViewCell.h"
static const NSInteger kMAX_LIMIT_NUMS = 1000;
@interface PPSSActivityDetailInputTableViewCell()<UITextViewDelegate>
@property (nonatomic, weak) UITextView *textView;
@property (nonatomic, weak) UILabel *placeholdLbl;
@property (nonatomic, weak) UILabel *limitLbl;
@end
@implementation PPSSActivityDetailInputTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = 0;
        self.backgroundColor = [UIColor whiteColor];
        [self _layoutMainView];
    }
    return self;
}
- (void)_layoutMainView {
    UILabel *titleLble = [PPSSPublicViewManager initLblForColor3333:@"活动介绍" textAlignment:0];
    titleLble.font = FontBoldInit(12);
    [self.contentView addSubview:titleLble];
    WS(ws)
    [titleLble mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).with.offset(15);
        make.top.equalTo(ws.contentView);
        make.height.mas_equalTo(44);
    }];
    
    UIView *inputView = [[UIView alloc]init];
    ViewRadius(inputView, 3.0);
    ViewBorderLayer(inputView, ColorHexadecimal(kMainBackground_Color, 1.0), LINEVIEW_WIDTH);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(textViewBecomeFirst)];
    [inputView addGestureRecognizer:tap];
    UITextView *textView = [[UITextView alloc]init];
    textView.delegate = self;
    textView.textColor = ColorHexadecimal(Color_Text_3333, 1.0);
    textView.font = FontNornalInit(10);
    self.textView = textView;
    [inputView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(inputView).with.insets(UIEdgeInsetsMake(0, 0, 25, 0));
    }];
    
    UILabel *placeholdLbl = [PPSSPublicViewManager initLblForColor6666:@"请输入活动介绍"];
    self.placeholdLbl = placeholdLbl;
    [textView addSubview:placeholdLbl];
    [placeholdLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(textView).with.offset(5);
        make.top.equalTo(textView).with.offset(8);
    }];
    
    UILabel *limitLbl = [PPSSPublicViewManager initLblForColor9999:@"0/1000"];
    self.limitLbl = limitLbl;
    [inputView addSubview:limitLbl];
    [limitLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(inputView.mas_right).with.offset(-10);
        make.top.equalTo(textView.mas_bottom);
        make.bottom.equalTo(inputView);
    }];
    
    [self.contentView addSubview:inputView];
    [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).with.offset(15);
        make.top.equalTo(titleLble.mas_bottom);
        make.bottom.equalTo(ws.contentView).with.offset(-20);
        make.right.equalTo(ws.contentView).with.offset(-15);
    }];
    
}

- (void)textViewBecomeFirst {
    [self.textView becomeFirstResponder];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    NSInteger caninputlen = kMAX_LIMIT_NUMS - comcatstr.length;
    if (caninputlen >= 0) {
        return YES;
    } else {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        if (rg.length > 0) {
            NSString *s = [text substringWithRange:rg];
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
    
}

- (void)textViewDidChange:(UITextView *)textView {
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    if (existTextNum > kMAX_LIMIT_NUMS){
        //截取到最大位置的字符
        NSString *s = [nsTextContent substringToIndex:kMAX_LIMIT_NUMS];
        [textView setText:s];
    }
    //不让显示负数
    self.limitLbl.text = [NSString stringWithFormat:@"%ld/%ld",existTextNum,kMAX_LIMIT_NUMS];
    self.placeholdLbl.hidden = existTextNum > 0 ? YES:NO;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  MessTxtContentTableViewCell.m
//  SunShine
//
//  Created by 阳光互联 on 16/8/31.
//  Copyright © 2016年 阳光互联. All rights reserved.
//

#import "MessTiShiTableViewCell.h"
#import "UIImage+Extension.h"

#import "MessageSSModel.h"
#import <YYLabel.h>
#import "NSAttributedString+YYText.h"

//#import "UIImage+Extension.h"
#import "Utility.h"
//#import "MessFriendManager.h"

@interface MessTiShiTableViewCell ()
@property(nonatomic,copy) NSString * myHeadimage;
@property(nonatomic,copy) NSString * frindImage;
@property(nonatomic, strong)YYLabel *label;
@end

@implementation MessTiShiTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubViews];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Messagesuccesyincang:) name:@"Messagesuccesyincang" object:nil];
        UITapGestureRecognizer * tapmess = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browerImagehid:)];
        [self addGestureRecognizer:tapmess];
        self.backgroundColor= [UIColor redColor];
        
    }
    return self;
}
- (void)browerImagehid:(UITapGestureRecognizer*)tapp{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"chongzhiVIP" object:nil];

}
-(void)Messagesuccesyincang:(NSNotification *)obj{
    self.deleViwq.hidden = YES;
    _deleBbbtn.hidden = YES;
}



- (void)initSubViews{
    self.tiView = [UIView new];
    _tiView.backgroundColor = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1];
    _tiView.layer.cornerRadius = 5;
    _tiView.layer.masksToBounds = YES;
    self.label = [YYLabel new];
    self.headBtn = [[UIButton alloc]init];
    _headBtn.backgroundColor = [UIColor redColor];
    _label.userInteractionEnabled = YES;
    [self.contentView addSubview:_headBtn];
    [self.contentView addSubview:_tiView];
    [self.tiView addSubview:_label];
    
    
}

- (void)setMessFriendModel:(MessageSSModel *)messFriendModel{
    _messFriendModel = messFriendModel;
    [self setMessageFrame]; //设置内容
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setMessageFrame{//设置内容
 
    // 1、计算文字的宽高
    if (_messFriendModel.content&&![_messFriendModel.content isEqualToString:@""]) {
        if ([_messFriendModel.content isEqualToString:@"对不起，您发的联系信息已被系统屏蔽，对方无法接收，请购买vip"]) {
            
            NSString *string = [NSString stringWithFormat:@"%@",_messFriendModel.content];
            CGFloat content_h = [HelperClass calculationHeightWithTextsize:14.0 LabelWidth:kScreen_w - 98 WithText:string LineSpacing:0];
            _tiView.frame = CGRectMake(40, 10, kScreen_w - 80, content_h + 12);
            _label.frame = CGRectMake(6, 6, kScreen_w - 98, content_h);
            _backBtn.frame = CGRectMake(6, 6, kScreen_w - 98, content_h);
            _label.numberOfLines = 0;
            _label.alpha = 0.4;
            
            
            //属性字符串 简单实用
            NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:string];
            text.font = [UIFont boldSystemFontOfSize:14.0f];
            text.color = [UIColor blackColor];
//            [text setColor:[UIColor redColor] range:NSMakeRange(25, 6)];
            [text setTextHighlightRange:NSMakeRange(25, 6) color:[UIColor redColor] backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                NSLog(@"%@",text);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"chongzhiVIP" object:nil];

            }];
       
            
            
            _label.attributedText = text;

        }else if([_messFriendModel.content isEqualToString:@"您尝试多次发送联系方式将有可能被封号，请购买vip，无任何限制"]){
            NSString *string = [NSString stringWithFormat:@"%@",_messFriendModel.content];
            CGFloat content_h = [HelperClass calculationHeightWithTextsize:14.0 LabelWidth:kScreen_w - 98 WithText:string LineSpacing:0];
            _tiView.frame = CGRectMake(40, 10, kScreen_w - 80, content_h + 12);
            _label.frame = CGRectMake(6, 6, kScreen_w - 98, content_h);
            _backBtn.frame = CGRectMake(6, 6, kScreen_w - 98, content_h);
            _label.numberOfLines = 0;
            _label.alpha = 0.4;
            
            
            //属性字符串 简单实用
            NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:string];
            text.font = [UIFont boldSystemFontOfSize:14.0f];
            text.color = [UIColor blackColor];
            //            [text setColor:[UIColor redColor] range:NSMakeRange(25, 6)];
            [text setTextHighlightRange:NSMakeRange(19, 6) color:[UIColor redColor] backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                NSLog(@"%@",text);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"chongzhiVIP" object:nil];
                
            }];
            
            
            
            _label.attributedText = text;
        }else {
            NSString *string = [NSString stringWithFormat:@"%@",_messFriendModel.content];
            CGFloat content_h = [HelperClass calculationHeightWithTextsize:14.0 LabelWidth:kScreen_w - 98 WithText:string LineSpacing:0];
            _tiView.frame = CGRectMake(40, 10, kScreen_w - 80, content_h + 12);
            _label.frame = CGRectMake(6, 6, kScreen_w - 98, content_h);
//            _backBtn.frame = CGRectMake(6, 6, kScreen_h - 98, content_h);
            _label.numberOfLines = 0;
            _label.alpha = 0.4;
            
            
            //属性字符串 简单实用
            NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:string];
            text.font = [UIFont boldSystemFontOfSize:14.0f];
            text.color = [UIColor blackColor];
            //            [text setColor:[UIColor redColor] range:NSMakeRange(25, 6)];

            _label.attributedText = text;
        }
        
        
        
        
        
     
  
        
    }
}

- (void)shanchule{
    _deleViwq.hidden = YES;
    _deleBbbtn.hidden = YES;
}
- (void)delefuzhitextcon:(UILongPressGestureRecognizer *)lpgr
{
    _deleViwq.hidden = NO;
    _deleBbbtn.hidden = NO;
}
- (void)fuzhile{
    _deleViwq.hidden = YES;
    _deleBbbtn.hidden = YES;
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    NSString *string = [NSString stringWithFormat:@"%@",_messFriendModel.content];
    
    [pab setString:string];
    
    if (pab == nil) {
        
        
    }else{
        
    }
}
+ (instancetype)cellWithTxtTableView:(UITableView *)tableView{
    static NSString *identifier = @"MessTxtContentTableViewCell";
    MessTiShiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MessTiShiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
+ (CGFloat)heightOfTxtCellWithMessage:(NSString *)textContent nstime:(NSString *)timess{
    NSString *string = [NSString stringWithFormat:@"%@",textContent];

    CGFloat content_h = [HelperClass calculationHeightWithTextsize:14.0 LabelWidth:kScreen_w - 98 WithText:string LineSpacing:0];
    
    return content_h + 32;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

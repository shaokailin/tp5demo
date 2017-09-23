//
//  PPSSOrderHomeTableViewCell.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/18.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSOrderHomeTableViewCell.h"

@implementation PPSSOrderHomeTableViewCell
{
    UILabel *_timeLbl;
    UILabel *_orderNumLbl;
    UILabel *_moneyLbl;
    UILabel *_typeLbl;
    UIImageView *_typeImageView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = COLOR_WHITECOLOR;
        self.selectionStyle = 0;
        [self _layoutMainView];
    }
    return self;
}
- (void)setupCellContentWithTime:(NSString *)timeString orderNum:(NSString *)orderNum money:(NSString *)money type:(NSInteger)type {
    _timeLbl.text = timeString;
    _orderNumLbl.text = orderNum;
    _moneyLbl.text = money;
    [self changeImageAndTypeLblWithType:type];
}
- (void)changeImageAndTypeLblWithType:(NSInteger)type {
    _typeImageView.image = [self returnTypeImage:type];
    _typeLbl.text = [self returnTypeString:type];
    _typeLbl.textColor = [self returnTypeColor:type];
}
- (void)_layoutMainView {
    WS(ws)
    UIImageView *iconImageView = [[UIImageView alloc]init];
    _typeImageView = iconImageView;
    [self.contentView addSubview:iconImageView];
    
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).with.offset(15);
        make.centerY.equalTo(ws.contentView).with.offset(-0.5);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    
    UILabel *timeLbl = [PPSSPublicViewManager initLblForColor3333:nil textAlignment:0];
    _timeLbl = timeLbl;
    [self.contentView addSubview:timeLbl];
    [timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageView.mas_right).with.offset(8);
        make.top.equalTo(ws.contentView).with.offset(14);
    }];
    UILabel *orderLbl = [PPSSPublicViewManager initLblForColor9999:nil];
    _orderNumLbl = orderLbl;
    [self.contentView addSubview:orderLbl];
    [orderLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeLbl.mas_left);
        make.bottom.equalTo(ws.contentView).with.offset(-15);
    }];
    
    UILabel *moneyLble = [PPSSPublicViewManager initLblForColorPink:nil textAlignment:0];
    _moneyLbl = moneyLble;
    [self.contentView addSubview:moneyLble];
    [moneyLble mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView).with.offset(-15);
        make.top.equalTo(timeLbl.mas_top);
    }];
    
    UILabel *typeLle = [PPSSPublicViewManager initLblForColor9999:nil];
    _typeLbl = typeLle;
    [self.contentView addSubview:typeLle];
    [typeLle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(moneyLble);
        make.bottom.equalTo(orderLbl);
    }];
    
}

- (UIImage *)returnTypeImage:(NSInteger)type {
    UIImage *image = nil;
    switch (type) {
        case 0:
        {
            image = ImageNameInit(@"order_unpay");
            break;
        }
        case 1:
        {
            image = ImageNameInit(@"order_chu");
            break;
        }
        case 2:
        {
            image = ImageNameInit(@"order_alipay");
            break;
        }
        case 3:
        {
            image = ImageNameInit(@"order_wx");
            break;
        }
        default:
            image = ImageNameInit(@"order_yu");
            break;
    }
    return image;
}
- (NSString *)returnTypeString:(NSInteger)type {
    NSString *title = nil;
    switch (type) {
        case 0:
        {
            title = @"未支付";
            break;
        }
        case 1:
        {
             title = @"存蓄支付";
            break;
        }
        case 2:
        {
             title = @"支付宝支付";
            break;
        }
        case 3:
        {
             title = @"微信支付";
            break;
        }
        default:
             title = @"余额支付";
            break;
    }
    return title;
}

- (UIColor *)returnTypeColor:(NSInteger) type {
    UIColor *color = nil;
    switch (type) {
        case 0:
        {
            color = ColorHexadecimal(Color_Order_UnPay, 1.0);
            break;
        }
        case 1:
        {
            color = ColorHexadecimal(Color_Order_CHU, 1.0);
            break;
        }
        case 2:
        {
            color = ColorHexadecimal(Color_Order_Alipay, 1.0);
            break;
        }
        case 3:
        {
            color = ColorHexadecimal(Color_Order_WeChat, 1.0);
            break;
        }
        default:
            color = ColorHexadecimal(Color_Order_YUE, 1.0);
            break;
    }
    return color;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

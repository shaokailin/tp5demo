//
//  PPSSOrderHomeTableViewCell.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/18.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSOrderHomeTableViewCell.h"
#import "UIImageView+WebCache.h"
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
- (void)setupCellContentWithName:(NSString *)name timeString:(NSString *)timeString  money:(NSString *)money type:(NSInteger)type photoImage:(NSString *)photoImage {
    if (KJudgeIsNullData(photoImage)) {
        [_typeImageView sd_setImageWithURL:[NSURL URLWithString:photoImage] placeholderImage:ImageNameInit(@"photoerror")];
    }else {
        _typeImageView.image = ImageNameInit(@"nophoto");
    }
    _timeLbl.text = name;
    _orderNumLbl.text = timeString;
    _moneyLbl.text = money;
    [self changeImageAndTypeLblWithType:type];
}
- (void)setupCellContentWithTime:(NSString *)timeString orderNum:(NSString *)orderNum money:(NSString *)money type:(NSInteger)type {
    _timeLbl.text = timeString;
    _orderNumLbl.text = orderNum;
    _moneyLbl.text = money;
    [self changeImageAndTypeLblWithType:type];
}
- (void)changeImageAndTypeLblWithType:(NSInteger)type {
//    _typeImageView.image = [self returnTypeImage:type];
    _typeLbl.text = [PPSSPublicMethod returnPayTypeStringWithType:type];
    _typeLbl.textColor = [self returnTypeColor:type];
}
- (void)_layoutMainView {
    WS(ws)
    UIImageView *iconImageView = [[UIImageView alloc]init];
    ViewBoundsRadius(iconImageView, 5.0);
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
        make.top.equalTo(ws.contentView).with.offset(18);
    }];
    UILabel *orderLbl = [PPSSPublicViewManager initLblForColor9999:nil];
    _orderNumLbl = orderLbl;
    [self.contentView addSubview:orderLbl];
    [orderLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeLbl.mas_left);
        make.bottom.equalTo(ws.contentView).with.offset(-18);
    }];
    
    UILabel *moneyLble = [PPSSPublicViewManager initLblForColorPink:nil textAlignment:0];
    _moneyLbl = moneyLble;
    [self.contentView addSubview:moneyLble];
    [moneyLble mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView).with.offset(-15);
        make.centerY.equalTo(timeLbl.mas_centerY);
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
        case -1:
            image = ImageNameInit(@"order_unpay");
            break;
        case 1:
            image = ImageNameInit(@"order_tong");
            break;
        case 2:
            image = ImageNameInit(@"order_shop");
            break;
        case 3:
            image = ImageNameInit(@"order_alipay");
            break;
        case 4:
            image = ImageNameInit(@"order_wx");
            break;
        default:
            
            break;
    }
    return image;
}

- (UIColor *)returnTypeColor:(NSInteger) type {
    UIColor *color = nil;
    switch (type) {
        case -1:
            color = ColorHexadecimal(Color_Order_UnPay, 1.0);
            break;
        case 1:
            color = ColorHexadecimal(Color_Order_YUE, 1.0);
            break;
        case 2:
            color = ColorHexadecimal(Color_Order_CHU, 1.0);
            break;
        case 3:
            color = ColorHexadecimal(Color_Order_Alipay, 1.0);
            break;
        case 4:
            color = ColorHexadecimal(Color_Order_WeChat, 1.0);
            break;
        default:
            break;
    }
    return color;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

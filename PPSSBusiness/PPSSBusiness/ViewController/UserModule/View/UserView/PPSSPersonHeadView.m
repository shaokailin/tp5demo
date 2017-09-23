//
//  PPSSPersonHeadView.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/15.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSPersonHeadView.h"
#import "UIImageView+WebCache.h"
@interface PPSSPersonHeadView ()
@property (nonatomic, assign) PersonHeaderType type;
@property (nonatomic, weak) UILabel *leftLbl;
@property (nonatomic, weak) UILabel *leftMidLbl;
@property (nonatomic, weak) UILabel *rightMidLbl;
@property (nonatomic, weak) UILabel *rightLbl;
@property (nonatomic, weak) UIImageView *photoImageView;
@property (nonatomic, weak) UILabel *nameLbl;
@property (nonatomic, weak) UILabel *phoneLbl;
@end
@implementation PPSSPersonHeadView

- (instancetype)initWithPersonType:(PersonHeaderType)headerType {
    if (self = [super init]) {
        self.backgroundColor = ColorHexadecimal(Color_APP_MAIN, 1.0);
        _type = headerType;
        [self _layoutMainView];
    }
    return self;
}
#pragma mark - 开放方法
- (void)setupUserPhoto:(NSString *)photo name:(NSString *)name phone:(NSString *)phone {
    if ([photo isHasValue]) {
        [_photoImageView sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:ImageNameInit(@"photoerror")];
    }else {
        _photoImageView.image = ImageNameInit(@"nophoto");
    }
    _nameLbl.text = name;
    _phoneLbl.text = NSStringFormat(@"手机:%@",phone);
}
- (void)setupMessageWithShareMoney:(NSString *)share allAmount:(NSString *)allAmount memberCount:(NSString *)memberCount {
    _leftLbl.text = share;
    _leftMidLbl.text = allAmount;
    _rightMidLbl.text = memberCount;
}

- (void)setupMessageWithConsumeCount:(NSString *)count integral:(NSString *)integral storedValue:(NSString *)storedValue returnCash:(NSString *)returnCash {
    _leftLbl.text = count;
    _leftMidLbl.text = integral;
    _rightMidLbl.text = storedValue;
    _rightLbl.text = returnCash;
}
#pragma mark 界面初始化
- (void)_layoutMainView {
    [self _layoutHeaderMessageView];
    [self _layoutBottonMessageView];
}
- (void)_layoutHeaderMessageView {
    WS(ws)
    UIView *imageShadowView = [[UIView alloc]init];
    imageShadowView.backgroundColor = ColorRGBA(0, 0, 0, 0.1);
    ViewRadius(imageShadowView, 68 / 2.0);
    [self addSubview:imageShadowView];
    [imageShadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(20);
        make.top.equalTo(ws).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(68, 68));
    }];
    UIImageView *userPhotoView = [[UIImageView alloc]initWithImage:ImageNameInit(@"nophoto")];
    self.photoImageView = userPhotoView;
    ViewBoundsRadius(userPhotoView, 65 / 2.0);
    [imageShadowView addSubview:userPhotoView];
    [userPhotoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(imageShadowView);
        make.size.mas_equalTo(CGSizeMake(65, 65));
    }];
    
    UILabel *nameLbl = [LSKViewFactory initializeLableWithText:@"凯先生" font:15 textColor:COLOR_WHITECOLOR textAlignment:0 backgroundColor:nil];
    self.nameLbl = nameLbl;
    [self addSubview:nameLbl];
    [nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageShadowView.mas_right).with.offset(15);
        make.top.equalTo(ws.mas_top).with.offset(22);
    }];
    
    UILabel * phoneLbl = [LSKViewFactory initializeLableWithText:@"手机:18850565545" font:12 textColor:COLOR_WHITECOLOR textAlignment:1 backgroundColor:nil];
    self.phoneLbl = phoneLbl;
    ViewBoundsRadius(phoneLbl, 25 / 2.0);
    ViewBorderLayer(phoneLbl, ColorRGBA(255, 255, 255, 0.2), 1);
    [self addSubview:phoneLbl];
    [phoneLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageShadowView.mas_right).with.offset(13);
        make.top.equalTo(nameLbl.mas_bottom).with.offset(14);
        make.size.mas_equalTo(CGSizeMake(135, 25));
    }];
    
    if (_type == PersonHeaderType_Member) {
//        UIButton *messageBtn = [PPSSPublicViewManager initBtnWithNornalImage:@"usermessage_icon" target:nil action:nil];
//        [[messageBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
//            if (ws.clickBlock) {
//                self.clickBlock(0);
//            }
//        }];
//        [self addSubview: messageBtn];
//        [messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo (ws).with.offset(-15);
//            make.size.mas_equalTo(CGSizeMake(23, 17));
//            make.centerY.equalTo(imageShadowView.mas_centerY);
//        }];
    }
}
- (void)_layoutBottonMessageView {
    WS(ws)
    UIView *footerView = [[UIView alloc]init];
    footerView.backgroundColor = ColorRGBA(0, 0, 0, 0.2);
    
    UILabel *leftTitleLbl = [self customLableView:12 text:[self bottonViewTitleWithIndex:0]];
    [footerView addSubview:leftTitleLbl];
    UILabel *leftLbl = [self customLableView:10 text:@"0"];
    self.leftLbl = leftLbl;
    [footerView addSubview:leftLbl];
    UIView *line1 = [self customLineView];
    [footerView addSubview:line1];
    
    UILabel *leftMidTitleLbl = [self customLableView:12 text:[self bottonViewTitleWithIndex:1]];
    [footerView addSubview:leftMidTitleLbl];
    UILabel *leftMidLbl = [self customLableView:10 text:@"0"];
    self.leftMidLbl = leftMidLbl;
    [footerView addSubview:leftMidLbl];
    UIView *line2 = [self customLineView];
    [footerView addSubview:line2];
    
    UILabel *rightMidTitleLbl = [self customLableView:12 text:[self bottonViewTitleWithIndex:2]];
    [footerView addSubview:rightMidTitleLbl];
    UILabel *rightMidLbl = [self customLableView:10 text:@"0"];
    self.rightMidLbl = rightMidLbl;
    [footerView addSubview:rightMidLbl];
    
    [leftTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footerView.mas_left);
        make.top.equalTo(footerView).with.offset(10);
        make.width.equalTo(leftMidTitleLbl);
    }];
    [leftLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(leftTitleLbl);
        make.bottom.equalTo(footerView.mas_bottom).with.offset(-8);
    }];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftTitleLbl.mas_right);
        make.size.mas_equalTo(CGSizeMake(LINEVIEW_WIDTH, 36));
//        make.width.mas_equalTo(LINEVIEW_WIDTH);
        make.centerY.equalTo(footerView);
    }];
    
    [leftMidTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line1.mas_right);
        make.top.equalTo(leftTitleLbl);
        make.width.equalTo(leftTitleLbl);
    }];
    [leftMidLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(leftMidTitleLbl);
        make.bottom.equalTo(leftLbl.mas_bottom);
    }];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftMidTitleLbl.mas_right);
        make.size.equalTo(line1);
        make.centerY.equalTo(line1);
    }];
    
    if (_type == PersonHeaderType_Member) {
        UIView *line3 = [self customLineView];
        [footerView addSubview:line3];
        UILabel *rightTitleLbl = [self customLableView:12 text:[self bottonViewTitleWithIndex:3]];
        [footerView addSubview:rightTitleLbl];
        UILabel *rightLbl = [self customLableView:10 text:@"0"];
        self.rightLbl = rightLbl;
        [footerView addSubview:rightLbl];
        [rightMidTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(line2.mas_right);
            make.top.equalTo(leftTitleLbl);
            make.width.equalTo(leftMidLbl);
        }];
        [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(rightMidTitleLbl.mas_right);
            make.size.equalTo(line1);
            make.centerY.equalTo(line1);
        }];
        [rightTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(line3.mas_right);
            make.top.equalTo(leftTitleLbl);
            make.right.equalTo(footerView.mas_right);
            make.width.equalTo(rightMidTitleLbl);
        }];
        [rightLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(rightTitleLbl);
            make.bottom.equalTo(leftLbl.mas_bottom);
        }];
        
    }else {
        [rightMidTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(line2.mas_right);
            make.top.equalTo(leftTitleLbl);
            make.right.equalTo(footerView.mas_right);
            make.width.equalTo(leftMidLbl);
        }];
    }
    [rightMidLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(rightMidTitleLbl);
        make.bottom.equalTo(leftLbl.mas_bottom);
    }];
    
    [self addSubview:footerView];
    [footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(ws);
        make.height.mas_equalTo(50);
    }];
}
- (UILabel *)customLableView:(CGFloat)font text:(NSString *)text {
    UILabel *lbl = [LSKViewFactory initializeLableWithText:text font:font textColor:COLOR_WHITECOLOR textAlignment:1 backgroundColor:nil];
    lbl.adjustsFontSizeToFitWidth = YES;
    return lbl;
}
//先的初始化
- (UIView *)customLineView {
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = ColorHexadecimal(0xffffff, 0.2);
    return lineView;
}
//index 按UI 的设计，从左到右
- (NSString *)bottonViewTitleWithIndex:(NSInteger)index {
    NSString *title = nil;
    switch (index) {
        case 0:
        {
            title = _type == PersonHeaderType_Member?@"消费次数":@"直接会员消费分润";
            break;
        }
        case 1:
        {
            title = _type == PersonHeaderType_Member?@"积分":@"直接会员消费总额";
            break;
        }
        case 2:
        {
            title = _type == PersonHeaderType_Member?@"储值":@"直接会员";
            break;
        }
        default:
            title = @"已返金额";
            break;
    }
    return title;
}
@end

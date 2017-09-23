//
//  PPSSShopCardSaveView.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/20.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSShopCardSaveView.h"

@implementation PPSSShopCardSaveView
{
    UIImageView *_qrCodeImage;
}
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = COLOR_WHITECOLOR;
        ViewRadius(self, 5.0);
        [self _layoutMainView];
    }
    return self;
}
- (void)setupImageView:(UIImage *)image {
    _qrCodeImage.image = image;
}
- (BOOL)isHasImage {
    if (_qrCodeImage.image) {
        return YES;
    }else{
        return NO;
    }
}
- (void)_layoutMainView {
    UIImageView *sysIconImgView = [[UIImageView alloc]initWithImage:ImageNameInit(@"sys_icon")];
    [self addSubview:sysIconImgView];
    WS(ws)
    [sysIconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws).with.offset(25);
        make.width.mas_equalTo(342 / 2.0);
        make.centerX.equalTo(ws);
    }];
    
    UIImageView *qrImgView = [[UIImageView alloc]init];
    _qrCodeImage = qrImgView;
    [self addSubview:qrImgView];
    [qrImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sysIconImgView.mas_bottom).with.offset(25);
        make.centerX.equalTo(ws);
        make.size.mas_equalTo(CGSizeMake(kQRImageWidth, kQRImageWidth));
    }];
    
    UIImageView *aliPayImg = [[UIImageView alloc]initWithImage:ImageNameInit(@"zfb_logo")];
    [self addSubview:aliPayImg];
    [aliPayImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(qrImgView);
        make.top.equalTo(qrImgView.mas_bottom).with.offset(35);
        make.width.mas_equalTo(138 / 2.0);
    }];
    
    UIImageView *wxPayImg = [[UIImageView alloc]initWithImage:ImageNameInit(@"wzf_logo")];
    [self addSubview:wxPayImg];
    [wxPayImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(aliPayImg.mas_right).with.offset(15);
        make.centerY.equalTo(aliPayImg);
        make.width.mas_equalTo(208 / 2.0);
    }];
    
}
@end

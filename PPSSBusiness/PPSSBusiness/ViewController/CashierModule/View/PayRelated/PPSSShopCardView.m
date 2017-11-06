//
//  PPSSShopCardView.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/20.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSShopCardView.h"
#import "PPSSShopCardSaveView.h"
#import "LSKImageManager.h"
#import "UIImageView+WebCache.h"
@interface PPSSShopCardView ()
@property (nonatomic, weak) PPSSShopCardSaveView *cardView;
@property (nonatomic, weak) UIButton *saveBtn;
@property (nonatomic, strong) UIImageView *shopIconImageView;

@property (nonatomic, strong) UIImage *shopIconImage;
@end
@implementation PPSSShopCardView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = ColorHexadecimal(Color_APP_MAIN, 1.0);
        [self _layoutMainView];
    }
    return self;
}
- (void)_layoutMainView {
    UIView *contentView = [[UIView alloc]init];
    contentView.backgroundColor = COLOR_WHITECOLOR;
    ViewRadius(contentView, 5.0);
    CGFloat contentHeight = WIDTH_RACE_6S(25);
    
    PPSSShopCardSaveView *saveCardView = [[PPSSShopCardSaveView alloc]init];
    self.cardView = saveCardView;
    [contentView addSubview:saveCardView];
    [saveCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(contentView).with.offset(contentHeight);
        make.height.mas_equalTo(300 + 50 + 15);
    }];
    
    contentHeight += 365;
    
    UIButton *saveBtn = [PPSSPublicViewManager initAPPThemeBtn:@"保存台卡到相册" font:WIDTH_RACE_6S(13) target:self action:@selector(saveCardClickEvent)];
    ViewRadius(saveBtn, 3.0);
    self.saveBtn = saveBtn;
    [contentView addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(WIDTH_RACE_6S(170), WIDTH_RACE_6S(30)));
        make.top.equalTo(saveCardView.mas_bottom);
        make.centerX.equalTo(contentView);
    }];
    contentHeight += WIDTH_RACE_6S(30);
    contentHeight += WIDTH_RACE_6S(30);
    
    [self addSubview:contentView];
    WS(ws)
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws).with.offset(WIDTH_RACE_6S(30));
        make.centerX.equalTo(ws);
        make.size.mas_equalTo(CGSizeMake(300, contentHeight));
    }];
    
    UIButton *applyBtn = [LSKViewFactory initializeButtonWithTitle:@"分享给好友" nornalImage:nil selectedImage:nil target:nil action:nil textfont:13 textColor:ColorHexadecimal(Color_APP_MAIN, 1.0) backgroundColor:COLOR_WHITECOLOR backgroundImage:nil];
    ViewRadius(applyBtn, 3.0);
    self.applyBtn = applyBtn;
    [self addSubview:applyBtn];
    [applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_bottom).with.offset(WIDTH_RACE_6S(44));
        make.size.mas_equalTo(CGSizeMake(WIDTH_RACE_6S(100), WIDTH_RACE_6S(30)));
        make.centerX.equalTo(ws);
    }];
    
    if (KJudgeIsNullData(KUserMessageManager.logo)) {
        self.shopIconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        ViewBorderLayer(self.shopIconImageView, COLOR_WHITECOLOR, 2.0);
        ViewBoundsRadius(self.shopIconImageView, 5.0);
        [self loadShopIcon];
    }else {
        [self.cardView setupImageView:[LSKImageManager initializeQRCodeImage:KUserMessageManager.qcode size:CGSizeMake(kQRImageWidth, kQRImageWidth)]];
    }
}
- (void)setShopName:(NSString *)shopName {
    self.cardView.shopName = shopName;
}
- (void)saveCardClickEvent {
    if (self.cardView.hasImage) { UIImageWriteToSavedPhotosAlbum(self.saveImage,self,@selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:),nil);
    }else {
        [SKHUD showLoadingDotInView:self];
        [self loadShopIcon];
    }
}
- (void)loadShopIcon {
    
    @weakify(self)
    [self.shopIconImageView sd_setImageWithURL:[NSURL URLWithString:KUserMessageManager.logo] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [SKHUD dismiss];
        @strongify(self)
        if (error) {
            [self.saveBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        }else {
            self.shopIconImageView.image = image;
            [self.saveBtn setTitle:@"保存台卡到相册" forState:UIControlStateNormal];
            [self.cardView setupImageView:[LSKImageManager qrImageForString:KUserMessageManager.qcode imageSize:kQRImageWidth logoImageSize:40 icon:self.shopIconImage]];
        }
    }];
}
- (UIImage *)shopIconImage {
    if (!_shopIconImage) {
        UIGraphicsBeginImageContextWithOptions(self.shopIconImageView.bounds.size, NO, 0.0); //currentView 当前的view  创建一个基于位图的图形上下文并指定大小为
        [self.shopIconImageView.layer renderInContext:UIGraphicsGetCurrentContext()];//renderInContext呈现接受者及其子范围到指定的上下文
        UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();//返回一个基于当前图形上下文的图片
        UIGraphicsEndImageContext();//移除栈顶的基于当前位图的图形上下文
        _shopIconImage = viewImage;
    }
    return _shopIconImage;
}
- (UIImage *)saveImage {
    if (!_saveImage) {
        UIGraphicsBeginImageContextWithOptions(self.cardView.bounds.size, NO, 0.0); //currentView 当前的view  创建一个基于位图的图形上下文并指定大小为
        [self.cardView.layer renderInContext:UIGraphicsGetCurrentContext()];//renderInContext呈现接受者及其子范围到指定的上下文
        UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();//返回一个基于当前图形上下文的图片
        UIGraphicsEndImageContext();//移除栈顶的基于当前位图的图形上下文
        _saveImage = viewImage;
    }
    return _saveImage;
}
#pragma mark 保存图片后的回调
- (void)imageSavedToPhotosAlbum:(UIImage*)image didFinishSavingWithError:  (NSError*)error contextInfo:(id)contextInfo {
    if (!error) {
        [SKHUD showMessageInView:self.superview withMessage:@"保存成功!~"];
    }else {
        if (error.code == -3310) {
            [SKHUD showMessageInView:self.superview withMessage:@"保存失败!!~您不允许访问相册,请到设置界面开启才能保存!"];
        }else {
            [SKHUD showMessageInView:self.superview withMessage:@"保存失败!!"];
        }
    }
}
@end

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
#import "SGQRCodeGenerateManager.h"
@interface PPSSShopCardView ()
@property (nonatomic, weak) PPSSShopCardSaveView *cardView;
@property (nonatomic, weak) UIButton *saveBtn;
@property (nonatomic, strong) UIImage *saveImage;
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
        make.height.mas_equalTo(300 + 50);
    }];
    
    contentHeight += 350;
    
    UIButton *saveBtn = [PPSSPublicViewManager initAPPThemeBtn:@"保存台卡到相册" font:WIDTH_RACE_6S(13) target:self action:@selector(saveCardClickEvent)];
    ViewRadius(saveBtn, 3.0);
    self.saveBtn = saveBtn;
    [contentView addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(170, WIDTH_RACE_6S(30)));
        make.top.equalTo(saveCardView.mas_bottom);
        make.centerX.equalTo(contentView);
    }];
    contentHeight += WIDTH_RACE_6S(30);
    contentHeight += WIDTH_RACE_6S(49);
    
    [self addSubview:contentView];
    WS(ws)
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws).with.offset(WIDTH_RACE_6S(30));
        make.centerX.equalTo(ws);
        make.size.mas_equalTo(CGSizeMake(300, contentHeight));
    }];
    
    contentHeight += WIDTH_RACE_6S(30);
    
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:@"申请台卡物料" font:13 textColor:COLOR_WHITECOLOR textAlignment:1 backgroundColor:nil];
    titleLbl.font = FontBoldInit(WIDTH_RACE_6S(13));
    [self addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_bottom).with.offset(WIDTH_RACE_6S(18));
        make.centerX.equalTo(ws);
    }];
    
    UILabel *remarkLbl = [LSKViewFactory initializeLableWithText:@"注：申请台卡注意事项，如一家门店只能免费申请一次台卡。" font:WIDTH_RACE_6S(10) textColor:COLOR_WHITECOLOR textAlignment:1 backgroundColor:nil];
    [self addSubview:remarkLbl];
    [remarkLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLbl.mas_bottom).with.offset(WIDTH_RACE_6S(12));
        make.centerX.equalTo(ws);
    }];
    
    [self.cardView setupImageView:[LSKImageManager initializeQRCodeImage:@"https://baidu.com" size:CGSizeMake(kQRImageWidth, kQRImageWidth)]];
}
- (void)saveCardClickEvent {
    if (self.cardView.hasImage) {
 UIImageWriteToSavedPhotosAlbum(self.saveImage,self,@selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:),nil);
    }
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

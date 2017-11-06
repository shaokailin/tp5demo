//
//  PPSSShopCardSaveView.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/20.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
static const CGFloat kQRImageWidth = 171;
@interface PPSSShopCardSaveView : UIView
@property (nonatomic, copy) NSString *shopName;
@property (nonatomic, assign, readonly, getter=isHasImage) BOOL hasImage;
- (void)setupImageView:(UIImage *)image;
@end

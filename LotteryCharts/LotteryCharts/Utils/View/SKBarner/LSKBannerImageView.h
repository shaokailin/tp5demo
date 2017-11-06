//
//  HSPBannerImageView.h
//  HSPlan
//
//  Created by hsPlan on 2017/6/26.
//  Copyright © 2017年 厦门花生计划网络科技公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSKBannerImageView : UIImageView
@property (nonatomic ,copy) NSString *imageWebUrl;
- (instancetype)initWithFrame:(CGRect)frame placeHolderImage:(UIImage *)placeHolderImage;
- (void)loadWebImageView;
@end

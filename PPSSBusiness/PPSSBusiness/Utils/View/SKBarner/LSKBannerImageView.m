//
//  HSPBannerImageView.m
//  HSPlan
//
//  Created by hsPlan on 2017/6/26.
//  Copyright © 2017年 厦门花生计划网络科技公司. All rights reserved.
//

#import "LSKBannerImageView.h"
#import "UIImageView+WebCache.h"
@interface LSKBannerImageView ()
{
    UIImage *_placeHolderImage;
    BOOL isHasSucess;
}
@end
@implementation LSKBannerImageView
-(instancetype)initWithFrame:(CGRect)frame placeHolderImage:(UIImage *)placeHolderImage {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        _placeHolderImage = placeHolderImage;
        self.contentMode = UIViewContentModeScaleAspectFill;
        isHasSucess = NO;
    }
    return self;
}
- (void)loadWebImageView {
    if (!isHasSucess && KJudgeIsNullData(_imageWebUrl)) {
        [self sd_setImageWithURL:[NSURL URLWithString:_imageWebUrl] placeholderImage:_placeHolderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (!error && image) {
                isHasSucess = YES;
            }else
            {
                isHasSucess = NO;
            }
        }];
    }
}

- (void)setImageWebUrl:(NSString *)imageWebUrl {
    if (![_imageWebUrl isEqualToString:imageWebUrl]) {
        isHasSucess = NO;
    }
    _imageWebUrl = imageWebUrl;
}

@end

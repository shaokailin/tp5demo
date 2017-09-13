//
//  SDPhotoBrowser.h
//  photobrowser
//
//  Created by passion on 15-2-3.
//  Copyright (c) 2015年 passion. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SDButton, SDPhotoBrowser;

@protocol SDPhotoBrowserDelegate <NSObject>

@required

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index;

@optional

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index;

@end


@interface SDPhotoBrowser : UIView <UIScrollViewDelegate>

@property (nonatomic, weak) UIView *sourceImagesContainerView;
@property (nonatomic, assign) NSInteger currentImageIndex;
@property (nonatomic, assign) NSInteger imageCount;
@property (nonatomic,assign) BOOL isSaved;
@property (nonatomic,assign) BOOL isShowAnimation;
@property (nonatomic, weak) id<SDPhotoBrowserDelegate> delegate;

- (void)show;

@end

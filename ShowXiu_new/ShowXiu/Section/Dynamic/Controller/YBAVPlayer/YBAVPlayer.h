//
//  YBAVPlayer.h
//  YBAVPlayer
//
//  Created by ch on 2017/3/20.
//  Copyright © 2017年 杨艺博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Masonry.h"
typedef NS_ENUM(NSInteger, YBAVPlayerState) {
    YBAVPlayerStatePlaying,
    YBAVPlayerStatePause
};
@protocol YBAVPlayerDelegate <NSObject>

@optional
- (void)backBtnActionWith:(BOOL)isFullScreen;
- (void)videoEndPlay;
- (void)fullScreenBtnActionWith:(BOOL)isFullScreen;
- (void)autoSwitchHorizontalVerticalScreenWith:(BOOL)isFullScreen;
- (void)videoPlayFail;
- (void)playOrPauseBtnActionWith:(YBAVPlayerState)playState;
@end

@interface YBAVPlayer : UIView

@property (nonatomic, assign) id<YBAVPlayerDelegate>delegate;

- (void)playWith:(NSURL *)videoUrl;
- (void)setVideoName:(NSString *)videoName;
- (void)pause;
- (void)play;
- (void)setVideoPlayViewToFullScreenWith:(CGFloat)angle;

@end

//
//  HSPBarnerScrollView.h
//  HSPlan
//
//  Created by hsPlan on 2017/6/26.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  滚动时间间隔 可以自己修改
 */
static const CGFloat kFGGScrollInterval = 3.0f;

typedef void(^LSKImageClickBlock)(NSInteger selectedIndex);

@interface LSKBarnerScrollView : UIView
/**点击照片的回调*/
@property(nonatomic,copy,readonly)LSKImageClickBlock didSelectedImageAtIndex;
/**
 *  加载网络图片滚动
 *
 *  @param frame    frame
 *  @param didSelectedImageAtIndex 点击图片时回调的block
 *  @return HSPBarnerScrollView对象
 */
-(instancetype)initWithFrame:(CGRect)frame placeHolderImage:(UIImage *)placeHolderImage imageDidSelectedBlock:(LSKImageClickBlock) didSelectedImageAtIndex;

/**
 设置bannar的内容

 @param urlArray 包含bannar图片地址的数组
 */
- (void)setupBannarContentWithUrlArray:(NSArray *)urlArray;
/**
 针对定时器的长时间的单利不断后台运行的优化
 */
//定时开启
- (void)viewDidAppearStartRun;
//定时关闭
- (void)viewDidDisappearStop;
@end

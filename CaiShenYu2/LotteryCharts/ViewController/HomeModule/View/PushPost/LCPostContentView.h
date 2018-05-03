//
//  LCPostContentView.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/22.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ContentFrameBlock)(CGFloat height);
typedef void (^ContentMediaBlock)(NSInteger type);
typedef void (^ContentMediaDelectBlock)(NSInteger type,NSInteger index);
@interface LCPostContentView : UIView
@property (nonatomic, strong) NSMutableArray *photoArray;
@property (nonatomic, assign) BOOL isVoice;
@property (nonatomic, assign) NSInteger timeString;
@property (nonatomic, copy) ContentFrameBlock frameBlock;
@property (nonatomic, copy) ContentMediaBlock mediaBlock;
@property (nonatomic, copy) ContentMediaDelectBlock mediaDelectBlock;
@property (nonatomic, assign, getter=isCanTakePhoto) BOOL canTakePhoto;
@property (nonatomic, weak) UITextField *titleField;
@property (nonatomic, weak) UITextView *contentTextView;
- (void)addImage:(UIImage *)image;
- (void)addVoice:(NSInteger)time;
@end

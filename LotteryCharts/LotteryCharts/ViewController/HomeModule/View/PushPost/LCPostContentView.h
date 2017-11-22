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
@interface LCPostContentView : UIView
@property (nonatomic, copy) ContentFrameBlock frameBlock;
@property (nonatomic, copy) ContentMediaBlock mediaBlock;
@property (nonatomic, assign, getter=isCanTakePhoto) BOOL canTakePhoto;
@property (nonatomic, weak) UITextField *titleField;
@property (nonatomic, weak) UITextView *contentTextView;
- (void)addImage:(UIImage *)image;
- (void)addVoice:(id)voice;
@end

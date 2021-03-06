//
//  LCPostDetailHeaderView.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/22.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^HeaderViewBlock)(NSInteger type,NSInteger index);
typedef void (^HeaderViewFrameBlock)(CGFloat height);
@interface LCPostDetailHeaderView : UIView
@property (nonatomic, copy) HeaderViewFrameBlock frameBlock;
@property (nonatomic, copy) HeaderViewBlock headerBlock;
@property (nonatomic, copy) PhotoClickBlock photoBlock;
@property (nonatomic, assign) BOOL isUser;
@property (nonatomic, assign) BOOL isCare;

@property (nonatomic, copy) NSString *postType;
- (void)setupPayBtnState:(BOOL)isPay;
- (void)setupContentWithPhoto:(NSString *)photo name:(NSString *)name userId:(NSString *)userId money:(NSString *)money title:(NSString *)title content:(NSString *)content postId:(NSString *)postId time:(NSString *)time count:(NSString *)count type:(NSInteger)type zanshu:(NSString *)zanshu isZan:(BOOL)isZan;
- (void)setupContent:(NSString *)content media:(NSDictionary *)mediaDict isShow:(BOOL)isCanShow;
- (void)setupRewardCount:(NSInteger)count;
- (void)changeZanCount:(NSString *)count;
@end

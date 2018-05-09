//
//  LCPostDetailViewModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseViewModel.h"
#import "LCPostDetailModel.h"
#import "LCPostReplyListModel.h"
#import "LCPostReplySuccessModel.h"
#import "LCPostDetailMessageModel.h"
@interface LCPostDetailViewModel : LSKBaseViewModel
@property (nonatomic, copy) NSString *postId;
@property (nonatomic, copy) NSString *userId;
- (void)getPostDetail:(BOOL)isPull;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *replyArray;
- (void)getReplyList;

- (void)payForShowEvent;
@property (nonatomic, assign) BOOL isNeedSend;
- (void)sendReplyText:(NSString *)content;
- (void)rewardPostMoney:(NSString *)money;
- (void)attentionPost:(BOOL)isAttention;

@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *target;
@property (nonatomic, assign) NSInteger replyType;
- (void)getCommentReplyList:(BOOL)isPull;

@end

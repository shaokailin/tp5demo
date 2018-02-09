//
//  LCHomeModuleAPI.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/30.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCHomeModuleAPI.h"
#import "LCHomeHeaderMessageModel.h"
#import "LCBaseResponseModel.h"
#import "LCHomeHotListModel.h"
#import "LCRankingRenListModel.h"
#import "LCRankingVipListModel.h"
#import "LCHistoryLotteryListModel.h"
#import "LCPostReplySuccessModel.h"
#import "LCPostReplyListModel.h"
#import "LCPostDetailModel.h"
#import "LCPostDetailMessageModel.h"
#import "LCRechargeMoneyListModel.h"
#import "LCLotteryFiveModel.h"
#import "LCLottery5DListModel.h"
#import "LCWeiPayOrderModel.h"
static NSString * kPushPostApi = @"post/add.html";
static NSString * kLotteryFiveApi = @"Direct/getRangeOne.html";
static NSString * kOnlineAllApi = @"Direct/getOnlineNum.html";
static NSString * kHomeHotPostApi = @"Index/hotpost.html";
static NSString * kHomeHeaderApi = @"Index/index.html";
static NSString * kVipPostApi = @"Index/vipPost.html";
static NSString * kRenPostApi = @"Index/renPost.html";
static NSString * kPullPostApi = @"Index/pullPost.html";
static NSString * kRewardPostApi = @"Index/rewardPost.html";
static NSString * kHistoryLotteryApi = @"Period/index.html";
static NSString * kLottery5DListApi = @"Direct/getRangeList.html";

static NSString * kPostReply = @"post/reply.html";
static NSString * kPostReplyList = @"post/replypage.html";
static NSString * kPostDetail = @"post/show.html";
static NSString * kPayPost = @"post/show_payorder.html";
static NSString * kAllPost = @"post/lists.html";

static NSString * kAttentionPost = @"Post/postFollow.html";
static NSString * kNoAttentionPost = @"Post/unPostFollow.html";

static NSString * kRewardPost = @"Post/rewardPost.html";
static NSString * kIsPostPay = @"Post/isPostPay.html";

static NSString * kSearchPost = @"direct/search.html";
static NSString * kGetUserId = @"Direct/getMchUid.html";
static NSString * kUpPostVip = @"post/up_pay.html";

static NSString * kPayTypeList = @"Direct/getPaySet.html";
static NSString * kAliPay = @"Alipay/setPay.html";
static NSString * kWXPay = @"Wxpay/getWxpayData.html";
@implementation LCHomeModuleAPI
+ (LSKParamterEntity *)pushPostEvent:(NSString *)title content:(NSString *)content media:(NSString *)media type:(NSInteger)type money:(NSString *)money vipMoney:(NSString *)vipMoney {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kPushPostApi;
    entity.responseObject = [LSKBaseResponseModel class];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:title,@"post_title",content,@"post_content",media,@"post_upload",@(type),@"post_type",kUserMessageManager.token,@"token", nil];
    if (type == 1) {
        [param setObject:money forKey:@"post_money"];
    }
    if (KJudgeIsNullData(vipMoney)) {
        [param setObject:vipMoney forKey:@"post_vipmoney"];
    }
    entity.params = param;
    return entity;
}

+ (LSKParamterEntity *)getOnLineAll {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kOnlineAllApi;
    entity.requestType = HTTPRequestType_GET;
    entity.responseObject = [LCBaseResponseModel class];
    return entity;
}
+ (LSKParamterEntity *)getLastLotteryFive {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kLotteryFiveApi;
    entity.requestType = HTTPRequestType_POST;
    entity.responseObject = [LCLotteryFiveModel class];
    return entity;
    
}
+ (LSKParamterEntity *)getHotPostList:(NSInteger)page {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kHomeHotPostApi;
    entity.params = @{@"p":@(page)};
    entity.responseObject = [LCHomeHotListModel class];
    return entity;
}
+ (LSKParamterEntity *)getHomeHeaderMessage {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kHomeHeaderApi;
    entity.responseObject = [LCHomeHeaderMessageModel class];
    return entity;
}

+ (LSKParamterEntity *)getPostRanking:(NSInteger)page type:(NSInteger)type {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.params = @{@"p":@(page)};
    if (type != 1) {
        if (type == 0) {
            entity.requestApi = kVipPostApi;
        }else if (type == 2){
            entity.requestApi = kPullPostApi;
        }else {
            entity.requestApi = kRewardPostApi;
        }
        entity.responseObject = [LCRankingVipListModel class];
    }else {
        entity.requestApi =kRenPostApi;
        entity.responseObject = [LCRankingRenListModel class];
    }
    return entity;
}
+ (LSKParamterEntity *)getkHistoryLotteryList:(NSInteger)page limitRow:(NSInteger)limit period_id:(NSString *)period_id {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kHistoryLotteryApi;
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObject:@(page) forKey:@"p"];
    [dict setObject:@(limit) forKey:@"limitrow"];
    if (KJudgeIsNullData(period_id)) {
        [dict setObject:period_id forKey:@"period_id"];
    }
    entity.params = dict;
    entity.responseObject = [LCHistoryLotteryListModel class];
    return entity;
}

+ (LSKParamterEntity *)getLottery5DList:(NSInteger)page limitRow:(NSInteger)limit period_id:(NSString *)period_id {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kLottery5DListApi;
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObject:@(page) forKey:@"p"];
    [dict setObject:@(limit) forKey:@"limitrow"];
    if (KJudgeIsNullData(period_id)) {
        [dict setObject:period_id forKey:@"p_name"];
    }
    entity.params = dict;
    entity.responseObject = [LCLottery5DListModel class];
    return entity;
}

+ (LSKParamterEntity *)sendPostReply:(NSString *)content postId:(NSString *)postId {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kPostReply;
    entity.params = @{@"token":kUserMessageManager.token,@"post_id":postId,@"message":content};
    entity.responseObject = [LCPostReplySuccessModel class];
    return entity;
}
+ (LSKParamterEntity *)getPostReplyList:(NSInteger)page postId:(NSString *)postId {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kPostReplyList;
    entity.params = @{@"token":kUserMessageManager.token,@"post_id":postId,@"p":@(page)};
    entity.responseObject = [LCPostReplyListModel class];
    return entity;
}
+ (LSKParamterEntity *)getPostDetail:(NSString *)postId {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kPostDetail;
    entity.params = @{@"token":kUserMessageManager.token,@"post_id":postId};
    entity.responseObject = [LCPostDetailModel class];
    return entity;
}

+ (LSKParamterEntity *)payPostForShow:(NSString *)postId {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kPayPost;
    entity.params = @{@"token":kUserMessageManager.token,@"post_id":postId};
    entity.responseObject = [LSKBaseResponseModel class];
    return entity;
    
}
+ (LSKParamterEntity *)getAllPostList:(NSInteger)page {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kAllPost;
    entity.params = @{@"p":@(page)};
    entity.responseObject = [LCHomeHotListModel class];
    return entity;
}
+ (LSKParamterEntity *)attentionPost:(NSString *)postId isCare:(BOOL)isCare {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    if (isCare) {
        entity.requestApi = kNoAttentionPost;
    }else {
        entity.requestApi = kAttentionPost;
    }
    entity.params = @{@"token":kUserMessageManager.token,@"post_id":postId};
    entity.responseObject = [LSKBaseResponseModel class];
    return entity;
}
+ (LSKParamterEntity *)rewardPostMoney:(NSString *)money postId:(NSString *)postId {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kRewardPost;
    entity.params = @{@"token":kUserMessageManager.token,@"post_id":postId,@"money":money};
    entity.responseObject = [LSKBaseResponseModel class];
    return entity;
}
+ (LSKParamterEntity *)needPayForShowPost:(NSString *)postId {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kIsPostPay;
    entity.params = @{@"token":kUserMessageManager.token,@"post_id":postId};
    entity.responseObject = [LCPostDetailMessageModel class];
    return entity;
}

+ (LSKParamterEntity *)getSearchPostList:(NSString *)searchText page:(NSInteger)page {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kSearchPost;
    entity.params = @{@"p":@(page),@"searchword":searchText};
    entity.responseObject = [LCHomeHotListModel class];
    return entity;
}
+ (LSKParamterEntity *)getUserUid:(NSString *)searchText {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kGetUserId;
    entity.params = @{@"mch_no":searchText};
    entity.responseObject = [LCBaseResponseModel class];
    return entity;
}
+ (LSKParamterEntity *)upPostVipRanking:(NSString *)postId money:(NSString *)money {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kUpPostVip;
    entity.params = @{@"token":kUserMessageManager.token,@"post_id":postId,@"pay_money":money};
    entity.responseObject = [LSKBaseResponseModel class];
    return entity;
}

+ (LSKParamterEntity *)getPayTypeList {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kPayTypeList;
    entity.responseObject = [LCRechargeMoneyListModel class];
    return entity;
}
+ (LSKParamterEntity *)aliPayMoney:(NSString *)jinbi {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kAliPay;
    entity.params = @{@"token":kUserMessageManager.token,@"id":jinbi};
    entity.responseObject = [LCBaseResponseModel class];
    return entity;
}
+ (LSKParamterEntity *)wxPayMoney:(NSString *)jinbi {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kWXPay;
    entity.params = @{@"token":kUserMessageManager.token,@"id":jinbi};
    entity.responseObject = [LCWeiPayOrderModel class];
    return entity;
}
@end

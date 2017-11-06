//
//  PPSSMemberDetailViewModel.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/14.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseViewModel.h"
#import "PPSSMemberDetailModel.h"
@interface PPSSMemberDetailViewModel : LSKBaseViewModel
@property (nonatomic, copy) NSString *userId;
- (void)getMemberDetail:(BOOL)isPull;
@property (nonatomic, strong) PPSSMemberDetailModel *memberDetailModel;
@end

//
//  PPSSComplaintViewModel.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/25.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseViewModel.h"

@interface PPSSComplaintViewModel : LSKBaseViewModel
@property (nonatomic, copy) NSString *textString;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, assign) NSInteger type;
- (void)uploadEditText;
@end

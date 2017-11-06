//
//  PPSSMemberListHeaderView.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/20.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^OMemberListSearchBlock) (NSString* searchText);
@interface PPSSMemberListHeaderView : UIView
@property (nonatomic, copy) OMemberListSearchBlock searchBlock;
@property (nonatomic, copy, readonly, getter=getSearchText) NSString *searchText;
@property (nonatomic, assign) NSInteger type;
@end

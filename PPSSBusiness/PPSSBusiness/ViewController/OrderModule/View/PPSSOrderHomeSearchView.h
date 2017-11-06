//
//  PPSSOrderHomeSearchView.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/18.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPSSOrderHomeSearchView : UIView
@property (nonatomic, copy)OrderHomeSearchClickBlock clickBlock;
@property (nonatomic, readonly, copy) NSString *dateString;
@property (nonatomic, readonly, copy, getter = searchText) NSString *searchContent;
- (void)changeBtnText:(NSString *)text type:(OrderHomeSearchClickType)type;
@end

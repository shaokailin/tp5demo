//
//  PPSSOrderHomeScreenView.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/20.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^OrderHomeScreenBlock)(NSInteger payType,NSInteger payState);
@interface PPSSOrderHomeScreenView : UIView
- (instancetype)initWithEventBlock:(OrderHomeScreenBlock)clickBlock;
- (void)showInView;
@end

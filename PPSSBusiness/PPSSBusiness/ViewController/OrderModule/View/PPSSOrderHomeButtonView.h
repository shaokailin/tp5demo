//
//  PPSSOrderHomeButtonView.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/18.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,OrderHomeButtonType ) {
    OrderHomeButtonType_Date,
    OrderHomeButtonType_Shop,
};
@interface PPSSOrderHomeButtonView : UIButton
@property (nonatomic, readonly, copy) NSString *dateString;
- (instancetype)initWithType:(OrderHomeButtonType)type;
- (void)setupTitle:(NSString *)title;
@end

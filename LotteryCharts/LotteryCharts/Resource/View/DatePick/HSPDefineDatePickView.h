//
//  HSPDefineDatePickView.h
//  HSPBusiness
//
//  Created by hsPlan on 2017/7/24.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,DefineDateType) {
    DefineDateType_Year = 0,
    DefineDateType_Mouth
    
};
typedef void (^DefineDateBlock) (NSInteger year);
@interface HSPDefineDatePickView : UIView
@property (nonatomic, copy) DefineDateBlock dateBlock;
@property (nonatomic, assign) DefineDateType datePickerMode;
- (void)showInView;
@end

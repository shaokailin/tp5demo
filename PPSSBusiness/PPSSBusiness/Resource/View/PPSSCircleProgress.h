//
//  PPSSCircleProgress.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/22.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPSSCircleProgress : UIView
@property (nonatomic, strong) UIColor *strokeColor;/**<线条填充色*/
//进度
@property (nonatomic, assign) CGFloat progress;/**<进度 0-1 */

@end

//
//  PPSSActivitySelectTableViewCell.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/22.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ActivitySelectBlock)(NSInteger type);
static NSString * const kPPSSActivitySelectTableViewCell = @"PPSSActivitySelectTableViewCell";
@interface PPSSActivitySelectTableViewCell : UITableViewCell
@property (nonatomic, copy) ActivitySelectBlock selectBlock;
@end

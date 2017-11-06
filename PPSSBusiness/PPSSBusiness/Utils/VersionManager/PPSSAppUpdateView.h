//
//  PPSSAppUpdateView.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/27.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^AppUpdateBlock) (NSInteger index);
@interface PPSSAppUpdateView : UIView

/**
 更新界面

 @param title 标题
 @param content 内容
 @param type 2.非强制 1.强制
 @return 参数
 */
-(instancetype)initWithTitle:(NSString *)title content:(NSString *)content type:(NSInteger)type;
@property (copy ,nonatomic) AppUpdateBlock clickblock;
- (void)showInView;
@end

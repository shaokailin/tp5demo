//
//  UITableView+Extend.h
//  SingleStore
//
//  Created by hsPlan on 2017/9/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, LSKTableViewExitType) {
    LSKTableViewExitType_Reload,
    LSKTableViewExitType_Insert,
    LSKTableViewExitType_Delete
};
@interface UITableView (Extend)

/**
 TableCell 编辑

 @param type 编辑的类型
 @param start 开始
 @param end 结束位置
 @param section 刷新的快
 @param animation 动画效果
 
 */
- (void)exitTableViewWithType:(LSKTableViewExitType)type indexPathStart:(NSInteger)start indexPathEnd:(NSInteger)end section:(NSInteger)section animation:(UITableViewRowAnimation)animation;
@end

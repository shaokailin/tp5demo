//
//  UITableView+Extend.m
//  SingleStore
//
//  Created by hsPlan on 2017/9/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "UITableView+Extend.h"

@implementation UITableView (Extend)
- (void)exitTableViewWithType:(LSKTableViewExitType)type indexPathStart:(NSInteger)start indexPathEnd:(NSInteger)end section:(NSInteger)section animation:(UITableViewRowAnimation)animation {
    if (start <= 0 && end <= 0) {
        return;
    }
    if (start >= 0 && end >= 0) {
        //区分传的数据的大小是否有不同
        if (start > end) {
            NSInteger temp = start;
            start = end;
            end = temp;
        }
        NSMutableArray *indexPathArray = [NSMutableArray array];
        if (start == end) {
            [indexPathArray addObject:[NSIndexPath indexPathForRow:start inSection:section]];
        }else {
            while (start <= end) {
                [indexPathArray addObject:[NSIndexPath indexPathForRow:start inSection:section]];
                start ++;
            }
        }
        [self beginUpdates];
        switch (type) {
            case LSKTableViewExitType_Reload:
                [self reloadRowsAtIndexPaths:indexPathArray withRowAnimation:animation];
                break;
            case LSKTableViewExitType_Delete:
                [self deleteRowsAtIndexPaths:indexPathArray withRowAnimation:animation];
                break;
            case LSKTableViewExitType_Insert:
                [self insertRowsAtIndexPaths:indexPathArray withRowAnimation:animation];
                break;
                
            default:
                break;
        }
        [self endUpdates];
    }
}
@end

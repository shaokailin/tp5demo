//
//  NSObject+Data.m
//  iRiding
//
//  Created by Vian on 13-12-9.
//  Copyright (c) 2013年 Maytaste. All rights reserved.
//

#import "NSObject+Data.h"
#import "objc/runtime.h"

@implementation NSObject (Data)
@dynamic index,dataId;

-(void)setDataId:(NSInteger)dataId{
    objc_setAssociatedObject(self, @"dataId", @(dataId), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSInteger)dataId{
    return [objc_getAssociatedObject(self, @"dataId") intValue];
}

-(void)setIndex:(NSInteger)index{
    objc_setAssociatedObject(self, @"index", @(index), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSInteger)index{
    return [objc_getAssociatedObject(self, @"index") intValue];
}
@end

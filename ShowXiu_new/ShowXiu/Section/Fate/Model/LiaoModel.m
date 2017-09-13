//
//  LiaoModel.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/6/3.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "LiaoModel.h"

@implementation LiaoModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

+(JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"ID"}];
}


@end

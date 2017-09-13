//
//  SystemModel.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/4/28.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "SystemModel.h"

@implementation SystemModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

+(JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"ID"}];
}
@end

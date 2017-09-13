//
//  SiImaModel.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/6/8.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "SiImaModel.h"

@implementation SiImaModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

+(JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"ID"}];
}
@end

//
//  MianAllModel.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/6/10.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "MianAllModel.h"

@implementation MianAllModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

+(JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"ID"}];
}
@end

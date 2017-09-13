//
//  FateModel.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/3/21.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "FateModel.h"

@implementation FateModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

+(JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"ID"}];
}



@end

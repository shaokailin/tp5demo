//
//  JInModel.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/5/11.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "JInModel.h"

@implementation JInModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}
+(JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"ID"}];
}
@end

//
//  LSKMediaParamterEntity.h
//  SingleStore
//
//  Created by hsPlan on 2017/9/11.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKParamterEntity.h"
@interface LSKMediaParamterEntity : LSKParamterEntity
@property (nonatomic, copy) NSArray *mediaArray;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) LSKUploadMediaType uploadType;
@end

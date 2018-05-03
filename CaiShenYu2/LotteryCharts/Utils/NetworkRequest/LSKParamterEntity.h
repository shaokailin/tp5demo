//
//  LSKParamterEntity.h
//  SingleStore
//
//  Created by hsPlan on 2017/9/11.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSKParamterEntity : NSObject
@property (nonatomic ,copy) NSString *requestApi;
@property (nonatomic ,assign) Class responseObject;
@property (nonatomic ,strong) NSDictionary *params;
@property (nonatomic ,assign) HTTPRequestType requestType;
@end

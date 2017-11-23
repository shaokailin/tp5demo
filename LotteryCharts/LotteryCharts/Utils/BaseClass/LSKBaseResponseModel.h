//
//  LSKBaseResponseModel.h
//  SingleStore
//
//  Created by hsPlan on 2017/9/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSKBaseResponseModel : NSObject
@property (nonatomic ,assign)   NSInteger code;
@property (nonatomic ,copy)     NSString *message;
@end

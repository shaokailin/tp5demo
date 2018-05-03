//
//  LCBaseMediaViewController.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/29.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseViewController.h"

@interface LCBaseMediaViewController : LSKBaseViewController
- (void)takeCameraPhoto;
- (void)takeLocationImage;
- (void)selectImage:(UIImage *)image;
@end

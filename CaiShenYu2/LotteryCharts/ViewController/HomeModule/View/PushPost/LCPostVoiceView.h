//
//  LCPostVoiceView.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/22.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^VoiceBlock)(NSInteger time);
@interface LCPostVoiceView : UIView
@property (nonatomic, copy) VoiceBlock voiceBlock;
@end

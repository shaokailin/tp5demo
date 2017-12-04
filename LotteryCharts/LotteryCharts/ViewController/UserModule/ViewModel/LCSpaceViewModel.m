//
//  LCSpaceViewModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/4.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCSpaceViewModel.h"
@interface LCSpaceViewModel ()
@property (nonatomic, strong) RACCommand *attentionCommand;
@property (nonatomic, strong) RACCommand *spaceCommand;
@end
@implementation LCSpaceViewModel
- (void)getSpaceData:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInView:self.currentView];
    }
    [self.spaceCommand execute:nil];
}

- (void)attentionUserClick {
    [SKHUD showLoadingDotInWindow];
    [self.attentionCommand execute:nil];
}
- (RACCommand *)attentionCommand {
    if (!_attentionCommand) {
        
    }
    return _attentionCommand;
}
@end

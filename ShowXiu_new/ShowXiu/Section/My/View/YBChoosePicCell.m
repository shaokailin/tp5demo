//
//  YBChoosePicCell.m
//  MusicPlayer
//
//  Created by ch on 2017/3/28.
//  Copyright © 2017年 hxcj. All rights reserved.
//

#import "YBChoosePicCell.h"

@implementation YBChoosePicCell


- (IBAction)deleteBtnAction:(UIButton *)sender {
    if (self.clickedDeleteBtn) {
        self.clickedDeleteBtn();
    }
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end

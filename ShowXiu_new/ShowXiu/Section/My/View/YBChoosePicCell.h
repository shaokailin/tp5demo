//
//  YBChoosePicCell.h
//  MusicPlayer
//
//  Created by ch on 2017/3/28.
//  Copyright © 2017年 hxcj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBChoosePicCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property (nonatomic, copy) void(^clickedDeleteBtn)();
- (void)setClickedDeleteBtn:(void (^)())clickedDeleteBtn;

@end

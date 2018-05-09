//
//  LCMeCommentCell.m
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/4.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LCMeCommentCell.h"
@interface LCMeCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *photoImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *tyleLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;

@end
@implementation LCMeCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ViewBoundsRadius(self.photoImg, 17.0);
}
- (void)setupCellContent:(NSString *)name time:(NSString *)time content:(NSString *)content img:(NSString *)image type:(NSInteger)type {
    if (type == 0) {
        self.tyleLbl.text = @"评论了你";
    }else {
        self.tyleLbl.text = @"回复了你";
    }
    if (KJudgeIsNullData(image)) {
        [self.photoImg sd_setImageWithURL:[NSURL URLWithString:image]];
    }else {
        self.photoImg.image = nil;
    }
    self.contentLbl.text = content;
    self.nameLbl.text = name;
    self.timeLbl.text = time;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

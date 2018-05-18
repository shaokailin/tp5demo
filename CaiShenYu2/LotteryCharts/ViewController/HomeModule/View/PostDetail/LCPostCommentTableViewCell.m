//
//  LCPostCommentTableViewCell.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/22.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCPostCommentTableViewCell.h"
@interface LCPostCommentTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *userIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *stateLbl;

@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;


@end
@implementation LCPostCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ViewBoundsRadius(self.photoImage, 20);
    self.photoImage.userInteractionEnabled = YES;
    ViewBoundsRadius(self.stateLbl, 10.5);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpUserSpace)];
    [self.photoImage addGestureRecognizer:tap];
}
- (void)jumpUserSpace {
    if (self.photoBlock) {
        self.photoBlock(self);
    }
}
- (void)setupPhoto:(NSString *)photo name:(NSString *)name userId:(NSString *)userId count:(NSInteger)count time:(NSString *)time content:(NSString *)content isHiden:(BOOL)isHiden {
    if (KJudgeIsNullData(photo)) {
        [self.photoImage sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:nil];
    }else {
        self.photoImage.image = nil;
    }
    self.stateLbl.hidden = isHiden;
    self.nickNameLbl.text = name;
    if (userId) {
        self.userIdLbl.text = NSStringFormat(@"码师ID:%@",userId);

    } else {
        self.userIdLbl.text = NSStringFormat(@"码师ID:%@",kUserMessageManager.mch_no) ;
    }
    if (count > 0) {
        self.stateLbl.text = @"对话列表";
    }else {
        self.stateLbl.text = @"回复";
    }
    self.timeLbl.text = time;
    self.contentLbl.text = content;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

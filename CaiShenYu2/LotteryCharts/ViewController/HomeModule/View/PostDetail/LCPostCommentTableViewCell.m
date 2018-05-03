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
@property (weak, nonatomic) IBOutlet UILabel *indexLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;


@end
@implementation LCPostCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ViewBoundsRadius(self.photoImage, 20);
    self.photoImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpUserSpace)];
    [self.photoImage addGestureRecognizer:tap];
}
- (void)jumpUserSpace {
    if (self.photoBlock) {
        self.photoBlock(self);
    }
}
- (void)setupPhoto:(NSString *)photo name:(NSString *)name userId:(NSString *)userId index:(NSInteger)index time:(NSString *)time content:(NSString *)content {
    if (KJudgeIsNullData(photo)) {
        [self.photoImage sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:nil];
    }
    self.nickNameLbl.text = name;
    if (userId) {
        self.userIdLbl.text = NSStringFormat(@"码师ID:%@",userId);

    } else {
        self.userIdLbl.text = NSStringFormat(@"码师ID:%@",kUserMessageManager.mch_no) ;
    }
    self.indexLbl.text = NSStringFormat(@"%zd楼",index);
    self.timeLbl.text = time;
    self.contentLbl.text = content;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

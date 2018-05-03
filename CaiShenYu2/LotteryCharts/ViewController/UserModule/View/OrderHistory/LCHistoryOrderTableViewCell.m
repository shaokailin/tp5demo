//
//  LCHistoryOrderTableViewCell.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/15.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCHistoryOrderTableViewCell.h"
@interface LCHistoryOrderTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *postIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *pushTimeLbl;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *userIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *detailLbl;
@property (weak, nonatomic) IBOutlet UILabel *payMoney;


@end
@implementation LCHistoryOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ViewBoundsRadius(self.photoImageView, 15);
    self.photoImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpUserSpace)];
    [self.photoImageView addGestureRecognizer:tap];
}
- (void)jumpUserSpace {
    if (self.photoBlock) {
        self.photoBlock(self);
    }
}
- (void)setupContentWithPostId:(NSString *)postId pushTime:(NSString *)pushTime photoImage:(NSString *)photoImage name:(NSString *)name userId:(NSString *)userId detail:(NSString *)detail money:(NSString *)money {
    self.postIdLbl.text = NSStringFormat(@"帖子ID:%@",postId);
    self.pushTimeLbl.text = pushTime;
    if (KJudgeIsNullData(photoImage)) {
        [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:photoImage] placeholderImage:nil];
    }
    self.nameLbl.text = name;
    self.userIdLbl.text = NSStringFormat(@"码师ID:%@",userId);;
    self.detailLbl.text = detail;
    self.payMoney.text = NSStringFormat(@"%@金币",money);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

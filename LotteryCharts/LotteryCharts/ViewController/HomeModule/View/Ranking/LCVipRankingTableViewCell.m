//
//  LCVipRankingTableViewCell.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/18.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCVipRankingTableViewCell.h"
@interface LCVipRankingTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *indexLbl;
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *postTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *moneyLbl;
@property (weak, nonatomic) IBOutlet UILabel *userIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *robMoneyLbl;
@property (weak, nonatomic) IBOutlet UIImageView *indexBgImage;
@property (weak, nonatomic) IBOutlet UILabel *postIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *moneyWidth;

@property (weak, nonatomic) IBOutlet UIImageView *rankingImage;

@end
@implementation LCVipRankingTableViewCell
- (IBAction)buttonClick:(id)sender {
    if (self.vipRankingBlock) {
        self.vipRankingBlock(self);
    }
}
- (void)jumpUserSpace {
    if (self.photoBlock) {
        self.photoBlock(self);
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ViewRadius(self.button, 3.0);
    ViewBoundsRadius(self.photoImage, 15.0);
    ViewBorderLayer(self.button, [UIColor redColor], kLineView_Height);
    self.photoImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpUserSpace)];
    [self.photoImage addGestureRecognizer:tap];
}
- (void)setupContent:(NSInteger)index photo:(NSString *)photo postTitle:(NSString *)postTitle name:(NSString *)name money:(NSString *)money robMoney:(NSString *)robMoney userId:(NSString *)userId isShowBtn:(NSInteger)isShow time:(NSString *)time postId:(NSString *)postId mch_no:(NSString *)mch_no {
    self.indexLbl.text = NSStringFormat(@"%zd",index);
    self.postTitleLbl.text = postTitle;
    self.nameLbl.text = name;
    self.moneyLbl.text = money;
    self.robMoneyLbl.text = robMoney;
    self.userIdLbl.text = NSStringFormat(@"码师ID:%@",mch_no);
    self.button.hidden = !isShow;
    self.postIdLbl.text = NSStringFormat(@"帖子ID:%@",postId);
    self.timeLbl.text =time;
    if (KJudgeIsNullData(photo)) {
        [self.photoImage sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:nil];
    }
    if (index < 4) {
        self.indexLbl.textColor = ColorHexadecimal(0xffffff, 1.0);
        self.indexBgImage.hidden = NO;
        self.rankingImage.hidden = NO;
    }else {
        self.indexLbl.textColor = ColorHexadecimal(0xf6a623, 1.0);
        self.indexBgImage.hidden = YES;
        self.rankingImage.hidden = YES;
    }
    self.button.hidden = YES;
    if (isShow == YES) {
        if ([userId isEqualToString:kUserMessageManager.userId]) {
            self.button.hidden = NO;
        }
    }
    self.moneyWidth.constant = 70;
    self.btnWidth.constant = 60;
    self.image1.hidden = NO;
    self.image2.hidden = NO;
    self.moneyLbl.textColor = ColorHexadecimal(0xFF3030, 1.0);
}
- (void)setupPushContent:(NSInteger)index photo:(NSString *)photo postTitle:(NSString *)postTitle name:(NSString *)name showCount:(NSString *)showCount userId:(NSString *)userId isShowBtn:(NSInteger)isShow time:(NSString *)time postId:(NSString *)postId {
    self.indexLbl.text = NSStringFormat(@"%zd",index);
    self.postTitleLbl.text = postTitle;
    self.nameLbl.text = name;
    self.moneyLbl.text = NSStringFormat(@"阅读数:%@",showCount);
    self.moneyLbl.textColor = ColorHexadecimal(0xf6a623, 1.0);
    self.robMoneyLbl.text = nil;
    self.userIdLbl.text = NSStringFormat(@"码师ID:%@",userId);
    self.button.hidden = !isShow;
    self.postIdLbl.text = NSStringFormat(@"帖子ID:%@",postId);
    self.timeLbl.text =time;
    if (KJudgeIsNullData(photo)) {
        [self.photoImage sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:nil];
    }
    if (index < 4) {
        self.indexLbl.textColor = ColorHexadecimal(0xffffff, 1.0);
        self.indexBgImage.hidden = NO;
        self.rankingImage.hidden = NO;
    }else {
        self.indexLbl.textColor = ColorHexadecimal(0xf6a623, 1.0);
        self.indexBgImage.hidden = YES;
        self.rankingImage.hidden = YES;
    }
    self.moneyWidth.constant = 60;
    self.image1.hidden = YES;
    self.image2.hidden = YES;
    self.button.hidden = YES;
    self.btnWidth.constant = 10;
}
- (void)setupShangContent:(NSInteger)index photo:(NSString *)photo postTitle:(NSString *)postTitle name:(NSString *)name money:(NSString *)money userId:(NSString *)userId isShowBtn:(NSInteger)isShow time:(NSString *)time postId:(NSString *)postId {
    self.indexLbl.text = NSStringFormat(@"%zd",index);
    self.postTitleLbl.text = postTitle;
    self.nameLbl.text = name;
    self.moneyLbl.text = money;
    self.moneyLbl.textColor = ColorHexadecimal(0xf6a623, 1.0);
    self.robMoneyLbl.text = nil;
    self.userIdLbl.text = NSStringFormat(@"码师ID:%@",userId);
    self.button.hidden = !isShow;
    self.postIdLbl.text = NSStringFormat(@"帖子ID:%@",postId);
    self.timeLbl.text =time;
    if (KJudgeIsNullData(photo)) {
        [self.photoImage sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:nil];
    }
    if (index < 4) {
        self.indexLbl.textColor = ColorHexadecimal(0xffffff, 1.0);
        self.indexBgImage.hidden = NO;
        self.rankingImage.hidden = NO;
    }else {
        self.indexLbl.textColor = ColorHexadecimal(0xf6a623, 1.0);
        self.indexBgImage.hidden = YES;
        self.rankingImage.hidden = YES;
    }
    self.moneyWidth.constant = 30;
    self.image1.hidden = YES;
    self.image2.hidden = NO;
    self.button.hidden = YES;
    self.btnWidth.constant = 10;
}
- (void)setupTypeThreeContent:(NSString *)money isThree:(BOOL)isThree {
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

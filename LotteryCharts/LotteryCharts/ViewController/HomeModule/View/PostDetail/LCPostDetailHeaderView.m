//
//  LCPostDetailHeaderView.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/22.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCPostDetailHeaderView.h"
@interface LCPostDetailHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *userIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *countLbl;
@property (weak, nonatomic) IBOutlet UILabel *postIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIButton *shangBtn;
@property (weak, nonatomic) IBOutlet UILabel *shangCountLbl;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;

@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UIButton *careBtn;
@end
@implementation LCPostDetailHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    ViewBoundsRadius(self.photoImage, 30);
    ViewRadius(self.careBtn, 5.0);
    ViewBorderLayer(self.careBtn, ColorHexadecimal(0xf6a623, 1.0), 1.0);
    ViewBorderLayer(self.imageView1, ColorHexadecimal(0x7d7d7d, 1.0), 1.0);
    ViewBorderLayer(self.imageView2, ColorHexadecimal(0x7d7d7d, 1.0), 1.0);
    ViewBorderLayer(self.imageView3, ColorHexadecimal(0x7d7d7d, 1.0), 1.0);
    ViewRadius(self.shangBtn, 35 / 2.0);
    self.imageView1.hidden = YES;
    self.imageView2.hidden = YES;
    self.imageView3.hidden = YES;
    self.contentLbl.text = nil;
    self.imageView1.userInteractionEnabled = YES;
    self.imageView2.userInteractionEnabled = YES;
    self.imageView3.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick1)];
    [self.imageView1 addGestureRecognizer:tap1];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick2)];
    [self.imageView2 addGestureRecognizer:tap2];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick3)];
    [self.imageView3 addGestureRecognizer:tap3];
}
- (void)setupRewardCount:(NSInteger)count {
    self.shangCountLbl.text = NSStringFormat(@"%zd人打赏了帖主",count);
}
- (void)setupContent:(NSString *)content media:(NSDictionary *)mediaDict isShow:(BOOL)isCanShow {
    self.imageView1.hidden = YES;
    self.imageView2.hidden = YES;
    self.imageView3.hidden = YES;
    self.contentLbl.text = content;
    if (!isCanShow) {
    }else {
        self.contentLbl.text = content;
        if (mediaDict && [mediaDict isKindOfClass:[NSDictionary class]]) {
            NSArray *images = [mediaDict objectForKey:@"images"];
            if (KJudgeIsArrayAndHasValue(images)) {
                if (images.count > 0) {
                    self.imageView1.hidden = NO;
                    [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:[images objectAtIndex:0]] placeholderImage:nil];
                }
                if (images.count > 1) {
                    self.imageView2.hidden = NO;
                    [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:[images objectAtIndex:1]] placeholderImage:nil];
                }
                if (images.count > 2) {
                    self.imageView3.hidden = NO;
                    [self.imageView3 sd_setImageWithURL:[NSURL URLWithString:[images objectAtIndex:2]] placeholderImage:nil];
                }
            }
        }
    }
}
- (void)setupContentWithPhoto:(NSString *)photo name:(NSString *)name userId:(NSString *)userId money:(NSString *)money title:(NSString *)title content:(NSString *)content postId:(NSString *)postId time:(NSString *)time count:(NSString *)count type:(NSInteger)type {
    if (KJudgeIsNullData(photo)) {
        [self.photoImage sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:nil];
    }
    self.nameLbl.text = name;
    self.userIdLbl.text = NSStringFormat(@"码师ID:%@",userId);
    self.countLbl.text = NSStringFormat(@"付币帖 %@金币",money);
    self.titleLbl.text = title;
    self.postIdLbl.text = NSStringFormat(@"帖子ID:%@",postId);
    
    self.timeLbl.text = time;
    self.shangCountLbl.text = NSStringFormat(@"%@人打赏了帖主",count);
    if (type == 0) {
        self.shangBtn.hidden = NO;
        self.shangCountLbl.hidden = NO;
        self.careBtn.hidden = NO;
    }else {
        self.shangBtn.hidden = YES;
        self.shangCountLbl.hidden = YES;
        self.careBtn.hidden = YES;
    }
}
- (IBAction)careClick:(id)sender {
    if (self.headerBlock) {
        self.headerBlock(0, 0);
    }
}
- (void)imageClick1 {
    if (self.headerBlock) {
        self.headerBlock(1, 0);
    }
}
- (void)imageClick2 {
    if (self.headerBlock) {
        self.headerBlock(1, 1);
    }
}
- (void)imageClick3 {
    if (self.headerBlock) {
        self.headerBlock(1, 2);
    }
}
- (IBAction)rewardClick:(id)sender {
    if (self.headerBlock) {
        self.headerBlock(2, 0);
    }
}
- (void)setIsCare:(BOOL)isCare {
    _isCare = isCare;
    if (_isCare) {
        [self.careBtn setTitle:@"已关注" forState:UIControlStateNormal];
    }else {
        [self.careBtn setTitle:@"关注" forState:UIControlStateNormal];
    }
}

@end

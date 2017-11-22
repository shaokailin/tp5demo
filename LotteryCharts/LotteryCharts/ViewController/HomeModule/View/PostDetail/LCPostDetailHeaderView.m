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
}
- (void)setupContentWithPhoto:(NSString *)photo name:(NSString *)name userId:(NSString *)userId money:(NSString *)money title:(NSString *)title content:(NSString *)content postId:(NSString *)postId time:(NSString *)time count:(NSString *)count type:(NSInteger)type {
    self.nameLbl.text = name;
    self.userIdLbl.text = userId;
    self.countLbl.text = NSStringFormat(@"付币帖 %@金币",money);
    self.titleLbl.text = title;
    self.postIdLbl.text = postId;
    self.contentLbl.text = content;
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
}

@end

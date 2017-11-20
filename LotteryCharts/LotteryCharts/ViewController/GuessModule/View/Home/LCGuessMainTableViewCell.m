//
//  LCGuessMainTableViewCell.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/19.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCGuessMainTableViewCell.h"
@interface LCGuessMainTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet UILabel *topLbl;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *userIdLbl;
@property (weak, nonatomic) IBOutlet UIView *leftbgView;
@property (weak, nonatomic) IBOutlet UILabel *postIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *pushTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *countLbl;

@property (weak, nonatomic) IBOutlet UILabel *moneyLbl;
@property (weak, nonatomic) IBOutlet UILabel *openTimeLbl;
@end
@implementation LCGuessMainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ViewBoundsRadius(self.photoImage, 20);
    ViewBoundsRadius(self.topLbl, 5.0);
    self.userIdLbl.adjustsFontSizeToFitWidth = YES;
    ViewBorderLayer(self.topLbl, [UIColor redColor], kLineView_Height);
    ViewBoundsRadius(self.postIdLbl, 5.0);
    self.leftbgView.layer.shadowColor=[[UIColor grayColor] colorWithAlphaComponent:0.2].CGColor;
    self.leftbgView.layer.shadowOffset=CGSizeMake(1,1);
    self.leftbgView.layer.shadowOpacity=0.5;
    self.leftbgView.layer.shadowRadius=0;
}
- (void)setupContentWithPhoto:(NSString *)photo name:(NSString *)name userId:(NSString *)userId postId:(NSString *)postId pushTime:(NSString *)pushTime money:(NSString *)money count:(NSString *)count openTime:(NSString *)openTime {
    self.nameLbl.text = name;
    self.userIdLbl.text = userId;
    self.postIdLbl.text = postId;
    self.pushTimeLbl.text = pushTime;
    self.moneyLbl.text = NSStringFormat(@"押注：%@金币",money);
    self.countLbl.text = NSStringFormat(@"剩余：%@份",count);
    self.openTimeLbl.text = openTime;
}
- (IBAction)clickBtn:(id)sender {
    if (self.cellBlock) {
        self.cellBlock(self);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
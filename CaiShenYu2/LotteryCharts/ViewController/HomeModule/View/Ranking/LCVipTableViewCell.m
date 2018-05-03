//
//  LCVipTableViewCell.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/18.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCVipTableViewCell.h"
@interface LCVipTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *indexLbl;
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *postTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *moneyLbl;
@property (weak, nonatomic) IBOutlet UILabel *userIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *robMoneyLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *betweenValue;

@end
@implementation LCVipTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ViewRadius(self.button, 3.0);
    ViewBoundsRadius(self.photoImage, 25.0);
    ViewBorderLayer(self.button, [UIColor redColor], kLineView_Height);
}
- (void)setupContent:(NSInteger)index photo:(NSString *)photo postTitle:(NSString *)postTitle name:(NSString *)name money:(NSString *)money robMoney:(NSString *)robMoney userId:(NSString *)userId isShowBtn:(BOOL)isShow {
    self.indexLbl.text = NSStringFormat(@"%zd",index);
    self.postTitleLbl.text = postTitle;
    self.nameLbl.text = name;
    self.moneyLbl.text = money;
    self.robMoneyLbl.text = robMoney;
    if (KJudgeIsNullData(photo)) {
        [self.photoImage sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:nil];
    }
    self.userIdLbl.text = NSStringFormat(@"码师ID:%@",userId);
    self.button.hidden = !isShow;
}
- (void)setShowType:(NSInteger)showType {
    self.betweenValue.constant = 0;
}
- (IBAction)buttonClick:(id)sender {
    if (self.vipBlock) {
        self.vipBlock(self);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

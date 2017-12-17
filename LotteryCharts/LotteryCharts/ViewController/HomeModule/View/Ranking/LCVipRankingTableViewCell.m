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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *betweenValue;

@end
@implementation LCVipRankingTableViewCell
- (IBAction)buttonClick:(id)sender {
    if (self.vipRankingBlock) {
        self.vipRankingBlock(self);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ViewRadius(self.button, 3.0);
    ViewBoundsRadius(self.photoImage, 30.0);
    ViewBorderLayer(self.button, [UIColor redColor], kLineView_Height);
}
- (void)setupContent:(NSInteger)index photo:(NSString *)photo postTitle:(NSString *)postTitle name:(NSString *)name money:(NSString *)money robMoney:(NSString *)robMoney userId:(NSString *)userId isShowBtn:(NSInteger)isShow {
    self.indexLbl.text = NSStringFormat(@"%zd",index);
    self.postTitleLbl.text = postTitle;
    self.nameLbl.text = name;
    self.moneyLbl.text = money;
    self.robMoneyLbl.text = robMoney;
    self.userIdLbl.text = NSStringFormat(@"码师:%@",userId);
    self.button.hidden = !isShow;
    if (KJudgeIsNullData(photo)) {
        [self.photoImage sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:nil];
    }
    if ([userId isEqualToString:kUserMessageManager.userId]) {
        self.button.hidden = NO;
    }else {
        self.button.hidden = YES;;
    }
    if (isShow == 0) {
        self.betweenValue.constant = 11;
        
    }else {
        self.betweenValue.constant = 0;
        if (isShow == 1) {
            self.robMoneyLbl.textColor = ColorHexadecimal(0xf6a623, 1.0);
        }else {
            self.robMoneyLbl.textColor = ColorHexadecimal(0x01b9fd, 1.0);
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

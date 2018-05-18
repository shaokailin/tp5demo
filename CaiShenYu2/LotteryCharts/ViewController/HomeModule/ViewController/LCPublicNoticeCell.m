//
//  LCPublicNoticeCell.m
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/3.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LCPublicNoticeCell.h"
@interface LCPublicNoticeCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UIView *redCircle;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
@property (weak, nonatomic) IBOutlet UIView *bottonView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonViewHeight;

@end
@implementation LCPublicNoticeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDetailClick)];
    [self.bottonView addGestureRecognizer:tap];
    ViewBoundsRadius(self.timeLbl, 10);
    ViewRadius(self.redCircle, 5.5);
}
- (void)setupCellContent:(NSString *)title detail:(NSString *)detail time:(NSString *)time isShowRed:(BOOL)isRed isShowDetail:(BOOL)isShow {
    self.titleLbl.text = title;
    self.contentLbl.text = detail;
    self.timeLbl.text = NSStringFormat(@"   %@   ",time);
    self.redCircle.hidden = isRed;
    self.buttonViewHeight.constant = isShow?47:0;
    self.bottonView.hidden = !isShow;
}
- (void)showDetailClick {
    if (self.block) {
        self.block(self);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

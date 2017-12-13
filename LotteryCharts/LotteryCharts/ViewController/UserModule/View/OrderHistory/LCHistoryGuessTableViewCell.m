//
//  LCHistoryGuessTableViewCell.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCHistoryGuessTableViewCell.h"
@interface LCHistoryGuessTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *postIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *typeLbl;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *countLbl;
@property (weak, nonatomic) IBOutlet UILabel *hascountLbl;
@property (weak, nonatomic) IBOutlet UILabel *stateLbl;

@end
@implementation LCHistoryGuessTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ViewBoundsRadius(self.typeLbl, 8.0);
    ViewBorderLayer(self.typeLbl, [UIColor redColor], 0.5);
}
- (void)setupCellContent:(NSString *)postId time:(NSString *)time type:(NSInteger)type title:(NSString *)title payMoney:(NSString *)money hasBuy:(NSString *)hasBuy betState:(NSInteger)state {
    self.postIdLbl.text = NSStringFormat(@"帖子ID:%@",postId);
    self.timeLbl.text = NSStringFormat(@"%@发布",time);
    if (type == 2) {
        self.typeLbl.text = @"杀两码";
    }else {
        self.typeLbl.text = @"猜大小";
    }
    self.titleLbl.text = title;
    self.countLbl.text = NSStringFormat(@"%@银币/1份",money);
    self.hascountLbl.text = NSStringFormat(@"已挑战%@份",hasBuy);
    if (state == 0) {
        self.stateLbl.text = @"挑战失败";
        self.stateLbl.textColor = ColorHexadecimal(0x535353, 1.0);
    }else {
        self.stateLbl.text = @"挑战成功";
        self.stateLbl.textColor = [UIColor redColor];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

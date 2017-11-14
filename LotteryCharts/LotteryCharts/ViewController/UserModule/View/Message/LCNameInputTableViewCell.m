//
//  LCNameInputTableViewCell.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCNameInputTableViewCell.h"
@interface LCNameInputTableViewCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameField;

@end
@implementation LCNameInputTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    @weakify(self)
    [[self.nameField.rac_textSignal skip:1] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self)
        if (self.nameBlock) {
            self.nameBlock(x);
        }
    }];
    
}
- (void)setupCellContentWithName:(NSString *)name {
    self.nameField.text = name;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.nameField resignFirstResponder];
    return YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

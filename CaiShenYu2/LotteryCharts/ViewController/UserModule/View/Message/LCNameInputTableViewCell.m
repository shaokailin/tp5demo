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
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (nonatomic, assign) NSInteger type;
@end
@implementation LCNameInputTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    @weakify(self)
    [[self.nameField.rac_textSignal skip:1] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self)
        if (self.nameBlock) {
            self.nameBlock(x,self.type);
        }
    }];
    
}
- (void)setupCellContentWithName:(NSString *)name type:(NSInteger)type {
    self.nameField.text = name;
    self.type = type;
    if (type == 0) {
        self.nameLbl.text = @"昵称";
        self.nameField.placeholder = @"请输入昵称";
    }else {
        if (name.length > 0) {
            self.nameField.userInteractionEnabled = NO;
        } else {
            self.nameField.userInteractionEnabled = YES;
        }
        
        self.nameLbl.text = @"推荐码师";
        self.nameField.placeholder = @"推荐码师ID号，非必填";
    }
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

//
//  FocusTableViewCell.h
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/4/28.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FocusTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *touImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *VIPButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

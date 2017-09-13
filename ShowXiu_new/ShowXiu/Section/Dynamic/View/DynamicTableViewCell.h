//
//  DynamicTableViewCell.h
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/4/18.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DynamicTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *touImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *VIPButton;
@property (weak, nonatomic) IBOutlet UILabel *neiLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *contionView;
@property (weak, nonatomic) IBOutlet UIButton *XBButton;

@end

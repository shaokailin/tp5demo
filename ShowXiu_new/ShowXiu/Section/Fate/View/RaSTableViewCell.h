//
//  RaTableViewCell.h
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/5/8.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RaSTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *hangImageView;
@property (weak, nonatomic) IBOutlet UILabel *mingciLabel;
@property (weak, nonatomic) IBOutlet UIImageView *touImageView;
@property (weak, nonatomic) IBOutlet UIImageView *VIP;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *caifuLabel;
@property (weak, nonatomic) IBOutlet UIButton *xingButton;
@property (weak, nonatomic) IBOutlet UILabel *songLabel;

@end

//
//  PictureCollectionViewCell.h
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/3/3.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *TuimageView;
@property (weak, nonatomic) IBOutlet UILabel *shiLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *juLabel;
@property (weak, nonatomic) IBOutlet UIButton *xingB;
@property (weak, nonatomic) IBOutlet UIButton *anniuButton;

@end

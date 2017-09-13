//
//  MianImageAllTableViewCell.h
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/6/10.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MianAllModel.h"
@interface MianImageAllTableViewCell : UITableViewCell
@property (nonatomic, strong)UILabel *wenziLabel;
@property (nonatomic, strong)UILabel *suzilabel;
@property (nonatomic, strong)UIButton * hengButton;

@property (nonatomic, strong)NSMutableArray *dataMutableArray;
@property (nonatomic, strong) UIViewController *superVC;
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, copy)NSString *UID;
@property (nonatomic, strong) NSMutableArray *xiantuimageArray;
@property (nonatomic, copy)NSString *tyst;
@end

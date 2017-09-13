//
//  MessImageTableViewCell.h
//  SunShine
//
//  Created by 阳光互联 on 16/8/31.
//  Copyright © 2016年 阳光互联. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageSSModel;
@interface MessImageTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel * timeLabel;//时间
@property(nonatomic,strong)UIImageView * headImage;//头像
@property(nonatomic,strong)UIButton * headBtn;
@property(nonatomic,strong)UIButton * backBtn;//背景试图
@property(nonatomic,strong)UIImageView * ipickImage;//图片试图

@property(nonatomic,strong)UIView * deleViwq;//删除复制背景UIview
@property(nonatomic,strong)UIButton * deleBbbtn;//删除按钮
@property (nonatomic, strong)UIViewController *superVC;

@property(nonatomic,strong)MessageSSModel * messFriendModel;
+ (instancetype)cellWithImageTableView:(UITableView *)tableView;
+ (CGFloat)heightOfImageCellWithMessage:(NSString *)images imagData:(NSString *)imagedatas nstime:(NSString *)timess;
@end

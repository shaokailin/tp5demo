//
//  MessTxtContentTableViewCell.h
//  SunShine
//
//  Created by 阳光互联 on 16/8/31.
//  Copyright © 2016年 阳光互联. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageSSModel;
@interface MessTxtContentTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel * timeLabel;//时间
@property(nonatomic,strong)UIImageView * headImage;//头像
@property(nonatomic,strong)UIButton * headBtn;
@property(nonatomic,strong)UIButton * backBtn;//背景试图
@property(nonatomic,strong)UILabel * contentLabel;//文字试图
@property(nonatomic,strong)UIView * deleViwq;//删除复制背景UIview
@property(nonatomic,strong)UIButton * deleBbbtn;//删除按钮
@property(nonatomic,strong)UIButton * fuzhiBnttn;//复制按钮
@property(nonatomic,strong)UILabel * xianlabek;//线


@property(nonatomic,strong)MessageSSModel * messFriendModel;
+ (instancetype)cellWithTxtTableView:(UITableView *)tableView;
+ (CGFloat)heightOfTxtCellWithMessage:(NSString *)textContent nstime:(NSString *)timess;

@end

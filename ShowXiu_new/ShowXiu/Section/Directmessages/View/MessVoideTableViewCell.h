//
//  MessVoideTableViewCell.h
//  SunShine
//
//  Created by 阳光互联 on 16/8/31.
//  Copyright © 2016年 阳光互联. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageSSModel;
@interface MessVoideTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel * timeLabel;//时间
@property(nonatomic,strong)UIImageView * headImage;//头像
@property(nonatomic,strong)UIButton * headBtn;
@property(nonatomic,strong)UIButton * backBtn;//背景试图
//@property(nonatomic,strong)UIButton * yuyinBtn;//语音试图
@property(nonatomic,strong)UILabel * timwsLabel;//时间label
@property(nonatomic,strong)UIImageView * mesYuImage;//发过去的语音
//@property(nonatomic,strong)UIImageView * youYuIMage;//发过来的语音
@property(nonatomic,strong)UIView * deleViwq;//删除复制背景UIview
@property(nonatomic,strong)UIButton * deleBbbtn;//删除按钮

@property(nonatomic,strong)MessageSSModel * messFriendModel;
+ (instancetype)cellWithVoideTableView:(UITableView *)tableView;
+ (CGFloat)heightOfVoideCellWithMessage:(NSString *)voide yuyin:(NSString *)yuYindata nstime:(NSString *)timess;

@end

//
//  MessTiShiTableViewCell.h
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/6/20.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageSSModel;

@interface MessTiShiTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel * timeLabel;//时间
@property(nonatomic,strong)UIImageView * headImage;//头像
@property(nonatomic,strong)UIButton * headBtn;
@property(nonatomic,strong)UIButton * backBtn;//背景试图
@property(nonatomic,strong)UILabel * contentLabel;//文字试图
@property(nonatomic,strong)UIView * deleViwq;//删除复制背景UIview
@property(nonatomic,strong)UIButton * deleBbbtn;//删除按钮
@property(nonatomic,strong)UIButton * fuzhiBnttn;//复制按钮
@property(nonatomic,strong)UILabel * xianlabek;//线
@property(nonatomic, strong)UIView *tiView;



@property(nonatomic,strong)MessageSSModel * messFriendModel;
+ (instancetype)cellWithTxtTableView:(UITableView *)tableView;
+ (CGFloat)heightOfTxtCellWithMessage:(NSString *)textContent nstime:(NSString *)timess;

@end

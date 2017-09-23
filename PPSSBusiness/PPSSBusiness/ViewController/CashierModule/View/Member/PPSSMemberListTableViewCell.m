//
//  PPSSMemberListTableViewCell.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/20.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSMemberListTableViewCell.h"
#import "UIImageView+WebCache.h"
@interface PPSSMemberListTableViewCell ()
@property (nonatomic, weak) UILabel *nameLbl;
@property (nonatomic, weak) UILabel *phoneLbl;
@property (nonatomic, weak) UILabel *contentLbl;
@property (nonatomic, weak) UIImageView *photoImageView;
@end
@implementation PPSSMemberListTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = 0;
        [self _layoutMainView];
    }
    return self;
}
- (void)setupUserPhoto:(NSString *)photo name:(NSString *)name
                 phone:(NSString *)phone storedValue:(NSString *)storedValue
              integral:(NSString *)integral payCount:(NSString *)payCount {
    if ([photo isHasValue]) {
        [_photoImageView sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:ImageNameInit(@"photoerror")];
    }else {
        _photoImageView.image = ImageNameInit(@"nophoto");
    }
    _nameLbl.text = name;
    _phoneLbl.text = phone;
    _contentLbl.text = NSStringFormat(@"消费次数：%@  /  积分：%@  /  储值：%@",payCount,integral,storedValue);
}
- (void)_layoutMainView {
    UIImageView *photoImageView = [[UIImageView alloc]init];
    ViewRadius(photoImageView, 5.0);
    photoImageView.layer.masksToBounds = YES;
    self.photoImageView = photoImageView;
    [self.contentView addSubview:photoImageView];
    WS(ws)
    [photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).with.offset(15);
        make.size.mas_offset(CGSizeMake(60, 60));
        make.centerY.equalTo(ws.contentView);
    }];
    
    UILabel *nameLbl = [PPSSPublicViewManager initLblForColor3333:nil textAlignment:0];
    self.nameLbl = nameLbl;
    [self.contentView addSubview:nameLbl];
    [nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(photoImageView.mas_right).with.offset(10);
        make.top.equalTo(ws.contentView).with.offset(13);
    }];
    
    UILabel *phoneLbl = [PPSSPublicViewManager initLblForColor9999:nil];
    self.phoneLbl = phoneLbl;
    [self.contentView addSubview:phoneLbl];
    [phoneLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLbl);
        make.top.equalTo(nameLbl.mas_bottom).with.offset(11);
    }];
    
    UILabel *contentLbl = [PPSSPublicViewManager initLblForColor6666:nil];
    self.contentLbl = contentLbl;
    [self.contentView addSubview:contentLbl];
    [contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLbl);
        make.top.equalTo(phoneLbl.mas_bottom).with.offset(7);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

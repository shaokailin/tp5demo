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
                 phone:(NSString *)phone feetotal:(NSString *)feetotal
              payCount:(NSString *)payCount userStore:(NSString *)userStore {
    if (KJudgeIsNullData(photo)) {
        [_photoImageView sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:ImageNameInit(@"photoerror")];
    }else {
        _photoImageView.image = ImageNameInit(@"nophoto");
    }
    _nameLbl.text = name;
    _phoneLbl.text = phone;
    [self changeCotentStyleWithFeetotal:feetotal payCount:payCount userStore:userStore];
}
- (void)changeCotentStyleWithFeetotal:(NSString *)feetotal
                                payCount:(NSString *)payCount userStore:(NSString *)userStore {
    NSString *content = NSStringFormat(@"消费总额：%@  /  消费次数：%@  /  储值：%@",feetotal,payCount,userStore);
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:content];
    NSArray *compare = [content componentsSeparatedByString:@"："];
    if (compare.count > 0) {
        for (int i = 0; i < compare.count - 1; i++) {
            if (i == 0) {
                [attributedString addAttribute:NSForegroundColorAttributeName value:ColorHexadecimal(0xf35975, 1.0) range:NSMakeRange(5, feetotal.length)];
            }else {
                NSRange range = [content rangeOfString:[compare objectAtIndex:i]];
                if (range.location != NSNotFound) {
                    [attributedString addAttribute:NSForegroundColorAttributeName value:i == 1?ColorHexadecimal(0x3c9efa, 1.0):ColorHexadecimal(0xff8533, 1.0) range:NSMakeRange(range.location + range.length + 1, (i == 1?payCount.length:userStore.length))];
                }
            }
        }
    }
    _contentLbl.attributedText = attributedString;
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
        make.top.equalTo(ws.contentView).with.offset(9);
    }];
    
    UILabel *phoneLbl = [PPSSPublicViewManager initLblForColor9999:nil];
    self.phoneLbl = phoneLbl;
    [self.contentView addSubview:phoneLbl];
    [phoneLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLbl);
        make.top.equalTo(nameLbl.mas_bottom).with.offset(10);
    }];
    
    UILabel *contentLbl = [PPSSPublicViewManager initLblForColor6666:nil];
    self.contentLbl = contentLbl;
    [self.contentView addSubview:contentLbl];
    [contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLbl);
        make.top.equalTo(phoneLbl.mas_bottom).with.offset(8);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

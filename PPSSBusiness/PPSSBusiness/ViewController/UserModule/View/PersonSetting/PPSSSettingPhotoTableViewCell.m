//
//  PPSSSettingPhotoTableViewCell.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/22.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSSettingPhotoTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation PPSSSettingPhotoTableViewCell
{
    UIImageView *_photoImgView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = 0;
        [self _layoutMainView];
    }
    return self;
}

- (void)setupContentWithPhoto:(id)photo {
    if ([photo isHasValue]) {
        if ([photo isKindOfClass:[UIImage class]]) {
            _photoImgView.image = photo;
        }else {
            [_photoImgView sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:ImageNameInit(@"photoerror")];
        }
    }else {
        _photoImgView.image = ImageNameInit(@"nophoto");
    }
}
- (void)_layoutMainView {
    UILabel *titleLbl = [PPSSPublicViewManager initLblForColor3333:@"头像" textAlignment:0];
    [self.contentView addSubview:titleLbl];
    WS(ws)
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).with.offset(15);
        make.centerY.equalTo(ws.contentView);
    }];
    
    UIImageView *arrowImg = [[UIImageView alloc]initWithImage:ImageNameInit(@"arrow_right")];
    [self.contentView addSubview:arrowImg];
    [arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView).with.offset(-15);
        make.centerY.equalTo(ws.contentView);
        make.width.mas_equalTo(7);
    }];
    
    _photoImgView = [[UIImageView alloc]init];
    ViewBoundsRadius(_photoImgView, 25);
    ViewBorderLayer(_photoImgView, ColorHexadecimal(kMainBackground_Color, 1.0), LINEVIEW_WIDTH);
    [self.contentView addSubview:_photoImgView];
    [_photoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(arrowImg.mas_left).with.offset(-8);
        make.centerY.equalTo(ws.contentView);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

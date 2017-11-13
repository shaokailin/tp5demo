//
//  LCUserHomeHeaderView.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCUserHomeHeaderView.h"
#import "GPUImage.h"
#import "UIImageView+WebCache.h"
@implementation LCUserHomeHeaderView
{
    UIImageView *_userPhotoImageView;
    UIImageView *_bgImageView;
    UILabel *_nameLbl;
    UILabel *_userIdLbl;
    UILabel *_attentionLbl;
    UILabel *_teamLbl;
    GPUImageGaussianBlurFilter * _blurFilter;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)changeBgImage:(id)bgImage {
    if ([bgImage isKindOfClass:[UIImage class]]) {
        [self setupBgImage:bgImage];
    }else if (KJudgeIsNullData(bgImage)){
        @weakify(self)
        [_bgImageView sd_setImageWithURL:[NSURL URLWithString:bgImage] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            @strongify(self)
            if (error == nil) {
                [self setupBgImage:image];
            }
        }];
    }else {
        [self setupBgImage:ImageNameInit(@"userbgImage")];
    }
}
- (void)changeUserPhoto:(id)photo {
    if ([photo isKindOfClass:[UIImage class]]) {
        _userPhotoImageView.image = photo;
    }else if (KJudgeIsNullData(photo)){
        [_userPhotoImageView sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:nil];
    }
}
- (void)setupBgImage:(UIImage *)image {
    [self customBlurFilter];
    _bgImageView.image = [_blurFilter imageByFilteringImage:image];
}
- (GPUImageGaussianBlurFilter *)customBlurFilter {
    if (!_blurFilter) {
        GPUImageGaussianBlurFilter * blurFilter = [[GPUImageGaussianBlurFilter alloc] init];
        blurFilter.blurRadiusInPixels = 9.0;
        _blurFilter = blurFilter;
    }
    return _blurFilter;
}
- (void)setupContentWithName:(NSString *)name userid:(NSString *)userId attention:(NSString *)attention teem:(NSString *)teem {
    _nameLbl.text = name;
    _userIdLbl.text = NSStringFormat(@"我的ID:%@",userId);
    _attentionLbl.text = attention;
    _teamLbl.text = teem;
}
- (void)punchCardAction {
    if (self.punchBlock) {
        self.punchBlock(3);
    }
}
- (void)changeBgImage {
    if (self.punchBlock) {
        self.punchBlock(1);
    }
}
- (void)changePhotoImage {
    if (self.punchBlock) {
        self.punchBlock(2);
    }
}
- (void)_layoutMainView {
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    bgImageView.clipsToBounds=YES;
    bgImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeBgImage)];
    [bgImageView addGestureRecognizer:bgTap];
    _bgImageView = bgImageView;
    [self addSubview:bgImageView];
    [self changeBgImage:nil];
    UIView *photoBgView = [[UIView alloc]init];
    photoBgView.backgroundColor = ColorHexadecimal(0xe5e5e5, 0.5);
    ViewRadius(photoBgView, 50);
    [self addSubview:photoBgView];
    WS(ws)
    [photoBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws).with.offset(80);
        make.centerX.equalTo(ws);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    ViewBoundsRadius(imageView, 45);
    imageView.backgroundColor = ColorHexadecimal(0xe5e5e5, 1.0);
    _userPhotoImageView = imageView;
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *photoTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changePhotoImage)];
    [imageView addGestureRecognizer:photoTap];
    [photoBgView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(photoBgView);
        make.size.mas_equalTo(CGSizeMake(90, 90));
    }];
    
    UILabel *nameLbl = [LSKViewFactory initializeLableWithText:nil font:15 textColor:[UIColor whiteColor] textAlignment:0 backgroundColor:nil];
    _nameLbl = nameLbl;
    [self addSubview:nameLbl];
    [nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(photoBgView.mas_bottom).with.offset(10);
        make.centerX.equalTo(ws);
    }];
    
    UIButton *punchBtn = [LSKViewFactory initializeButtonNornalImage:@"punchcard" selectedImage:@"punchcard" target:self action:@selector(punchCardAction)];
    [self addSubview:punchBtn];
    [punchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(45, 45));
        make.centerY.equalTo(nameLbl.mas_bottom).with.offset(-5);
    }];
    
    
    UILabel *useridLbl = [LSKViewFactory initializeLableWithText:nil font:10 textColor:[UIColor whiteColor] textAlignment:0 backgroundColor:nil];
    _userIdLbl = useridLbl;
    [self addSubview:useridLbl];
    [useridLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLbl.mas_bottom).with.offset(10);
        make.centerX.equalTo(ws);
    }];
    
    [self _layoutUserMessage];
    
}
- (void)_layoutUserMessage {
    WS(ws)
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = ColorRGBA(255, 255, 255, 0.9);
    ViewRadius(view, 5.0);
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(10);
        make.bottom.equalTo(ws).with.offset(-10);
        make.width.mas_equalTo(SCREEN_WIDTH - 20);
        make.height.mas_equalTo(50);
    }];
    
    UIView *lineView = [LSKViewFactory initializeLineView];
    [view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kLineView_Height, 25));
        make.center.equalTo(view);
    }];
    
    UILabel *atentionTitleLbl = [LSKViewFactory initializeLableWithText:@"关注" font:12 textColor:ColorHexadecimal(0xbfbfbf, 1.0) textAlignment:1 backgroundColor:nil];
    [view addSubview:atentionTitleLbl];
    [atentionTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).with.offset(8);
        make.left.equalTo(view).with.offset(5);
        make.right.equalTo(lineView.mas_left).with.offset(-5);
    }];
    
    UILabel *teemTitleLbl = [LSKViewFactory initializeLableWithText:@"团队" font:12 textColor:ColorHexadecimal(0xbfbfbf, 1.0) textAlignment:1 backgroundColor:nil];
    [view addSubview:teemTitleLbl];
    [teemTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(atentionTitleLbl);
        make.right.equalTo(view).with.offset(-5);
        make.left.equalTo(lineView.mas_right).with.offset(5);
    }];
    UILabel *atentionLbl = [LSKViewFactory initializeLableWithText:nil font:15 textColor:ColorHexadecimal(0xf6a623, 1.0) textAlignment:1 backgroundColor:nil];
    _attentionLbl = atentionLbl;
    [view addSubview:atentionLbl];
    [atentionLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(atentionTitleLbl);
        make.top.equalTo(atentionTitleLbl.mas_bottom).with.offset(6);
    }];
    
    UILabel *teemLbl = [LSKViewFactory initializeLableWithText:nil font:15 textColor:ColorHexadecimal(0xf6a623, 1.0) textAlignment:1 backgroundColor:nil];
    _teamLbl = teemLbl;
    [view addSubview:teemLbl];
    [teemLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(teemTitleLbl);
        make.top.equalTo(teemTitleLbl.mas_bottom).with.offset(6);
    }];
}
@end
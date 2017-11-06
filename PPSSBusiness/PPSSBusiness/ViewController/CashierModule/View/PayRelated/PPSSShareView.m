//
//  PPSSShareView.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/24.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSShareView.h"
#import <UMSocialCore/UMSocialCore.h>
static const NSInteger kContentViewHeight = 125;
@implementation PPSSShareView
{
    ShareTypeBlock _shareBlock;
    UIView *_contentView;
    UIView *_bgView;
    CGFloat _tabbarHeight;
}
+ (BOOL)isCanShareForPlatforms {
    if (![[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession] && ![[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ] && ![[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Qzone]
        ) {
        return NO;
    }else {
        return YES;
    }
}
- (instancetype)initWithShareBlock:(ShareTypeBlock)typeBlock tabbarHeight:(CGFloat)height {
    if (self = [super init]) {
        _shareBlock = typeBlock;
        _tabbarHeight = height;
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self _layoutMainView];
    }
    return self;
}
- (void)shopInView {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        _contentView.frame = CGRectMake(0, SCREEN_HEIGHT - kContentViewHeight - _tabbarHeight, SCREEN_WIDTH, kContentViewHeight);
        _bgView.alpha = 1;
    }];
}
- (void)hidenView {
    [UIView animateWithDuration:0.25 animations:^{
        _contentView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, kContentViewHeight);
        _bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark - 界面初始化
- (void)_layoutMainView {
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _bgView.backgroundColor = ColorRGBA(0, 0, 0, 0.5);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidenView)];
    [_bgView addGestureRecognizer:tap];
    _bgView.alpha = 0;
    [self addSubview:_bgView];
    [self _layoutContentView];
}
- (void)_layoutContentView {
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, kContentViewHeight)];
    contentView.backgroundColor = COLOR_WHITECOLOR;
    _contentView = contentView;
    [self addSubview:contentView];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = ColorHexadecimal(0xcdcdcd, 1.0);
    [_contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(contentView);
        make.height.mas_equalTo(LINEVIEW_WIDTH);
    }];
    
    UIView *lineView1 = [PPSSPublicViewManager initializeLineView];
    [_contentView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.bottom.equalTo(contentView).with.offset(-40);
        make.height.mas_equalTo(LINEVIEW_WIDTH);
    }];
//    [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]
    BOOL isWeixin = YES;
    CGFloat btnWidth = (SCREEN_WIDTH - 14) / 4.0;
    UIButton *wxBtn;
    WS(ws)
    if (isWeixin) {
        UIButton *wxcircleBtn = [self customBtnWithTitle:@"微信朋友圈" image:@"wxquan" tag:202];
        [_contentView addSubview:wxcircleBtn];
        [wxcircleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws).with.offset(7);
            make.top.equalTo(lineView.mas_bottom);
            make.bottom.equalTo(lineView1.mas_top);
            make.width.mas_equalTo(btnWidth);
        }];
        UIButton *wxfriend = [self customBtnWithTitle:@"微信好友" image:@"wxfriend" tag:201];
        [_contentView addSubview:wxfriend];
        [wxfriend mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.top.bottom.equalTo(wxcircleBtn);
            make.left.equalTo(wxcircleBtn.mas_right);
        }];
        wxBtn = wxfriend;
    }
//    if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ] || [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Qzone]) {
        UIButton *qqcircleBtn = [self customBtnWithTitle:@"QQ空间" image:@"qqspace" tag:205];
//        if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ]) {
             UIButton *qqfriend = [self customBtnWithTitle:@"QQ好友" image:@"qqfriend" tag:204];
            [_contentView addSubview:qqfriend];
            if (wxBtn) {
                [qqfriend mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.top.bottom.equalTo(wxBtn);
                    make.left.equalTo(wxBtn.mas_right);
                }];
            }else {
                [qqfriend mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(ws).with.offset(7);
                    make.top.equalTo(lineView.mas_bottom);
                    make.bottom.equalTo(lineView1.mas_top);
                    make.width.mas_equalTo(btnWidth);
                }];
            }
            wxBtn = qqfriend;
//        }
        [_contentView addSubview:qqcircleBtn];
        if (wxBtn) {
            [qqcircleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.top.bottom.equalTo(wxBtn);
                make.left.equalTo(wxBtn.mas_right);
            }];
        }else {
            [qqcircleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(ws).with.offset(7);
                make.top.equalTo(lineView.mas_bottom);
                make.bottom.equalTo(lineView1.mas_top);
                make.width.mas_equalTo(btnWidth);
            }];
        }
//    }
    UIButton *cancleBtn = [LSKViewFactory initializeButtonWithTitle:@"取消" nornalImage:nil selectedImage:nil target:self action:@selector(hidenView) textfont:18 textColor: ColorHexadecimal(Color_Text_3333, 1.0) backgroundColor:nil backgroundImage:nil];
    [_contentView addSubview:cancleBtn];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(contentView);
        make.top.equalTo(lineView1.mas_bottom);
        make.left.right.equalTo(contentView);
    }];
}

- (UIButton *)customBtnWithTitle:(NSString *)title image:(NSString *)image tag:(NSInteger)tag {
    UIButton *btn = [LSKViewFactory initializeButtonWithTitle:nil nornalImage:nil selectedImage:nil target:self action:@selector(selectBtnClick:) textfont:0 textColor:nil backgroundColor:nil backgroundImage:nil];
    btn.tag = tag;
    UIImageView *imageView = [[UIImageView alloc]initWithImage:ImageNameInit(image)];
    [btn addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn).with.offset(10);
        make.centerX.equalTo(btn);
    }];
    UILabel *titleLbl = [PPSSPublicViewManager initLblForColor6666:title];
    [btn addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).with.offset(4);
        make.centerX.equalTo(imageView);
    }];
    return btn;
}

- (void)selectBtnClick:(UIButton *)btn {
    if (_shareBlock) {
        _shareBlock(btn.tag - 200);
    }
    [self hidenView];
}
@end

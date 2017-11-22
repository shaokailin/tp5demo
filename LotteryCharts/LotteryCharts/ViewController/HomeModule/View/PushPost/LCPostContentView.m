//
//  LCPostContentView.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/22.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCPostContentView.h"
@interface LCPostContentView ()
@property (nonatomic, strong) NSMutableArray *photoArray;
@property (nonatomic, weak) UILabel *placeHoldLbl;
@property (nonatomic, weak) UIButton *takeImageBtn;
@property (nonatomic, weak) UIButton *takeVoiceBtn;
@property (nonatomic, weak) UILabel *timeLbl;
@property (nonatomic, weak) UIButton *delectVoiceBtn;
@property (nonatomic, assign) BOOL isVoice;
@end
@implementation LCPostContentView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self _layoutMainView];
    }
    return self;
}
- (void)takePhotoClick {
    if (!_photoArray || _photoArray.count < 3) {
        if (self.mediaBlock) {
            self.mediaBlock(0);
        }
    }
}
- (void)addClick:(UIButton *)btn {
    NSInteger index = btn.tag - 300;
    if (!_photoArray || (_photoArray.count != 3 && _photoArray.count <= index)) {
        if (self.mediaBlock) {
            self.mediaBlock(0);
        }
    }
}
- (void)takeVoiceClick {
    if (!self.isVoice) {
        if (self.mediaBlock) {
            self.mediaBlock(1);
        }
    }
}
- (void)addImage:(UIImage *)image {
    if (self.frame.size.height != 276 && self.isVoice) {
        if (self.frameBlock) {
            self.frameBlock(276);
        }
    }else if (self.frame.size.height != 230 && !self.isVoice) {
        if (self.frameBlock) {
            self.frameBlock(230);
        }
    }
    if (self.contentTextView.frame.size.height != 85) {
        [self.contentTextView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(85);
        }];
    }
    if (!_photoArray || _photoArray.count == 0) {
        WS(ws)
        if (self.isVoice) {
            [self.takeVoiceBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(ws).with.offset(20);
                make.bottom.equalTo(ws).with.offset(-20);
                make.size.mas_equalTo(CGSizeMake(25, 25));
            }];
        }else {
            [self.takeVoiceBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(ws).with.offset(-20);
                make.bottom.equalTo(ws).with.offset(-20);
                make.size.mas_equalTo(CGSizeMake(25, 25));
            }];
        }
    }
    [self.photoArray addObject:image];
    self.takeImageBtn.hidden = YES;
    [self setupImageView];
}
- (void)setupImageView {
    NSInteger max = self.photoArray.count >= 3 ? 3:(self.photoArray.count == 0? 0: self.photoArray.count + 1);
    for (int i = 0; i < 3; i++) {
        UIView *photoView = [self viewWithTag:200 + i];
        if (i < max) {
            if (!photoView) {
                photoView = [self customImageViewWithFlag:i];
                photoView.frame = CGRectMake(i * (87.5 + 3.5) + 20, 132, 87.5, 87.5);
                [self addSubview:photoView];
            }
            UIButton *photoBtn = [photoView viewWithTag:300 + i];
            UIButton *delectBtn = [photoView viewWithTag:400 + i];
            if (i < self.photoArray.count) {
                [photoBtn setImage:[self.photoArray objectAtIndex:i] forState:UIControlStateNormal];
                delectBtn.hidden = NO;
            }else {
                [photoBtn setImage:ImageNameInit(@"imageAdd") forState:UIControlStateNormal];
                delectBtn.hidden = YES;
            }
        }else {
            if (photoView) {
                [photoView removeFromSuperview];
            }
        }
    }
    
}

- (void)delectImage:(UIButton *)btn {
    NSInteger tag = btn.tag - 400;
    [self.photoArray removeObjectAtIndex:tag];
    [self setupImageView];
    
    if (self.photoArray.count == 0) {
        self.takeImageBtn.hidden = NO;
        if (self.frame.size.height != 230) {
            if (self.frameBlock) {
                self.frameBlock(230);
            }
        }
        if (self.contentTextView.frame.size.height != 130) {
            [self.contentTextView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(130);
            }];
        }
        if (!_photoArray || _photoArray.count == 0) {
            WS(ws)
            [self.takeVoiceBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(ws).with.offset(60);
                make.bottom.equalTo(ws).with.offset(-20);
                make.size.mas_equalTo(CGSizeMake(25, 25));
            }];
        }
    }
}

- (void)addVoice:(id)voice {
    self.isVoice = YES;
    self.delectVoiceBtn.hidden = NO;
    self.timeLbl.text = @"45'";
    [self.takeVoiceBtn setImage:ImageNameInit(@"voice_icon") forState:UIControlStateNormal];
    if (self.frame.size.height != 276 && self.isVoice && self.photoArray.count > 0) {
        if (self.frameBlock) {
            self.frameBlock(276);
        }
    }else if (self.frame.size.height != 230) {
        if (self.frameBlock) {
            self.frameBlock(230);
        }
    }
    WS(ws)
    if (self.photoArray.count > 0) {
        [self.takeVoiceBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws).with.offset(20);
            make.bottom.equalTo(ws).with.offset(-20);
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];
    }else {
        [self.takeVoiceBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws).with.offset(60);
            make.bottom.equalTo(ws).with.offset(-20);
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];
    }
}
- (void)delectVoice {
    self.isVoice = NO;
    self.delectVoiceBtn.hidden = YES;
    self.timeLbl.text = nil;
    [self.takeVoiceBtn setImage:ImageNameInit(@"takeVoice") forState:UIControlStateNormal];
    if (self.frame.size.height != 230 ) {
        if (self.frameBlock) {
            self.frameBlock(230);
        }
    }
    [self changeFrame];
}
- (void)changeFrame {
    WS(ws)
    if (self.photoArray.count > 0) {
        [self.takeVoiceBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(ws).with.offset(-20);
            make.bottom.equalTo(ws).with.offset(-20);
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];
    }else {
        [self.takeVoiceBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws).with.offset(60);
            make.bottom.equalTo(ws).with.offset(-20);
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];
    }
}
- (void)_layoutMainView {
    WS(ws)
    UIView *lineView = [LSKViewFactory initializeLineView];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(20);
        make.right.equalTo(ws).with.offset(-20);
        make.height.mas_equalTo(kLineView_Height);
        make.top.equalTo(ws).with.offset(40);
    }];
    
    UITextField *field = [LSKViewFactory initializeTextFieldWithDelegate:self text:nil placeholder:@"请输入标题" textFont:15 textColor:ColorHexadecimal(0x434343, 1.0) placeholderColor:ColorHexadecimal(0xbfbfbf, 1.0) textAlignment:0 borStyle:0 returnKey:UIReturnKeyDone keyBoard:UIKeyboardTypeDefault cleanModel:0];
    self.titleField = field;
    [self addSubview:field];
    [field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(lineView);
        make.height.mas_equalTo(32);
    }];
    UITextView *textView = [[UITextView alloc]init];
    textView.textColor = ColorHexadecimal(0x434343, 1.0);
    textView.font = FontNornalInit(15);
    self.contentTextView = textView;
    [self addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lineView);
        make.top.equalTo(lineView.mas_bottom).with.offset(5);
        make.height.mas_equalTo(130);
    }];
    
    UILabel *placeLbl = [LSKViewFactory initializeLableWithText:@"请输入发布内容" font:15 textColor:ColorHexadecimal(0xbfbfbf, 1.0) textAlignment:0 backgroundColor:nil];
    self.placeHoldLbl = placeLbl;
    [textView addSubview:placeLbl];
    [placeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(textView).with.offset(1);
        make.top.equalTo(textView).with.offset(7);
    }];
    [[textView.rac_textSignal skip:1] subscribeNext:^(NSString * _Nullable x) {
        [ws textChange];
    }];
    
    UIButton *imageBtn = [LSKViewFactory initializeButtonNornalImage:@"takeImage" selectedImage:@"takeImage" target:self action:@selector(takePhotoClick)];
    self.takeImageBtn = imageBtn;
    [self addSubview:imageBtn];
    [imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(20);
        make.bottom.equalTo(ws).with.offset(-20);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    UIButton *voiceBtn = [LSKViewFactory initializeButtonNornalImage:@"takeVoice" selectedImage:nil target:self action:@selector(takeVoiceClick)];
    self.takeVoiceBtn = voiceBtn;
    [self addSubview:voiceBtn];
    [voiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(60);
        make.bottom.equalTo(ws).with.offset(-20);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    UILabel *timeLbl = [LSKViewFactory initializeLableWithText:nil font:12 textColor:ColorHexadecimal(0xbfbfbf, 1.0) textAlignment:0 backgroundColor:nil];
    self.timeLbl = timeLbl;
    [self addSubview:timeLbl];
    [timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(voiceBtn.mas_right).with.offset(5);
        make.bottom.equalTo(voiceBtn.mas_bottom).with.offset(4);
    }];
    UIButton *delectBtn = [LSKViewFactory initializeButtonWithTitle:@"删除" target:self action:@selector(delectVoice) textfont:12 textColor:ColorHexadecimal(0x434343, 1.0)];
    self.delectVoiceBtn = delectBtn;
    delectBtn.contentHorizontalAlignment = 1;
    delectBtn.hidden = YES;
    [self addSubview:delectBtn];
    [delectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeLbl.mas_right).with.offset(10);
        make.centerY.equalTo(timeLbl);
        make.size.mas_equalTo(CGSizeMake(40, 30));
    }];
}

- (void)textChange {
    if (self.contentTextView.text.length > 0) {
        self.placeHoldLbl.hidden = YES;
    }else {
        self.placeHoldLbl.hidden = NO;
    }
}
- (NSMutableArray *)photoArray {
    if (!_photoArray) {
        _photoArray = [NSMutableArray array];
    }
    return _photoArray;
}

- (UIView *)customImageViewWithFlag:(NSInteger)flag {
    UIView *imageView = [[UIView alloc]init];
    imageView.tag = 200 + flag;
    UIButton *photoImage = [LSKViewFactory initializeButtonNornalImage:nil selectedImage:nil target:self action:@selector(addClick:)];
    photoImage.layer.borderWidth = 1.;
    photoImage.layer.borderColor = ColorHexadecimal(0xbfbfbf, 1.0).CGColor;
    photoImage.frame = CGRectMake(0, 7.5, 80, 80);
    photoImage.tag = 300+flag;
    [imageView addSubview:photoImage];
    UIButton *delectBtn = [LSKViewFactory initializeButtonNornalImage:@"delectImage" selectedImage:@"delectImage@2x" target:self action:@selector(delectImage:)];
    delectBtn.frame = CGRectMake(80 - 7.5, 0, 15, 15);
    delectBtn.tag = 400 + flag;
    [imageView addSubview:delectBtn];
    return imageView;
}
@end

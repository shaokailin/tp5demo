//
//  LCPushPostMainVC.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/21.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCPushPostMainVC.h"
#import "LCPostTopView.h"
#import "LCPostShowTypeView.h"
#import "LCPostContentView.h"
#import "TPKeyboardAvoidingScrollView.h"
#import <AVFoundation/AVFoundation.h>
#import "LCPostVoiceView.h"
#import "LCPostAlertView.h"
#import "LCPushPostViewModel.h"
@interface LCPushPostMainVC ()
@property (nonatomic, weak) TPKeyboardAvoidingScrollView *mainScrollerView;
@property (nonatomic, weak) LCPostContentView *contentView;
@property (nonatomic, weak) LCPostShowTypeView *typeView;
@property (nonatomic, weak) LCPostTopView *bottonView;
@property (nonatomic, strong) LCPostVoiceView *voiceView;
@property (nonatomic, strong) LCPushPostViewModel *viewModel;
@end

@implementation LCPushPostMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发布帖子";
    [self addNavigationBackButton];
    [self initializeMainView];
    [self bindSignal];
}
- (void)pushPost {
    BOOL isAlert = [kUserMessageManager getMessageManagerForBoolWithKey:kPushPost_Alter];
    if (!isAlert) {
        @weakify(self)
        LCPostAlertView *alertView = [[[NSBundle mainBundle] loadNibNamed:@"LCPostAlertView" owner:self options:nil] lastObject];
        alertView.alertBlock = ^(NSInteger clickIndex) {
            if (clickIndex == 1) {
                @strongify(self)
                [self pushPostClick];
            }
        };
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:alertView];
        [alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(window);
        }];
    }else {
        [self pushPostClick];
    }
}
- (void)pushPostClick {
    self.viewModel.showType = self.typeView.currentShow;
    self.viewModel.showMoney = self.typeView.moneyFied.text;
    self.viewModel.isVoice = self.contentView.isVoice;
    self.viewModel.imageArray = self.contentView.photoArray;
    self.viewModel.time = self.contentView.timeString;
    [self.viewModel pushPostActionEvent];
}
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[LCPushPostViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        [self.navigationController popViewControllerAnimated:YES];
    } failure:nil];
    
    self.typeView.typeBlock = ^(NSInteger type) {
        @strongify(self)
        [self.view endEditing:YES];
        CGFloat height = self.typeView.frame.size.height;
        BOOL isNeedChange = NO;
        if (type != 1 && height != 107) {
            height = 107;
            isNeedChange = YES;
        }else if(type == 1 && height != 167) {
            height = 167;
            isNeedChange = YES;
        }
        if (isNeedChange) {
            [self.typeView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(height);
            }];
             self.mainScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, height + 184 + CGRectGetHeight(self.contentView.frame) + 30);
        }
    };
    self.contentView.frameBlock = ^(CGFloat height) {
        @strongify(self)
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
             self.mainScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetHeight(self.typeView.frame) + 184 + height + 30);
        }];
    };
    self.contentView.mediaBlock = ^(NSInteger type) {
        @strongify(self)
        [self.view endEditing:YES];
        if (type == 0) {
            UIActionSheet *sheetView = [[UIActionSheet alloc]initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"手机相册", nil];
            [sheetView.rac_buttonClickedSignal subscribeNext:^(NSNumber * _Nullable x) {
                @strongify(self)
                if ([x integerValue] == 0) {
                    [self takeCameraPhoto];
                }else if ([x integerValue] == 1){
                    [self takeLocationImage];
                }
            }];
            [sheetView showInView:self.view];
        }else {
            AVAudioSession *audioSession = [AVAudioSession sharedInstance];
            [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
            [audioSession setActive:YES error:nil];
            if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
                [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                    if (granted) {
                        // Microphone enabled code
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.voiceView.hidden = NO;
                        });
                    }
                    else {
                        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"提示" message:@"应用尚未获取访问麦克风的权限,如需使用请到系统设置->隐私->麦克风中开启" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        [alter show];
                    }
                }];
            }
        }
    };
    
    self.contentView.mediaDelectBlock = ^(NSInteger type, NSInteger index) {
        @strongify(self)
        [self.viewModel delectMedia:type index:index];
    };
    _viewModel.titleSignal = self.contentView.titleField.rac_textSignal;
    _viewModel.contentSignal = self.contentView.contentTextView.rac_textSignal;
    _viewModel.vipSignal = self.bottonView.moneyFied.rac_textSignal;
    [_viewModel bindPushPostSignal];
    self.bottonView.pushBlock = ^(BOOL isPush) {
        @strongify(self)
        [self pushPost];
    };
}
- (void)selectImage:(UIImage *)image {
    [self.contentView addImage:image];
}
- (LCPostVoiceView *)voiceView {
    if (!_voiceView) {
        _voiceView = [[[NSBundle mainBundle] loadNibNamed:@"LCPostVoiceView" owner:self options:nil] lastObject];
        @weakify(self)
        _voiceView.voiceBlock = ^(NSInteger time) {
            @strongify(self)
            [self.contentView addVoice:time];
        };
        [self.view addSubview:_voiceView];
        WS(ws)
        [_voiceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws.view);
        }];
    }
    return _voiceView;
}
- (void)initializeMainView {
    [self addRightNavigationButtonWithTitle:@"发布" target:self action:@selector(pushPost)];
    WS(ws)
    TPKeyboardAvoidingScrollView *mainScrollerView = [LSKViewFactory initializeTPScrollView];
    mainScrollerView.backgroundColor = ColorHexadecimal(kMainBackground_Color, 1.0);
    self.mainScrollerView = mainScrollerView;
    [self.view addSubview:mainScrollerView];
    LCPostContentView *contentView = [[LCPostContentView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 230)];
    self.contentView = contentView;
    [mainScrollerView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(mainScrollerView);
        make.right.equalTo(ws.view);
        make.height.mas_equalTo(230);
    }];
    LCPostShowTypeView *typeView = [[[NSBundle mainBundle] loadNibNamed:@"LCPostShowTypeView" owner:self options:nil] lastObject];
    self.typeView = typeView;
    [mainScrollerView addSubview:typeView];
    
    [typeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mainScrollerView);
        make.top.equalTo(contentView.mas_bottom).with.offset(0.5);
        make.right.equalTo(ws.view);
        make.height.mas_equalTo(107);
    }];
    
    LCPostTopView *topView = [[[NSBundle mainBundle] loadNibNamed:@"LCPostTopView" owner:self options:nil] lastObject];
    self.bottonView = topView;
    [mainScrollerView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mainScrollerView);
        make.top.equalTo(typeView.mas_bottom).with.offset(10);
        make.right.equalTo(ws.view);
        make.height.mas_equalTo(184);
    }];
    
    [mainScrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(0, 0, ws.tabbarBetweenHeight , 0));
    }];
    mainScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, 107 + 184 + 230 + 30);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

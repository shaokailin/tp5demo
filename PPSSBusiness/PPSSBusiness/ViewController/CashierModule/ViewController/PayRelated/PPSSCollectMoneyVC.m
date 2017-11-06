//
//  PPSSCollectMoneyVC.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/20.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSCollectMoneyVC.h"
#import "PPSSCollectInputView.h"
#import "PPSSCollectKeyboardView.h"
#import "PPSSSaoYiSaoVC.h"
#import <AVFoundation/AVFoundation.h>
#import "LSKImageManager.h"
#import "PPSSPayMoneyViewModel.h"
@interface PPSSCollectMoneyVC ()
@property (nonatomic, weak) PPSSCollectInputView *inputView;
@property (nonatomic, weak) PPSSCollectKeyboardView *keyboardView;
@property (nonatomic, strong) PPSSPayMoneyViewModel *viewModel;
@end

@implementation PPSSCollectMoneyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kCollectMoney_Title_Name;
    [self addNavigationBackButton];
    [self initializeMainView];
    [self bindSignal];
}
- (void)collectMoney{
    LSKLog(@"%d",KJudgeIsNullData(self.inputView.allMoneyField.text));
    if (KJudgeIsNullData(self.inputView.allMoneyField.text) && [self.inputView.allMoneyField.text floatValue] > 0) {
        self.inputView.currentType = 0;
        NSString *realString = self.inputView.check ?  self.inputView.discountField.text:nil;
        if (self.inType == CollectMoneyInType_Input) {
            @weakify(self)
            [LSKImageManager isAvailableSelectAVCapture:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                @strongify(self)
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        PPSSSaoYiSaoVC *saoyisao = [[PPSSSaoYiSaoVC alloc]init];
                        saoyisao.collectMoney = self.inputView.allMoneyField.text;
                        saoyisao.discountMoney = self.inputView.discountField.text;
                        saoyisao.inType = CollectMoneyInType_SaoYiSao;
                        saoyisao.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:saoyisao animated:YES];
                    });
                }
            }];
        }else {
            if (KJudgeIsNullData(self.qrCodeString)) {
                self.viewModel.totalPay = self.inputView.allMoneyField.text;
                self.viewModel.realPay = realString;
                self.viewModel.qcode = self.qrCodeString;
                [self.viewModel payMoneyEvent];
            }
        }
    }else {
         [SKHUD showMessageInView:self.view withMessage:@"请输入要收款的金额"];
    }
}
- (PPSSPayMoneyViewModel *)viewModel {
    if (!_viewModel) {
        @weakify(self)
        _viewModel = [[PPSSPayMoneyViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
            @strongify(self)
           [self performSelector:@selector(backToHome) withObject:nil afterDelay:1.5];
        } failure:nil];
    }
    return _viewModel;
}
- (void)backToHome {
    NSInteger count = self.navigationController.viewControllers.count;
    if (self.navigationController.viewControllers.count >= 3) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:count - 3] animated:YES];
    }
}

- (void)initializeMainView {
    self.view.backgroundColor = COLOR_WHITECOLOR;
    PPSSCollectInputView *inputView = [[PPSSCollectInputView alloc]init];
    self.inputView = inputView;
    [self.view addSubview:inputView];
    WS(ws)
    [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(ws.view);
        make.height.mas_equalTo(20 + 70 + 25);
    }];
    CGFloat betweenWidth = WIDTH_RACE_6S(15);
    CGFloat btnWidth = (SCREEN_WIDTH - betweenWidth * 5) / 4;
    CGFloat contentHeight = btnWidth * 4 + betweenWidth * 5;
    PPSSCollectKeyboardView *keyboardView = [[PPSSCollectKeyboardView alloc]initWithBtnWidth:btnWidth betweenWidth:betweenWidth];
    keyboardView.collectBlock = ^(NSString *title) {
        [ws collectMoney];
    };
    self.keyboardView = keyboardView;
    [self.view addSubview:keyboardView];
    [keyboardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(ws.view);
        make.top.equalTo(inputView.mas_bottom);
        make.height.mas_equalTo(contentHeight);
    }];
}
- (void)bindSignal {
    @weakify(self)
    [[[RACObserve(self.inputView, currentType) skip:1]distinctUntilChanged]subscribeNext:^(NSNumber *current) {
        @strongify(self)
        if ([current integerValue] != 0) {
            if ([current integerValue] == 1) {
                NSString * text = [self.keyboardView changeInputType:self.inputView.allMoneyField.text];
                if (text) {
                    self.inputView.discountField.text = text;
                }
            }else {
               NSString * text =  [self.keyboardView changeInputType:self.inputView.discountField.text];
                if (text) {
                    self.inputView.allMoneyField.text = text;
                }
            }
        }
    }];
    [[RACObserve(self.keyboardView, inputStr)skip:1]subscribeNext:^(NSString *text) {
        @strongify(self)
        if (self.inputView.currentType == 0) {
            [self.inputView changeBecome];
        }
        if (self.inputView.currentType == 1) {
            self.inputView.allMoneyField.text = text;
        }else if(self.inputView.currentType == 2) {
            self.inputView.discountField.text = text;
        }
    }];
    
    self.inputView.inputBlock = ^(NSInteger type) {
      @strongify(self)
        if (type == 0) {
            if (self.inputView.currentType == 1) {
                [self.keyboardView cleanText];
            }
        }else {
            [self changeCollectInputFrame];
        }
    };
}
- (void)changeCollectInputFrame {
    CGFloat contentHeight = self.inputView.check ? 20 + 70 + 25 + 50 : 20 + 70 + 25;
//    WS(ws)
    [self.inputView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.left.top.right.equalTo(ws.view);
        make.height.mas_equalTo(contentHeight);
    }];
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

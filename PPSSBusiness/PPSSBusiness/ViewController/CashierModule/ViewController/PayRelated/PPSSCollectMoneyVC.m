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
@interface PPSSCollectMoneyVC ()
@property (nonatomic, weak) PPSSCollectInputView *inputView;
@property (nonatomic, weak) PPSSCollectKeyboardView *keyboardView;
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
- (void)initializeMainView {
    self.view.backgroundColor = COLOR_WHITECOLOR;
    PPSSCollectInputView *inputView = [[PPSSCollectInputView alloc]init];
    self.inputView = inputView;
    [self.view addSubview:inputView];
    WS(ws)
    [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(ws.view);
        make.height.mas_equalTo(WIDTH_RACE_6S(179));
    }];
    CGFloat betweenWidth = WIDTH_RACE_6S(15);
    CGFloat btnWidth = (SCREEN_WIDTH - betweenWidth * 5) / 4;
    CGFloat contentHeight = btnWidth * 4 + betweenWidth * 5;
    PPSSCollectKeyboardView *keyboardView = [[PPSSCollectKeyboardView alloc]initWithBtnWidth:btnWidth betweenWidth:betweenWidth];
    self.keyboardView = keyboardView;
    [self.view addSubview:keyboardView];
    [keyboardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(ws.view);
        make.top.equalTo(inputView.mas_bottom);
        make.height.mas_equalTo(contentHeight);
    }];
    self.keyboardView.userInteractionEnabled = NO;
}
- (void)bindSignal {
    @weakify(self)
    [[[RACObserve(self.inputView, currentType) skip:1]distinctUntilChanged]subscribeNext:^(NSNumber *current) {
        @strongify(self)
        if ([current integerValue] != 0) {
            self.keyboardView.userInteractionEnabled = YES;
            if ([current integerValue] == 1) {
                [self.keyboardView changeInputType:self.inputView.allMoneyField.text];
            }else {
                [self.keyboardView changeInputType:self.inputView.discountField.text];
            }
            
        }
    }];
    [[RACObserve(self.keyboardView, inputStr)skip:1]subscribeNext:^(NSString *text) {
        @strongify(self)
        if (self.inputView.currentType == 1) {
            self.inputView.allMoneyField.text = text;
        }else if(self.inputView.currentType == 2) {
            self.inputView.discountField.text = text;
        }
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

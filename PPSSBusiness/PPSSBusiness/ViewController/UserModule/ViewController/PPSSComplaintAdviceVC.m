//
//  PPSSComplaintAdviceVC.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/9.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSComplaintAdviceVC.h"
#import "PPSSComplaintViewModel.h"
#import "LSKActionSheetView.h"
@interface PPSSComplaintAdviceVC ()<UITextViewDelegate>
{
    NSInteger _categoryType;
}
@property (nonatomic, weak) UITextView *textView;
@property (nonatomic, weak) UILabel *categoryLbl;;
@property (nonatomic, weak) UILabel *placeholdLbl;
@property (nonatomic, weak) UILabel *limitLbl;
@property (nonatomic, strong) PPSSComplaintViewModel *viewModel;
@end

@implementation PPSSComplaintAdviceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavigationBackButton];
    [self initializeMainView];
    [self bindSignal];
}
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[PPSSComplaintViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        if (self.remarkBlock) {
            self.remarkBlock(self.viewModel.textString);
        }
        [self performSelector:@selector(backToView) withObject:nil afterDelay:1.25];
    } failure:nil];
    self.viewModel.userId = self.userId;
    [[self.textView.rac_textSignal merge:RACObserve(self.textView, text)]subscribeNext:^(NSString *text) {
        @strongify(self)
        self.viewModel.textString = text;
        [self textViewChange];
    }];
}
- (void)selectCategoryClick {
    @weakify(self)
    LSKActionSheetView *sheetView = [[LSKActionSheetView alloc]initWithCancelButtonTitle:@"取消" clcikIndex:^(NSInteger seletedIndex) {
        if (seletedIndex != 0) {
            @strongify(self)
            _categoryType = seletedIndex - 1;
            self.categoryLbl.text = seletedIndex == 1 ?@"投诉":@"建议";
        }
    } otherButtonTitles:@"投诉",@"建议", nil];
    [sheetView showInView];
}
- (void)submitComplain {
    [self.textView resignFirstResponder];
    self.viewModel.type = _categoryType;
    [self.viewModel uploadEditText];
}
- (void)backToView {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)initializeMainView {
    _categoryType = -1;
    CGFloat top = 0;
    NSString *placehold = nil;
    if (_type == InControllerType_Complaint) {
        self.title = kComplaintAdvice_Title_Name;
        placehold = @"请输入您的投诉或建议";
        top = 45;
        [self customCategoryView];
    }else {
        self.title = kMemberRemark_Title_Name;
        placehold = @"阳光，帅气，有内涵";
        top = 0;
    }
    UIView *contentView = [[UIView alloc]init];
    contentView.backgroundColor = COLOR_WHITECOLOR;
    [self.view addSubview:contentView];
    UIView *inputView = [[UIView alloc]init];
    ViewRadius(inputView, 3.0);
    inputView.backgroundColor = COLOR_WHITECOLOR;
    ViewBorderLayer(inputView, ColorHexadecimal(0xdadada, 1.0), LINEVIEW_WIDTH / 2.0);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(textViewBecomeFirst)];
    [inputView addGestureRecognizer:tap];
    UITextView *textView = [[UITextView alloc]init];
    textView.delegate = self;
    textView.textColor = ColorHexadecimal(Color_Text_3333, 1.0);
    textView.font = FontNornalInit(10);
    
    self.textView = textView;
    [inputView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(inputView).with.insets(UIEdgeInsetsMake(0, 0, 25, 0));
    }];
    
    UILabel *placeholdLbl = [PPSSPublicViewManager initLblForColor6666:placehold];
    self.placeholdLbl = placeholdLbl;
    [textView addSubview:placeholdLbl];
    [placeholdLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(textView).with.offset(5);
        make.top.equalTo(textView).with.offset(7);
    }];
    UILabel *limitLbl = [PPSSPublicViewManager initLblForColor9999:@"0/1000"];
    self.limitLbl = limitLbl;
    [inputView addSubview:limitLbl];
    [limitLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(inputView.mas_right).with.offset(-10);
        make.top.equalTo(textView.mas_bottom);
        make.bottom.equalTo(inputView);
    }];
    
    [contentView addSubview:inputView];
    WS(ws)
    
    [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).with.offset(20);
        make.top.equalTo(contentView).with.offset(10);
        make.height.mas_equalTo(190);
        make.right.equalTo(contentView).with.offset(-20);
    }];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view).with.offset(top);
        make.height.mas_equalTo(220);
        make.left.right.equalTo(ws.view);
    }];
    if (KJudgeIsNullData(self.remarkText)) {
        textView.text = self.remarkText;
    }
    UIButton *completeBtn = [PPSSPublicViewManager initAPPThemeBtn:@"提交" font:18 target:self action:@selector(submitComplain)];
    [self.view addSubview:completeBtn];
    [completeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws.view);
        make.bottom.equalTo(ws.view).with.offset(-ws.tabbarBetweenHeight);
        make.height.mas_equalTo(49);
    }];
}
- (void)customCategoryView {
    UIButton *categoryBtn = [PPSSPublicViewManager initBtnWithNornalImage:nil target:self action:@selector(selectCategoryClick)];
    categoryBtn.backgroundColor = COLOR_WHITECOLOR;
    UILabel *titleLbl = [PPSSPublicViewManager initLblForColor3333:@"选择分类" textAlignment:0];
    [categoryBtn addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(categoryBtn).with.offset(15);
        make.centerY.equalTo(categoryBtn);
    }];
    UIImageView *arrowImage = [[UIImageView alloc]initWithImage:ImageNameInit(@"arrow_right")];
    [categoryBtn addSubview:arrowImage];
    [arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(categoryBtn).with.offset(-15);
        make.centerY.equalTo(categoryBtn);
    }];
    UILabel *rightLbl = [PPSSPublicViewManager initLblForColor6666:@"请选择投诉分类"];
    self.categoryLbl = rightLbl;
    [categoryBtn addSubview:rightLbl];
    [rightLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(arrowImage.mas_left).with.offset(-8);
        make.centerY.equalTo(categoryBtn);
    }];
    [self.view addSubview:categoryBtn];
    WS(ws)
    [categoryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(ws.view);
        make.height.mas_equalTo(44);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textView resignFirstResponder];
}
- (void)textViewBecomeFirst {
    [self.textView becomeFirstResponder];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text {
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    NSInteger caninputlen = kMAX_LIMIT_NUMS - comcatstr.length;
    if (caninputlen >= 0) {
        return YES;
    } else {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        if (rg.length > 0) {
            NSString *s = [text substringWithRange:rg];
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
    
}

- (void)textViewChange {
    NSString  *nsTextContent = _textView.text;
    NSInteger existTextNum = nsTextContent.length;
    if (existTextNum > kMAX_LIMIT_NUMS){
        //截取到最大位置的字符
        NSString *s = [nsTextContent substringToIndex:kMAX_LIMIT_NUMS];
        [_textView setText:s];
    }
    //不让显示负数
    self.limitLbl.text = [NSString stringWithFormat:@"%ld/%zd",(long)existTextNum,kMAX_LIMIT_NUMS];
    self.placeholdLbl.hidden = existTextNum > 0 ? YES:NO;
    
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

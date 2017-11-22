//
//  LCAboutUsVC.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCAboutUsVC.h"

@interface LCAboutUsVC ()
{
    BOOL _isChange;
}
@property (weak, nonatomic) IBOutlet UILabel *version;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;

@end

@implementation LCAboutUsVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_isChange) {
        [self backToNornalNavigationColor];
    }
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _isChange = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"关于彩神榜";
    [self addNavigationBackButton];
    [self addRightNavigationButtonWithNornalImage:@"share_icon" seletedIamge:@"share_icon" target:self action:@selector(shareClick)];
    [self initializeMainView];
}
- (void)initializeMainView {
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:self.contentLbl.text];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:8];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [self.contentLbl.text length])];
    [self.contentLbl setAttributedText:attributedString1];
    self.version.text = NSStringFormat(@"V%@",[LSKPublicMethodUtil getAppVersion]);
}
- (void)shareClick {
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"发送给微信朋友",@"分享到微信朋友圈",@"分享到QQ", nil];
    
    [sheet.rac_buttonClickedSignal subscribeNext:^(NSNumber * _Nullable x) {
        NSInteger type = [x integerValue];
        if (type != 3) {
            
        }
    }];
    [sheet showInView:self.view];
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

//
//  TXXLDayDetailInfoVC.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/7/3.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLDayDetailInfoVC.h"
#import "TXXLDayDetailInfoView.h"
#import "TXXLDayDetailHeaderView.h"
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <WXApi.h>
#import "TXSMShareView.h"
#import "TXXLCityDBManager.h"
@interface TXXLDayDetailInfoVC ()<UIScrollViewDelegate>
{
    BOOL _isClickAnimal;
    CGFloat _contentHeight;
}
@property (nonatomic, weak) TXXLDayDetailHeaderView *headerView;
@property (nonatomic, weak) UIScrollView *contentScroll;
@end

@implementation TXXLDayDetailInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.titleString;
    [self addNavigationBackButton];
    [self addRightNavigationButtonWithNornalImage:@"back_share_icon" seletedIamge:nil target:self action:@selector(shareClick)];
    [self initializeMainView];
}
- (void)shareClick {
    if (![WXApi isWXAppInstalled] && ![TencentOAuth iphoneQQInstalled]) {
        [SKHUD showMessageInWindowWithMessage:@"暂无可分享的平台！"];
        return;
    }
    TXSMShareView *shareView = [[TXSMShareView alloc]initWithTabbar:self.tabbarBetweenHeight ];
    @weakify(self)
    shareView.shareBlock = ^(NSInteger type) {
        @strongify(self)
        [self shareContentWithType:type];
    };
    [shareView showInView];
}
- (void)showShareResult:(NSNotification *)notice {
    BOOL isReuslt = [[notice.userInfo objectForKey:@"result"] boolValue];
    if (isReuslt) {
        [SKHUD showMessageInView:self.view withMessage:@"分享成功"];
    }else {
        [SKHUD showMessageInView:self.view withMessage:@"分享失败"];
    }
}
- (void)shareContentWithType:(NSInteger)type {
    NSString *url = @"http://a.app.qq.com/o/simple.jsp?pkgname=com.tx.txalmanac";
    NSString *title = NSStringFormat(@"天象黄历为您播报%@的天气情况                                                                                                                                                                                                                                                                                                                                                                             ",self.titleString);
    NSDictionary *dict = [self returnShareDetailContent];
    NSString *content = [dict objectForKey:@"content"];
    NSString * image = [dict objectForKey:@"image"];
    UIImage *iconImage = ImageNameInit(image);
    if (type < 2) {
        [self shareForWX:type image:iconImage title:title url:url content:content];
    }else {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSURL* urlUrl = [NSURL URLWithString:url];
            QQApiNewsObject* img = [QQApiNewsObject objectWithURL:urlUrl title:title description:content previewImageData:UIImagePNGRepresentation(iconImage)];
            img.shareDestType = ShareDestTypeQQ;
            SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
            if (type == 2) {
                [QQApiInterface sendReq:req];
            }else {
                [QQApiInterface SendReqToQZone:req];
            }
        });
        
    }
}
- (NSDictionary *)returnShareDetailContent{
    NSMutableString *content = [NSMutableString stringWithString:@""];
    NSString * image = nil;
    if (self.dataArray) {
        NSDictionary *dict = [self.dataArray objectAtIndex:_currentIndex];
        NSDate *date = [dict objectForKey:@"time"];
        NSString *white = [dict objectForKey:@"fc"];
        NSString *back = [dict objectForKey:@"fd"];
        [content appendString:[date dateTransformToString:@"MM月dd日"]];
        [content appendFormat:@"  %@  ",NSStringFormat(@"%@°C~%@°C",white,back)];
        NSString *backCode = [dict objectForKey:@"fa"];
        [content appendFormat:@"  %@  ",[TXXLCityDBManager weatherState:backCode]];
        image = backCode;
    }else {
        image = @"appicon";
    }
    return @{@"content":content,@"image":image};
}
- (void)shareForWX:(NSInteger)type image:(UIImage *)image title:(NSString *)title url:(NSString *)url content:(NSString *)content {
    dispatch_async(dispatch_get_main_queue(), ^{
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = title;
        message.description = content;
        [message setThumbImage:image];
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl = url;
        message.mediaObject = ext;
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        if (type == 0) {
            req.scene = WXSceneSession;
        }else {
            req.scene = WXSceneTimeline;
        }
        [WXApi sendReq:req];
        
    });
}
- (void)headerClickChange:(NSInteger)index {
    _currentIndex = index;
    [self changeProductShow:NO];
}
#pragma mark -滚动视图
#pragma mark 控制产品界面的切换
- (void)changeProductShow:(BOOL)isTap {
    if (!isTap) {
        _isClickAnimal = YES;
        [UIView animateWithDuration:0.25 animations:^{
            [self.contentScroll setContentOffset:CGPointMake((SCREEN_WIDTH) * self->_currentIndex, 0)];
        }completion:^(BOOL finished) {
            self->_isClickAnimal = NO;
            [self frameChange];
        }];
    }else {
        [self frameChange];
    }
}
- (void)frameChange {
    TXXLDayDetailInfoView *view = [self.contentScroll.subviews objectAtIndex:_currentIndex];
    CGFloat contentHeight = [view returnViewHeight];
    if (contentHeight > _contentHeight) {
        CGRect frame = view.frame;
        frame.size.height = contentHeight;
        view.frame = frame;
        CGSize size = self.contentScroll.contentSize;
        size.height = contentHeight;
        self.contentScroll.contentSize = size;
    }
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    _isClickAnimal = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat x = self.contentScroll.contentOffset.x;
    if (!_isClickAnimal) {
        CGFloat screenWidth = SCREEN_WIDTH;
        if ((NSInteger)x % (NSInteger)screenWidth == 0) {
            NSInteger indexPage = x / screenWidth ;
            if (_currentIndex != indexPage) {
                _currentIndex = indexPage;
                self.headerView.currentIndex = _currentIndex;
                [self changeProductShow:YES];
            }
        }
    }
}
#pragma mark - 界面初始化
- (void)initializeMainView {
    if (KJudgeIsArrayAndHasValue(self.dataArray)) {
        TXXLDayDetailHeaderView *headerView = [[TXXLDayDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        @weakify(self)
        headerView.clickBlock = ^(NSInteger index) {
            @strongify(self)
            [self headerClickChange:index];
        };
        [headerView setupContentDate:self.dataArray];
        headerView.currentIndex = self.currentIndex;
        self.headerView = headerView;
        [self.view addSubview:headerView];
        
        _contentHeight = self.viewMainHeight - self.tabbarBetweenHeight - 40 ;
        UIScrollView *m_mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH,_contentHeight)];
        m_mainScrollView.delegate = self;
        m_mainScrollView.bounces = NO;
        m_mainScrollView.pagingEnabled = YES;
        m_mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.dataArray.count, _contentHeight);
        m_mainScrollView.layer.masksToBounds = YES;
        m_mainScrollView.showsVerticalScrollIndicator = NO;
        m_mainScrollView.showsHorizontalScrollIndicator = NO;
        self.contentScroll = m_mainScrollView;
        for (int i = 0; i < self.dataArray.count; i++) {
            TXXLDayDetailInfoView *view = [[[NSBundle mainBundle]loadNibNamed:@"TXXLDayDetailInfoView" owner:self options:nil]lastObject];
            NSDictionary *dict = [self.dataArray objectAtIndex:i];
            [view setupContentWithWealther:dict];
            view.frame = CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, _contentHeight);
            [m_mainScrollView addSubview:view];
        }
        [self.view addSubview:m_mainScrollView];
        [m_mainScrollView setContentOffset:CGPointMake(SCREEN_WIDTH * self.currentIndex, 0)];
    }
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

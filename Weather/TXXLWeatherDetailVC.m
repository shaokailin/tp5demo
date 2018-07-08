//
//  TXXLWeatherDetailVC.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/6/27.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLWeatherDetailVC.h"
#import "TXXLWeatherDetailHeaderView.h"
#import "TXXLWeatherDetailTopView.h"
#import "TXXLWeatherDetailBottonView.h"
#import "TXXLWealtherVM.h"
#import "TXXLDayDetailInfoVC.h"
#import "TXXLWeatherDataManager.h"
#import "TXXLCityDBManager.h"
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <WXApi.h>
#import "TXSMShareView.h"
@interface TXXLWeatherDetailVC ()<UIScrollViewDelegate>
{
    CGFloat _contentHeight;
    NSInteger _currentIndex;
    NSInteger _cityIndex;
    CGFloat _heightBetween;
    UIVisualEffectView *_effectView;
    BOOL _isLoadData;
    BOOL _isViewAppear;
}
@property (nonatomic, strong) TXXLWealtherVM *weatherVM;
@property (nonatomic, weak) TXXLWeatherDetailHeaderView *headerView;
@property (nonatomic, weak) UIImageView *bgImageView;
@property (nonatomic, weak) UIScrollView *mainScrollView;
@property (nonatomic, weak) UIScrollView *topScrollView;
@property (nonatomic, weak) UIScrollView *bottonScrollView;
@property (nonatomic, weak) TXXLUserSharedInstance *userManager;
@end

@implementation TXXLWeatherDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.userManager = [TXXLUserSharedInstance sharedInstance];
    [self initializeMainView];
    [self bindSignal];
    [self addNotificationWithSelector:@selector(refreshData) name:kHOURSCHANGE];
    [self addNotificationWithSelector:@selector(showShareResult:) name:kShare_Notice];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _isViewAppear = YES;
    if (_isLoadData && _isViewAppear) {
        _isLoadData = NO;
        [self loadData];
    }
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    _isViewAppear = NO;
}
- (void)refreshData {
    _isLoadData = YES;
    for (TXXLWeatherDetailTopView *top in self.topScrollView.subviews) {
        top.isRefresh = YES;
    }
    if (_isLoadData && _isViewAppear) {
        _isLoadData = NO;
        [self loadData];
    }
}
- (void)loadData {
    TXXLWeatherDetailTopView *topView = [self.topScrollView.subviews objectAtIndex:_cityIndex];
    topView.isRefresh = NO;
    [self loadData:NO];
}
#pragma mark - 网络
- (void)bindSignal {
    @weakify(self)
    _weatherVM = [[TXXLWealtherVM alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        if (identifier == 0) {
            [self setupCurrentData:model];
        }else if (identifier == 10){
            TXXLWeatherHoursModel *hours = (TXXLWeatherHoursModel *)model;
            [self setupHoursData:hours.jh code:hours.code isLoading:YES];
        }else if (identifier == 15) {
            TXXLWeatherDaysModel *days = (TXXLWeatherDaysModel *)model;
            [self setupDaysData:days.f code:days.code isLoading:YES];
            [self.mainScrollView.mj_header endRefreshing];
        }
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        if (identifier == 15) {
            [self.mainScrollView.mj_header endRefreshing];
        }
    }];
    _weatherVM.isLoadNext = YES;
    _weatherVM.isShowAlertAndHiden = NO;
    [self loadData:YES];
}
- (void)setupCurrentData:(NSArray *)data {
    if (KJudgeIsArrayAndHasValue(data) && data.count > 1) {
        NSDictionary *dict0 = [data objectAtIndex:0];
        NSDictionary *cityinfo = [dict0 objectForKey:@"cityinfo"];
        NSString *areaid = [cityinfo objectForKey:@"areaid"];
        NSDictionary *dict = [data objectAtIndex:1];
        NSDictionary *dict1 = [dict objectForKey:@"l"];
        
        NSInteger dataIndex = [self.userManager cityIndex:areaid];
        if (dataIndex == self.userManager.selectIndex && self.detailBlock) {
            self.detailBlock(10, dict1);
        }
        if (dataIndex >= 0) {
            TXXLWeatherDetailTopView *topView = [self.topScrollView.subviews objectAtIndex:dataIndex];
            [topView setupContent:dict1];
        }
    }
}
- (void)setupHoursData:(NSArray *)data code:(NSString *)code isLoading:(BOOL)isLoading {
    NSInteger dataIndex = [self.userManager cityIndex:code];
    if (dataIndex >= 0) {
        if (isLoading) {
            [[TXXLWeatherDataManager sharedInstance]updateHours:data index:dataIndex];
        }
        TXXLWeatherDetailBottonView *bottonView = [self.bottonScrollView.subviews objectAtIndex:dataIndex];
        TXXLWeatherDetailTopView *topView = [self.topScrollView.subviews objectAtIndex:dataIndex];
        [bottonView setupHoursContent:data current:topView.currentDict];
    }
}
- (void)setupDaysData:(NSDictionary *)data code:(NSString *)code isLoading:(BOOL)isLoading {
    NSInteger dataIndex = [self.userManager cityIndex:code];
    if (dataIndex >= 0) {
        if (isLoading) {
            [[TXXLWeatherDataManager sharedInstance]updateDays:data index:dataIndex];
        }
        NSArray *array = [data objectForKey:@"f1"];
        if (KJudgeIsArrayAndHasValue(array)) {
            TXXLWeatherDetailTopView *topView = [self.topScrollView.subviews objectAtIndex:dataIndex];
            [topView setupTomorrow:array];
            TXXLWeatherDetailBottonView *bottonView = [self.bottonScrollView.subviews objectAtIndex:dataIndex];
            NSDate *date = [NSDate stringTransToDate:[data objectForKey:@"f0"] withFormat:@"yyyyMMddHHmm"];
            NSDate *date1 = [NSDate stringTransToDate:[date dateTransformToString:@"yyyyMMdd"] withFormat:@"yyyyMMdd"];
            [bottonView setupDaysContent:array time:date1];
        }
    }
}
- (void)loadData:(BOOL)isPull {
    TXXLCityModel *cityModel = [self.userManager.cityArray objectAtIndex:_cityIndex];
    _weatherVM.cityCode = cityModel.code;
    
    [_weatherVM getWealtherCurrent:isPull];
}
#pragma mark citylist event
- (void)listCityEvent:(NSInteger)type object:(id)param{
    if (type == 0) {
        NSInteger index = [param integerValue];
        if (index != _cityIndex) {
            _cityIndex = index;
            [self.bottonScrollView setContentOffset:CGPointMake(SCREEN_WIDTH * _cityIndex, 0)];
            [self.topScrollView setContentOffset:CGPointMake(SCREEN_WIDTH * _cityIndex, 0)];
            TXXLWeatherDetailTopView *topView = [self.topScrollView.subviews objectAtIndex:_cityIndex];
            TXXLWeatherDetailBottonView *bottonView = [self.bottonScrollView.subviews objectAtIndex:_cityIndex];
            if (!topView.hasData && !bottonView.hasData) {
                [self loadData:YES];
            }
            [self.headerView changeCurrentSelect:_cityIndex];
        }
    }else if (type == 1){
        NSInteger allCount = self.topScrollView.subviews.count;
        TXXLWeatherDetailTopView *view = [[TXXLWeatherDetailTopView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * allCount, 0, SCREEN_WIDTH, _contentHeight)];;
        [self.topScrollView addSubview:view];
        TXXLWeatherDetailBottonView *view1 = [[TXXLWeatherDetailBottonView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * allCount, 0, SCREEN_WIDTH, _contentHeight)];
        @weakify(self)
        view1.bottonBlock = ^(NSInteger index) {
            @strongify(self)
            [self bottonClick:index];
        };
        [self.bottonScrollView addSubview:view1];
        _cityIndex = allCount;
        allCount += 1;
        self.bottonScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * allCount, _contentHeight);
        self.topScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * allCount, _contentHeight);
        [self.bottonScrollView setContentOffset:CGPointMake(SCREEN_WIDTH * _cityIndex, 0)];
        [self.topScrollView setContentOffset:CGPointMake(SCREEN_WIDTH * _cityIndex, 0)];
        [self.headerView editPageControl];
        [self.headerView changeCurrentSelect:_cityIndex];
        [self loadData:YES];
    }else if (type == 2){
        NSInteger delectIndex = [param integerValue];
        NSInteger allCount = self.topScrollView.subviews.count;
        if (delectIndex < allCount) {
            UIView *topView = [self.topScrollView.subviews objectAtIndex:delectIndex];
            UIView *bottonView = [self.bottonScrollView.subviews objectAtIndex:delectIndex];
            [topView removeFromSuperview];
            [bottonView removeFromSuperview];
            allCount -= 1;
            for (NSInteger i = delectIndex; i < allCount; i++) {
                UIView *topView1 = [self.topScrollView.subviews objectAtIndex:i];
                topView1.frame = CGRectMake(SCREEN_WIDTH * (i), 0, SCREEN_WIDTH, _contentHeight);
                UIView *bottonView1 = [self.bottonScrollView.subviews objectAtIndex:i];
                 bottonView1.frame = CGRectMake(SCREEN_WIDTH * (i), 0, SCREEN_WIDTH, _contentHeight);
            }
            self.bottonScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * allCount, _contentHeight);
            self.topScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * allCount, _contentHeight);
            if (_cityIndex == delectIndex) {
                _cityIndex = 0;
                [self.bottonScrollView setContentOffset:CGPointMake(SCREEN_WIDTH * _cityIndex, 0)];
                [self.topScrollView setContentOffset:CGPointMake(SCREEN_WIDTH * _cityIndex, 0)];
                [self.headerView changeCurrentSelect:_cityIndex];
            }
            [self.headerView editPageControl];
            
        }
    }
}
#pragma mark action
- (void)openClick {
    self.detailBlock(0,nil);
}
- (void)headerEventClick:(NSInteger)type {
    if (type == 1) {
        [self openClick];
    }else if(type == 2) {
        [self shareClick];
    }else {
        self.detailBlock(1, nil);
    }
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
    NSString *title = NSStringFormat(@"天象黄历为您播报%@的天气情况                                                                                                                                                                                                                                                                                                                                                                             ",[self returnTitle]);
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
    TXXLWeatherDataModel *model = [[TXXLWeatherDataManager sharedInstance].dataArray objectAtIndex:_cityIndex];
    NSMutableString *content = [NSMutableString stringWithString:@""];
    NSString * image = nil;
    if (model.days) {
        NSString *timeString = [model.days objectForKey:@"f0"];
        NSDate *date = [NSDate stringTransToDate:timeString withFormat:@"yyyyMMddHHmm"];
        NSArray *array = [model.days objectForKey:@"f1"];
        NSDictionary *today = [array objectAtIndex:0];
        NSString *white = [today objectForKey:@"fc"];
        NSString *back = [today objectForKey:@"fd"];
        [content appendString:[date dateTransformToString:@"MM月dd日"]];
        if (!KJudgeIsNullData(white)) {
            [content appendFormat:@"  %@  ",back];
            NSString *backCode = [today objectForKey:@"fb"];
            [content appendFormat:@"  %@  ",[TXXLCityDBManager weatherState:backCode]];
           image = backCode;
        }else {
            [content appendFormat:@"  %@  ",NSStringFormat(@"%@°C~%@°C",white,back)];
            NSString *backCode = [today objectForKey:@"fa"];
            [content appendFormat:@"  %@  ",[TXXLCityDBManager weatherState:backCode]];
            image = backCode;
        }
        [content appendString:@"/n"];
        NSDictionary *tomorrow = [array objectAtIndex:1];
        NSDate *date1 = [date dateByAddingTimeInterval:3600 * 24];
        NSString *dataString = [date1 dateTransformToString:@"MM-dd"];
         [content appendString:dataString];
        NSString *tomorrowWhite = [tomorrow objectForKey:@"fc"];
        NSString *tomorrowBack = [tomorrow objectForKey:@"fd"];
        [content appendFormat:@"  %@  ",NSStringFormat(@"%@°C~%@°C",tomorrowWhite,tomorrowBack)];
        NSString *backCode = [tomorrow objectForKey:@"fa"];
        [content appendFormat:@"  %@  ",[TXXLCityDBManager weatherState:backCode]];
    }else if (model.current){
         [content appendString:[[NSDate date] dateTransformToString:@"MM月dd日"]];
        NSString * code = [model.current objectForKey:@"l5"];
        [content appendFormat:@"  %@  ",NSStringFormat(@"%@°C",[model.current objectForKey:@"l1"])];
        [content appendFormat:@"  %@  ",[TXXLCityDBManager weatherState:code]];
        image = code;
    }else {
        image = @"appicon";
    }
    return @{@"content":content,@"image":image};
}
- (NSString *)returnTitle {
    TXXLCityModel *model1 = [[TXXLUserSharedInstance sharedInstance].cityArray objectAtIndex:_cityIndex];
    NSString *area = model1.areaName;
    NSString *city = model1.cityName;
    return KJudgeIsNullData(area)?area:city;
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




- (void)bottonClick:(NSInteger)index {
    TXXLDayDetailInfoVC *info = [[TXXLDayDetailInfoVC alloc]init];
    info.currentIndex = index;
    TXXLWeatherDetailBottonView *bottonView = [self.bottonScrollView.subviews objectAtIndex:_cityIndex];
    info.dataArray = bottonView.daysArray;
    TXXLCityModel *cityModel = [self.userManager.cityArray objectAtIndex:_cityIndex];
    NSString *area = cityModel.areaName;
    NSString *city = cityModel.cityName;
    if (!KJudgeIsNullData(area)) {
        info.titleString = city;
    }else {
        info.titleString = area;
    }
    UIViewController *controller = [LSKViewFactory getCurrentViewController];
    [controller.navigationController pushViewController:info animated:YES];
}
- (void)pullDownRefresh {
    
    [self loadData:NO];
}
#pragma mark - scrollview delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.topScrollView  || scrollView == self.bottonScrollView) {
        return;
    }
    // 停止类型1、停止类型2
    BOOL scrollToScrollStop = !scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
    if (scrollToScrollStop) {
        [self scrollViewDidEndScroll];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView == self.topScrollView || scrollView == self.bottonScrollView) {
        return;
    }
    if (!decelerate) {
        // 停止类型3
        BOOL dragToDragStop = scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
        if (dragToDragStop) {
            [self scrollViewDidEndScroll];
        }
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.topScrollView  || scrollView == self.bottonScrollView) {
        CGFloat x = scrollView.contentOffset.x;
        CGFloat screenWidth = SCREEN_WIDTH;
        if ((NSInteger)x % (NSInteger)screenWidth == 0) {
            NSInteger indexPage = x / screenWidth ;
            if (_cityIndex != indexPage) {
                _cityIndex = indexPage;
                if (scrollView == self.topScrollView) {
                    [self.bottonScrollView setContentOffset:CGPointMake(SCREEN_WIDTH * _cityIndex, 0)];
                }else {
                    [self.topScrollView setContentOffset:CGPointMake(SCREEN_WIDTH * _cityIndex, 0)];
                }
                TXXLWeatherDetailTopView *topView = [self.topScrollView.subviews objectAtIndex:_cityIndex];
                if (topView.isRefresh) {
                    topView.isRefresh = NO;
                    [self loadData:YES];
                }
                [self.headerView changeCurrentSelect:_cityIndex];
            }
        }
    }else {
        CGFloat rate = self.mainScrollView.contentOffset.y / _contentHeight;
        if (rate >= 1) {
            rate = 0.95;
        }
        _effectView.alpha = rate;
    }
}
- (void)scrollViewDidEndScroll {
    CGFloat offset = self.mainScrollView.contentOffset.y;
    if (offset >= 0 && offset <= _contentHeight) {
        if (offset <= _heightBetween) {
            _currentIndex = 0;
            [self changeColor:NO];
            [self.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }else if (_currentIndex == 1 && offset >= (_contentHeight - _heightBetween)){
            _currentIndex = 1;
            [self changeColor:YES];
            [self.mainScrollView setContentOffset:CGPointMake(0, _contentHeight) animated:YES];
        }else if (_currentIndex == 0){
            _currentIndex = 1;
            [self changeColor:YES];
            [self.mainScrollView setContentOffset:CGPointMake(0, _contentHeight) animated:YES];
        }else {
            _currentIndex = 0;
            [self changeColor:NO];
            [self.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    }
}
- (void)changeColor:(BOOL)isBg {
    [self.headerView changeBgColor:isBg];
}
- (void)initializeMainView {
    _cityIndex = self.userManager.selectIndex;
    _heightBetween = STATUSBAR_HEIGHT + 44;
    NSInteger week = [[NSDate date]getWeekIndex];
    UIImageView *bgImage = [[UIImageView alloc]initWithImage:ImageFileInit(NSStringFormat(@"%ld",(long)week), @"jpg")];
    bgImage.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.bgImageView = bgImage;
    [self.view addSubview:bgImage];
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    _effectView = [[UIVisualEffectView alloc]initWithEffect:effect];
    _effectView.frame = bgImage.bounds;
    _effectView.alpha = 0;
    [bgImage addSubview:_effectView];
    TXXLWeatherDetailHeaderView *headerView = [[TXXLWeatherDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STATUSBAR_HEIGHT + 44)];
    @weakify(self)
    headerView.eventBlock = ^(NSInteger type) {
        @strongify(self);
        [self headerEventClick:type];
    };
    self.headerView = headerView;
    [self.view addSubview:headerView];
    _currentIndex = 0;
    UIScrollView *scrollView = [LSKViewFactory initializeScrollViewTarget:self headRefreshAction:@selector(pullDownRefresh) footRefreshAction:nil];
    scrollView.delegate = self;
    self.mainScrollView = scrollView;
    _contentHeight = SCREEN_HEIGHT - STATUSBAR_HEIGHT - 44 - self.tabbarBetweenHeight;
    NSInteger count = self.userManager.cityArray.count;
    UIScrollView *topScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0 , SCREEN_WIDTH,_contentHeight)];
    topScrollView.delegate = self;
    topScrollView.bounces = NO;
    topScrollView.pagingEnabled = YES;
    topScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * count, _contentHeight);
    topScrollView.layer.masksToBounds = YES;
    topScrollView.showsVerticalScrollIndicator = NO;
    topScrollView.showsHorizontalScrollIndicator = NO;
    self.topScrollView = topScrollView;
    
    [scrollView addSubview:topScrollView];
    
    UIScrollView *bottonScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,_contentHeight , SCREEN_WIDTH,_contentHeight)];
    bottonScrollView.delegate = self;
    bottonScrollView.bounces = NO;
    bottonScrollView.pagingEnabled = YES;
    bottonScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * count, _contentHeight);
    bottonScrollView.layer.masksToBounds = YES;
    bottonScrollView.showsVerticalScrollIndicator = NO;
    bottonScrollView.showsHorizontalScrollIndicator = NO;
    self.bottonScrollView = bottonScrollView;
    [scrollView addSubview:bottonScrollView];
    NSArray *array1 = [TXXLWeatherDataManager sharedInstance].dataArray;
    for (int i = 0; i < count; i++) {
        TXXLWeatherDataModel *model = [array1 objectAtIndex:i];
        TXXLWeatherDetailTopView *topView = [[TXXLWeatherDetailTopView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, _contentHeight)];
        if (i != _cityIndex) {
            topView.isRefresh = YES;
        }
        [topScrollView addSubview:topView];
        
        TXXLWeatherDetailBottonView *bottonView = [[TXXLWeatherDetailBottonView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, _contentHeight)];
        bottonView.bottonBlock = ^(NSInteger index) {
            @strongify(self)
            [self bottonClick:index];
        };
        if (model.current) {
            [topView setupContent:model.current];
        }
        if (model.hous) {
            [bottonView setupHoursContent:model.hous current:model.current];
        }
        if (model.days) {
            NSArray *array = [model.days objectForKey:@"f1"];
            if (KJudgeIsArrayAndHasValue(array)) {
                [topView setupTomorrow:array];
                NSDate *date = [NSDate stringTransToDate:[model.days objectForKey:@"f0"] withFormat:@"yyyyMMddHHmm"];
                NSDate *date1 = [NSDate stringTransToDate:[date dateTransformToString:@"yyyyMMdd"] withFormat:@"yyyyMMdd"];
                [bottonView setupDaysContent:array time:date1];
            }
        }
        [bottonScrollView addSubview:bottonView];
    }
    [topScrollView setContentOffset:CGPointMake(SCREEN_WIDTH *_cityIndex, 0)];
    [bottonScrollView setContentOffset:CGPointMake(SCREEN_WIDTH *_cityIndex, 0)];
    
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, _contentHeight * 2);
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(headerView.mas_bottom);
        make.bottom.equalTo(self.view).with.offset(-self.tabbarBetweenHeight);
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

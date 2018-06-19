//
//  LCUserMainVC.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/6.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCUserMainVC.h"
#import "LCUserHomeTableViewCell.h"
#import "LCUserHomeHeaderView.h"
#import "LCSpaceTableViewCell.h"
#import "LSKImageManager.h"
#import "RSKImageCropper.h"
#import <AVFoundation/AVFoundation.h>
#import "LCUserMessageVC.h"
#import "LCAboutUsVC.h"
#import "LCMySpaceMainVC.h"
#import "LCOrderHistoryVC.h"
#import "LCWalletMainVC.h"
#import "LCTaskMainVC.h"
#import "LCTeamMainVC.h"
#import "LCContactMainVC.h"
#import "LCAttentionMainVC.h"
#import "LCUserMianViewModel.h"
#import "LCUserSignVC.h"
#import "LCUserMessageListVC.h"
#import "LCSystemMessageVC.h"
#import "LCNoticeSettingVC.h"
#import "LCMessageListVM.h"
static NSString * const kSettingName = @"UserHomeSetting";
@interface LCUserMainVC ()<UITableViewDelegate, UITableViewDataSource,RSKImageCropViewControllerDelegate>
{
    NSArray *_settingArray;
    NSInteger _editImageType;
    NSInteger _jumpViewType;
    BOOL _isHasLoad;
    BOOL _isLoadNotice;
}
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, weak) LCUserHomeHeaderView *headerView;
@property (nonatomic, strong) UIImage *homeNaviBgImage;
@property (nonatomic, strong) LCUserMianViewModel *viewModel;
@property (nonatomic, strong) LCMessageListVM *noticeViewModel;
@end

@implementation LCUserMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _jumpViewType = -1;
    [self setEdgesForExtendedLayout:UIRectEdgeAll];
    [self initializeMainView];
    [self bindSignal];
    [self addNotificationWithSelector:@selector(updateUserMessage) name:kUserModule_HomeChangeMessageNotice];
    [self addNotificationWithSelector:@selector(loginOutChange) name:kLoginOutChange_Notice];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!_isHasLoad) {
        _isHasLoad = YES;
        [self.viewModel getUserMessage];
    }
    if (!_isLoadNotice) {
        _isLoadNotice = YES;
        [self.viewModel getNoticeCount];
    }
}

- (void)loginOutChange {
    _isHasLoad = NO;
    self.viewModel.messageModel = nil;
}

- (void)updateUserMessage {
    [self.headerView updateUserMessage];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:self.homeNaviBgImage forBarMetrics:UIBarMetricsDefault];
}

- (UIImage *)homeNaviBgImage {
    if (!_homeNaviBgImage) {
        _homeNaviBgImage = [LSKImageManager imageWithColor:ColorRGBA(0, 0, 0, 0.4) size:CGSizeMake(SCREEN_WIDTH, self.navibarHeight)];
    }
    return _homeNaviBgImage;
}

- (void)loginOutClick {
    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否要退出当前的用户" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    @weakify(self)
    [alter.rac_buttonClickedSignal subscribeNext:^(NSNumber * _Nullable x) {
        if ([x integerValue] == 1) {
            @strongify(self)
            [self.viewModel loginOutClickEvent];
        }
    }];
    [alter show];
}
- (void)shareClick {
    [self shareEventClick];
}
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[LCUserMianViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, LCUserHomeMessageModel *model) {
        @strongify(self)
        if (identifier == 1) {
            [self.headerView changeUserPhoto:self.viewModel.photoImage];
        }else if (identifier == 10){
             [self.headerView changeBgImage:self.viewModel.photoImage];
        }else if(identifier == 300){
            self->_isLoadNotice = NO;
            [self.mainTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0],[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }
        else{
            [self.headerView setupContentWithAttention:self.viewModel.messageModel.follow_count teem:self.viewModel.messageModel.team_count fans:self.viewModel.messageModel.fans_count];
            [self updateUserMessage];
            if (self->_jumpViewType != -1) {
                [self jumpEvent];
            }
            [self.mainTableView.mj_header endRefreshing];
        }
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        if (identifier == 300) {
            self->_isLoadNotice = NO;
        }
        [self.mainTableView.mj_header endRefreshing];
    }];
    _viewModel.mine_count = 0;
    _viewModel.sys_count = 0;
}
#pragma mark - 消息设置
- (LCMessageListVM *)noticeViewModel {
    if (!_noticeViewModel) {
        @weakify(self)
        _noticeViewModel = [[LCMessageListVM alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
            @strongify(self)
            [self settingClick];
        } failure:^(NSUInteger identifier, NSError *error) {
            
        }];
    }
    return _noticeViewModel;
}
- (void)settingClick {
    if (!_noticeViewModel || !_noticeViewModel.model) {
        [self.noticeViewModel getUserNoticeSetting];
    }else {
        LCNoticeSettingVC *setting = [[LCNoticeSettingVC alloc]init];
        setting.model = self.noticeViewModel.model;
        setting.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setting animated:YES];
    }
    
}
#pragma mark -
- (void)jumpEvent {
    _jumpViewType = -1;
}

- (void)headerViewClickEvent:(NSInteger)type {
    if (type < 3) {
        _editImageType = type;
        UIActionSheet *sheetView = [[UIActionSheet alloc]initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"手机相册", nil];
        @weakify(self)
        [sheetView.rac_buttonClickedSignal subscribeNext:^(NSNumber * _Nullable x) {
            @strongify(self)
            if ([x integerValue] == 0) {
                [self takeCameraPhoto];
            }else if ([x integerValue] == 1){
                [self takeLocationImage];
            }
        }];
        [sheetView showInView:self.view];
        
    }else if(type == 3) {
        [self.viewModel userSignClickEvent];
    }else if (type == 4){
        LCAttentionMainVC *attentionVC = [[LCAttentionMainVC alloc]init];
        attentionVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:attentionVC animated:YES];
    }else if (type == 5) {
        LCTeamMainVC *teamVC = [[LCTeamMainVC alloc]init];
        teamVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:teamVC animated:YES];
    }else if (type == 6) {
        LCAttentionMainVC *attentionVC = [[LCAttentionMainVC alloc]init];
        attentionVC.isFans = YES;
        attentionVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:attentionVC animated:YES];
    }
}
- (void)pullDownRefresh {
    [self.viewModel getUserMessage];
}
#pragma mark delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _settingArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 7 || indexPath.row == 11 || indexPath.row == 14) {
        LCSpaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCSpaceTableViewCell];
        return cell;
    }else {
        LCUserHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLCUserHomeTableViewCell];
        NSDictionary *dict = [_settingArray objectAtIndex:indexPath.row];
        NSInteger count = 0;
        if(indexPath.row == 1) {
            count = self.viewModel.mine_count;
        }else if (indexPath.row == 2){
            count = self.viewModel.sys_count;
        }
        [cell setupContentTitle:[dict objectForKey:@"title"] detail:[dict objectForKey:@"detail"] icon:[dict objectForKey:@"icon"] count:count];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 7 || indexPath.row == 11 || indexPath.row == 14) {
        return 10;
    }else {
        return 44;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 7 || indexPath.row == 11 || indexPath.row == 14) {
    }else {
        UIViewController *controller = nil;
        switch (indexPath.row) {
            case 0:
            {
                LCUserMessageVC *messageVC = [[LCUserMessageVC alloc]init];
                controller = messageVC;
                break;
            }
            case 1:
            {
                LCUserMessageListVC *messageList = [[LCUserMessageListVC alloc]init];
                messageList.selectIndex = 0;
                controller = messageList;
                break;
            }
            case 2:
            {
                LCSystemMessageVC *messageList = [[LCSystemMessageVC alloc]init];
                controller = messageList;
                break;
            }
            case 3:
            {
                [self settingClick];
                break;
            }
            case 4:
            {
                LCMySpaceMainVC *spaceVC = [[LCMySpaceMainVC alloc]init];
                spaceVC.userId = kUserMessageManager.userId;
                controller = spaceVC;
                break;
            }
            case 5:
            {
                LCOrderHistoryVC *historyVC = [[LCOrderHistoryVC alloc]init];
                controller = historyVC;
                break;
            }
            case 6:
            {
                LCUserSignVC *signVC = [[LCUserSignVC alloc]init];
                controller = signVC;
                break;
            }
            case 8:
            {
                LCWalletMainVC *historyVC = [[LCWalletMainVC alloc]init];
                controller = historyVC;
                break;
            }
            case 9:
            {
                LCTaskMainVC *taskVC = [[LCTaskMainVC alloc]init];
                controller = taskVC;
                break;
            }
            case 10:
            {
                [self headerViewClickEvent:5];
                break;
            }
            case 12:
            {
                LCAboutUsVC *aboutVC = [[LCAboutUsVC alloc]init];
                controller = aboutVC;
                break;
            }
            case 13:
            {
                LCContactMainVC *attentionVC = [[LCContactMainVC alloc]init];
                controller = attentionVC;
                break;
            }
            default:
                break;
        }
        if (controller) {
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark view
- (void)initializeMainView {
    [self addRightNavigationButtonWithNornalImage:@"shareIcon" seletedIamge:nil target:self action:@selector(shareClick)];
    _settingArray = [NSArray arrayWithPlist:kSettingName];
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:nil separatorColor:ColorHexadecimal(kMainBackground_Color, 1.0) backgroundColor:nil];
    tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 0);
    [tableView registerNib:[UINib nibWithNibName:kLCUserHomeTableViewCell bundle:nil] forCellReuseIdentifier:kLCUserHomeTableViewCell];
    [tableView registerClass:[LCSpaceTableViewCell class] forCellReuseIdentifier:kLCSpaceTableViewCell];
    LCUserHomeHeaderView *headerView = [[LCUserHomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 304) isHome:YES];
   
    
    self.headerView = headerView;
    tableView.tableHeaderView = headerView;
    WS(ws)
    headerView.punchBlock = ^(NSInteger type) {
        [ws headerViewClickEvent:type];
    };
    [headerView updateUserMessage];
    UIView *footView = [[UIView alloc]init];
    footView.backgroundColor = ColorHexadecimal(kMainBackground_Color, 1.0);
    footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 88);
    UIButton *outBtn = [LSKViewFactory initializeButtonWithTitle:@"退出登录" target:self action:@selector(loginOutClick) textfont:15 textColor:ColorHexadecimal(0x434343, 1.0)];
    outBtn.backgroundColor = [UIColor whiteColor];
    outBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    [footView addSubview:outBtn];
    tableView.tableFooterView = footView;
    self.mainTableView = tableView;
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
    }];
}

#pragma mark 拍照
- (void)selectImage:(UIImage *)image {
    RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:image cropMode:RSKImageCropModeSquare];
    imageCropVC.delegate = self;
    if (_editImageType == 1) {
        imageCropVC.portraitSquareMaskRectInnerEdgeInset = 0;
    }else {
        imageCropVC.portraitSquareMaskRectInnerEdgeInset = (SCREEN_WIDTH - 260) / 2.0;
    }
    imageCropVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:imageCropVC animated:NO];
}
#pragma mark - RSKImageCropViewControllerDelegate

- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage usingCropRect:(CGRect)cropRect rotationAngle:(CGFloat)rotationAngle {
    self.viewModel.photoImage = croppedImage;
    self.viewModel.editType = _editImageType;
     [self.viewModel updateUserPhoto];
    
    [self.navigationController popViewControllerAnimated:YES];

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

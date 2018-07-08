//
//  TXXLWeatherCitySelectVC.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/6/27.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLWeatherCitySelectVC.h"
#import "TXXLCitySelectView.h"
#import "TXXLSearchResultCell.h"
#import "TXXLCityHotCell.h"
#import "TXXLCityHotHeaderReusableView.h"
#import "TXXLCityDBManager.h"
#import "TXXLWealtherVM.h"
#import "TXXLWeatherDataManager.h"
//#define kHeaderViewHeight WIDTH_RACE_6S(186)
static NSString * const kHOTDATAPLIST = @"hotcity";
@interface TXXLWeatherCitySelectVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSArray *_hotArray;
    NSArray *_searchArray;
    NSString *_searchText;
}
@property (nonatomic, weak) UICollectionView *hotCollection;
@property (nonatomic, weak) TXXLCitySelectView *headerView;
@property (nonatomic, strong) UITableView *searchTableView;
@property (nonatomic, strong) TXXLWealtherVM *viewModel;
@property (nonatomic, strong) TXXLCityDBManager *dbManager;
@end

@implementation TXXLWeatherCitySelectVC
- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
}
#pragma mark - 网络请求 -
- (TXXLWealtherVM *)viewModel {
    if (!_viewModel) {
        @weakify(self)
        _viewModel = [[TXXLWealtherVM alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
            @strongify(self)
            if (self.selectBlock) {
                self.selectBlock(model);
            }
            [self headerEvent:0];
        } failure:nil];
    }
    return _viewModel;
}
#pragma mark - searchEvent
- (void)searchEvent:(NSString *)text {
    if (KJudgeIsNullData(text)) {
        self.searchTableView.hidden = NO;
        if (![_searchText isEqualToString:text]) {
            _searchText = text;
            _searchArray = [self.dbManager searchCityList:text];
            [self.searchTableView reloadData];
        }
    }else {
        _searchText = nil;
        _searchArray = nil;
        if (_searchTableView) {
            [_searchTableView reloadData];
            _searchTableView.hidden = YES;
        }
    }
    
}
- (TXXLCityDBManager *)dbManager {
    if (!_dbManager) {
        _dbManager = [[TXXLCityDBManager alloc]init];
    }
    return _dbManager;
}
- (void)headerEvent:(NSInteger)type {
    if (type == 0) {
        [self navigationBackClick];
    }
}
#pragma mark - table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_searchArray) {
        return _searchArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TXXLSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXXLSearchResultCell];
    NSDictionary *dict = [_searchArray objectAtIndex:indexPath.row];
    [cell setupCellContent:[dict objectForKey:@"name"] detail:[dict objectForKey:@"detail"]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = [_searchArray objectAtIndex:indexPath.row];
    [self.headerView cleanText];
    self.searchTableView.hidden = YES;
    [self selectEvent:dict];
}
#pragma mark - collection
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _hotArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TXXLCityHotCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTXXLCityHotCell forIndexPath:indexPath];
    cell.cityNameLbl.text = [_hotArray objectAtIndex:indexPath.row];
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        TXXLCityHotHeaderReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kTXXLCityHotHeaderReusableView forIndexPath:indexPath];
        return view;
    }
    return nil;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.headerView cleanText];
    if (_searchTableView) {
        _searchTableView.hidden = YES;
    }
    [self.view endEditing:YES];
    NSString *name = [_hotArray objectAtIndex:indexPath.row];
    NSDictionary *dict = [self.dbManager selectCityInfo:name];
    [self selectEvent:dict];
}
- (void)selectEvent:(NSDictionary *)dict {
    if (self.selectBlock) {
        self.viewModel.cityData = dict;
        [self.viewModel addCityForSave];
    }else {
        NSString *code = [dict objectForKey:@"areaId"];
        NSInteger index = [[TXXLUserSharedInstance sharedInstance]cityIndex:code];
        if (index > -1) {
            self.addBlock(0, @(index));
        }else {
            TXXLCityModel *city1 = [[TXXLCityModel alloc]init];
            city1.areaName = [dict objectForKey:@"name"];
            city1.code = [dict objectForKey:@"areaId"];
            city1.cityName = [dict objectForKey:@"city"];
            city1.province = [dict objectForKey:@"province"];
            city1.country = [dict objectForKey:@"nationcn"];
            [[TXXLUserSharedInstance sharedInstance] addCityModel:city1];
            [[TXXLWeatherDataManager sharedInstance] addData:city1.code];
            self.addBlock(1, nil);
        }
        [self navigationBackClick];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}
#pragma mark - 事件
- (void)initializeMainView {
    [self customHeaderView];
    _hotArray = [NSArray arrayWithPlist:kHOTDATAPLIST];
    UICollectionViewFlowLayout *flowyout = [[UICollectionViewFlowLayout alloc]init];
    flowyout.sectionInset = UIEdgeInsetsMake(0.5, 0, 0.5, 0);
    flowyout.itemSize = CGSizeMake((SCREEN_WIDTH - 1) / 3.0, 40);
    flowyout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 39);
    flowyout.minimumLineSpacing = 0.5;
    flowyout.minimumInteritemSpacing = 0.0;
    UICollectionView *collectionView = [LSKViewFactory initializeCollectionViewWithDelegate:self collectionViewLayout:flowyout headRefreshAction:nil footRefreshAction:nil backgroundColor:KColorHexadecimal(kLineMain_Color, 1.0)];
    [collectionView registerNib:[UINib nibWithNibName:kTXXLCityHotCell bundle:nil] forCellWithReuseIdentifier:kTXXLCityHotCell];
    [collectionView registerNib:[UINib nibWithNibName:kTXXLCityHotHeaderReusableView bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kTXXLCityHotHeaderReusableView];
    self.hotCollection = collectionView;
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.headerView.mas_bottom);
        make.bottom.equalTo(self.view).with.offset(-self.tabbarBetweenHeight);
    }];
}
- (void)customHeaderView {
    TXXLCitySelectView *headerView = [[TXXLCitySelectView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WIDTH_RACE_6S(186))];
    @weakify(self)
    headerView.searchBlock = ^(NSString *text) {
        @strongify(self)
        [self searchEvent:text];
    };
    headerView.eventBlock = ^(NSInteger type) {
        @strongify(self)
        [self headerEvent:type];
    };
    self.headerView = headerView;
    [self.view addSubview:headerView];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (UITableView *)searchTableView {
    if (!_searchTableView) {
        _searchTableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:UITableViewCellSeparatorStyleSingleLine headRefreshAction:nil footRefreshAction:nil separatorColor:KColorHexadecimal(kLineMain_Color, 1.0) backgroundColor:[UIColor whiteColor]];
        _searchTableView.rowHeight = 64;
        [_searchTableView registerNib:[UINib nibWithNibName:kTXXLSearchResultCell bundle:nil] forCellReuseIdentifier:kTXXLSearchResultCell];
        _searchTableView.tableFooterView = [[UIView alloc]init];
        [self.view addSubview:_searchTableView];
        [_searchTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.headerView.mas_bottom);
            make.bottom.equalTo(self.view).with.offset(-self.tabbarBetweenHeight);
        }];
    }
    return _searchTableView;
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

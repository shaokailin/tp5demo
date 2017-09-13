//
//  SMKCycleScrollView.m
//  SMKCycleScrollViewDemo
//
//  Created by Mac on 17/5/4.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "SMKCycleScrollView.h"
#import "UIView+SEKExtension.h"
#import "NSAttributedString+YYText.h"

#define SMKMaxSections 6

@interface SMKCycleScrollView ()<UITableViewDelegate, UITableViewDataSource>
/**
 *  滚动视图
 */
@property (nonatomic, strong) UITableView *tableView;
/**
 *  定时器
 */
@property (nonatomic,strong) NSTimer *timer;

@end

@implementation SMKCycleScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tableView.frame = self.bounds;
}

- (void)setTitleArray:(NSArray *)titleArray {
    
    _titleArray = titleArray;
    
    if (titleArray.count == 0) {
        [self removeTimer];
        return;
    }
    
    if (titleArray.count == 1) {
        [self removeTimer];
    }
    
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:SMKMaxSections / 2] atScrollPosition:UITableViewScrollPositionTop animated:NO];

    [self addTimer];

}

- (NSIndexPath *)resetIndexPath
{
    // 当前正在展示的位置
    NSIndexPath *currentIndexPath = [[self.tableView indexPathsForVisibleRows] lastObject];
    // 马上显示回最中间那组的数据
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForRow:currentIndexPath.row inSection:SMKMaxSections/2];
    [self.tableView scrollToRowAtIndexPath:currentIndexPathReset atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    return currentIndexPathReset;
}

/**
 *  下一页
 */
- (void)nextPage
{
    // 1.马上显示回最中间那组的数据
    NSIndexPath *currentIndexPathReset = [self resetIndexPath];
    
    // 2.计算出下一个需要展示的位置
    NSInteger nextItem = currentIndexPathReset.row + 1;
    NSInteger nextSection = currentIndexPathReset.section;
    if (nextItem == self.titleArray.count) {
        nextItem = 0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:nextItem inSection:nextSection];
    
    // 3.通过动画滚动到下一个位置
    [self.tableView scrollToRowAtIndexPath:nextIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)setIsCanScroll:(BOOL)isCanScroll {
    
    _isCanScroll = isCanScroll;
    self.tableView.scrollEnabled = isCanScroll;
}

#pragma mark --------------------  UITableView DataSource && Delegate  --------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return SMKMaxSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.typeString isEqualToString:@"chat"]) {
        CycleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        //    cell.textLabel.backgroundColor = self.backColor;
        //    cell.textLabel.textColor = self.titleColor;
        //    cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.font = self.titleFont;
        NSDictionary *dic = self.titleArray[indexPath.row];
        NSString *st = [NSString stringWithFormat:@"%@ %@ %@ %@ %@",dic[@"from_name"],dic[@"desc"],dic[@"to_name"],dic[@"gift_name"],dic[@"end"]];
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:st];
        NSUInteger length = [dic[@"from_name"] length];
        NSUInteger length2 = [dic[@"desc"] length];
        NSUInteger length3 = [dic[@"to_name"] length];
        NSUInteger length4 = [dic[@"gift_name"] length];
        NSUInteger length5 = [dic[@"end"] length];

        UIColor *color = hong;
        [text addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, length)];
        [text addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(length + length2 + 2 , length3 )];
        [text addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(length + length2 + length3 + 3 , length4)];
        
        cell.textLabel.attributedText = text;
        //    cell.textLabel = st;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.contentView.backgroundColor =  [UIColor colorWithRed:226.0/255.0 green:226.0/255.0 blue:226.0/255.0 alpha:1];
        

        return cell;

        
    }else {
        CycleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        //    cell.textLabel.backgroundColor = self.backColor;
        //    cell.textLabel.textColor = self.titleColor;
        //    cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.font = self.titleFont;
        NSDictionary *dic = self.titleArray[indexPath.row];
        NSString *st = [NSString stringWithFormat:@"[%@]%@",dic[@"user_nicename"],dic[@"desc"]];
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:st];
        NSUInteger length = [dic[@"user_nicename"] length];
        
        UIColor *color = hong;
        [text addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, length + 2)];

        cell.textLabel.attributedText = text;
        cell.textLabel.textAlignment = NSTextAlignmentLeft;

        //    cell.textLabel = st;
        
        return cell;

        
    }
    
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.titleArray[indexPath.row];
    NSString *st = [NSString stringWithFormat:@"[%@]%@",dic[@"user_nicename"],dic[@"desc"]];
    !self.selectedBlock ?: self.selectedBlock(indexPath.row, st);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    //开启定时器
    [self addTimer];
}

- (void)addTimer{
    [self removeTimer];
    self.timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}



- (void)removeTimer {
    
    [self.timer invalidate];
    self.timer = nil;
}

- (void)dealloc {
    
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark --------------------  懒加载  --------------------
- (UITableView *)tableView {
    
    if (_tableView == nil) {
        
//        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView = [[UITableView alloc]init];
//        _tableView.style = UITableViewStyleGrouped;
        _tableView.frame = CGRectMake(0, 100,self.frame.size.width , 200);
        _tableView.sectionFooterHeight = 0;
        _tableView.sectionHeaderHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 32;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.scrollEnabled = NO;
        _tableView.pagingEnabled = YES;
//        _tableView.backgroundColor = [UIColor yellowColor];
//        self.backgroundColor = [UIColor blackColor];
        [_tableView registerClass:[CycleViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.tableFooterView = [[UIView alloc]init];
        [self addSubview:_tableView];

    }
    
    return _tableView;
}

@end


@implementation CycleViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [UIColor clearColor];
    self.textLabel.x = 0;
    self.textLabel.y = 0;
    self.textLabel.width = self.contentView.width;
    self.textLabel.height = self.contentView.height;
    self.textLabel.alpha = 0.8;
 
   
    
    
}

@end

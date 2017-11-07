//
//  LSKViewFactory.m
//  SingleStore
//
//  Created by hsPlan on 2017/9/11.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKViewFactory.h"
#import "LSKImageManager.h"
#import "TPKeyboardAvoidingTableView.h"
#import "TPKeyboardAvoidingScrollView.h"
@implementation LSKViewFactory
+ (UIView *)initializeLineView {
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = ColorHexadecimal(kLineMain_Color, 1.0);
    return lineView;
}
+ (UILabel *)initializeLableWithText:(NSString *)text font:(CGFloat)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)alignment backgroundColor:(UIColor *)bgColor {
    UILabel *label = [[UILabel alloc]init];
    if (bgColor) {
        label.backgroundColor = bgColor;
    }else {
        label.backgroundColor = [UIColor clearColor];
    }
    if (textColor) {
        label.textColor = textColor;
    }
    label.font = FontNornalInit(font);
    label.textAlignment = alignment;
    label.text = text;
    return label ;
}

+ (UIButton *)initializeButtonWithTitle:(NSString *)title nornalImage:(NSString *)nornalImage selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)action textfont:(CGFloat)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)bgColor backgroundImage:(NSString *)bgimage {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (bgColor) {
        [button setBackgroundColor:bgColor];
    }
    if (KJudgeIsNullData(bgimage)) {
        [button setBackgroundImage:[UIImage imageNamed:bgimage] forState:UIControlStateNormal];
    }
    if (KJudgeIsNullData(nornalImage)) {
        [button setImage:[UIImage imageNamed:nornalImage] forState:UIControlStateNormal];
    }
    if (KJudgeIsNullData(selectedImage)) {
        [button setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    }
    if (target && action) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    if (title != nil) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    button.titleLabel.font = FontNornalInit(font);
    if (textColor) {
        [button setTitleColor:textColor forState:UIControlStateNormal];
    }
    return button ;
}

+ (UITextField *)initializeTextFieldWithDelegate:(id)delegate text:(NSString *)text placeholder:(NSString *)placeholder textFont:(CGFloat)font textColor:(UIColor *)color placeholderColor:(UIColor *)placeholderColor textAlignment:(NSTextAlignment)alignment borStyle:(UITextBorderStyle)style returnKey:(UIReturnKeyType)keyTyle keyBoard:(UIKeyboardType)keyBoard cleanModel:(UITextFieldViewMode)cleanMode  {
    
    UITextField *textField = [[UITextField alloc]init];
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    if (delegate != nil) {
        textField.delegate = delegate;
    }
    textField.text = text;
    textField.placeholder = placeholder;
    if (placeholderColor) {
        [textField setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
    }
    textField.font = FontNornalInit(font);
    if (color) {
        textField.textColor = color;
    }
    textField.clearButtonMode =  cleanMode;
    textField.textAlignment = alignment;
    textField.borderStyle = style;
    textField.returnKeyType = keyTyle;
    textField.keyboardType = keyBoard;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    return textField ;
}

+ (UITableView *)initializeTableViewWithDelegate:(id)delegate tableType:(UITableViewStyle)style separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle headRefreshAction:(SEL)headAction footRefreshAction:(SEL)footAction separatorColor:(UIColor *)separatorColor backgroundColor:(UIColor *)backgroundColor {
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:style];
    tableView.delegate = delegate;
    tableView.dataSource = delegate;
    if (separatorColor) {
        tableView.separatorColor = separatorColor;
        
    }else {
        tableView.separatorColor = ColorHexadecimal(kLineMain_Color, 1.0);
    }
    tableView.separatorInset = UIEdgeInsetsZero;
    tableView.separatorStyle = separatorStyle;
    [[self class]_setupScrollViewMJRefresh:tableView target:delegate headerAction:headAction footerAction:footAction background:backgroundColor];
    return tableView ;
}

+ (TPKeyboardAvoidingTableView *)initializeTPTableViewWithDelegate:(id)delegate tableType:(UITableViewStyle)style separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle headRefreshAction:(SEL)headAction footRefreshAction:(SEL)footAction separatorColor:(UIColor *)separatorColor backgroundColor:(UIColor *)backgroundColor {
    TPKeyboardAvoidingTableView *tableView = [[TPKeyboardAvoidingTableView alloc]initWithFrame:CGRectZero style:style];
    tableView.delegate = delegate;
    tableView.dataSource = delegate;
    if (separatorColor) {
        tableView.separatorColor = separatorColor;
        tableView.separatorInset = UIEdgeInsetsZero;
    }
    tableView.separatorStyle = separatorStyle;
    [[self class]_setupScrollViewMJRefresh:tableView target:delegate headerAction:headAction footerAction:footAction background:backgroundColor];
    return tableView ;
}
+ (TPKeyboardAvoidingScrollView *)initializeTPScrollView {
     TPKeyboardAvoidingScrollView *scrollView = [[TPKeyboardAvoidingScrollView alloc]init];
    //因为iOS 11 下的 刷新会出现偏移，所以适配
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 110000
    if (@available(iOS 11.0, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
#endif
    return scrollView;
}
+ (UICollectionView *)initializeCollectionViewWithDelegate:(id)delegate collectionViewLayout:(UICollectionViewLayout *)layout headRefreshAction:(SEL)headAction footRefreshAction:(SEL)footAction backgroundColor:(UIColor *)backgroundColor {
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.delegate = delegate;
    collectionView.dataSource = delegate;
    [[self class]_setupScrollViewMJRefresh:collectionView target:delegate headerAction:headAction footerAction:footAction background:backgroundColor];
    return collectionView ;
}
//设置滚动视图的刷新喝加载更多
+ (void)_setupScrollViewMJRefresh:(UIScrollView *)scrollView target:(id)target headerAction:(SEL)headerAction footerAction:(SEL)footerAction background:(UIColor *)background {
    if (background) {
        scrollView.backgroundColor = background;
    }else {
        scrollView.backgroundColor = ColorHexadecimal(kMainBackground_Color, 1.0);
    }
    //添加头部刷新
    if (headerAction) {
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:headerAction];
        scrollView.mj_header = header;
    }
    //添加尾部加载更多
    if (footerAction) {
        MJRefreshAutoNormalFooter *footerView = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:footerAction];
        footerView.automaticallyRefresh = NO;
        [footerView setTitle:@"查看更多" forState:MJRefreshStateIdle];
        footerView.backgroundColor = [UIColor whiteColor];
        footerView.stateLabel.font = FontNornalInit(15);
        footerView.stateLabel.textColor = ColorHexadecimal(0x4a4a4a, 1.0);
        footerView.triggerAutomaticallyRefreshPercent = 200;
//        footerView.hidden = YES;
        scrollView.mj_footer = footerView;
    }
    //因为iOS 11 下的 刷新会出现偏移，所以适配
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 110000
    if (@available(iOS 11.0, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
#endif
}
//对需要刷新和加载的进行foot处理
+ (void)setupFootRefresh:(UIScrollView *)scrollView page:(NSInteger)page currentCount:(NSInteger)count {
    //判断是否超出屏幕的高度，超出再进行尾部的处理  小于的话就进行隐藏
    if (scrollView.contentSize.height > VIEW_MAIN_HEIGHT) {
        scrollView.mj_footer.hidden = NO;
        NSInteger pageIndex = page + 1;
        if (count < pageIndex * PAGE_SIZE_NUMBER) {
            [scrollView.mj_footer endRefreshingWithNoMoreData];
        }else {
            [scrollView.mj_footer resetNoMoreData];
        }
    }else {
        scrollView.mj_footer.hidden = YES;
    }
}
//设置导航栏的属性
+ (void)setupMainNavigationBgColor:(UIColor *)bgColor titleFont:(CGFloat)font titleColor:(UIColor *)titleColor lineColor:(UIColor *)lineColor {
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    navigationBar.barTintColor = bgColor;
    navigationBar.tintColor = bgColor;
    navigationBar.translucent = NO;
    navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : titleColor,NSFontAttributeName : FontNornalInit(font)};
    [[UINavigationBar appearance]  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    if (lineColor == nil) {
        lineColor = [UIColor clearColor];
    }
    [[UINavigationBar appearance] setShadowImage:[LSKImageManager imageWithColor:lineColor size:CGSizeMake(SCREEN_WIDTH, 0.5)]];
}

+ (UIViewController *)getCurrentViewController {
    UIViewController *resultVC;
    resultVC = [[self class] _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [[self class] _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [[self class] _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [[self class] _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

@end

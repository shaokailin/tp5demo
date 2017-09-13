//
//  keyBoardToolView.h
//  keyBoard
//
//  Created by yangyu on 16/7/5.
//  Copyright © 2016年 yangyu. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol keyBoardToolViewDelegate <NSObject>

- (void)keyBoardToolShouldEndEditing:(UITextView *)textView;

@end

@interface keyBoardToolView : UIView
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) NSString *string;
@property (nonatomic, strong) UILabel *wenLabel;
@property (nonatomic, assign) id<keyBoardToolViewDelegate>delegate;

@end

//
//  Config.h
//  SingleStore
//
//  Created by hsPlan on 2017/9/8.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#ifndef Config_h
#define Config_h

typedef NS_ENUM(NSInteger, OrderHomeSearchClickType) {
    OrderHomeSearchClickType_Search,
    OrderHomeSearchClickType_Date,
    OrderHomeSearchClickType_Shop
};
typedef void(^OrderHomeSearchClickBlock) (OrderHomeSearchClickType type);

// 圆角效果 view 10
#define ViewBoundsRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]\

#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
//layer颜色用来调试视图
#define ViewBorderLayer(View,Color,Width)\
\
View.layer.borderWidth = (Width);\
View.layer.borderColor = (Color).CGColor\

static const NSInteger LINEVIEW_WIDTH = 1.0;

#define COLOR_WHITECOLOR [UIColor whiteColor]

#endif /* Config_h */

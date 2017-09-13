//
//  GiftView.h
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/5/14.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GiftView : UIView
@property (nonatomic, copy)NSString *LUID;
@property (nonatomic, strong)UILabel *VIPLabel;
@property (nonatomic, strong)UIButton *chpngbutton;
@property (nonatomic, strong)UIButton *shenjiButton;
@property (nonatomic, strong)UILabel *moLAbel;
@property (nonatomic, strong)UILabel *monyLaebel;
@property (nonatomic, strong)UIButton *quabutton;
@property (nonatomic, strong)UIButton *qianxiaButton;
@property (nonatomic, strong)UIButton *yiqianButton;
@property (nonatomic, strong)UIButton *shiwanButton;
@property (nonatomic, strong)UICollectionView *collectionView;
//点
@property (nonatomic, strong)UILabel *dianLabel;
@property (nonatomic, strong)UILabel *VIPmony;
@property (nonatomic, strong)UILabel *shuLabel;
@property (nonatomic, strong)UITextField *suTextField;
@property (nonatomic, strong)UIButton *dabutton;
@end

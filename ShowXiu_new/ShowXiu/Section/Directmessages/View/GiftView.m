//
//  GiftView.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/5/14.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "GiftView.h"
#import "GiftCollectionViewCell.h"
#import "GiftModel.h"
#import "GoldTwoView.h"
@interface GiftView () <UICollectionViewDataSource, UICollectionViewDelegate,UITextFieldDelegate,UITextFieldDelegate>
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, assign)NSIndexPath * selectedIndexPath;
@property (nonatomic, strong)NSMutableArray *chudataArray;
//礼物的ID
@property (nonatomic, copy)NSString *liwuID;
@property (nonatomic, copy)NSString *jiageSt;
@property (nonatomic, strong)UITapGestureRecognizer *tagLI;
@end

@implementation GiftView
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
- (NSMutableArray *)chudataArray{
    if (!_chudataArray) {
        _chudataArray = [[NSMutableArray alloc]init];
    }
    return _chudataArray;
}


//chongxie初始化,添加控件
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){

        //添加控件
        self.backgroundColor = [UIColor whiteColor];

        [self addSubview:self.VIPLabel];
        [self addSubview:self.shenjiButton];
        [self addSubview:self.chpngbutton];
        [self addSubview:self.moLAbel];
        [self addSubview:self.monyLaebel];
        [self addSubview:self.qianxiaButton];
        [self addSubview:self.quabutton];
        [self addSubview:self.qianxiaButton];
        [self addSubview:self.yiqianButton];
        [self addSubview:self.shiwanButton];
        [self addSubview:self.collectionView];
        [self addSubview:self.monyLaebel];
        [self addSubview:self.dianLabel];
        [self addSubview:self.VIPmony];
        [self addSubview:self.shuLabel];
        [self addSubview:self.suTextField];
        [self addSubview:self.dabutton];
        
        [self liwuData];
     

        
    }
    return self;
}
- (void)AAdtag{
    [self endEditing:YES];
    
}
- (UILabel *)VIPLabel{
    if (!_VIPLabel) {
        _VIPLabel = [[UILabel alloc]init];
        _VIPLabel.frame = CGRectMake(10, 8, 120, 20);
        _VIPLabel.font = [UIFont systemFontOfSize:12];
    }
    return _VIPLabel;
}
- (UIButton *)shenjiButton{
    if (!_shenjiButton) {
        _shenjiButton = [[UIButton alloc]init];
        _shenjiButton.frame = CGRectMake(115, 8, 55, 18);
        [_shenjiButton setTitle:@"升级VIP" forState:UIControlStateNormal];
//        [_shenjiButton addTarget:self action:@selector(addshenjiButton:) forControlEvents:UIControlEventTouchUpInside];
        _shenjiButton.layer.masksToBounds = YES;
        _shenjiButton.layer.cornerRadius = 5.0;
        _shenjiButton.layer.borderWidth = 1.0;
        _shenjiButton.layer.borderColor = [UIColor redColor].CGColor;
        _shenjiButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_shenjiButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

    }
    return _shenjiButton;
    
}
- (UIButton *)chpngbutton{
    if(!_chpngbutton){
        _chpngbutton = [[UIButton alloc]init];
        _chpngbutton.frame = CGRectMake(kScreen_w - 60, 8, 50, 18);
        [_chpngbutton setTitle:@"充值" forState:UIControlStateNormal];
//        [_chpngbutton addTarget:self action:@selector(addchongButton:) forControlEvents:UIControlEventTouchUpInside];
        _chpngbutton.titleLabel.font = [UIFont systemFontOfSize:12];
        _chpngbutton.backgroundColor = hong;
        _chpngbutton.layer.masksToBounds = YES;
        _chpngbutton.layer.cornerRadius = 10.0;
        [_chpngbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _chpngbutton;
}
- (UILabel *)moLAbel{
    if (!_moLAbel) {
       _moLAbel = [[UILabel alloc]init];
        _moLAbel.frame = CGRectMake(kScreen_w - 145, 8, 70, 20);
        _moLAbel.font = [UIFont systemFontOfSize:12];
        _moLAbel.text = @"秀币余额:";
    }
    return _moLAbel;
}
- (UILabel *)monyLaebel{
    if (!_monyLaebel) {
        _monyLaebel = [[UILabel alloc]init];
        _monyLaebel.frame = CGRectMake(kScreen_w - 90, 8, 50, 20);
        _monyLaebel.font = [UIFont systemFontOfSize:12];
        _monyLaebel.textColor = [UIColor redColor];
    }
    return _monyLaebel;
}
- (UIButton *)quabutton{
    if (!_quabutton) {
        _quabutton = [[UIButton alloc]init];
        _quabutton.frame = CGRectMake(10, 35, 50, 26);
        [_quabutton setTitle:@"全部" forState:UIControlStateNormal];
        [_quabutton addTarget:self action:@selector(addshenjiButton:) forControlEvents:UIControlEventTouchUpInside];
        _quabutton.layer.masksToBounds = YES;
        _quabutton.layer.cornerRadius = 13.0;
        _quabutton.layer.borderWidth = 1.0;
        _quabutton.layer.borderColor = [UIColor redColor].CGColor;
        _quabutton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_quabutton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _quabutton.tag = 1000;
    }
    return _quabutton;
}
- (UIButton *)qianxiaButton{
    if (!_qianxiaButton) {
        _qianxiaButton = [[UIButton alloc]init];
        _qianxiaButton.frame = CGRectMake(65, 35, 80, 26);
        [_qianxiaButton setTitle:@"一千以下" forState:UIControlStateNormal];
        [_qianxiaButton addTarget:self action:@selector(addshenjiButton:) forControlEvents:UIControlEventTouchUpInside];
        _qianxiaButton.layer.masksToBounds = YES;
        _qianxiaButton.layer.cornerRadius = 13.0;
        _qianxiaButton.layer.borderWidth = 1.0;
        _qianxiaButton.layer.borderColor = [UIColor redColor].CGColor;
        _qianxiaButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_qianxiaButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _qianxiaButton.tag = 1001;

    }
    return _qianxiaButton;
}
- (UIButton *)yiqianButton{
    if (!_yiqianButton) {
        _yiqianButton = [[UIButton alloc]init];
        _yiqianButton.frame = CGRectMake(150, 35, 80, 26);
        [_yiqianButton setTitle:@"一千-10万" forState:UIControlStateNormal];
        [_yiqianButton addTarget:self action:@selector(addshenjiButton:) forControlEvents:UIControlEventTouchUpInside];
        _yiqianButton.layer.masksToBounds = YES;
        _yiqianButton.layer.cornerRadius = 13.0;
        _yiqianButton.layer.borderWidth = 1.0;
        _yiqianButton.layer.borderColor = [UIColor redColor].CGColor;
        _yiqianButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_yiqianButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _yiqianButton.tag = 1002;
    }
    return _yiqianButton;
}
- (UIButton *)shiwanButton{
    if (!_shiwanButton) {
        _shiwanButton = [[UIButton alloc]init];
        _shiwanButton.frame = CGRectMake(235, 35, 80, 26);
        [_shiwanButton setTitle:@"10万以上" forState:UIControlStateNormal];
        [_shiwanButton addTarget:self action:@selector(addshenjiButton:) forControlEvents:UIControlEventTouchUpInside];
        _shiwanButton.layer.masksToBounds = YES;
        _shiwanButton.layer.cornerRadius = 13.0;
        _shiwanButton.layer.borderWidth = 1.0;
        _shiwanButton.layer.borderColor = [UIColor redColor].CGColor;
        _shiwanButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_shiwanButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _shiwanButton.tag = 1003;

    }
    return _shiwanButton;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        //创建布局对象
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat  hh = liKsceen_K;
        flowLayout.itemSize = CGSizeMake((kScreen_w - 30)/ 5, hh);
        //设置分区的边界距离
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        //设置行间距
        flowLayout.minimumLineSpacing  = 5;
        //设置item的距离
        flowLayout.minimumInteritemSpacing = 5;
        //设置滚动的方向(默认竖直方向)
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;//水平方向
        
        //创建UICollectionView对象
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 66, kScreen_w,hh * 2 + 26) collectionViewLayout:flowLayout];
        //1.配置数据源对象
        _collectionView.dataSource = self;
        //2.设置代理对象
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        
        //注册cell(item)
        [_collectionView registerNib:[UINib nibWithNibName:@"GiftCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"GiftCollectionViewCell"];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(participatePayWX) name:@"participatePayWXXIU" object:nil];

     
        self.collectionView.backgroundColor = [UIColor whiteColor];
        
       

        
    }
    return _collectionView;
}
- (void)participatePayWX{
    [self liwuData];
}

- (UILabel *)dianLabel{
    if (!_dianLabel) {
        _dianLabel = [[UILabel alloc]init];
        CGFloat  hh = liKsceen_K;

        _dianLabel.frame = CGRectMake(0, 66 + hh * 2 + 26, kScreen_w, 20);
        _dianLabel.textAlignment = NSTextAlignmentCenter;
        _dianLabel.textColor = [UIColor blackColor];
    }
    return _dianLabel;
}
- (UILabel *)VIPmony{
    if (!_VIPmony) {
        _VIPmony = [[UILabel alloc]init];
        CGFloat  hh = liKsceen_K;

        _VIPmony.frame = CGRectMake(10, 86 + hh * 2 + 26, 150, 20);
        _VIPmony.textColor = hong;
        _VIPmony.text = @"VIP专属价：0金币";
        _VIPmony.font = [UIFont systemFontOfSize:12];
    }
    return _VIPmony;
}
- (UILabel *)shuLabel{
    if (!_shuLabel) {
        _shuLabel = [[UILabel alloc]init];
        CGFloat  hh = liKsceen_K;

        _shuLabel.frame = CGRectMake(kScreen_w / 2, 86 + hh * 2 + 26, 40, 20);
        _shuLabel.textAlignment = NSTextAlignmentRight;
        _shuLabel.text = @"数量:";
        _shuLabel.font = [UIFont systemFontOfSize:12];
        
    }
    return _shuLabel;
}
- (UITextField *)suTextField{
    if (!_suTextField) {
        _suTextField = [[UITextField alloc]init];
        CGFloat  hh = liKsceen_K;

        _suTextField.frame = CGRectMake(kScreen_w / 2 + 40, 86 + hh * 2 + 26, 50, 20);
        _suTextField.layer.cornerRadius = 10;
        _suTextField.layer.masksToBounds = YES;
        _suTextField.layer.borderWidth = 1;
        _suTextField.layer.borderColor = [UIColor grayColor].CGColor;
        _suTextField.text = @"1";
        _suTextField.delegate = self;
        _suTextField.textAlignment = NSTextAlignmentCenter;
        _suTextField.font = [UIFont systemFontOfSize:14];
        _suTextField.keyboardType = UIKeyboardTypeNumberPad;
        //弹出
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowLi:) name:UIKeyboardWillShowNotification object:nil];
        //收起
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideLi:) name:UIKeyboardWillHideNotification object:nil];
    }
    return  _suTextField;
}
- (UIButton *)dabutton{
    if (!_dabutton) {
        _dabutton = [[UIButton alloc]init];
        CGFloat  hh = liKsceen_K;

        _dabutton.frame = CGRectMake(kScreen_w - 60, 86 + hh * 2 + 26, 60, 30);
        [_dabutton setTitle:@"发送" forState:UIControlStateNormal];
        [_dabutton addTarget:self action:@selector(adddaButton:) forControlEvents:UIControlEventTouchUpInside];
        _dabutton.backgroundColor = hong;
    }
    return _dabutton;
}


//
- (void)addshenjiButton:(UIButton *)sender{
    if (sender.tag == 1000) {
        [self.dataArray removeAllObjects];
        NSMutableArray *Array = self.chudataArray;
        for (GiftModel *mdoel in Array) {
            [self.dataArray addObject:mdoel];
        }

        
        GiftModel *model = [GiftModel new];
        [self.dataArray insertObject:model atIndex:11];
        [self.dataArray insertObject:model atIndex:13];
        [self.dataArray insertObject:model atIndex:15];
        [self.dataArray insertObject:model atIndex:17];
        
        NSInteger count = self.dataArray.count;
        NSInteger y = count % 10;
        NSInteger x = 10 - y - 1;
        for (int i = 0; i < x; i ++ ) {
            GiftModel *model = [GiftModel new];
            [self.dataArray addObject:model];
        }
        [self.collectionView reloadData];
    }else if(sender.tag == 1001){
        [self.dataArray removeAllObjects];

        for (GiftModel *model in self.chudataArray) {
            NSString *mostring = [NSString stringWithFormat:@"%@",model.price];
            int HH = [mostring intValue];
            if (HH < 1000) {
                [self.dataArray addObject:model];
            }
        }
        GiftModel *model = [GiftModel new];
        [self.dataArray insertObject:model atIndex:1];
        [self.dataArray insertObject:model atIndex:3];
        [self.dataArray insertObject:model atIndex:5];
        [self.dataArray insertObject:model atIndex:7];
        
//        NSInteger count = self.dataArray.count;
//        NSInteger y = count % 10;
//        NSInteger x = 10 - y - 1;
//        for (int i = 0; i < x; i ++ ) {
//            GiftModel *model = [GiftModel new];
//            [self.dataArray addObject:model];
//        }
        [self.collectionView reloadData];
        

        
        
    }else if(sender.tag == 1002){
        [self.dataArray removeAllObjects];

        for (GiftModel *model in self.chudataArray) {
            NSString *mostring = [NSString stringWithFormat:@"%@",model.price];
            int HH = [mostring intValue];
            if ((HH < 100000 && HH > 1000) || HH == 1000) {
                [self.dataArray addObject:model];
            }
        }
        GiftModel *model = [GiftModel new];
        [self.dataArray insertObject:model atIndex:7];
        
//        NSInteger count = self.dataArray.count;
//        NSInteger y = count % 10;
//        NSInteger x = 10 - y - 1;
//        for (int i = 0; i < x; i ++ ) {
//            GiftModel *model = [GiftModel new];
//            [self.dataArray addObject:model];
//        }
        [self.collectionView reloadData];

        
    }else if(sender.tag == 1003){
        [self.dataArray removeAllObjects];

        for (GiftModel *model in self.chudataArray) {
            NSString *mostring = [NSString stringWithFormat:@"%@",model.price];
            int HH = [mostring intValue];
            if (HH > 100000 ) {
                [self.dataArray addObject:model];
            }
        }
        GiftModel *model = [GiftModel new];
        [self.dataArray insertObject:model atIndex:1];
        
//        NSInteger count = self.dataArray.count;
//        NSInteger y = count % 10;
//        NSInteger x = 10 - y - 1;
//        for (int i = 0; i < x; i ++ ) {
//            GiftModel *model = [GiftModel new];
//            [self.dataArray addObject:model];
//        }
        [self.collectionView reloadData];
        
    }
    
    
}
//充值按钮
- (void)addchongButton:(UIButton *)sender{
    
}
//发送
- (void)adddaButton:(UIButton *)sender{
    NSString *stringURL = [NSString stringWithFormat:@"%@%@",AppURL,API_sendgift];
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *uidS = [defatults objectForKey:uidSG];
    if (self.liwuID == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"你还没有选择礼物" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else {
        NSDictionary *dic = @{@"fromuid":uidS,@"touid":self.LUID,@"giftid":self.liwuID,@"giftnum":self.suTextField.text};
        
        
        [HttpUtils postRequestWithURL:stringURL withParameters:dic withResult:^(id result) {
            
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"送礼成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        } withError:^(NSString *msg, NSError *error) {
            [SVProgressHUD showInfoWithStatus:msg];
            [SVProgressHUD dismissWithDelay:1.0];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"zhifujinbiXIUXIU" object:nil];

            
          
        }];

        
    }
    
    
}


//礼物的数据
- (void)liwuData{
    NSString *stringURL = [NSString stringWithFormat:@"%@%@",AppURL,API_shopgift];
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *uidS = [defatults objectForKey:uidSG];
    
    [HttpUtils postRequestWithURL:stringURL withParameters:@{@"uid":uidS,@"p":@""} withResult:^(id result) {
        NSArray *giftlist = result[@"data"][@"giftlist"];
        [self.dataArray removeAllObjects];
        [self.chudataArray removeAllObjects];
        for (NSDictionary *dic in giftlist) {
            GiftModel *mode = [[GiftModel alloc]initWithDictionary:dic error:nil];
            [self.dataArray addObject:mode];
            [self.chudataArray addObject:mode];
        }

        GiftModel *model = [GiftModel new];
        [self.dataArray insertObject:model atIndex:11];
        [self.dataArray insertObject:model atIndex:13];
        [self.dataArray insertObject:model atIndex:15];
        [self.dataArray insertObject:model atIndex:17];
        
        NSInteger count = self.dataArray.count;
        NSInteger y = count % 10;
        NSInteger x = 10 - y - 1;
        for (int i = 0; i < x; i ++ ) {
            GiftModel *model = [GiftModel new];
            [self.dataArray addObject:model];
        }

        
        [self.dataArray addObject:model];
        

        NSString *VIPString = [NSString stringWithFormat:@"VIP剩余天数:%@天",result[@"data"][@"uinfo"][@"rank_time"]];
        self.VIPLabel.text = VIPString;
        self.monyLaebel.text = result[@"data"][@"uinfo"][@"money"];
     
        
        
        
        [self.collectionView reloadData];
        
    
        
    } withError:^(NSString *msg, NSError *error) {
        
        
    }];
    
}
#pragma mark ------ UICollectionViewDataSource
//设置分区item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.dataArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GiftModel *model = self.dataArray[indexPath.row];
    GiftCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GiftCollectionViewCell" forIndexPath:indexPath];
    if (model.images == nil) {
        cell.contentView.alpha = 0;
    }else {
        cell.contentView.alpha = 1;
        [cell.touimageView sd_setImageWithURL:[NSURL URLWithString:model.images] placeholderImage:[UIImage imageNamed:zhanImage]];
    }
    cell.nameLabel.text = model.gift_name;
    NSString *jiageSTring = [NSString stringWithFormat:@"%@",model.price];
    cell.jiageLabel.text = jiageSTring;
    
    if (indexPath.row < 11) {
        self.dianLabel.text = @".";
    }else {
        self.dianLabel.text = @"..";
    }
    
    if (indexPath.row == 0){
        [cell.xuanButton setBackgroundImage:[UIImage imageNamed:@"形状-17-拷贝"] forState:UIControlStateNormal];
        GiftModel *mdoel = _dataArray[0];
        NSString *VString = [NSString stringWithFormat:@"VIP专享价：%@秀币",mdoel.vip_price];
        self.VIPmony.text = VString;
        self.liwuID = mdoel.gift_id;
        self.jiageSt = mdoel.vip_price;
    }else {
        [cell.xuanButton setBackgroundImage:[UIImage imageNamed:@"形状-17"] forState:UIControlStateNormal];

    }
    
    return cell;
}
#pragma mark ---- UICollectionViewDelegate
//选中item触发的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger HH =  [[ _collectionView visibleCells ] count];
    NSUInteger KK = HH;

    
    for (int i = 0; i < KK
         ; i ++) {
        GiftCollectionViewCell *celled = self.collectionView.visibleCells[i];
        
        [celled.xuanButton setBackgroundImage:[UIImage imageNamed:@"形状-17"] forState:UIControlStateNormal];
    }
    
    //celled.xlDelegate = self;
    //记录当前选中的位置索引
    _selectedIndexPath = indexPath;
    //当前选择的打勾
    GiftCollectionViewCell *cell = [_collectionView cellForItemAtIndexPath:indexPath];
    //cell1.accessoryType = UITableViewCellAccessoryCheckmark;
    [cell.xuanButton setBackgroundImage:[UIImage imageNamed:@"形状-17-拷贝"] forState:UIControlStateNormal];
    GiftModel *mdoel = _dataArray[indexPath.row];
    NSString *VString = [NSString stringWithFormat:@"VIP专享价：%@秀币",mdoel.vip_price];
    self.VIPmony.text = VString;
    self.liwuID = mdoel.gift_id;
    self.jiageSt = mdoel.vip_price;
    
    
    NSLog(@"点击跳转");
}
//健谈将要弹出调用的方法
- (void)keyboardWillShowLi:(NSNotification *)aNotification{
    NSDictionary * userInFo = [aNotification userInfo];
    NSValue * aValue = [userInFo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyBoardRect = [aValue CGRectValue];
    int messHeight = keyBoardRect.size.height;
    self.tagLI =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(AAdtag)];
    [self addGestureRecognizer:self.tagLI];
    //添加动画改变
    [UIView animateWithDuration:0.1 animations:^{
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(kScreen_h - 370 - messHeight, 0, messHeight, 0));
        }];
        //告诉self.view约束改变重新计算，否则无动画
        [self layoutIfNeeded];
    }];
}
//键盘将要收起时调用
- (void)keyboardWillHideLi:(NSNotification *)aNotification{
    [self removeGestureRecognizer:self.tagLI];
    //添加动画改变
    [UIView animateWithDuration:0.1 animations:^{
        //mas_updateConstraints 更改约束的值
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(kScreen_h-370, 0, 0, 0));
        }];
 
        //告诉self.view约束改变重新计算，否则无动画
        [self layoutIfNeeded];
    }];}

//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    int HHS = [string intValue];
//    int jiaH = [self.jiageSt intValue];
//    int KK = HHS * jiaH;
//    NSString *VString = [NSString stringWithFormat:@"VIP专享价：%d秀币",KK];
//    self.VIPmony.text = VString;
//    
//    
//    return YES;
//}
//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    
//        int HHS = [textField.text intValue];
//        int jiaH = [self.jiageSt intValue];
//        int KK = HHS * jiaH;
//        NSString *VString = [NSString stringWithFormat:@"VIP专享价：%d秀币",KK];
//        self.VIPmony.text = VString;
//}


- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
     NSString * new_text_str = [textField.text stringByReplacingCharactersInRange:range withString:string];//变化后的字符串
    int HHS = [new_text_str intValue];
    int jiaH = [self.jiageSt intValue];
    int KK = HHS * jiaH;
    NSString *VString = [NSString stringWithFormat:@"VIP专享价：%d秀币",KK];
    self.VIPmony.text = VString;
    
    return YES;
}


@end

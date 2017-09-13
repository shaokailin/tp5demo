//
//  MessImageTableViewCell.m
//  SunShine
//
//  Created by 阳光互联 on 16/8/31.
//  Copyright © 2016年 阳光互联. All rights reserved.
//

#import "MessImageTableViewCell.h"
#import "MessageSSModel.h"
#import "UIImage+Extension.h"
#import "XHImageViewer.h"
#import "MyChongViewController.h"

@interface MessImageTableViewCell ()
@property(nonatomic,copy) NSString * myHeadimage;
@property(nonatomic,copy) NSString * frindImage;
@property(nonatomic,strong) UIVisualEffectView *effectView;
@end
@implementation MessImageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubViews];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Messagesuccesyincang:) name:@"Messagesuccesyincang" object:nil];
        UITapGestureRecognizer * tapmess = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browerImagehid:)];
        [self addGestureRecognizer:tapmess];
    }
    return self;
}
- (void)browerImagehid:(UITapGestureRecognizer*)tapp{
     self.deleViwq.hidden = YES;
    _deleBbbtn.hidden = YES;
     [[NSNotificationCenter defaultCenter] postNotificationName:@"Messagesuccessdianji" object:nil];
}
-(void)Messagesuccesyincang:(NSNotification *)obj{
    self.deleViwq.hidden = YES;
    _deleBbbtn.hidden = YES;
    
}

- (void)initSubViews{
    
    //时间
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textColor = [UIColor colorWithRed:48.0/255.0 green:48.0/255.0 blue:48.0/255.0 alpha:1];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_timeLabel];
    _headBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    _headBtn.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_headBtn];
    
    
    // 初始化头像视图
    _headImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _headImage.layer.cornerRadius = 20;
    _headImage.layer.masksToBounds = YES;
    _headImage.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_headImage];

    
    //初始化正文视图
    _backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_backBtn];

    
    _ipickImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _ipickImage.backgroundColor = [UIColor colorWithHue:255/255 saturation:255/255 brightness:255/255 alpha:0.5];
    _ipickImage.contentMode = UIViewContentModeScaleAspectFill;
    _ipickImage.clipsToBounds  = YES;
    _ipickImage.layer.cornerRadius = 5;
    _ipickImage.layer.masksToBounds = YES;
    [_backBtn addSubview:_ipickImage];
    
    _deleViwq = [[UIView  alloc] initWithFrame:CGRectZero];
    _deleViwq.hidden = YES;
    
    _deleViwq.layer.cornerRadius = 5;
    _deleViwq.layer.masksToBounds = YES;
    _deleViwq.backgroundColor = [UIColor blackColor];
    _deleViwq.alpha = 0.8;
    [self.contentView addSubview:_deleViwq];
    _deleBbbtn = [[UIButton  alloc] initWithFrame:CGRectZero];
    _deleBbbtn.hidden = YES;
    [_deleBbbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_deleBbbtn setTitle:@"删除" forState:UIControlStateNormal];
    _deleBbbtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_deleBbbtn addTarget:self action:@selector(shanchule) forControlEvents:UIControlEventTouchUpInside];
    _deleBbbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.contentView addSubview:_deleBbbtn];
   
}
- (void)setMessFriendModel:(MessageSSModel *)messFriendModel{
    _messFriendModel = messFriendModel;
    [self setFaceFrame];//设置头像
    [self setMessageFrame]; //设置内容
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setFaceFrame{//设置头像
   
//    if (_messFriendModel.create_at&&![_messFriendModel.create_at isEqualToString:@""]) {
//         _timeLabel.frame = CGRectMake(50, 10, kScreenWidth-100, 15);
//        NSArray *fristArray = [_messFriendModel.create_at componentsSeparatedByString:@":"];
//        NSString * nianString = fristArray[0];
//        NSArray * nianArray = [nianString componentsSeparatedByString:@"-"];
//        NSString * textTime = [NSString stringWithFormat:@"%@-%@:%@",nianArray[1],nianArray[2],fristArray[1]];
//        _timeLabel.text = textTime;
//        
//    }else{
//         _timeLabel.frame = CGRectMake(50, 10, kScreen_w-100, 0);
//        _timeLabel.text = @"";
//    }
    CGFloat width = 44;
    CGFloat height = 44;
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *uidS = [defatults objectForKey:uidSG];
    if ([_messFriendModel.fromuid isEqualToString:uidS]){
        _headImage.frame = CGRectMake(kScreen_w-width-5.0, CGRectGetMaxY(_timeLabel.frame)+10, width, height);
    }else {
        _headImage.frame = CGRectMake(5.0, CGRectGetMaxY(_timeLabel.frame)+10, width, height);
        
    }
    
    
    //    if ([_messFriendModel.isSender isEqualToString:@"YES"]) {//如果是自己发送
    //    } else if([_messFriendModel.isSender isEqualToString:@"NO"]){
    //    }
    _headBtn.frame = _headImage.frame;
    _myHeadimage = [defatults objectForKey:avatarIMG];
    //    _frindImage = [defatults objectForKey:avatarIMG];
    _frindImage = _messFriendModel.avatar;
    if ([_messFriendModel.fromuid isEqualToString:uidS]) {
        [_headImage sd_setImageWithURL:[NSURL URLWithString:_myHeadimage] placeholderImage:[UIImage imageNamed:zhantuImage]];
        _headImage.userInteractionEnabled = YES;

    } else {
        //        _headImage.image = [UIImage imageNamed:@"default_userpicc"];
        [_headImage sd_setImageWithURL:[NSURL URLWithString:_messFriendModel.avatar] placeholderImage:[UIImage imageNamed:zhantuImage]];
    }
}


- (void)setMessageFrame{//设置内容
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *uidS = [defatults objectForKey:uidSG];
    NSString *VIPSt = [defatults objectForKey:user_rankVIP];
    int VIPINt = [VIPSt intValue];
    
    if((_messFriendModel.content&&![_messFriendModel.content isEqualToString:@""]) ) {

        _ipickImage.frame = CGRectMake(kEdgeInsetsWidth-8, kEdgeInsetsWidth-10, 100, 150);
//         if ([_messFriendModel.isSender isEqualToString:@"YES"]) {
//            
//             NSData * imageda = [[NSData alloc] initWithBase64EncodedString:_messFriendModel.imageData options:NSDataBase64DecodingIgnoreUnknownCharacters];
//             UIImage * imagena = [UIImage imageWithData:imageda];
//             _ipickImage.image = imagena;
//             
//         } else if([_messFriendModel.isSender isEqualToString:@"NO"]){
//            [_ipickImage sd_setImageWithURL:[NSURL URLWithString:_messFriendModel.img_path] placeholderImage:[UIImage imageNamed:@"loading"]];
//             
//         }
        [_ipickImage sd_setImageWithURL:[NSURL URLWithString:_messFriendModel.content] placeholderImage:[UIImage imageNamed:@"loading"]];

         _ipickImage.userInteractionEnabled = YES;
         UITapGestureRecognizer * tapmess = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browerImagemeees:)];
         [_ipickImage addGestureRecognizer:tapmess];
        // 2、计算背景图片的frame，X坐标发送和接收计算方式不一样
        CGFloat bgY = CGRectGetMinY(_headImage.frame)+2;
        CGFloat width = _ipickImage.frame.size.width + kEdgeInsetsWidth+4;
        CGFloat height = _ipickImage.frame.size.height+kEdgeInsetsWidth;
        UIImage *bgImage; //声明一个背景图片对象
        UIImage *bgHighImage;
        // 3、判断是否为自己发送，来设置frame以及背景图片
        if ([_messFriendModel.fromuid isEqualToString:uidS]) { //如果是自己发送的
            CGFloat bgX = kScreen_w-kPaddingL*2-CGRectGetWidth(_headImage.frame)-width+4;
            _backBtn.frame = CGRectMake(bgX,bgY, width, height);
            [_backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            bgImage = [UIImage resizableImageWithName:nil];
            bgHighImage = [UIImage resizableImageWithName:nil];
        } else {
            if (VIPINt == 0) {
                CGFloat bgX = CGRectGetMaxX(_headImage.frame)+5;
                _backBtn.frame = CGRectMake(bgX, bgY, width, height);
                [_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                bgImage = [UIImage resizableImageWithName:nil];
                bgHighImage = [UIImage resizableImageWithName:nil];
                
                UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
                //  毛玻璃view 视图
                self.effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
                //添加到要有毛玻璃特效的控件中
                _effectView.frame = CGRectMake(0, 0, 100, 150);
                [_ipickImage addSubview:_effectView];
                //设置模糊透明度
                _effectView.alpha = 0.99;
                
            }else {
                CGFloat bgX = CGRectGetMaxX(_headImage.frame)+5;
                _backBtn.frame = CGRectMake(bgX, bgY, width, height);
                [_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                bgImage = [UIImage resizableImageWithName:nil];
                bgHighImage = [UIImage resizableImageWithName:nil];
            }
            
            
            
            
        }
        _deleViwq.frame = CGRectMake(_backBtn.frame.origin.x + _backBtn.frame.size.width/2-23, _backBtn.frame.origin.y-26, 40, 24);
        _deleBbbtn.frame = CGRectMake(_deleViwq.frame.origin.x, _deleViwq.frame.origin.y, 39.5, 24);
        UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longpress:)];
        
        //设置手指数
        lpgr.numberOfTouchesRequired = 1;
        //长按最小时间
        //>= 2秒都会触发
        lpgr.minimumPressDuration = 1;
        
        //2.添加到self.iconView
        [self.ipickImage addGestureRecognizer:lpgr];
       
        [_backBtn setBackgroundImage:bgImage forState:UIControlStateNormal];
        [_backBtn setBackgroundImage:bgHighImage forState:UIControlStateHighlighted];
    }
}
- (void)shanchule{
    _deleViwq.hidden = YES;
    _deleBbbtn.hidden = YES;
}
- (void)longpress:(UILongPressGestureRecognizer *)lpgr
{
   _deleViwq.hidden = NO;
    _deleBbbtn.hidden = NO;
}


//8
- (void)browerImagemeees:(UITapGestureRecognizer *)gest{
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *VIPSt = [defatults objectForKey:user_rankVIP];
    int VIPINt = [VIPSt intValue];
    if (VIPINt == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"你现在还不是VIP，不能查看，是否充值！" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *seqing = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"去充值" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"chongzhiVIP" object:nil];

        }];
        [alert addAction:seqing];
        [alert addAction:quxiao];
        
        [_superVC presentViewController:alert animated:YES completion:nil];

        
    }else {
        self.deleViwq.hidden = YES;
        _deleBbbtn.hidden = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Messagesuccessdianji" object:nil];
        UIImageView * tapView = (UIImageView *)gest.view;
        NSArray * array = [[NSArray alloc] initWithObjects:tapView, nil];
        XHImageViewer * brower  = [[XHImageViewer alloc]init];
        [brower showWithImageViews:array selectedView:tapView];
    }
}



+ (instancetype)cellWithImageTableView:(UITableView *)tableView{
    static NSString *identifier = @"MessImageTableViewCell";
    MessImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MessImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
+ (CGFloat)heightOfImageCellWithMessage:(NSString *)images imagData:(NSString *)imagedatas nstime:(NSString *)timess{
    CGFloat height = 20;
    if (timess && ![timess isEqualToString:@""]) {
        
        height += 15;
    }
       if ((images&&![images isEqualToString:@""]) || (imagedatas && ! [imagedatas isEqualToString:@""])) {
        
        height += 180;
        
    }
    return height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  MessVoideTableViewCell.m
//  SunShine
//
//  Created by 阳光互联 on 16/8/31.
//  Copyright © 2016年 阳光互联. All rights reserved.
//

#import "MessVoideTableViewCell.h"
#import "MessageSSModel.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Extension.h"

#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>


@interface MessVoideTableViewCell ()
@property(nonatomic,copy) NSString * myHeadimage;
@property(nonatomic,copy) NSString * frindImage;
@property (strong, nonatomic) AVAudioPlayer *avPlay;//播放录制语音
@property(nonatomic,copy)NSString * recordFileName;//网址语音
@property(nonatomic,copy)NSString * yuyinLeng;//语音时长
@property(nonatomic,strong)NSMutableArray * meImageArray;
@property(nonatomic,strong)NSMutableArray * youImageArray;

@end
@implementation MessVoideTableViewCell

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
    self.yuyinLeng = @"0";
    
    _meImageArray = [[NSMutableArray alloc] init];
    for (int i=1; i<4; i++) {
        UIImage *mesYuImageArray = [UIImage imageNamed:[NSString stringWithFormat:@"wifiMeIcon%d",i]];
        [_meImageArray addObject:mesYuImageArray];
    }
    _youImageArray = [[NSMutableArray alloc] init];
    for (int i=1; i<4; i++) {
        UIImage *mesYuImageArray = [UIImage imageNamed:[NSString stringWithFormat:@"wifiYouIIcon%d",i]];
        [_youImageArray addObject:mesYuImageArray];
    }
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
    _backBtn.layer.cornerRadius = 5;
    _backBtn.layer.masksToBounds = YES;
    [self.contentView addSubview:_backBtn];
    
    
    _timwsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _timwsLabel.textColor = [UIColor grayColor];
    _timwsLabel.font = [UIFont systemFontOfSize:14];
    
    _timwsLabel.backgroundColor = [UIColor clearColor];
    _timwsLabel.text = @"";
    [self.contentView addSubview:_timwsLabel];
    
    
    _mesYuImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _mesYuImage.userInteractionEnabled = YES;
    [_backBtn addSubview:_mesYuImage];
    
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
    [self setMessageFrame];//设置内容
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setFaceFrame{//设置头像
    

    CGFloat width = 40;
    CGFloat height = 40;
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    NSString *uidS = [defatults objectForKey:uidSG];
    if ([_messFriendModel.fromuid isEqualToString:uidS]) {//如果是自己发送
        _headImage.frame = CGRectMake(kScreen_w-width-5.0, CGRectGetMaxY(_timeLabel.frame)+10, width, height);
    } else {
        _headImage.frame = CGRectMake(5.0, CGRectGetMaxY(_timeLabel.frame)+10, width, height);
    }
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
    
     if((_messFriendModel.content&&![_messFriendModel.content isEqualToString:@""]) || (_messFriendModel.content && ! [_messFriendModel.content isEqualToString:@""]))  {
         if ([_messFriendModel.voice_time isEqualToString:@""] || [_messFriendModel.voice_time isEqual:[NSNull null]] || _messFriendModel.voice_time == nil) {
             
             _timwsLabel.text = @"";
         }else{
//             _timwsLabel.text = [NSString stringWithFormat:@"%@''",_messFriendModel.voice_time];
//             self.yuyinLeng = _messFriendModel.voice_time;
         }
         
         if ([_messFriendModel.fromuid isEqualToString:uidS]) { //如果是自己发送的
             _mesYuImage.frame = CGRectMake(35, 15, 15, 23);
             _mesYuImage.image = [UIImage imageNamed:@"wifiMeIcon3"];
             _mesYuImage.animationImages = _meImageArray;
             
         } else {
             _mesYuImage.frame = CGRectMake(25, 15, 15, 23);
             _mesYuImage.image = [UIImage imageNamed:@"wifiYouIIcon3"];
             _mesYuImage.animationImages = _youImageArray;

         }
         
         _mesYuImage.animationDuration = 1;
         //动画重复次数 （0为重复播放）
         _mesYuImage.animationRepeatCount = 0;
         [_mesYuImage stopAnimating];
         UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bofangg:)];
         [_mesYuImage addGestureRecognizer:tap];
        // 2、计算背景图片的frame，X坐标发送和接收计算方式不一样
        CGFloat bgY = CGRectGetMinY(_headImage.frame);
        CGFloat width = _mesYuImage.frame.size.width + kEdgeInsetsWidth*3;
        CGFloat height = _mesYuImage.frame.size.height + 30;
        UIImage *bgImage; //声明一个背景图片对象
        UIImage *bgHighImage;
        // 3、判断是否为自己发送，来设置frame以及背景图片
        if ([_messFriendModel.fromuid isEqualToString:uidS]) { //如果是自己发送的
            CGFloat bgX = kScreen_w-kPaddingL*2-CGRectGetWidth(_headImage.frame)-width-5;
            _backBtn.frame = CGRectMake(bgX,bgY, width, height);
            [_backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            bgImage = [UIImage resizableImageWithName:@"dialog_box_pink"];
            bgHighImage = [UIImage resizableImageWithName:@"dialog_box_pink"];
            _timwsLabel.textAlignment = NSTextAlignmentRight;
            _timwsLabel.frame = CGRectMake(bgX-30, bgY, 28, height);
        } else {
            CGFloat bgX = CGRectGetMaxX(_headImage.frame)+10;
            _backBtn.frame = CGRectMake(bgX, bgY, width, height);
            [_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            bgImage = [UIImage resizableImageWithName:@"dialog_box_white"];
            bgHighImage = [UIImage resizableImageWithName:@"dialog_box_white"];
            _timwsLabel.textAlignment = NSTextAlignmentLeft;
            _timwsLabel.frame = CGRectMake(CGRectGetMaxX(_backBtn.frame)+2, bgY, 30, height);

        }
         _deleViwq.frame = CGRectMake(_backBtn.frame.origin.x + _backBtn.frame.size.width/2-23, _backBtn.frame.origin.y-26, 40, 24);
         _deleBbbtn.frame = CGRectMake(_deleViwq.frame.origin.x, _deleViwq.frame.origin.y, 39.5, 24);
         UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(delefuzhiyuyin:)];
         
         //设置手指数
         lpgr.numberOfTouchesRequired = 1;
         //长按最小时间
         //>= 2秒都会触发
         lpgr.minimumPressDuration = 1;
         
         //2.添加到self.iconView
         [self.backBtn addGestureRecognizer:lpgr];
        [_backBtn setBackgroundImage:bgImage forState:UIControlStateNormal];
        [_backBtn setBackgroundImage:bgHighImage forState:UIControlStateHighlighted];
    }
}

- (void)shanchule{
    _deleViwq.hidden = YES;
    _deleBbbtn.hidden = YES;
}
- (void)delefuzhiyuyin:(UILongPressGestureRecognizer *)lpgr{
    _deleViwq.hidden = NO;
    _deleBbbtn.hidden = NO;
}


- (void)bofangg:(UIButton *)btn{
     self.deleViwq.hidden = YES;
    _deleBbbtn.hidden = YES;
    if (self.avPlay.playing) {
        [self.avPlay stop];
        [_mesYuImage stopAnimating];
        return;
    }
    [_mesYuImage startAnimating];
    if (_messFriendModel.content == nil) {
        
        
    }else{
    
//        NSData * yuyind = [[NSData alloc] initWithBase64EncodedString:_messFriendModel.content options:NSDataBase64DecodingIgnoreUnknownCharacters];
        NSData *yuyind = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:_messFriendModel.content]];
        AVAudioPlayer * player = [[AVAudioPlayer alloc] initWithData:yuyind error:nil];
        //播放时长

//        NSLog(@"%f",player.duration);
        
//        player.duration
        self.avPlay = player;
        [self.avPlay play];
    }
    NSInteger timm = 6;
   [self performSelector:@selector(gotimeees) withObject:nil afterDelay:timm];
    
}
- (void)gotimeees{
   [_mesYuImage stopAnimating];
    
}

+ (instancetype)cellWithVoideTableView:(UITableView *)tableView{
    static NSString *identifier = @"MessVoideTableViewCell";
    MessVoideTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MessVoideTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
+ (CGFloat)heightOfVoideCellWithMessage:(NSString *)voide yuyin:(NSString *)yuYindata nstime:(NSString *)timess{
    CGFloat height = 20;
    if (timess && ![timess isEqualToString:@""]) {
        
        height += 15;
    }
     if ((voide &&![voide isEqualToString:@""]) || (yuYindata &&![yuYindata isEqualToString:@""])) {
        
        height += 60;
    }
    return height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

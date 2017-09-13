//
//  MessTxtContentTableViewCell.m
//  SunShine
//
//  Created by 阳光互联 on 16/8/31.
//  Copyright © 2016年 阳光互联. All rights reserved.
//

#import "MessTxtContentTableViewCell.h"
#import "UIImage+Extension.h"

#import "MessageSSModel.h"
//#import "UIImage+Extension.h"
#import "Utility.h"
//#import "MessFriendManager.h"

@interface MessTxtContentTableViewCell ()
@property(nonatomic,copy) NSString * myHeadimage;
@property(nonatomic,copy) NSString * frindImage;
@end

@implementation MessTxtContentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubViews];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Messagesuccesyincang:) name:@"Messagesuccesyincang" object:nil];
        UITapGestureRecognizer * tapmess = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browerImagehid:)];
        [self addGestureRecognizer:tapmess];
        self.backgroundColor= [UIColor redColor];

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
    _headImage.layer.cornerRadius = 25;
    _headImage.layer.masksToBounds = YES;
    _headImage.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_headImage];
    
   
    //初始化正文视图
    _backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    _backBtn.layer.cornerRadius = 5;
    _backBtn.layer.masksToBounds = YES;
    [self.contentView addSubview:_backBtn];
    
    //初始化正文视图
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _contentLabel.font = [UIFont systemFontOfSize:16];
    _contentLabel.numberOfLines = 0;
    _contentLabel.userInteractionEnabled = NO;
    [_backBtn addSubview:_contentLabel];
    
    
    _deleViwq = [[UIView  alloc] initWithFrame:CGRectZero];
    _deleViwq.hidden = YES;
    _deleViwq.layer.cornerRadius = 5;
    _deleViwq.layer.masksToBounds = YES;
    _deleViwq.backgroundColor = [UIColor blackColor];
    _deleViwq.alpha = 0.8;
    [self.contentView addSubview:_deleViwq];
    
   _xianlabek = [[UILabel alloc] initWithFrame:CGRectZero];
    _xianlabek.backgroundColor = [UIColor whiteColor];
    [self.deleViwq addSubview:_xianlabek];
    
    _deleBbbtn = [[UIButton  alloc] initWithFrame:CGRectZero];
    _deleBbbtn.hidden = YES;
    [_deleBbbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_deleBbbtn setTitle:@"删除" forState:UIControlStateNormal];
    _deleBbbtn.titleLabel.font = [UIFont systemFontOfSize:12];
     [_deleBbbtn addTarget:self action:@selector(shanchule) forControlEvents:UIControlEventTouchUpInside];
    _deleBbbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.contentView addSubview:_deleBbbtn];
    
    _fuzhiBnttn = [[UIButton alloc] initWithFrame:CGRectZero];
    [_fuzhiBnttn setTitle:@"复制" forState:UIControlStateNormal];
    _fuzhiBnttn.titleLabel.font = [UIFont systemFontOfSize:12];
    _fuzhiBnttn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_fuzhiBnttn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_fuzhiBnttn addTarget:self action:@selector(fuzhile) forControlEvents:UIControlEventTouchUpInside];
    [self.deleViwq addSubview:_fuzhiBnttn];
    
   
}

- (void)setMessFriendModel:(MessageSSModel *)messFriendModel{
    _messFriendModel = messFriendModel;
    [self setFaceFrame];//设置头像
    [self setMessageFrame]; //设置内容
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
- (void)setFaceFrame{//设置头像
    
    
//    if (![_messFriendModel.create_at isEqual:[NSNull null]] && _messFriendModel.create_at&&![_messFriendModel.create_at isEqualToString:@""]) {
//        
//        _timeLabel.frame = CGRectMake(50, 10, kScreen_w-100, 15);
//        NSArray *fristArray = [_messFriendModel.create_at componentsSeparatedByString:@":"];
//        NSString * nianString = fristArray[0];
//        NSArray * nianArray = [nianString componentsSeparatedByString:@"-"];
//        NSString * textTime = [NSString stringWithFormat:@"%@-%@:%@",nianArray[1],nianArray[2],fristArray[1]];
//        _timeLabel.text = textTime;
//        
//    }else{
//        _timeLabel.frame = CGRectMake(50, 10, kScreen_w-100, 0);
//       _timeLabel.text = @"";
//    }
    CGFloat width = 50;
    CGFloat height = 50;
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
    self.contentView.backgroundColor = ViewRGB;
    // 1、计算文字的宽高
    float textMaxWidth = kScreen_w-40- 5.0 *2-70; //60是消息框体距离右侧或者左侧的距离
    if (_messFriendModel.content&&![_messFriendModel.content isEqualToString:@""]) {
        NSMutableAttributedString *attrStr = [Utility emotionStrWithString:_messFriendModel.content];
        //    NSMutableAttributedString *attrStr = [Utility emotionStrWithString:_message.content plistName:@"emoticons.plist" y:-8];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kContentFontSize] range:NSMakeRange(0, attrStr.length)];
        CGSize textSize = [attrStr boundingRectWithSize:CGSizeMake(textMaxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        _contentLabel.attributedText = attrStr;
        
        _contentLabel.frame = CGRectMake(kEdgeInsetsWidth, kEdgeInsetsWidth, textSize.width, textSize.height);
        
        // 2、计算背景图片的frame，X坐标发送和接收计算方式不一样
        CGFloat bgY = CGRectGetMinY(_headImage.frame);
        CGFloat width = textSize.width + kEdgeInsetsWidth*2;
        CGFloat height = textSize.height + kEdgeInsetsWidth*2;
        UIImage *bgImage; //声明一个背景图片对象
        UIImage *bgHighImage;
        // 3、判断是否为自己发送，来设置frame以及背景图片
        if ([_messFriendModel.fromuid isEqualToString:uidS]) { //如果是自己发送的
            CGFloat bgX = kScreen_w-kPaddingL*2-CGRectGetWidth(_headImage.frame)-width-5;
            _backBtn.frame = CGRectMake(bgX,bgY, width, height);
            [_backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            bgImage = [UIImage resizableImageWithName:@"dialog_box_pink"];
            bgHighImage = [UIImage resizableImageWithName:@"dialog_box_pink"];
        } else {
            CGFloat bgX = CGRectGetMaxX(_headImage.frame)+10;
            _backBtn.frame = CGRectMake(bgX, bgY, width, height);
            [_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            bgImage = [UIImage resizableImageWithName:@"dialog_box_white"];
            bgHighImage = [UIImage resizableImageWithName:@"dialog_box_white"];
        }
        _deleViwq.frame = CGRectMake(_backBtn.frame.origin.x + _backBtn.frame.size.width/2-43, _backBtn.frame.origin.y-26, 80, 24);
        _xianlabek.frame = CGRectMake(39.5, 2, 1, 20);
        _deleBbbtn.frame = CGRectMake(_deleViwq.frame.origin.x, _deleViwq.frame.origin.y, 39.5, 24);
        _fuzhiBnttn.frame = CGRectMake(41.5, 0, 39.5, 24);
        UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(delefuzhitextcon:)];
        
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
- (void)delefuzhitextcon:(UILongPressGestureRecognizer *)lpgr
{
    _deleViwq.hidden = NO;
    _deleBbbtn.hidden = NO;
}
- (void)fuzhile{
    _deleViwq.hidden = YES;
    _deleBbbtn.hidden = YES;
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    NSString *string = [NSString stringWithFormat:@"%@",_messFriendModel.content];
    
    [pab setString:string];
    
    if (pab == nil) {
        
        
    }else{
        
    }
}
+ (instancetype)cellWithTxtTableView:(UITableView *)tableView{
    static NSString *identifier = @"MessTxtContentTableViewCell";
    MessTxtContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MessTxtContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
+ (CGFloat)heightOfTxtCellWithMessage:(NSString *)textContent nstime:(NSString *)timess{
    CGFloat height = 30;
    if (timess && ![timess isEqualToString:@""]) {
        
        height += 15;
    }
    
    float textMaxWidth = kScreen_w-40-kPaddingL *2-60; //60是消息框体距离右侧或者左侧的距离
    if (textContent&&![textContent isEqualToString:@""]) {
        NSMutableAttributedString *attrStr = [Utility emotionStrWithString:textContent
                                              ];
        //    NSMutableAttributedString *attrStr = [Utility emotionStrWithString:message.content plistName:@"emoticons.plist" y:-8];
       
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kContentFontSize] range:NSMakeRange(0, attrStr.length)];
    CGSize textSize = [attrStr boundingRectWithSize:CGSizeMake(textMaxWidth,CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    height += (textSize.height+kEdgeInsetsWidth*2);
        
        if (height < 60) {
            height = 60;
        }
    }
    return height;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

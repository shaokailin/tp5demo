//
//  MyPaiViewController.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/5/12.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "MyPaiViewController.h"
#import "ArtMicroVideoViewController.h"
#import "TZImagePickerController.h"
#import "TZLocationManager.h"

#define kCellIdentifier @"picCell"
#import "YBChoosePicCell.h"
#import "LxGridViewFlowLayout.h"
#import "TZTestCell.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "TZImageManager.h"
#import "FootderView.h"
static NSString *headerIden = @"header";
static NSString *footerIden = @"footer";
@interface MyPaiViewController ()<UITextViewDelegate,UINavigationControllerDelegate,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
{
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;
    
    CGFloat _itemWH;
    CGFloat _margin;
    int flag;
}
@property (strong, nonatomic) CLLocation *location;

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITextField *columnNumberTF;
@property (weak, nonatomic) IBOutlet UISwitch *allowCropSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *needCircleCropSwitch;
@property (nonatomic, strong)UITextView *textView;
@property (nonatomic, strong)UILabel *ziLabel;
@property (nonatomic, strong)UIButton *imView;
//
@property (nonatomic, copy)NSString *shiString;
@property (nonatomic, strong)UIImage *imaG;

//返回的地址 URL
@property (nonatomic, copy)NSString *imaURL;
@property (nonatomic, copy)NSString *videoURL;
@property (nonatomic, assign)NSInteger hhh;

@property(nonatomic,copy)NSString * image_type;
@property(nonatomic,copy)NSString * imageFileName;
//选着的图片
@property(nonatomic, strong)UIImageView *tuiamgView;

@property (nonatomic, strong) NSMutableArray *selectPhotos;
@property (nonatomic, strong) NSMutableArray *selectAssets;
@property (nonatomic, strong) NSMutableArray *imagePathArr;
@property (nonatomic, strong) UIView *tiView;
@property (nonatomic, strong) UITextView *textViewLi;
@property (nonatomic, strong) FootderView *baView;
@property (nonatomic, strong) UIButton *queButton;
@property (nonatomic, strong) UIBarButtonItem *rightItem11;
@property (nonatomic, strong) NSMutableArray *imDataArray;

@end

@implementation MyPaiViewController
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}
- (NSMutableArray *)imDataArray{
    if (!_imDataArray) {
        _imDataArray = [[NSMutableArray alloc]init];
    }
    return _imDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ViewRGB;
    self.navigationItem.title = @"我的照片";
    [self addHAddView];

    
    UIImage *leimage = [UIImage imageNamed:@"形状16"];
    UIImage *Leimage = [leimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:Leimage style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarLeftitemAction:)];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    [self addView];
    
}
- (void)addHAddView{
    
    //获取页眉 --- 重用
    self.tiView = [[UIView alloc]init];
    self.tiView.backgroundColor = [UIColor whiteColor];
    self.tiView.frame = CGRectMake(0, 64, kScreen_w, 100);
    [self.view addSubview:_tiView];
    
    
    self.textViewLi = [[UITextView alloc]init];
    _textViewLi.frame = CGRectMake(12, 12, kScreen_w - 24, 80);
    self.textViewLi.font = [UIFont systemFontOfSize:14.0];
    self.textViewLi.scrollEnabled = NO;

    
    self.textViewLi.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tiView.tag = 1001;
    
    self.textViewLi.delegate = self;
    [self.tiView addSubview:_textViewLi];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.ziLabel = [[UILabel alloc]init];
    _ziLabel.frame = CGRectMake(0, 10, kScreen_w - 24, 20);
    _ziLabel.text = @"这一刻的想法.....";
    //        _ziLabel.enabled = NO;
    _ziLabel.textColor = [UIColor blackColor];
    _ziLabel.font = [UIFont systemFontOfSize:15.0];
    _ziLabel.alpha = 0.6;
    //    _ziLabel.backgroundColor = [UIColor redColor];
    [self.textViewLi addSubview:_ziLabel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (doneButtonshow:) name: UIKeyboardDidShowNotification object:nil];
    
}


//- (BOOL)prefersStatusBarHidden {
//    return NO;
//}
#pragma mark - 用户交互
- (void)handleNavigationBarLeftitemAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//布局
- (void)addView{
    // 如不需要长按排序效果，将LxGridViewFlowLayout类改成UICollectionViewFlowLayout即可
    LxGridViewFlowLayout *layout = [[LxGridViewFlowLayout alloc] init];
    _margin = 4;
    _itemWH = (kScreen_w - 2 * _margin - 4) / 3 - _margin;
    layout.itemSize = CGSizeMake(kScreen_w / 3  - 5, kScreen_w / 3 - 5);
    layout.minimumInteritemSpacing = _margin;
    layout.minimumLineSpacing = _margin;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,170, kScreen_w, kScreen_h) collectionViewLayout:layout];
    //设置页眉大小
    //    layout.headerReferenceSize = CGSizeMake(kScreen_w, 100);
    //设置页脚
    layout.footerReferenceSize = CGSizeMake(kScreen_w, 200);
    CGFloat rgb = 244.0 / 255.0;
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1.0];
    _collectionView.contentInset = UIEdgeInsetsMake(2, 2, 2, 2);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
    //    _collectionView.viewForFirstBaselineLayout = self.tiView;
    //注册页眉(headerIden)
    //    [_collectionView registerClass:[HeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIden];
    
    
    //注册页脚(footIden)
    [_collectionView registerClass:[FootderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerIden];
    
    
}



#pragma mark UICollectionView

//设置分区页眉页脚 --- 页眉页脚采用重用机制
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        return nil;
    }else {
        //获取页脚 -- 重用
        self.baView  = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerIden forIndexPath:indexPath];
        UILabel *tiLabel = [[UILabel alloc]init];
        tiLabel.frame = CGRectMake(12, 5, kScreen_w - 24, 20);
        tiLabel.text = @"特别提醒";
        tiLabel.textColor = [UIColor redColor];
        tiLabel.font = [UIFont systemFontOfSize:15];
        tiLabel.alpha = 0.6;
        _baView.userInteractionEnabled = YES;
        
        [_baView addSubview:tiLabel];
        
        NSString *wenString = @"照片大小不大于2M\n每天上传一张公开照可得5金币\n禁止上传淫秽色情及非自拍图片，一经发现将扣除收益直至封停账号!";
        CGFloat collectionView_h = [HelperClass calculationHeightWithTextsize:15.0 LabelWidth:kScreen_w - 80 WithText:wenString LineSpacing:0];
        
        UILabel *neiLabel = [[UILabel alloc]init];
        neiLabel.frame = CGRectMake(12, 25, kScreen_w - 24, collectionView_h);
        neiLabel.text = wenString;
        neiLabel.numberOfLines = 0;
        neiLabel.font = [UIFont systemFontOfSize:15.0];
        neiLabel.alpha = 0.6;
        [_baView addSubview:neiLabel];
        
        self.queButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _queButton.frame = CGRectMake(20, collectionView_h + 45, kScreen_w - 40, 40);
        [_queButton addTarget:self action:@selector(addQuebuttonLL) forControlEvents:UIControlEventTouchUpInside];
        [_queButton setTitle:@"确定发布" forState:UIControlStateNormal];
        _queButton.layer.cornerRadius = 20;
        _queButton.layer.masksToBounds = YES;
        _queButton.backgroundColor = hong;
        [_queButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //        _queButton.userInteractionEnabled = YES;
        flag = 0;
        [_baView addSubview:_queButton];
        
        
        //返回
        return self.baView;
        
    }
    
}
-(void)doneButtonshow: (NSNotification *)notification {
    
    self.rightItem11 = [[UIBarButtonItem alloc]initWithTitle:@"完成编辑" style:UIBarButtonItemStylePlain target:self action:@selector(handleNavigationBarRinghtAction)];
    _rightItem11.tintColor = [UIColor colorWithRed:247.0/255.0 green:48.0/255.0 blue:103.0/255.0 alpha:1];
    self.navigationItem.rightBarButtonItem = _rightItem11;
    
}
-(void)handleNavigationBarRinghtAction{
    [self.view endEditing:YES];
    self.rightItem11 = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItem = _rightItem11;
    
    [_textView resignFirstResponder];
    
}
//确定上传
- (void)addQuebuttonLL {
    NSString *wenString = self.textViewLi.text;
    if (self.textViewLi.text == nil || [wenString isEqualToString:@""]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"标题不能为空" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }];
        
        
        [alert addAction:otherAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }else {
        
        
        
        NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_upload];
        [SVProgressHUD showWithStatus:@"图片上传中..."];
        
        
        AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
        manage.requestSerializer = [AFHTTPRequestSerializer serializer];
        manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
        
        //    NSDictionary *dic = @{@"uid":@"21444"};
        [manage POST:URL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            
            NSData *data = UIImageJPEGRepresentation(_selectedPhotos[flag], 0.5);
            NSString *imageName = [NSString stringWithFormat:@"image%02d.jpg", flag + 1];
            [formData appendPartWithFileData:data name:@"img" fileName:imageName mimeType:@"image/jpeg"];
            
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = responseObject;
            NSString *code = dic[@"code"];
            int incode = [code intValue];
            if (incode == 1) {
                [self.imDataArray addObject:dic[@"data"][@"img"][@"url"] ];
                NSLog(@"ajsguiusgu ==== %lu",_selectedPhotos.count);
                if (flag < _selectedPhotos.count - 1) {
                    flag ++;
                    [self addQuebuttonLL];
                    
                    
                }else {
                    [self upData];
                }
                
            }
            
            [SVProgressHUD dismissWithDelay:1.0];
            
            
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showErrorWithStatus:@"加载失败"];
            [SVProgressHUD dismissWithDelay:1.0];
            
            
            
        }];
    }
    
    
    
    
}
//提交照片
- (void)upData{
    NSString *URL = [NSString stringWithFormat:@"%@%@",AppURL,API_My_UpPhoto];
    NSUserDefaults *defatults = [NSUserDefaults standardUserDefaults];
    
    NSString *uidS = [defatults objectForKey:uidSG];
    NSString *imString = self.imDataArray[0];
    for (int i = 1; i < _imDataArray.count; i++) {
        NSString *String = _imDataArray[i];
        imString = [NSString stringWithFormat:@"%@,%@",imString,String];
        
    }
    
    //    for (NSString *String in self.imDataArray) {
    //    }
    NSString *teString = self.textViewLi.text;
    
    NSDictionary *dci = @{@"uid":uidS,@"title":teString,@"image":imString,@"thimage":imString,@"uptype":self.uptype};
    [HttpUtils postRequestWithURL:URL withParameters:dci withResult:^(id result) {
        [SVProgressHUD showSuccessWithStatus:result[@"msg"]];
        [SVProgressHUD dismissWithDelay:1.0];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addImgView" object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"adddengluShuaxin11" object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addsimizhaoXIUXIU" object:nil];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } withError:^(NSString *msg, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        [SVProgressHUD dismissWithDelay:1.0];
    }];
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _selectedPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
    if (indexPath.row == _selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:@"icon_add_pic_"];
        
        cell.deleteBtn.hidden = YES;
        cell.gifLable.hidden = YES;
    } else {
        cell.imageView.image = _selectedPhotos[indexPath.row];
        cell.asset = _selectedAssets[indexPath.row];
        cell.deleteBtn.hidden = NO;
    }
    
    cell.gifLable.hidden = YES;
    
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _selectedPhotos.count) {
        BOOL showSheet = YES;
        if (showSheet) {
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"去相册选择", nil];
            [sheet showInView:self.view];
        } else {
            [self pushImagePickerController];
        }
    } else { // preview photos or video / 预览照片或者视频
        id asset = _selectedAssets[indexPath.row];
        BOOL isVideo = NO;
        if ([asset isKindOfClass:[PHAsset class]]) {
            PHAsset *phAsset = asset;
            isVideo = phAsset.mediaType == PHAssetMediaTypeVideo;
        } else if ([asset isKindOfClass:[ALAsset class]]) {
            ALAsset *alAsset = asset;
            isVideo = [[alAsset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo];
        }
        
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_selectedAssets selectedPhotos:_selectedPhotos index:indexPath.row];
        imagePickerVc.maxImagesCount = 9;
        imagePickerVc.allowPickingOriginalPhoto = YES;
        imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            _selectedPhotos = [NSMutableArray arrayWithArray:photos];
            _selectedAssets = [NSMutableArray arrayWithArray:assets];
            _isSelectOriginalPhoto = isSelectOriginalPhoto;
            [_collectionView reloadData];
            _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
            
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
        
    }
}

#pragma mark - LxGridViewDataSource

/// 以下三个方法为长按排序相关代码
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.item < _selectedPhotos.count;
}

- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath canMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    return (sourceIndexPath.item < _selectedPhotos.count && destinationIndexPath.item < _selectedPhotos.count);
}

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath didMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    UIImage *image = _selectedPhotos[sourceIndexPath.item];
    [_selectedPhotos removeObjectAtIndex:sourceIndexPath.item];
    [_selectedPhotos insertObject:image atIndex:destinationIndexPath.item];
    
    id asset = _selectedAssets[sourceIndexPath.item];
    [_selectedAssets removeObjectAtIndex:sourceIndexPath.item];
    [_selectedAssets insertObject:asset atIndex:destinationIndexPath.item];
    
    [_collectionView reloadData];
}

#pragma mark - TZImagePickerController

- (void)pushImagePickerController {
    if (9 <= 0) {
        return;
    }
    //相册里面显示每行的张数
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 columnNumber:3 delegate:self pushPhotoPickerVc:YES];
    
    
#pragma mark - 四类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    
    if (9 > 1) {
        // 1.设置目前已经选中的图片数组
        imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    }
    imagePickerVc.allowTakePicture = NO; // 在内部显示拍照按钮
    
    
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.allowPickingGif = NO;
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = NO;
    
    /// 5. Single selection mode, valid when maxImagesCount = 1
    /// 5. 单选模式,maxImagesCount为1时才生效
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = self.allowCropSwitch.isOn;
    imagePickerVc.needCircleCrop = self.needCircleCropSwitch.isOn;
    imagePickerVc.circleCropRadius = 100;
    
#pragma mark - 到这里为止
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - UIImagePickerController

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        // 无相机权限 做一个友好的提示
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
        // 拍照之前还需要检查相册权限
    } else if ([TZImageManager authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        alert.tag = 1;
        [alert show];
    } else if ([TZImageManager authorizationStatus] == 0) { // 正在弹框询问用户是否允许访问相册，监听权限状态
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            return [self takePhoto];
        });
    } else { // 调用相机
        // 提前定位
        [[TZLocationManager manager] startLocationWithSuccessBlock:^(CLLocation *location, CLLocation *oldLocation) {
            _location = location;
        } failureBlock:^(NSError *error) {
            _location = nil;
        }];
        
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            self.imagePickerVc.sourceType = sourceType;
            if(iOS8Later) {
                _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            }
            [self presentViewController:_imagePickerVc animated:YES completion:nil];
        } else {
            NSLog(@"模拟器中无法打开照相机,请在真机中使用");
        }
    }
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        tzImagePickerVc.sortAscendingByModificationDate = NO;
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image location:self.location completion:^(NSError *error){
            if (error) {
                [tzImagePickerVc hideProgressHUD];
                NSLog(@"图片保存失败 %@",error);
            } else {
                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES completion:^(TZAlbumModel *model) {
                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                        [tzImagePickerVc hideProgressHUD];
                        TZAssetModel *assetModel = [models firstObject];
                        if (tzImagePickerVc.sortAscendingByModificationDate) {
                            assetModel = [models lastObject];
                        }
                        if (self.allowCropSwitch.isOn) { // 允许裁剪,去裁剪
                            TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initCropTypeWithAsset:assetModel.asset photo:image completion:^(UIImage *cropImage, id asset) {
                                [self refreshCollectionViewWithAddedAsset:asset image:cropImage];
                            }];
                            imagePicker.needCircleCrop = self.needCircleCropSwitch.isOn;
                            imagePicker.circleCropRadius = 100;
                            [self presentViewController:imagePicker animated:YES completion:nil];
                        } else {
                            [self refreshCollectionViewWithAddedAsset:assetModel.asset image:image];
                        }
                    }];
                }];
            }
        }];
    }}

- (void)refreshCollectionViewWithAddedAsset:(id)asset image:(UIImage *)image {
    [_selectedAssets addObject:asset];
    [_selectedPhotos addObject:image];
    
    [_collectionView reloadData];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) { // take photo / 去拍照
        [self takePhoto];
    } else if (buttonIndex == 1) {
        [self pushImagePickerController];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) { // 去设置界面，开启相机访问权限
        if (iOS8Later) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        } else {
            NSURL *privacyUrl;
            if (alertView.tag == 1) {
                privacyUrl = [NSURL URLWithString:@"prefs:root=Privacy&path=PHOTOS"];
            } else {
                privacyUrl = [NSURL URLWithString:@"prefs:root=Privacy&path=CAMERA"];
            }
            if ([[UIApplication sharedApplication] canOpenURL:privacyUrl]) {
                [[UIApplication sharedApplication] openURL:privacyUrl];
            } else {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"抱歉" message:@"无法跳转到隐私设置页面，请手动前往设置页面，谢谢" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
        }
    }
}

#pragma mark - UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView  {
    
    if (textView.text.length == 0) {
        _ziLabel.alpha = 1;
        _ziLabel.text = @"这一刻的想法.....";
    }else {
        _ziLabel.alpha = 0;
        //        _ziLabel.text = @"";
    }
    
    if (textView.text.length > 150) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"字数不能超过150个字符！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![_textView isExclusiveTouch]) {
        [_textView resignFirstResponder];
    }
}

//点击屏幕空白处
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //回收键盘，两者方式
    UITextView *textView = (UITextView*)[self.view viewWithTag:1001];
    [textView resignFirstResponder];
    
    [self.view endEditing:YES];
}

#pragma mark - TZImagePickerControllerDelegate

/// User click cancel button
/// 用户点击了取消
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    // NSLog(@"cancel");
}


- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    _collectionView.frame = CGRectMake(0, 170, kScreen_w, kScreen_h - 170);
    [_collectionView reloadData];
    //     _collectionView.contentSize = CGSizeMake(kScreen_w, kScreen_h);
    
    // 1.打印图片名字
    [self printAssetsName:assets];
}

// If user picking a video, this callback will be called.
// If system version > iOS8,asset is kind of PHAsset class, else is ALAsset class.
// 如果用户选择了一个视频，下面的handle会被执行
// 如果系统版本大于iOS8，asset是PHAsset类的对象，否则是ALAsset类的对象
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset {
    _selectedPhotos = [NSMutableArray arrayWithArray:@[coverImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    // open this code to send video / 打开这段代码发送视频
    // [[TZImageManager manager] getVideoOutputPathWithAsset:asset completion:^(NSString *outputPath) {
    // NSLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
    // Export completed, send video here, send by outputPath or NSData
    // 导出完成，在这里写上传代码，通过路径或者通过NSData上传
    
    // }];
    [_collectionView reloadData];
    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
}

// If user picking a gif image, this callback will be called.
// 如果用户选择了一个gif图片，下面的handle会被执行
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingGifImage:(UIImage *)animatedImage sourceAssets:(id)asset {
    _selectedPhotos = [NSMutableArray arrayWithArray:@[animatedImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    [_collectionView reloadData];
}

#pragma mark - Click Event

- (void)deleteBtnClik:(UIButton *)sender {
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    [_selectedAssets removeObjectAtIndex:sender.tag];
    
    [_collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [_collectionView reloadData];
    }];
}

#pragma mark - Private

/// 打印图片名字
- (void)printAssetsName:(NSArray *)assets {
    NSString *fileName;
    for (id asset in assets) {
        if ([asset isKindOfClass:[PHAsset class]]) {
            PHAsset *phAsset = (PHAsset *)asset;
            fileName = [phAsset valueForKey:@"filename"];
        } else if ([asset isKindOfClass:[ALAsset class]]) {
            ALAsset *alAsset = (ALAsset *)asset;
            fileName = alAsset.defaultRepresentation.filename;;
        }
        //NSLog(@"图片名字:%@",fileName);
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}
#pragma clang diagnostic pop
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */







@end

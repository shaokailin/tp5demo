//
//  DYFindModel.m
//  ShowXiu
//
//  Created by 上官昌璟 on 2017/4/18.
//  Copyright © 2017年 上官昌璟. All rights reserved.
//

#import "DYFindModel.h"

@implementation DYFindModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}






+ (DYFindModel *)modelWithDict:(NSDictionary *)dict {
    NSError *error = nil;
    DYFindModel *model =  [[DYFindModel alloc] initWithDictionary:dict error:&error];
    
    CGFloat content_h = [HelperClass calculationHeightWithTextsize:15.0 LabelWidth:kScreen_w - 80 WithText:model.title LineSpacing:0];
    content_h = model.title.length == 0 ? 0 : content_h;
    
    CGFloat collectionView_h = 0;
    if (model.thumbfiles.count > 1 && model.thumbfiles.count <= 3) {
        collectionView_h = (kScreen_w - 80) / 3.0;
    }else if (model.thumbfiles.count > 3 && model.thumbfiles.count <= 6) {
        collectionView_h = (kScreen_w - 80) / 3.0 * 2 + 2;
    }else if (model.thumbfiles.count > 6){
        collectionView_h = (kScreen_w - 80) / 3.0 * 3 + 2;
        
    }else if(model.thumbfiles.count == 1){
        NSDictionary *dic = model.thumbfiles[0];
        CGFloat WHH = [HelperClass getImageSizeWithURL:dic[@"thumbfiles"]].width;
        CGFloat HHH = [HelperClass getImageSizeWithURL:dic[@"thumbfiles"]].height;
        CGFloat collectionView_w = 0;
        if (WHH > (kScreen_w - 80)) {
            if (WHH / 2 > (kScreen_w - 80)) {
                if (WHH / 4 > (kScreen_w - 80)) {
                    if (WHH / 8 >  (kScreen_w - 80)) {
                        collectionView_h = 200;
                        collectionView_w = 200;
                    }else {
                        collectionView_h = HHH / 8;
                        collectionView_w = WHH / 8;
                        if (collectionView_h <0 || collectionView_h == 0) {
                            collectionView_h = WHH / 8;
                            collectionView_w = WHH / 8;
                        }
                    }
                    
                }else {
                    collectionView_h = HHH / 4;
                    collectionView_w = WHH / 4;
                    if (collectionView_h <0 || collectionView_h == 0) {
                        collectionView_h = WHH / 4;
                        collectionView_w = WHH / 4;

                    }
                }
                
            }else {
                collectionView_h = HHH / 2;
                collectionView_w = WHH / 2;

                if (collectionView_h <0 || collectionView_h == 0) {
                    collectionView_h = WHH / 2;
                    collectionView_w = WHH / 2;
                }
                
                
            }
        }else{
            collectionView_h = HHH;
            collectionView_w = WHH;
            if (collectionView_h == 0 || collectionView_h < 0) {
                collectionView_h = 200;
                collectionView_w = 200;

            }
        }
        NSString *st = [NSString stringWithFormat:@"%f",collectionView_h];
        NSString *stW = [NSString stringWithFormat:@"%f",collectionView_w];
        model.imagWW = stW;
        model.imagHH = st;
    }else {
        collectionView_h = 0;
    }
    NSString *string = [NSString stringWithFormat:@"%f",80 + content_h + collectionView_h];
    model.cellHH = string;
    
    if (model.comment.count == 0) {
        model.ViewHH = @"12";
    }else {
        if (model.comment.count > 5) {
            int HH = 12;
            for (int i = 0; i < 5; i++) {
                NSDictionary *dic = model.comment[i];
                NSString *string = [NSString stringWithFormat:@"%@:%@",dic[@"user_nicename"],dic[@"content"]];
                CGFloat content_h = [HelperClass calculationHeightWithTextsize:14.0 LabelWidth:kScreen_w - 80 WithText:string LineSpacing:0];
                
                HH = HH + content_h + 3;
            }
            NSString *string = [NSString stringWithFormat:@"%d",HH];
            model.ViewHH = string;
            
        }else {
            int HH = 12;
            for (int i = 0; i < model.comment.count; i++) {
                NSDictionary *dic = model.comment[i];
                NSString *string = [NSString stringWithFormat:@"%@:%@",dic[@"user_nicename"],dic[@"content"]];
                CGFloat content_h = [HelperClass calculationHeightWithTextsize:14.0 LabelWidth:kScreen_w - 80 WithText:string LineSpacing:0];
                
                HH = HH + content_h + 3;
            }
            NSString *string = [NSString stringWithFormat:@"%d",HH];
            model.ViewHH = string;
        }
  
    }

    return model;
}


@end

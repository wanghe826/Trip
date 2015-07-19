//
//  QiniuUploadImageApi.h
//  notice
//
//  Created by jbas on 15/2/1.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^QiniuUploadFinished)(NSMutableArray *uploadedImages);

@interface QiniuUploadImageApi : NSObject

//-(id)initWithUploadImg:(UIImage *)uploadImg withQiNiuURL:(NSString *)qiniuURL;

-(id)initWithUploadImgArray:(NSMutableArray *)uploadImgArray withQiNiuBucket:(NSString *)qiniuBucket;

-(void)upLoadImagesWithDisPlayHud:(BOOL)isHud done:(QiniuUploadFinished)done;


@end

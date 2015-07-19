//
//  ImageItem.h
//  syncdbdemo
//
//  Created by jbas on 15/3/17.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetRepresentation.h>
#import "JSONModel.h"

#define IMAGERESTYPE_HTTP 0
#define IMAGERESTYPE_ALASSET 1
#define IMAGERESTYPE_IMGNAME 2

@protocol ImageSelectItem @end

@interface ImageSelectItem : JSONModel

@property(assign,nonatomic) int restype;             //资源类型，0：网络图片，1：本地手机资源，2：app图片
@property(strong,nonatomic) NSString *imgpath;       //网络上的图片地址、本地选择的图片地址、app中的图片名称

+(instancetype)initWithHttpUrl:(NSString *)httpImgURL;
+(instancetype)initWithALAsset:(NSString *)alAssetPath;
+(instancetype)initwithImgName:(NSString *)imgname;

@end

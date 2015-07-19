//
//  ImageItem.m
//  syncdbdemo
//
//  Created by jbas on 15/3/17.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "ImageSelectItem.h"

@implementation ImageSelectItem

+(instancetype)initWithALAsset:(NSString *)alAssetPath{
    ImageSelectItem *imageSelectItem=[[ImageSelectItem alloc]init];
    imageSelectItem.restype=IMAGERESTYPE_ALASSET;
    imageSelectItem.imgpath=alAssetPath;
    return imageSelectItem;
}

+(instancetype)initWithHttpUrl:(NSString *)httpImgURL{
    ImageSelectItem *imageSelectItem=[[ImageSelectItem alloc]init];
    imageSelectItem.restype=IMAGERESTYPE_HTTP;
    imageSelectItem.imgpath=httpImgURL;
    return imageSelectItem;
}

+(instancetype)initwithImgName:(NSString *)imgname{
    ImageSelectItem *imageSelectItem=[[ImageSelectItem alloc]init];
    imageSelectItem.restype=IMAGERESTYPE_IMGNAME;
    imageSelectItem.imgpath=imgname;
    return imageSelectItem;
}
@end

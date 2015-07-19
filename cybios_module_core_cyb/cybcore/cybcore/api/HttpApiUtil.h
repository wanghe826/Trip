//
//  ApiUtil.h
//  notice
//
//  Created by jbas on 15/1/28.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"
#import "SyncItem.h"
#import "QiniuUploadImageApi.h"

@interface HttpApiUtil : NSObject

#pragma mark --异步网络请求返回数据
+(void)httpGet:(NSString*)url withDic:(NSDictionary*)dic callBack:(void (^)(id responseJSON))getCallback;

#pragma mark --异步提交POST数据
+(void)httpSync:(Entity*)entity disPlayHud:(BOOL)isHud finishedCallBack:(void (^)(id responseJSON))finishedCallBack;

#pragma mark --异步提交POST数据
+(void)httpSyncArray:(NSMutableArray *)entityArray disPlayHud:(BOOL)isHud itemStartSyncCallback:(void(^)(id item)) itemStartSyncCallback itemEndSyncCallback:(void(^)(id itemResponse))itemEndSyncCallback finishedCallBack:(void (^)(id finishedResponse))finishedCallback;


#pragma mark --提交图片
+(void)qiniuUploadImg:(NSMutableArray *)uploadImgArray withQiNiuBucket:(NSString *)qiNiuBucket disPlayHud:(BOOL)isHud withDone:(QiniuUploadFinished)done;

@end

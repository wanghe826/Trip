//
//  ApiUtil.m
//  notice
//
//  Created by jbas on 15/1/28.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "HttpApiUtil.h"
#import "AppUtil.h"
#import "HUD.h"
#import "JSONModel+networking.h"
#import "SyncItem.h"
#import "QiniuUploadImageApi.h"
#import "AFNetworking.h"
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetRepresentation.h>
#import "SyncJsonItem.h"
#import "CYBLoginUser.h"

static NSString *K_Imgurls = @"\"imgurls\":[";
static NSString *K_ImgurlsAndQuotationMarks = @"\"imgurls\":[\"";
static NSString *K_RightBracket = @"]";
static NSString *K_QuotationMarksAndRightBracket = @"\"]";

@implementation HttpApiUtil

+(void)httpGet:(NSString *)url withDic:(NSDictionary *)dic callBack:(void (^)(id))getCallback{
    NSString *apiurl=[AppUtil createApiURL:url params:dic];
    NSLog(@"RequestApiUrl= %@",apiurl);
    [HUD showUIBlockingIndicator];
    [JSONHTTPClient getJSONFromURLWithString:apiurl
                                  completion:^(NSDictionary *json, JSONModelError *err) {
                                      [HUD hideUIBlockingIndicator];
                                      if (err) {
                                          [self showJSONModelError:err];
                                          return getCallback(nil);
                                      }
                                      return getCallback(json);
                                  }];
}


+(void)httpSync:(Entity *)entity disPlayHud:(BOOL)isHud finishedCallBack:(void (^)(id))finishedCallBack{
    [self httpSync:entity disPlayHud:isHud itemStartSyncCallback:nil itemEndCallback:nil finishedCallBack:finishedCallBack];
}

#pragma mark 同步表单数据
+(void)httpSync:(Entity *)entity disPlayHud:(BOOL)isHud itemStartSyncCallback:(void (^)(id))itemStartSyncCallback itemEndCallback:(void(^)(id itemResponse))itemEndCallback finishedCallBack:(void (^)(id finishedResponse))finishedCallBack{
    //判断提交的数据结构是否SyncItem
    if ([entity isKindOfClass:[SyncItem class]]) {
        NSMutableArray<Entity,ConvertOnDemand> *entityArray=((SyncItem *)entity).syncEntityList;
        [self httpSyncArray:entityArray disPlayHud:isHud itemStartSyncCallback:itemStartSyncCallback itemEndSyncCallback:itemEndCallback finishedCallBack:finishedCallBack];
    }
    
    //需要上传的图片UIImage数组
    NSMutableArray *toUploadImageArray=[[NSMutableArray alloc]init];
    //不需要上传的图片URL数组
    NSMutableArray *notToUploadImageURLArray=[[NSMutableArray alloc]init];
    ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
    dispatch_queue_t queue = dispatch_queue_create("ALAsset.chuyoubao", DISPATCH_QUEUE_SERIAL);
    for (NSString *imgurl in entity.imgurls) {
        
        if ([imgurl hasPrefix:@"assets"]) {  //本地资源，需要被上传
            NSURL *url=[NSURL URLWithString:imgurl];
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            dispatch_async(queue, ^{
                [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset) {
                    UIImage *image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
                    [toUploadImageArray addObject:image];
                    dispatch_semaphore_signal(sema);
                } failureBlock:^(NSError *error) {
                    dispatch_semaphore_signal(sema);
                }];
            });
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        } else{
            [notToUploadImageURLArray addObject:imgurl];
        }
    }
    
    if (!entity.isDeleted && toUploadImageArray.count>0) { //有需要上传的图片
        [HttpApiUtil qiniuUploadImg:toUploadImageArray withQiNiuBucket:entity.syncEntity.qiniubucket disPlayHud:isHud withDone:^(NSMutableArray *uploadedImages) {
            [notToUploadImageURLArray addObjectsFromArray:uploadedImages];
            entity.imgurls = notToUploadImageURLArray;
            if([entity isMemberOfClass:[SyncJsonItem class]])
            {
                SyncJsonItem *syncJsonItem = (SyncJsonItem *)entity;
                NSRange range = [HttpApiUtil substringRangeInString:syncJsonItem.syncEntityList[0]];
                range.location += K_ImgurlsAndQuotationMarks.length;
                range.length -= K_ImgurlsAndQuotationMarks.length + K_QuotationMarksAndRightBracket.length;
                
                NSString *str1 = [entity.imgurls componentsJoinedByString:@","];
                NSString *str2 = [str1 stringByReplacingOccurrencesOfString:@"," withString:@"\",\""];
                NSString *str3 = [str2 stringByReplacingOccurrencesOfString:@"/" withString:@"\\/"];
                syncJsonItem.syncEntityList[0] = [syncJsonItem.syncEntityList[0] stringByReplacingCharactersInRange:range withString:str3];
               // NSLog(@"图片上传后的syncJsonItem---%@", syncJsonItem);
                
                entity.imgurls = nil;
            }
            
            [self httpSync_FormPost:entity disPlayHud:isHud finishedCallBack:^(id finishedResponse) {
                if (isHud) {
                    [HUD showUIBlockingIndicatorWithText:@"带图片上传操作成功" withTimeout:1];
                }
                finishedCallBack(finishedResponse);
            }];
        }];
    }else{    //无图片需要上传或进行删除操作，直接上传表单内容
        [self httpSync_FormPost:entity disPlayHud:isHud finishedCallBack:^(id finishedResponse) {
            if (isHud) {
                [HUD showUIBlockingIndicatorWithText:@"操作成功" withTimeout:1];
            }
            finishedCallBack(finishedResponse);
        }];
    }
}

+(void)httpSyncArray:(NSMutableArray *)entityArray disPlayHud:(BOOL)isHud itemStartSyncCallback:(void (^)(id))itemStartSyncCallback itemEndSyncCallback:(void (^)(id))itemEndSyncCallback finishedCallBack:(void (^)(id))finishedCallback{
    if (entityArray.count==0) { //没有数据需要同步
        if (itemStartSyncCallback) {
            itemStartSyncCallback(nil);
        }
        if (itemEndSyncCallback) {
            itemEndSyncCallback(nil);
        }
        if (finishedCallback) {
            finishedCallback(nil);
        }
        return;
    }

    if (isHud) {
        [HUD showUIBlockingIndicatorWithText:@"正在处理,请等待..."];
    }
    dispatch_queue_t queue = dispatch_queue_create("uploadentity.chuyoubao", DISPATCH_QUEUE_SERIAL);
    for (int i = 0; i < entityArray.count; i++) {
        Entity *entity;
        if([entityArray[i] isMemberOfClass:[Entity class]])
        {
            entity = entityArray[i];
        } else if([entityArray[i] isMemberOfClass:[SyncJsonItem class]])
        {
            entity = entityArray[i];
            SyncJsonItem *syncJsonItem = entityArray[i];
          //  NSLog(@"未做处理的syncJsonItem---%@", syncJsonItem);
            
            NSRange range = [HttpApiUtil substringRangeInString:syncJsonItem.syncEntityList[0]];
            range.location += K_Imgurls.length;
            range.length -= K_Imgurls.length + K_RightBracket.length;
            
            NSString *str1 = [[syncJsonItem.syncEntityList[0] substringWithRange:range] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
            NSString *str2 = [str1 stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            entity.imgurls = (NSMutableArray *)[str2 componentsSeparatedByString:@","];
        }

        dispatch_async(queue, ^{
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            //开始同步前的操作
            if (itemStartSyncCallback) {
                itemStartSyncCallback(entity);
            }
            [self httpSync:entity disPlayHud:NO finishedCallBack:^(id responseJSON) {
                NSLog(@"%d,%@",i,responseJSON);
                //该条记录同步后的操作
                if (itemEndSyncCallback) {
                    itemEndSyncCallback(responseJSON);
                }
                if (i == entityArray.count - 1) {
                    //数组全部同步后的操作
                    if (finishedCallback) {
                        finishedCallback(responseJSON);
                    }
                    if (isHud) {
                        [HUD showUIBlockingIndicatorWithText:@"操作成功" withTimeout:1];
                    }
                }
                dispatch_semaphore_signal(sema);
            }];
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        });
    }
}

+(void)httpSync_FormPost:(Entity *)entity disPlayHud:(BOOL)isHud finishedCallBack:(void (^)(id finishedResponse))finishedCallback{
    SyncItem *syncItem=[[SyncItem alloc]initWithEntity:entity];  //更新数据库中要同步的数据
    NSString *syncjson=[syncItem toJSONString];
    NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:syncjson forKey:@"syncjson"];
    if (isHud) {
        [HUD showUIBlockingIndicatorWithText:@"正在操作"];
    }
    NSString *syncURL=entity.syncEntity.syncurl;
    if (!syncURL) {
        return;
    }
    NSString *sid=[CYBLoginUser sharedCYBLoginUser].sid;
    if (sid.length>0) {
        [[JSONHTTPClient requestHeaders] setValue:sid forKey:@"sid"];        
    }
    [JSONHTTPClient postJSONFromURLWithString:syncURL
                                       params:paramDic
                                   completion:^(NSDictionary *json, JSONModelError *err) {
                                       if (isHud) {
                                           [HUD hideUIBlockingIndicator];
                                       }
                                       if (err) {
                                           [self showJSONModelError:err];
                                           return finishedCallback(nil);
                                       }
                                       int ok=[(NSNumber *)[json objectForKey:@"ok"] intValue];
                                       if (ok==0) {
                                           NSString *errCode=[NSString stringWithFormat:@"%@",json[@"errCode"]];
                                           NSString *errDesc=[AppUtil getErrCodeDesc:errCode];
                                           [AppUtil showAlert:errDesc];
                                           return finishedCallback(nil);
                                       }
                                       return finishedCallback(json);
                                   }];
}

+(void)qiniuUploadImg:(NSMutableArray *)uploadImgArray withQiNiuBucket:(NSString *)qiNiuBucket disPlayHud:(BOOL)isHud withDone:(QiniuUploadFinished)done {
    QiniuUploadImageApi *qiniuaApi=[[QiniuUploadImageApi alloc]initWithUploadImgArray:uploadImgArray withQiNiuBucket:qiNiuBucket];
    [qiniuaApi upLoadImagesWithDisPlayHud:isHud done:^(NSMutableArray *finishedArray) {
        done(finishedArray);
    }];
}


#pragma mark -显示jsonmodel返回的错误信息
+(void)showJSONModelError:(JSONModelError *)err{
    [[[UIAlertView alloc] initWithTitle:@"错误"
                                message:[err localizedDescription]
                               delegate:nil
                      cancelButtonTitle:@"关闭"
                      otherButtonTitles:nil] show];
}

+(NSRange)substringRangeInString:(NSString *)searchString
{
    NSRange range = [searchString rangeOfString:@"\"imgurls\":.+\"]" options:NSRegularExpressionSearch];
    if (range.location == NSNotFound) {
        NSLog(@"\"imgurls\": is not Found!");
    }
    return range;
}
@end
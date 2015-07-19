//
//  QiniuUploadImageApi.m
//  notice
//
//  Created by jbas on 15/2/1.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "QiniuUploadImageApi.h"
#import "QiniuSDK.h"
#import "HUD.h"
#import "QiniuTokenApi.h"

#define QINIUIMGURL @"http://%@.qiniudn.com/%@"


@implementation QiniuUploadImageApi{
    NSMutableArray *_uploadImgArray;
    NSMutableArray *_uploadedResultImgUrls;
    int _uploadImageNumber;
    NSString *_qiniuBucket;
}

-(id)initWithUploadImgArray:(NSMutableArray *)uploadImgArray withQiNiuBucket:(NSString *)qiniuBucket{
    self=[super init];
    _uploadedResultImgUrls=[[NSMutableArray alloc]init];
    if (self) {
        _uploadImgArray=uploadImgArray;
    }
    _qiniuBucket=qiniuBucket;
    return self;
}

-(void)uploadImageWithData:(NSString *)upTokenString andData:(NSData*)data callBack:(void (^)(id responseObj))callBack percent:(void(^)(float p))percents
{
    dispatch_queue_t queue = dispatch_queue_create("xxx.ConcurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_barrier_async(queue, ^{
        QNUploadOption *opt = [[QNUploadOption alloc]initWithMime:@"image/jpg" progressHandler:^(NSString *key, float percent) {
            percents(percent);
        } params:nil checkCrc:YES cancellationSignal:nil];
        QNUploadManager *upManager = [[QNUploadManager alloc] init];
        [upManager putData:data key:nil token:upTokenString
                  complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                   //   NSLog(@"%@", info);
                    //  NSLog(@"%@", resp);
                      callBack(resp);
                  } option:opt];
    });
}

//获取Token后上传图片
-(void)upLoadImagesWithDisPlayHud:(BOOL)isHud done:(QiniuUploadFinished)done{
  //  NSLog(@"-(void)upLoadImagesWithDisPlayHud:");
    if (_uploadImgArray.count == 0) { //不需要上传
        done(_uploadedResultImgUrls);
    }else{
        if (isHud) {
            [HUD showUIBlockingIndicatorWithText:@"正在上传图片..."];
        }
        QiniuTokenApi *qiniuTokenApi=[[QiniuTokenApi alloc]initWithBucket:_qiniuBucket];
        [qiniuTokenApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
          //  NSLog(@"startWithCompletionBlockWithSuccess:");
            NSString *upTokenString=request.responseString;//本次上传用的Token
            [self startUpLoadImages:upTokenString andDone:done];
        } failure:^(YTKBaseRequest *request) {
            done(_uploadedResultImgUrls);  //出错则不上传图片
        }];

    }
}

//批量上传图片
-(void)startUpLoadImages:(NSString *)upTokentString andDone:(QiniuUploadFinished)done{
    for (UIImage *img in _uploadImgArray) {
        NSData* imageData = UIImageJPEGRepresentation(img, 1);
        [self uploadImageWithData:upTokentString andData:imageData callBack:^(id responseObj) {
            if(!responseObj){
                return;
            }
            _uploadImageNumber++;
            NSString* imageKey = [NSString stringWithFormat:@"%@",responseObj[@"key"]];
            NSString* imageUrl = [NSString stringWithFormat:QINIUIMGURL,_qiniuBucket,imageKey];
            [_uploadedResultImgUrls addObject:imageUrl];
            int x=[[NSNumber numberWithInteger:_uploadImgArray.count] intValue];
            if(_uploadImageNumber == x ){
                done(_uploadedResultImgUrls);
            };
        } percent:^(float p) {
            NSLog(@"percent=%f",p);
        }];
    }
}



@end

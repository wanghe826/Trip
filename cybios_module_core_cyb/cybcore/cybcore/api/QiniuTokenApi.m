//
//  QiniuTokenApi.m
//  notice
//
//  Created by jbas on 15/2/1.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "QiniuTokenApi.h"
#import "CybCoreURLs.h"

@interface QiniuTokenApi(){
    NSString *_bucketName;
}

@end

@implementation QiniuTokenApi

-(instancetype)initWithBucket:(NSString *)bucketName{
    self=[super init];
    if (self) {
        _bucketName=bucketName;
    }
    return self;
}

-(NSString *)requestUrl{
    return [NSString stringWithFormat:@"%@/%@",COREQINIU_UPLOADTOKEN,_bucketName];
}

-(NSInteger)cacheTimeInSeconds{
    return 2*60*60;
}

@end

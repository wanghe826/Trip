//
//  QiniuTokenApi.h
//  notice
//
//  Created by jbas on 15/2/1.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "YTKRequest.h"

@interface QiniuTokenApi : YTKRequest

-(instancetype)initWithBucket:(NSString *)bucketName;
@end

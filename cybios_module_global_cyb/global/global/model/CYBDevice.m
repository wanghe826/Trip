//
//  CYBDevice.m
//  global
//
//  Created by wanghe on 15-5-11.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "CYBDevice.h"
#import "GlobalURLs.h"

@implementation CYBDevice

-(instancetype)init{
    self=[super init];
    if (self) {
        self.requestCode=GLOBALSYNC_REQUESTCODE;
        self.syncEntity.cmodule=GLOBALMODULENAME;
        self.syncEntity.syncurl=GLOBAL_SYNC;
        self.syncEntity.qiniubucket=GLOBALQINIU_BUCKET;
        self.methodName=@"saveAdvice";
    }
    return self;
}


@end

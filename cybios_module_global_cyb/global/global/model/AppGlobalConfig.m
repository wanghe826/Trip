//
//  AppGlobalConfig.m
//  global
//
//  Created by jbas on 15/4/29.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "AppGlobalConfig.h"
#import "GlobalURLs.h"

@implementation AppGlobalConfig

-(instancetype)init{
    self=[super init];
    if (self) {
        self.requestCode=GLOBALSYNC_REQUESTCODE;
        self.syncEntity.cmodule=GLOBALMODULENAME;
        self.syncEntity.syncurl=GLOBAL_SYNC;
        self.syncEntity.qiniubucket=GLOBALQINIU_BUCKET;
    }
    return self;
}

@end

//
//  CYBUserLinker.m
//  global
//
//  Created by jbas on 15/5/3.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "CYBUserLinker.h"
#import "GlobalURLs.h"

@implementation CYBUserLinker

-(instancetype)init{
    self=[super init];
    if (self) {
        self.requestCode=GLOBALSYNC_REQUESTCODE;
        self.syncEntity.cmodule=GLOBALMODULENAME;
        self.syncEntity.syncurl=GLOBAL_SYNC;
        self.syncEntity.qiniubucket=GLOBALQINIU_BUCKET;
        self.methodName=@"linkuser";
    }
    return self;
}

@end

//
//  UpdatePwdModel.m
//  global
//
//  Created by jbas on 15/4/29.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "UpdatePwdModel.h"
#import "GlobalURLs.h"

@implementation UpdatePwdModel

-(instancetype)init{
    self=[super init];
    if (self) {
        self.requestCode=GLOBALSYNC_REQUESTCODE;
        self.syncEntity.cmodule=GLOBALMODULENAME;
        self.syncEntity.syncurl=GLOBAL_SYNC;
        self.syncEntity.qiniubucket=GLOBALQINIU_BUCKET;
        self.methodName=@"updatepwd";
    }
    return self;
}

@end

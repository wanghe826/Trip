//
//  CYBAdviceReply.m
//  global
//
//  Created by wanghe on 15-5-13.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "CYBAdviceReply.h"
#import "GlobalURLs.h"

@implementation CYBAdviceReply
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

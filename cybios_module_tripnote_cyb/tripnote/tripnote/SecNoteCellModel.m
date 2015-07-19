//
//  SecNoteCellModel.m
//  tripnote
//
//  Created by wanghe on 15-5-18.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "SecNoteCellModel.h"
#import "TripNoteApiUrls.h"

@implementation SecNoteCellModel


-(instancetype)init{
    self=[super init];
    if (self) {
        self.requestCode=TRIPNOTESYNC_REQUESTCODE;
        self.syncEntity.cmodule=TRIPNOTEMODULENAME;
        self.syncEntity.syncurl=TRIPNOTE_SYNC;
        self.syncEntity.qiniubucket=TRIPNOTEQINIU_BUCKET;
        self.methodName=@"TripNote";
    }
    return self;
}

@end

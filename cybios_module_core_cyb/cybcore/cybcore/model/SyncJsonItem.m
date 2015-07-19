//
//  SyncJsonItem.m
//  reportarrival
//
//  Created by jbas on 15/3/29.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "SyncJsonItem.h"
#import "SyncDBItem.h"

@implementation SyncJsonItem

-(instancetype)init{
    self=[super init];
    if (self) {
        if (!self.syncEntityList) {
        self.syncEntityList=(NSMutableArray<Entity,ConvertOnDemand> *)[[NSMutableArray alloc]init];
        }
    }
    return self;
}

-(SyncJsonItem *)initWithEntity:(Entity *)entity{
    SyncJsonItem *syncJsonItem=[[SyncJsonItem alloc]init];
    syncJsonItem.syncEntity=entity.syncEntity;
    [syncJsonItem.syncEntityList addObject:entity];
    return syncJsonItem;
}

-(SyncJsonItem *)initWithSyncDBItem:(SyncDBItem *)syncDBItem{
    SyncJsonItem *syncJsonItem=[[SyncJsonItem alloc]init];
    syncJsonItem.syncid=syncDBItem.syncid;
    syncJsonItem.syncEntity=syncDBItem.syncEntity;
    syncJsonItem.syncEntity.syncrequestcode=syncDBItem.syncEntity.syncrequestcode;
    [syncJsonItem.syncEntityList addObject:syncDBItem.syncjson];
    return syncJsonItem;
}

@end

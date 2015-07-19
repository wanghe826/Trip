//
//  SyncItem.m
//  Notice
//
//  Created by jbas on 15/1/12.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "SyncItem.h"
#import "SyncEntity.h"
#import "SyncJsonItem.h"

@implementation SyncItem

-(instancetype)init{
    self=[super init];
    if (self) {
        if (!self.syncEntityList) {
            self.syncEntityList=(NSMutableArray<Entity,ConvertOnDemand> *)[[NSMutableArray alloc]init];
//            self.syncEntityList=(NSMutableArray<SyncEntity,ConvertOnDemand> *)[[NSMutableArray alloc]init];

        }
    }
    return self;
}

-(SyncItem*)initWithEntity:(Entity *)entity{
    if ([entity isKindOfClass:[SyncItem class]]) {
        return (SyncItem *)entity;
    }
    SyncItem *syncItem=[[SyncItem alloc]init];
    if ([entity isKindOfClass:[SyncJsonItem class]]) {
        syncItem.syncrequestcode=entity.syncEntity.syncrequestcode;
        syncItem.syncEntityList=((SyncJsonItem *)entity).syncEntityList;
    }else{
        syncItem.syncrequestcode=entity.syncEntity.syncrequestcode;
        [syncItem.syncEntityList addObject:entity];
    }
    return syncItem;
}

-(SyncItem *)initwithEntityArray:(NSMutableArray *)entityArray{
    if (entityArray.count==0) {
        return nil;
    }
    SyncItem *syncItem=[[SyncItem alloc]init];
    syncItem.syncrequestcode=((Entity *)entityArray[0]).syncEntity.syncrequestcode;
    [syncItem.syncEntityList addObjectsFromArray:entityArray];
    return syncItem;
}

@end

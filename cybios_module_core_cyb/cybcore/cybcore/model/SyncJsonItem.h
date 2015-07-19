//
//  SyncJsonItem.h
//  reportarrival
//
//  Created by jbas on 15/3/29.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "Entity.h"
#import "SyncItem.h"
@class SyncDBItem;

@protocol SyncJsonItem @end

@interface SyncJsonItem : Entity<SyncEntity,ConvertOnDemand>

@property (nonatomic,strong) NSString *syncid;
//@property (nonatomic,strong) NSString *syncrequestcode;
@property(nonatomic,strong) NSMutableArray<Entity,ConvertOnDemand> *syncEntityList;

-(SyncJsonItem *)initWithEntity:(Entity*)entity;
-(SyncJsonItem *)initWithSyncDBItem:(SyncDBItem *)syncDBItem;
@end
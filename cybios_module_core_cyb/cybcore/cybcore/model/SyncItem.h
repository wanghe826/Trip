//
//  SyncItem.h
//  Notice
//
//  Created by jbas on 15/1/12.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "Entity.h"
#import "SyncItem.h"
#import "SyncEntity.h"
#import "SyncDBItem.h"

@protocol SyncItem @end

@interface SyncItem : Entity<SyncEntity,ConvertOnDemand>
@property(nonatomic,strong) NSString *syncrequestcode;
@property(nonatomic,strong) NSMutableArray<Entity,ConvertOnDemand> *syncEntityList;

//@property(nonatomic,strong) NSMutableArray<SyncEntity,ConvertOnDemand> *syncEntityList;
-(SyncItem *)initWithEntity:(Entity*)entity;
-(SyncItem *)initwithEntityArray:(NSMutableArray *)entityArray;
@end

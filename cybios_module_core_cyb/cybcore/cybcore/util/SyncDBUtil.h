//
//  YTKKeyValueStore.h
//  Ape
//
//  Created by TangQiao on 12-11-6.
//  Copyright (c) 2012年 TangQiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"
@class SyncItem;


@interface SyncDBUtil : NSObject

//- (id)initDBWithName:(NSString *)dbName;

- (id)initWithCYBSYNC;

- (id)initWithDBWithPath:(NSString *)dbPath;

- (void)createTableWithName:(NSString *)tableName;

- (void)clearTable:(NSString *)tableName;

- (void)close;

///************************ Put&Get methods *****************************************

//- (void)putObject:(id)object withId:(NSString *)objectId intoTable:(NSString *)tableName;

//- (id)getObjectById:(NSString *)objectId fromTable:(NSString *)tableName;

//- (SyncDBItem *)getSyncDBItemById:(NSString *)objectId fromTable:(NSString *)tableName;

//- (void)putString:(NSString *)string withId:(NSString *)stringId intoTable:(NSString *)tableName;

//- (NSString *)getStringById:(NSString *)stringId fromTable:(NSString *)tableName;

//- (void)putNumber:(NSNumber *)number withId:(NSString *)numberId intoTable:(NSString *)tableName;

//- (NSNumber *)getNumberById:(NSString *)numberId fromTable:(NSString *)tableName;

//- (NSMutableArray *)getNotSyncedItemsFromTable;

//- (NSMutableArray *)getNotSyncedItemsFromTable:(NSString *)tableName;

//- (void)deleteObjectById:(NSString *)objectId fromTable:(NSString *)tableName;

//- (void)deleteObjectsByIdArray:(NSArray *)objectIdArray fromTable:(NSString *)tableName;
//- (void)deleteObjectsByIdArray:(NSArray *)objectIdArray;
-(void)updateSyncedItems:(id)itemResponse andNextState:(int)nextState;//更新已经同步过的数据状态


- (void)deleteSyncedItems:(id)itemResponse; //删除已经同步过的本地数据

//- (void)deleteObjectsByIdPrefix:(NSString *)objectIdPrefix fromTable:(NSString *)tableName;

- (BOOL)putEntity:(Entity *)entity;  //把需要同步的数据保存到本地

//- (BOOL)putEntityWithTable:(Entity *)entity intoTable:(NSString *)tableName;

- (BOOL)updateSyncing:(NSString *)syncid andNextState:(int)nextState;  //开始数据同步前更新开始同步时间

//-(BOOL)updateSyncing:(NSString *)syncid tableName:(NSString *)tableName;

-(void)syncJsonItemArr:(void (^)(id))finishedCallback;

-(void)syncJsonItemArr:(NSString *)moduleName isDelSynced:(BOOL) isDelSynced finishedCallback:(void (^)(id))finishedCallback;

-(int)countNotSyncedItem:(NSString *)moduleName;
        
@end

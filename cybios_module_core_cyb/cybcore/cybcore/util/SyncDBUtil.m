//
//  YTKKeyValueStore.m
//  Ape
//
//  Created by TangQiao on 12-11-6.
//  Copyright (c) 2012年 TangQiao. All rights reserved.
//

#import "SyncDBUtil.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "CYBLoginUser.h"
#import "SyncDBItem.h"
#import "SyncItem.h"
#import "SyncPostResult.h"
#import "SyncJsonItem.h"
#import "HttpApiUtil.h"

#ifdef DEBUG
#define debugLog(...)    NSLog(__VA_ARGS__)
#define debugMethod()    NSLog(@"%s", __func__)
#define debugError()     NSLog(@"Error at %s Line:%d", __func__, __LINE__)
#else
#define debugLog(...)
#define debugMethod()
#define debugError()
#endif

#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

typedef NS_ENUM(NSInteger, SYNCSTATE){
    SYNCSTATE_INIT,
    SYNCSTATE_GOING,
    SYNCSTATE_SUCCEED,
    SYNCSTATE_FAILED
};

@interface SyncDBUtil()

@property (strong, nonatomic) FMDatabaseQueue * dbQueue;

@end

@implementation SyncDBUtil

static NSString *const CYB_SYNCDBNAME = @"cybsyncdb";
static NSString *const CYB_SYNCTABLENAME = @"tsync";


//syncstate状态值 0:未上传，1:正在上传,2:上传成功,3:上传失败

static NSString *const CREATE_TABLE_SQL =
@"CREATE TABLE IF NOT EXISTS %@ ( \
syncid TEXT NOT NULL, \
psyncid TEXT, \
syncstate TEXT, \
syncjson TEXT, \
createdtime TEXT NOT NULL, \
createdcid TEXT, \
synctime TEXT, \
cmodule TEXT, \
syncurl TEXT, \
qiniubucket TEXT, \
requestcode TEXT, \
PRIMARY KEY(syncid)) \
";

//static NSString *const UPDATE_ITEM_SQL = @"REPLACE INTO %@ (id, json, createdTime) values (?, ?, ?)";
static NSString *const UPDATE_ITEM_SQL = @"REPLACE INTO %@ (syncid, psyncid,syncstate,syncjson, createdtime,createdcid,cmodule,syncurl,qiniubucket,requestcode) values (?, ?, ?,?,?,?,?,?,?,?)";

static NSString *const UPDATE_SYNCING_SQL = @"UPDATE %@ SET syncState=?,synctime=? WHERE syncid=?";
static NSString *const UPDATE_ITEMS_SQL = @"UPDATE %@ SET syncState=?,synctime=? WHERE syncid in (%@)";

//static NSString *const QUERY_ITEM_SQL = @"SELECT json, createdTime from %@ where id = ? Limit 1";
static NSString *const QUERY_NOSYNC_ITEM_SQL = @"SELECT * from %@ where (syncstate = 0 or syncstate=3) order by createdtime";

static NSString *const QUERY_NOSYNC_ITEM_SQL_UseModule = @"SELECT * from %@ where (syncstate = 0 or syncstate=3) and cmodule='%@' order by createdtime";

static NSString *const SELECT_ALL_SQL = @"SELECT * from %@";

static NSString *const CLEAR_ALL_SQL = @"DELETE from %@";

static NSString *const DELETE_ITEM_SQL = @"DELETE from %@ where id = ?";


static NSString *const DELETE_ITEMS_SQL = @"DELETE from %@ where syncid in ( %@ )";
//static NSString *const DELETE_ITEMS_SQL = @"DELETE from %@ where id in ( %@ )";

static NSString *const DELETE_ITEMS_WITH_PREFIX_SQL = @"DELETE from %@ where id like ? ";

static NSString *const COUNT_NOTSYNCED_SQL=@"SELECT COUNT(*) from %@ where cmodule=? and syncstate!=2";

+ (BOOL)checkTableName:(NSString *)tableName {
    if (tableName == nil || tableName.length == 0 || [tableName rangeOfString:@" "].location != NSNotFound) {
        debugLog(@"ERROR, table name: %@ format error.", tableName);
        return NO;
    }
    return YES;
}

- (id)init {
    return [self initDBWithName:CYB_SYNCDBNAME];
}

- (id)initDBWithName:(NSString *)dbName {
    self = [super init];
    if (self) {
        NSString * dbPath = [PATH_OF_DOCUMENT stringByAppendingPathComponent:dbName];
        debugLog(@"dbPath = %@", dbPath);
        if (_dbQueue) {
            [self close];
        }
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    }
    return self;
}

-(id)initWithCYBSYNC{
    self=[self initDBWithName:CYB_SYNCDBNAME];
    [self createTableWithName:CYB_SYNCTABLENAME];
    return self;
}

- (id)initWithDBWithPath:(NSString *)dbPath {
    self = [super init];
    if (self) {
        debugLog(@"dbPath = %@", dbPath);
        if (_dbQueue) {
            [self close];
        }
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    }
    return self;
}

- (void)createTableWithName:(NSString *)tableName {
    if ([SyncDBUtil checkTableName:tableName] == NO) {
        return;
    }
    NSString * sql = [NSString stringWithFormat:CREATE_TABLE_SQL, tableName];
    __block BOOL result;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:sql];
    }];
    if (!result) {
        debugLog(@"ERROR, failed to create table: %@", tableName);
    }
}

- (void)clearTable:(NSString *)tableName {
    if ([SyncDBUtil checkTableName:tableName] == NO) {
        return;
    }
    NSString * sql = [NSString stringWithFormat:CLEAR_ALL_SQL, tableName];
    __block BOOL result;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:sql];
    }];
    if (!result) {
        debugLog(@"ERROR, failed to clear table: %@", tableName);
    }
}
//
////- (void)putObject:(id)object withId:(NSString *)objectId intoTable:(NSString *)tableName {
////    if ([SyncDBUtil checkTableName:tableName] == NO) {
////        return;
////    }
////    NSError * error;
////    NSData * data = [NSJSONSerialization dataWithJSONObject:object options:0 error:&error];
////    if (error) {
////        debugLog(@"ERROR, faild to get json data");
////        return;
////    }
////    NSString * jsonString = [[NSString alloc] initWithData:data encoding:(NSUTF8StringEncoding)];
////    NSDate * createdTime = [NSDate date];
////    NSString * sql = [NSString stringWithFormat:UPDATE_ITEM_SQL, tableName];
////    __block BOOL result;
////    [_dbQueue inDatabase:^(FMDatabase *db) {
////        result = [db executeUpdate:sql, objectId, jsonString, createdTime];
////    }];
////    if (!result) {
////        debugLog(@"ERROR, failed to insert/replace into table: %@", tableName);
////    }
////}
//
//- (id)getObjectById:(NSString *)objectId fromTable:(NSString *)tableName {
//    SyncDBItem * item = [self getSyncDBItemById:objectId fromTable:tableName];
//    if (item) {
//        return item.itemObject;
//    } else {
//        return nil;
//    }
//}
//
//- (SyncDBItem *)getSyncDBItemById:(NSString *)objectId fromTable:(NSString *)tableName {
//    if ([SyncDBUtil checkTableName:tableName] == NO) {
//        return nil;
//    }
//    NSString * sql = [NSString stringWithFormat:QUERY_ITEM_SQL, tableName];
//    __block NSString * json = nil;
//    __block NSDate * createdTime = nil;
//    [_dbQueue inDatabase:^(FMDatabase *db) {
//        FMResultSet * rs = [db executeQuery:sql, objectId];
//        if ([rs next]) {
//            json = [rs stringForColumn:@"json"];
//            createdTime = [rs dateForColumn:@"createdTime"];
//        }
//        [rs close];
//    }];
//    if (json) {
//        NSError * error;
//        id result = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding]
//                                                    options:(NSJSONReadingAllowFragments) error:&error];
//        if (error) {
//            debugLog(@"ERROR, faild to prase to json");
//            return nil;
//        }
//        SyncDBItem * item = [[SyncDBItem alloc] init];
//        item.itemId = objectId;
//        item.itemObject = result;
//        item.createdTime = createdTime;
//        return item;
//    } else {
//        return nil;
//    }
//}
//
////- (void)putString:(NSString *)string withId:(NSString *)stringId intoTable:(NSString *)tableName {
////    if (string == nil) {
////        debugLog(@"error, string is nil");
////        return;
////    }
////    [self putObject:@[string] withId:stringId intoTable:tableName];
////}
//
//- (NSString *)getStringById:(NSString *)stringId fromTable:(NSString *)tableName {
//    NSArray * array = [self getObjectById:stringId fromTable:tableName];
//    if (array && [array isKindOfClass:[NSArray class]]) {
//        return array[0];
//    }
//    return nil;
//}
//
////- (void)putNumber:(NSNumber *)number withId:(NSString *)numberId intoTable:(NSString *)tableName {
////    if (number == nil) {
////        debugLog(@"error, number is nil");
////        return;
////    }
////    [self putObject:@[number] withId:numberId intoTable:tableName];
////}
//
//- (NSNumber *)getNumberById:(NSString *)numberId fromTable:(NSString *)tableName {
//    NSArray * array = [self getObjectById:numberId fromTable:tableName];
//    if (array && [array isKindOfClass:[NSArray class]]) {
//        return array[0];
//    }
//    return nil;
//}
//
//- (NSMutableArray *)getNotSyncedItemsFromTable{
//    return [self getNotSyncedItemsFromTable:CYB_SYNCTABLENAME];
//}

- (NSMutableArray *)getNotSyncedItemsFromTable:(NSString *)tableName andModuleName:(NSString *)moduleName {
    if ([SyncDBUtil checkTableName:tableName] == NO) {
        return nil;
    }
    NSString * sql;
    if (!moduleName) {  //没指定模块名，则表示取全部记录
        sql=[NSString stringWithFormat:QUERY_NOSYNC_ITEM_SQL, tableName];
    }else{              //获取指定模块名的数据
        sql=[NSString stringWithFormat:QUERY_NOSYNC_ITEM_SQL_UseModule, tableName,moduleName];
    }
    __block NSMutableArray * notSynceditems = [NSMutableArray array];
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            SyncDBItem * item = [[SyncDBItem alloc] init];
            item.syncid = [rs stringForColumn:@"syncid"];
            item.psyncid = [rs stringForColumn:@"psyncid"];
            item.syncstate = [[rs stringForColumn:@"syncstate"] intValue];
            item.syncjson = [rs stringForColumn:@"syncjson"];
            item.createdtime = [rs dateForColumn:@"createdtime"];
            item.createdcid = [rs stringForColumn:@"createdcid"];
            item.synctime = [rs dateForColumn:@"synctime"];
            item.syncEntity.syncurl=[rs stringForColumn:@"syncurl"];
            item.syncEntity.cmodule=[rs stringForColumn:@"cmodule"];
            item.syncEntity.qiniubucket=[rs stringForColumn:@"qiniubucket"];
            item.syncEntity.syncrequestcode=[rs stringForColumn:@"requestcode"];
            [notSynceditems addObject:item];
        }
        [rs close];
    }];
    NSMutableArray *result=[[NSMutableArray alloc]init];
    for (SyncDBItem *syncDBItem in notSynceditems) {
        SyncJsonItem *jsonItem=[[SyncJsonItem alloc]initWithSyncDBItem:syncDBItem];
        [result addObject:jsonItem];
    }
    return result;
}

//- (NSMutableArray *)getNotSyncedItemsFromTable:(NSString *)tableName {
//    return [self getNotSyncedItemsFromTable:tableName andModuleName:nil];
//}


//- (NSArray *)getNotSyncedItemsFromTable:(NSString *)tableName {
//    if ([SyncDBUtil checkTableName:tableName] == NO) {
//        return nil;
//    }
//    NSString * sql = [NSString stringWithFormat:QUERY_NOSYNC_ITEM_SQL, tableName];
//    __block NSMutableArray * result = [NSMutableArray array];
//    [_dbQueue inDatabase:^(FMDatabase *db) {
//        FMResultSet * rs = [db executeQuery:sql];
//        while ([rs next]) {
//            SyncDBItem * item = [[SyncDBItem alloc] init];
//            item.syncid = [rs stringForColumn:@"syncid"];
//            item.psyncid = [rs stringForColumn:@"psyncid"];
//            item.syncstate = [[rs stringForColumn:@"syncstate"] intValue];
//            item.syncjson = [rs stringForColumn:@"syncjson"];
//            item.createdtime = [rs dateForColumn:@"createdtime"];
//            item.createdcid = [rs stringForColumn:@"createdcid"];
//            item.synctime = [rs dateForColumn:@"synctime"];
//            [result addObject:item];
//        }
//        [rs close];
//    }];
//    // parse json string to object
//    NSError * error;
//    for (SyncDBItem * item in result) {
//        error = nil;
//        id object = [NSJSONSerialization JSONObjectWithData:[item.syncjson dataUsingEncoding:NSUTF8StringEncoding]
//                                                    options:(NSJSONReadingAllowFragments) error:&error];
//        if (error) {
//            debugLog(@"ERROR, faild to prase to json.");
//        } else {
//            item.syncjson = object;
//        }
//    }
//    return result;
//}
//
//- (void)deleteObjectById:(NSString *)objectId fromTable:(NSString *)tableName {
//    if ([SyncDBUtil checkTableName:tableName] == NO) {
//        return;
//    }
//    NSString * sql = [NSString stringWithFormat:DELETE_ITEM_SQL, tableName];
//    __block BOOL result;
//    [_dbQueue inDatabase:^(FMDatabase *db) {
//        result = [db executeUpdate:sql, objectId];
//    }];
//    if (!result) {
//        debugLog(@"ERROR, failed to delete item from table: %@", tableName);
//    }
//}

-(void)updateObjectsByIdArray:(NSArray *)objectIdArray andNextState:(int)nextState {
    [self updateObjectsByIdArray:objectIdArray andNextState:nextState fromTable:CYB_SYNCTABLENAME];
}

- (void)deleteObjectsByIdArray:(NSArray *)objectIdArray{
    [self deleteObjectsByIdArray:objectIdArray fromTable:CYB_SYNCTABLENAME];
}

- (void)updateObjectsByIdArray:(NSArray *)objectIdArray andNextState:(int)nextState fromTable:(NSString *)tableName {
    if ([SyncDBUtil checkTableName:tableName] == NO) {
        return;
    }
    NSMutableString *stringBuilder = [NSMutableString string];
    for (id objectId in objectIdArray) {
        NSString *item = [NSString stringWithFormat:@" '%@' ", objectId];
        if (stringBuilder.length == 0) {
            [stringBuilder appendString:item];
        } else {
            [stringBuilder appendString:@","];
            [stringBuilder appendString:item];
        }
    }
    NSString * sql = [NSString stringWithFormat:UPDATE_ITEMS_SQL, tableName,stringBuilder];
    __block BOOL result;
    NSString *syncState=[NSString stringWithFormat:@"%ld",(long)nextState];
    [_dbQueue inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:sql,syncState,[NSDate date]];
    }];
    if (!result) {
        debugLog(@"ERROR, failed to upate table: %@", tableName);
    }
}

- (void)deleteObjectsByIdArray:(NSArray *)objectIdArray fromTable:(NSString *)tableName {
    if ([SyncDBUtil checkTableName:tableName] == NO) {
        return;
    }
    NSMutableString *stringBuilder = [NSMutableString string];
    for (id objectId in objectIdArray) {
        NSString *item = [NSString stringWithFormat:@" '%@' ", objectId];
        if (stringBuilder.length == 0) {
            [stringBuilder appendString:item];
        } else {
            [stringBuilder appendString:@","];
            [stringBuilder appendString:item];
        }
    }
    NSString *sql = [NSString stringWithFormat:DELETE_ITEMS_SQL, tableName, stringBuilder];
    __block BOOL result;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:sql];
    }];
    if (!result) {
        debugLog(@"ERROR, failed to delete items by ids from table: %@", tableName);
    }
}
//
//- (void)deleteObjectsByIdPrefix:(NSString *)objectIdPrefix fromTable:(NSString *)tableName {
//    if ([SyncDBUtil checkTableName:tableName] == NO) {
//        return;
//    }
//    NSString *sql = [NSString stringWithFormat:DELETE_ITEMS_WITH_PREFIX_SQL, tableName];
//    NSString *prefixArgument = [NSString stringWithFormat:@"%@%%", objectIdPrefix];
//    __block BOOL result;
//    [_dbQueue inDatabase:^(FMDatabase *db) {
//        result = [db executeUpdate:sql, prefixArgument];
//    }];
//    if (!result) {
//        debugLog(@"ERROR, failed to delete items by id prefix from table: %@", tableName);
//    }
//}

//保存Entity
//- (void)putEntity:(Entity *)entity withId:(NSString *)objectId intoTable:(NSString *)tableName {

-(BOOL)putEntity:(Entity *)entity{
    return [self putEntityWithTable:entity intoTable:CYB_SYNCTABLENAME];
}

-(BOOL)putEntityWithTable:(Entity *)entity intoTable:(NSString *)tableName{
    if ([SyncDBUtil checkTableName:tableName] == NO) {
        return NO;
    }
    if (entity.syncEntity.syncid.length==0) {
        entity.syncEntity.syncid=[[NSUUID UUID]UUIDString];
    }
    NSString *jsonString=[entity toJSONString];
    NSDate * createdTime = [NSDate date];
    entity.createdcid=[CYBLoginUser sharedCYBLoginUser].cybid;
    NSString * sql = [NSString stringWithFormat:UPDATE_ITEM_SQL, tableName];
    __block BOOL result;
    NSString *syncState=[NSString stringWithFormat:@"%ld",(long)SYNCSTATE_INIT];
    [_dbQueue inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:sql, entity.syncEntity.syncid, entity.syncEntity.psyncid,syncState,jsonString,createdTime,entity.createdcid,entity.syncEntity.cmodule,entity.syncEntity.syncurl,entity.syncEntity.qiniubucket,entity.syncEntity.syncrequestcode];
    }];
    if (!result) {
        debugLog(@"ERROR, failed to insert/replace into table: %@", tableName);
    }
    return result;
}

//根据返回值获取上传的syncid的数组
-(NSArray *)fetchSyncedSyncidArr:(id)itemResponse{
    SyncPostResult *postResult=[[SyncPostResult alloc]initWithDictionary:itemResponse error:nil];
    NSMutableArray *syncedSyncidArr=[[NSMutableArray alloc]init];
    NSArray *idarray;
    for (NSString *rsitem in postResult.data) {
        idarray=[rsitem componentsSeparatedByString:@"@"];
        if (idarray[0]) {
            [syncedSyncidArr addObject:idarray[0]];
        }
    }
    return syncedSyncidArr;
}

//更新同步后的数据状态
-(void)updateSyncedItems:(id)itemResponse andNextState:(int)nextState{
    NSArray *syncedSyncidArr=[self fetchSyncedSyncidArr:itemResponse];
    [self updateObjectsByIdArray:syncedSyncidArr andNextState:nextState];
}

//删除同步后的数据
-(void)deleteSyncedItems:(id)itemResponse{
    NSArray *syncedSyncidArr=[self fetchSyncedSyncidArr:itemResponse];
    [self deleteObjectsByIdArray:syncedSyncidArr];
}

-(BOOL)updateSyncing:(NSString *)syncid andNextState:(int)nextState{
   return [self updateSyncing:syncid andNextState:nextState tableName:CYB_SYNCTABLENAME];
}

//-(BOOL)updateSyncing:(NSString *)syncid{
//    return [self updateSyncing:syncid tableName:CYB_SYNCTABLENAME];
//}

-(BOOL)updateSyncing:(NSString *)syncid andNextState:(int)nextState tableName:(NSString *)tableName{
    if ([SyncDBUtil checkTableName:tableName] == NO) {
        return NO;
    }
    NSString * sql = [NSString stringWithFormat:UPDATE_SYNCING_SQL, tableName];
    __block BOOL result;
    NSString *syncState=[NSString stringWithFormat:@"%ld",(long)nextState];
    [_dbQueue inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:sql,syncState,[NSDate date],syncid];
    }];
    if (!result) {
        debugLog(@"ERROR, failed to upate table: %@", tableName);
    }
    return result;
}

-(void)syncJsonItemArr:(void (^)(id))finishedCallback{
    [self syncJsonItemArr:nil isDelSynced:YES finishedCallback:finishedCallback];
}


-(void)syncJsonItemArr:(NSString *)moduleName isDelSynced:(BOOL)isDelSynced finishedCallback:(void (^)(id))finishedCallback{
    NSMutableArray *notSyncedItemArray=[self getNotSyncedItemsFromTable:CYB_SYNCTABLENAME andModuleName:moduleName];
    if (notSyncedItemArray.count==0) {
        NSLog(@"不需要上传数据");
        finishedCallback(nil);
        return;
    }
    [HttpApiUtil httpSyncArray:notSyncedItemArray disPlayHud:NO itemStartSyncCallback:^(id item) {
        if (!item) {
            return ;
        }
        //同步前更新开始同步时间
        [self updateSyncing:((SyncJsonItem *)item).syncid andNextState:SYNCSTATE_GOING];
    } itemEndSyncCallback:^(id itemResponse) {
        if (!itemResponse) {
            return ;
        }
        if (isDelSynced) {
             //删除本地已经同步过的数据
            [self deleteSyncedItems:itemResponse];
        }else{
            //不删除已同步的数据,只把同步后的数据状态更新
            [self updateSyncedItems:itemResponse andNextState:SYNCSTATE_SUCCEED];
        }
    } finishedCallBack:^(id finishedResponse) {
        finishedCallback(finishedResponse);
        NSLog(@"全部更新完成%@",finishedResponse);
    }];
}

#pragma mark -计算未同步的数据总数
-(int)countNotSyncedItem:(NSString *)moduleName{
    NSString *sql=[NSString stringWithFormat:COUNT_NOTSYNCED_SQL,CYB_SYNCTABLENAME];
    __block int notSyncedCount=0;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet * rs = [db executeQuery:sql,moduleName];
        if([rs next]) {
            notSyncedCount = [rs intForColumnIndex:0];
        }
        [rs close];
    }];
    return notSyncedCount;
}


//- (NSNumber *)getNumberById:(NSString *)numberId fromTable:(NSString *)tableName {
//    NSArray * array = [self getObjectById:numberId fromTable:tableName];
//    if (array && [array isKindOfClass:[NSArray class]]) {
//        return array[0];
//    }
//    return nil;
//}


- (void)close {
    [_dbQueue close];
    _dbQueue = nil;
}

@end

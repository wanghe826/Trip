//
//  YTKKeyValueStoreUtil.m
//  reportarrival
//
//  Created by jbas on 15/2/26.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "YTKKeyValueStoreUtil.h"
#import "YTKKeyValueStore.h"
#import "CYBLoginUser.h"

#define CYBDBNAME @"cybsyncdb"
#define CYBTABLENAME @"cybtb"

#define CYBLoginUserKey @"cybloginuser"

@interface YTKKeyValueStoreUtil()

@property(strong,nonatomic) YTKKeyValueStore *store;

@end

@implementation YTKKeyValueStoreUtil

-(instancetype)init{
    self=[super init];
    if (self) {
        if (!_store) {
            _store = [[YTKKeyValueStore alloc] initDBWithName:CYBDBNAME];
            [_store createTableWithName:CYBTABLENAME];
        }
    }
    return self;
}

-(void)saveEntityToLocal:(Entity *)entity forKey:(NSString *)key{
    NSDictionary *dict=[entity toDictionary];
    [_store putObject:dict withId:key intoTable:CYBTABLENAME];
}

-(void)saveStringToLocal:(NSString *)str forKey:(NSString *)key{
    [_store putString:str withId:key intoTable:CYBTABLENAME];
}

-(NSString *)getStringFromTable:(NSString *)key{
   return [_store getStringById:key fromTable:CYBTABLENAME];
}

-(void)saveCYBLoginUser{
    CYBLoginUser *loginUser=[CYBLoginUser sharedCYBLoginUser];
    if (loginUser) {
        NSDictionary *dict=[loginUser toDictionary];
        [_store putObject:dict withId:CYBLoginUserKey intoTable:CYBTABLENAME];
    }
}

-(CYBLoginUser *)readCYBLoginUser{
    id userinfo=[_store getObjectById:CYBLoginUserKey fromTable:CYBTABLENAME];
    if (!userinfo) {
        return nil;
    }
    return [[CYBLoginUser alloc] initWithDictionary:userinfo error:nil];
}

@end

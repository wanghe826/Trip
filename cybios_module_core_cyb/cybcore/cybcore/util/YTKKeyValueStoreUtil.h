//
//  YTKKeyValueStoreUtil.h
//  reportarrival
//
//  Created by jbas on 15/2/26.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"
@class CYBLoginUser;

@interface YTKKeyValueStoreUtil : NSObject

-(void)saveEntityToLocal:(Entity *)entity forKey:(NSString *)key;

-(void)saveStringToLocal:(NSString *)str forKey:(NSString *)key;

-(NSString *)getStringFromTable:(NSString *)key;

//保存当前单例的登录用户数据
-(void)saveCYBLoginUser;

//从本地数据库获取登录用户数据
-(CYBLoginUser *)readCYBLoginUser;
@end

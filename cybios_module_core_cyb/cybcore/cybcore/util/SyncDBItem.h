//
//  SyncDBItem.h
//  reportarrival
//
//  Created by jbas on 15/3/28.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "Entity.h"

@protocol SyncDBItem @end

@interface SyncDBItem : Entity
@property (strong, nonatomic) NSString *syncid;      //同步主键syncid
@property (strong, nonatomic) NSString *psyncid;     //对应父类的syncid
@property (assign, nonatomic) int syncstate;         //当前同步状态
@property (strong, nonatomic) NSString *syncjson;    //同步json数据
@property (strong, nonatomic) NSDate *createdtime;   //创建时间
@property (strong, nonatomic) NSDate *synctime;      //同步开始时间
@end
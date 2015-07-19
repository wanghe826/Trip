//
//  Entity.m
//  Notice
//
//  Created by jbas on 15/1/12.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "Entity.h"

@implementation Entity

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

-(instancetype)init{
    self=[super init];
    if (self) {
        if (!self.syncEntity) {
            self.syncEntity=[[SyncEntity alloc]init];
        }
    }
    return self;
}

-(void)setRequestCode:(NSString *)requestCode{
    self.syncEntity.syncrequestcode=requestCode;
}

-(void)setIsDeleted:(BOOL)isDeleted{
    self.syncEntity.syncdelete=1;
}

-(BOOL)isDeleted{
    return self.syncEntity.syncdelete;
}

-(void)setMethodName:(NSString *)methodName{
    self.syncEntity.syncmethod=methodName;
}

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
        @"syncEntity.syncrequestcode": @"requestCode",
    }];
}

@end

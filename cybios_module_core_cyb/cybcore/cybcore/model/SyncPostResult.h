//
//  SyncPostResult.h
//  reportarrival
//
//  Created by jbas on 15/3/30.
//  Copyright (c) 2015年 cyb. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Entity.h"

@interface SyncPostResult : JSONModel
@property(assign,nonatomic) int ok;
@property(strong,nonatomic) NSArray *data;

@end

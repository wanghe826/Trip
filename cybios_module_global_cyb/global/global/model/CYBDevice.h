//
//  CYBDevice.h
//  global
//
//  Created by wanghe on 15-5-11.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "Entity.h"

@interface CYBDevice : Entity
@property (nonatomic,strong) NSString* _id;     //id
@property (nonatomic,strong) NSString* cid;     //提问账号
@property (nonatomic,strong) NSString* cname;        //提问人姓名
@property (nonatomic,strong) NSString* comments;      //意见内容
@end

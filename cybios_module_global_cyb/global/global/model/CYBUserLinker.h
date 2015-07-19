//
//  CYBUserLinker.h
//  global
//
//  Created by jbas on 15/5/3.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "Entity.h"

@interface CYBUserLinker : Entity
@property(strong,nonatomic) NSString *_id;        //主键
@property(strong,nonatomic) NSString *cid;        //关联帐号的cid
@property(strong,nonatomic) NSString *linkcid;    //关联帐号的cid
@property(strong,nonatomic) NSString *linkuname;  //关联帐号的姓名描述
@property(strong,nonatomic) NSString* linkaccount; //关联账号的手机号码
@property(strong,nonatomic) NSString* linkdate;      //关联账号的时间
@end

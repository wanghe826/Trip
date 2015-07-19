//
//  SmsInfo.h
//  global
//
//  Created by jbas on 15/4/18.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "Entity.h"

@interface SmsInfo : Entity
@property(strong,nonatomic) NSString *mobile;   //接收短信的手机号码
@property(strong,nonatomic) NSString *msgbody;  //接收到的短信内容(只用于测试阶段)
@property(strong,nonatomic) NSString *_id;      //对应保存在数据库中的待发短信_id值
@property(strong,nonatomic) NSString *fromdev;  //哪个终端发端的，a:表示通过android发送，i:表示通过iphone发送，w:表示通过网页发送

@end

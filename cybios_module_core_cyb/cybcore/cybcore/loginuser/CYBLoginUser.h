//
//  CYBLoginUser.h
//
//
//  Created by jbas on 15-3-24.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "JSONModel.h"

@interface CYBLoginUser : JSONModel
single_interface(CYBLoginUser)
@property(nonatomic,strong) NSString *_id;         //主键，用户主键
@property(nonatomic,strong) NSString *cybid;       //对应CYBID号,自增值,不作为主键关联
@property(nonatomic,strong) NSString *account;     //登录帐号
@property(nonatomic,strong) NSString *name;        //用户姓名
@property(nonatomic,strong) NSString *pwd;         //登录密码
@property(strong,nonatomic) NSDate *joindate;      //用户注册时间
@property(assign,nonatomic) int state;             //当前状态
@property(nonatomic,assign) int sex;               //性别,1男,2女,0未知
@property(nonatomic,strong) NSString *mobile;      //手机号码
@property(nonatomic,strong) NSString *nickname;    //昵称
@property(nonatomic,strong) NSString *desc;        //个人说明
@property(nonatomic,strong) NSString *email;       //邮箱
@property(nonatomic,strong) NSString *comments;    //备注信息
@property(nonatomic,strong) NSString *loginip;     //登录时的ip地址
@property(nonatomic,strong) NSString *loginprovince;  //登录时的省份名称
@property(nonatomic,strong) NSString *logincity;      //登录时的城市名称
@property(nonatomic,strong) NSString *sid;         //当前登录人的sid号
@property(nonatomic,strong) NSString *token;       //当前用于登录的token值
@end


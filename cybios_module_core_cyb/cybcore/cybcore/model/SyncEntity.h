//
//  SyncEntity.h
//  Notice
//
//  Created by jbas on 15/1/12.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol SyncEntity @end

@interface SyncEntity : JSONModel

@property(strong,nonatomic) NSString *synctitle;         //动作描述
@property(strong,nonatomic) NSString *syncrequestcode;   //动作标识代码syncrequestcode
@property(strong,nonatomic) NSString *_id;
@property(assign,nonatomic) int syncdelete;              //同步时是否删除此记录,数值大于0就删除此数据
@property(strong,nonatomic) NSString *syncmethod;        //同步方法名称，用于后台判断此同步方法的作用
@property(nonatomic,strong) NSString *syncid;            //同步主键值
@property(nonatomic,strong) NSString *psyncid;           //同步父类主键值
@property(assign,nonatomic) int syncstate;               //本地数据与服务器同步状态值,0:未上传，1:正在上传,2:上传成功,3:上传失败
@property(strong,nonatomic) NSString *cmodule;           //是哪个模块的数据
@property(strong,nonatomic) NSString *syncurl;           //同步数据的地址
@property(strong,nonatomic) NSString *qiniubucket;       //上传到QiNiu的Bucket名称
@end

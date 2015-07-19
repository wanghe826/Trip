//
//  Entity.h
//  Notice
//
//  Created by jbas on 15/1/12.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SyncEntity.h"
#import "JSONModel.h"

@protocol Entity @end

@interface Entity : JSONModel
@property(nonatomic,strong) NSString *cacheKey;               //本地缓存名称
@property(nonatomic,strong) SyncEntity *syncEntity;           //数据上传动作
@property(nonatomic,strong) NSMutableArray *imgurls;          //上传图片的URL数组
@property(nonatomic,strong) NSMutableArray *removedimageurls; //需要删除的图片地址数组
@property(nonatomic,strong) NSString *requestCode;            //同步操作的requestCode
@property(nonatomic,assign) BOOL isDeleted;                   //是否删除数据
@property(nonatomic,strong) NSString *createdcid;              //记录创建者
@property(nonatomic,strong) NSString *methodName;             //设置提交方法
@end

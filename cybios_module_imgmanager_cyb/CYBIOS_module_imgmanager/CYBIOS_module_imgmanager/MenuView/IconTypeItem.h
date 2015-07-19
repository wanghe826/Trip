//
//  IconTypeItem.h
//  Icon 分页显示
//
//  Created by jbas on 14/11/3.
//  Copyright (c) 2014年 cyb. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IconTypeItem @end

@interface IconTypeItem : NSObject
@property(nonatomic,strong) NSString *_id;        //主键
@property(nonatomic,strong) NSString *title;      //费用名称
@property(nonatomic,strong) NSString *imgurl;     //费用描述图标地址
@property(nonatomic,strong) NSString *comment;    //备注
@property(nonatomic,strong) NSDate *createdate;   //创建时间
@property(nonatomic,assign) int seq;              //排序号
@property(nonatomic,assign) BOOL checked;         //是否已经选中

-(instancetype)initWithTitle:(NSString *)title andImgurl:(NSString *)imgurl;
@end

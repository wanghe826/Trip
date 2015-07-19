//
//  AppGlobalConfig.h
//  global
//
//  Created by jbas on 15/4/29.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "Entity.h"

@interface AppGlobalConfig : Entity
@property(nonatomic,assign) int newcomingnotalert;          //新消息是否提醒，默认：0,需要提醒
@property(nonatomic,assign) int addfriendnotconfirm;        //加我为好友时是否需要确认，默认：0，需要确认
@property(nonatomic,assign) int chatreceivernearnotopen;    //聊天听筒模式是否打开，默认：0，打开状态
@end

//
//  GlobalApi.h
//  global
//
//  Created by jbas on 15/4/15.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "YTKRequest.h"
@class CYBLoginUser;
@class SmsInfo;
@class AppGlobalConfig;
@class CYBUserLinker;

@interface GlobalApi : YTKRequest

-(id)initWithUrlParamDict:(NSString *)apiURL withParamDict:(NSDictionary *)paramDict andUseCache:(BOOL)useCache;

-(CYBLoginUser *)fetchLoginResult;        //获取登录结果
-(SmsInfo *)fetchForgotPwdResult;         //获取忘记密码结果
-(AppGlobalConfig *)fetchAppGlobalConfig; //获取app全局配置数据

-(NSMutableArray*)fetchCybUserLinkerArray;

-(NSMutableArray*)fetchAlreadyFeedback;
-(NSMutableArray*)fetchSingleAllReply;

@end

//
//  GlobalURLs.h
//  global
//
//  Created by jbas on 15/4/15.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#ifndef GlobalURLs_h
#define GlobalURLs_h
#endif

#define GLOBALMODULENAME @"global"

#define GLOBAL_HTTP @"http://"
#define GLOBAL_HOST @"180.153.47.93"
#define GLOBAL_PORT @"2088"
#define GLOBAL_API_HOST [NSString stringWithFormat:@"%@%@:%@",GLOBAL_HTTP,GLOBAL_HOST,GLOBAL_PORT]
#define GLOBAL_SYNC [NSString stringWithFormat:@"%@/%@",GLOBAL_API_HOST,@"api_v1/sync"]
#define GLOBALQINIU_BUCKET @"cybup"

#define GLOBALPAGESIZE 10
#define GLOBALSYNC_REQUESTCODE @"globalconfig_sync"

//登录
#define URL_GLOBAL_LOGIN [NSString stringWithFormat:@"%@/%@",GLOBAL_API_HOST,@"apip_v1/cybuser/login/:account/:loginpwd"]

//找回密码
#define URL_GLOBAL_FORGOTPWD [NSString stringWithFormat:@"%@/%@",GLOBAL_API_HOST,@"apip_v1/cybuser/forgotpwd/:account"]

//校验输入的短信
#define URL_GLOBAL_VERIFYSMS [NSString stringWithFormat:@"%@/%@",GLOBAL_API_HOST,@"apip_v1/cybuser/verifysmscode/:account/:smscode"]

//获取appGlobalConfig配置数据
#define URL_GLOBAL_GLOBALCONFIG [NSString stringWithFormat:@"%@/%@",GLOBAL_API_HOST,@"api_v1/appglobalconfig"]

//获取关联帐号列表
#define URL_GLOBAL_LINKERUSER [NSString stringWithFormat:@"%@/%@",GLOBAL_API_HOST,@"api_v1/fetchlinkerusers"]

//获取反馈消息(我所提的意见)
#define URL_GLOBAL_FEEDBACK [NSString stringWithFormat:@"%@/%@", GLOBAL_API_HOST, @"/api_v1/fetchmyadvice"]
//获取反馈消息（获取某条意见的回复记录)
#define URL_GLOBAL_FEEDBACK_REPLAY [NSString stringWithFormat:@"%@/%@", GLOBAL_API_HOST, @"/api_v1/fetchadvicereply/:id"]

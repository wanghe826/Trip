//
//  TripNoteApiUrls.h
//  tripnote
//
//  Created by wanghe on 15-5-19.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#ifndef tripnote_TripNoteApiUrls_h
#define tripnote_TripNoteApiUrls_h

//
//  TRIPNOTEURLs.h
//  TRIPNOTE
//
//  Created by jbas on 15/4/15.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#ifndef TRIPNOTEURLs_h
#define TRIPNOTEURLs_h
#endif

#define TRIPNOTEMODULENAME @"TRIPNOTE"

#define TRIPNOTE_HTTP @"http://"
#define TRIPNOTE_HOST @"180.153.47.93"
#define TRIPNOTE_PORT @"5068"
#define TRIPNOTE_API_HOST [NSString stringWithFormat:@"%@%@:%@",TRIPNOTE_HTTP,TRIPNOTE_HOST,TRIPNOTE_PORT]
#define TRIPNOTE_SYNC [NSString stringWithFormat:@"%@/%@",TRIPNOTE_API_HOST,@"api_v1/sync"]
#define TRIPNOTEQINIU_BUCKET @"cybup"

#define TRIPNOTEPAGESIZE 10
#define TRIPNOTESYNC_REQUESTCODE @"TRIPNOTEconfig_sync"

//登录
#define URL_TRIPNOTE_LOGIN [NSString stringWithFormat:@"%@/%@",TRIPNOTE_API_HOST,@"apip_v1/cybuser/login/:account/:loginpwd"]

//找回密码
#define URL_TRIPNOTE_FORGOTPWD [NSString stringWithFormat:@"%@/%@",TRIPNOTE_API_HOST,@"apip_v1/cybuser/forgotpwd/:account"]

//校验输入的短信
#define URL_TRIPNOTE_VERIFYSMS [NSString stringWithFormat:@"%@/%@",TRIPNOTE_API_HOST,@"apip_v1/cybuser/verifysmscode/:account/:smscode"]

//获取appTRIPNOTEConfig配置数据
#define URL_TRIPNOTE_TRIPNOTECONFIG [NSString stringWithFormat:@"%@/%@",TRIPNOTE_API_HOST,@"api_v1/appTRIPNOTEconfig"]

//获取关联帐号列表
#define URL_TRIPNOTE_LINKERUSER [NSString stringWithFormat:@"%@/%@",TRIPNOTE_API_HOST,@"api_v1/fetchlinkerusers"]

//获取反馈消息(我所提的意见)
#define URL_TRIPNOTE_FEEDBACK [NSString stringWithFormat:@"%@/%@", TRIPNOTE_API_HOST, @"/api_v1/fetchmyadvice"]
//获取反馈消息（获取某条意见的回复记录)
#define URL_TRIPNOTE_FEEDBACK_REPLAY [NSString stringWithFormat:@"%@/%@", TRIPNOTE_API_HOST, @"/api_v1/fetchadvicereply/:id"]

//获取服务器上面的记事和图片
#define URL_TRIPNOTE_MESSAGEADNPIC [NSString stringWithFormat:@"%@/%@", TRIPNOTE_API_HOST, @"/api_v1/mytripnotes/:tripid/:page/:pagesize"]

#endif

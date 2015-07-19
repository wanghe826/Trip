//
//  SettingXLFormHelper.h
//  global
//
//  Created by wanghe on 15-4-27.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLForm.h"


@interface SettingXLFormHelper : NSObject

+(XLFormRowDescriptor*)createSetting_accountSecure;
+(XLFormRowDescriptor*)createSetting_newMsgHint;
+(XLFormRowDescriptor*)createSetting_privation;
+(XLFormRowDescriptor*)createSetting_customSet;
+(XLFormRowDescriptor*)createSetting_accountRelate;
+(XLFormRowDescriptor*)createSetting_aboutApp;
+(XLFormRowDescriptor*)createSetting_quit;

+(XLFormRowDescriptor *)createSetting_customSet_miclistener;

+(XLFormRowDescriptor*)createRow:(NSString*)tag
                        withType:(NSString*)type
                       withTitle:(NSString*)title;


+(XLFormRowDescriptor*)createSetting_oldPassword;
+(XLFormRowDescriptor*)createSetting_newPassword;
+(XLFormRowDescriptor*)createSetting_againPassword;

+(XLFormRowDescriptor*)createSetting_verify;
+(XLFormRowDescriptor*)createSetting_clearChat;
+(XLFormRowDescriptor*)createSetting_clearCache;

+(XLFormRowDescriptor*)createSetting_relateName;
+(XLFormRowDescriptor*)createSetting_relateAccount;
+(XLFormRowDescriptor*)createSetting_relateDate;
+(XLFormRowDescriptor*)createSetting_unrelate;


+(XLFormRowDescriptor*)createSetting_aboutAppTitle;
+(XLFormRowDescriptor*)createSetting_version;
+(XLFormRowDescriptor*)createSetting_upgradeLog;
+(XLFormRowDescriptor*)createSetting_giveScore;
+(XLFormRowDescriptor*)createSetting_givePoint;

+(XLFormRowDescriptor*)createSetting_addRelateAccount;
+(XLFormRowDescriptor*)createSetting_loginPwd;
+(XLFormRowDescriptor*)createSetting_confirmBtn;
+(XLFormRowDescriptor*)createSetting_forgetPwd;

+(XLFormRowDescriptor*)createFeedback_textviewRow:(NSString*)tag;
+(XLFormRowDescriptor*)createFeedback_imgSelectRow:(NSString*)tag;
+(XLFormRowDescriptor*)createFeedback_messageRow:(NSString*)msg;

+(XLFormRowDescriptor*)createMsgDetail_infoRow;
+(XLFormRowDescriptor*)createMsgDetail_picRow;
@end

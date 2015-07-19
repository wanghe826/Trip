//
//  SettingXLFormHelper.m
//  global
//
//  Created by wanghe on 15-4-27.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "SettingXLFormHelper.h"
#import "AddRelateForgetPwdView.h"
#import "UnRelateAccountView.h"
#import "TripManSelectImageCell.h"

@implementation SettingXLFormHelper

+(XLFormRowDescriptor*)createSetting_accountSecure
{
    XLFormRowDescriptor* accountSecureRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"accountSecure" rowType:XLFormRowDescriptorTypeButton title:@"账户安全"];
    accountSecureRow.action.formSegueIdenfifier = @"setToAccountSecure";
    
    accountSecureRow.value = [XLFormOptionsObject formOptionsObjectWithValue:@(6) displayText:@"可修改密码"];
    return accountSecureRow;
}
+(XLFormRowDescriptor*)createSetting_newMsgHint
{
    return [XLFormRowDescriptor formRowDescriptorWithTag:@"newMsgHint" rowType:XLFormRowDescriptorTypeBooleanSwitch title:@"新消息声音提醒"];
}
+(XLFormRowDescriptor*)createSetting_privation
{
    XLFormRowDescriptor* privationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"privation" rowType:XLFormRowDescriptorTypeButton title:@"隐私"];
    privationRow.action.formSegueIdenfifier = @"setToPrivation";
    return privationRow;
}
+(XLFormRowDescriptor*)createSetting_customSet
{
  //  XLFormRowDescriptor* row = [XLFormRowDescriptor formRowDescriptorWithTag:@"setting" rowType:XLFormRowDescriptorTypeSelectorPush title:@"通用设置"];
    
    XLFormRowDescriptor* row = [XLFormRowDescriptor formRowDescriptorWithTag:@"commonSetting" rowType:XLFormRowDescriptorTypeButton title:@"通用设置"];
    
    row.action.formSegueIdenfifier = @"setToCustomSetting";
    return row;
}
+(XLFormRowDescriptor*)createSetting_accountRelate
{
    XLFormRowDescriptor* accountRelatedRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"accountRelated" rowType:XLFormRowDescriptorTypeButton title:@"账号关联"];
    accountRelatedRow.action.formSegueIdenfifier = @"setToAccountRelate";
    accountRelatedRow.value = [XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"可关联另外手机号码"];
    return accountRelatedRow;
}
+(XLFormRowDescriptor*)createSetting_aboutApp
{
    XLFormRowDescriptor* row = [XLFormRowDescriptor formRowDescriptorWithTag:@"aboutApp" rowType:XLFormRowDescriptorTypeButton title:@"关于App"];
    row.action.formSegueIdenfifier = @"setToAboutApp";
    return row;
}

+(XLFormRowDescriptor*)createSetting_quit
{
    XLFormRowDescriptor *quit = [XLFormRowDescriptor formRowDescriptorWithTag:@"quit" rowType:XLFormRowDescriptorTypeButton title:@"账号退出"];
    [quit.cellConfigAtConfigure setObject:[UIColor colorWithRed:100.0/255.0 green:122.0/255.0 blue:100.0/255.0 alpha:0.5] forKey:@"backgroundColor"];
    return quit;
}

+(XLFormRowDescriptor *)createSetting_customSet_miclistener{
    XLFormRowDescriptor *micRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"mic" rowType:XLFormRowDescriptorTypeBooleanSwitch title:@"聊天听筒模式"];
    return micRow;
}


+(XLFormRowDescriptor*)createSetting_oldPassword
{
    return [XLFormRowDescriptor formRowDescriptorWithTag:@"oldPassword" rowType:XLFormRowDescriptorTypePassword title:@"原密码"];
}

+(XLFormRowDescriptor*)createSetting_newPassword
{
    XLFormRowDescriptor *row= [XLFormRowDescriptor formRowDescriptorWithTag:@"newPassword" rowType:XLFormRowDescriptorTypePassword title:@"新密码"];
    [row.cellConfigAtConfigure setObject:@"输入新密码" forKey:@"textField.placeholder"];
    return row;
}

+(XLFormRowDescriptor*)createSetting_againPassword
{
    XLFormRowDescriptor* row = [XLFormRowDescriptor formRowDescriptorWithTag:@"againPassword" rowType:XLFormRowDescriptorTypePassword title:@"再次输入"];
    [row.cellConfigAtConfigure setObject:@"再次输入新密码" forKey:@"textField.placeholder"];
    return row;
}

+(XLFormRowDescriptor*)createSetting_verify
{
    return [XLFormRowDescriptor formRowDescriptorWithTag:@"verify" rowType:XLFormRowDescriptorTypeBooleanSwitch title:@"加我为好友需要验证"];
}
+(XLFormRowDescriptor*)createSetting_clearChat
{
    return [XLFormRowDescriptor formRowDescriptorWithTag:@"clearChat" rowType:XLFormRowDescriptorTypeButton title:@"清楚所有聊天记录"];
}
+(XLFormRowDescriptor*)createSetting_clearCache
{
    return [XLFormRowDescriptor formRowDescriptorWithTag:@"clearCache" rowType:XLFormRowDescriptorTypeButton title:@"清楚所有缓存数据"];
}


+(XLFormRowDescriptor*)createSetting_aboutAppTitle
{
    XLFormRowDescriptor* row = [XLFormRowDescriptor formRowDescriptorWithTag:@"aboutApp" rowType:XLFormRowDescriptorTypeText title:@"关于App"];
    return row;
}

+(XLFormRowDescriptor*)createSetting_version
{
    XLFormRowDescriptor* row = [XLFormRowDescriptor formRowDescriptorWithTag:@"version" rowType:XLFormRowDescriptorTypeButton title:@"已是最新版本"];
//    [row.cellConfig setObject:@(NSTextAlignmentLeft) forKey:@"textLabel.textAlignment"];
    return row;
}
+(XLFormRowDescriptor*)createSetting_upgradeLog
{
    XLFormRowDescriptor* row = [XLFormRowDescriptor formRowDescriptorWithTag:@"upgradeLog" rowType:XLFormRowDescriptorTypeButton title:@"更新日志"];
    row.value = [XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"看看有什么新的内容"];
    return row;
}
+(XLFormRowDescriptor*)createSetting_giveScore
{
    return [XLFormRowDescriptor formRowDescriptorWithTag:@"giveScore" rowType:XLFormRowDescriptorTypeButton title:@"去评分"];
}
+(XLFormRowDescriptor*)createSetting_givePoint
{
    XLFormRowDescriptor* row = [XLFormRowDescriptor formRowDescriptorWithTag:@"givePoint" rowType:XLFormRowDescriptorTypeButton title:@"给我们提点意见"];
    row.action.formSegueIdenfifier = @"about2feedback";
    return row;
}


+(XLFormRowDescriptor*)createSetting_relateName
{
    XLFormRowDescriptor* row = [XLFormRowDescriptor formRowDescriptorWithTag:@"relateName" rowType:XLFormRowDescriptorTypeInfo title:@"姓名"];
//    row.value = [XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"张天一"];
    row.value = @"张天一";
    return row;
}

+(XLFormRowDescriptor*)createSetting_relateAccount
{
    XLFormRowDescriptor* row = [XLFormRowDescriptor formRowDescriptorWithTag:@"relateAccount" rowType:XLFormRowDescriptorTypeInfo title:@"关联的账号"];
    row.value = @"1377777777";
    return row;
}
+(XLFormRowDescriptor*)createSetting_relateDate
{
    XLFormRowDescriptor* row = [XLFormRowDescriptor formRowDescriptorWithTag:@"relateDate" rowType:XLFormRowDescriptorTypeInfo title:@"关联的时间"];
    row.value = [NSString stringWithFormat:@"%@",[NSDate date]];
    return row;
}
+(XLFormRowDescriptor*)createSetting_unrelate
{
    XLFormRowDescriptor* row = [XLFormRowDescriptor formRowDescriptorWithTag:@"unrelate" rowType:XLFormRowDescriptorTypeUnRelateAccount title:@"解除关联"];
    return row;
}

+(XLFormRowDescriptor*)createSetting_addRelateAccount
{
    XLFormRowDescriptor* row = [XLFormRowDescriptor formRowDescriptorWithTag:@"addRelateAccount" rowType:XLFormRowDescriptorTypePhone title:@"要关联的手机号"];
    return row;
}
+(XLFormRowDescriptor*)createSetting_loginPwd
{
    XLFormRowDescriptor* row = [XLFormRowDescriptor formRowDescriptorWithTag:@"loginPwd" rowType:XLFormRowDescriptorTypePassword title:@"登录密码"];
    return row;
}

+(XLFormRowDescriptor*)createSetting_confirmBtn
{
    return [XLFormRowDescriptor formRowDescriptorWithTag:@"confirm" rowType:XLFormRowDescriptorTypeButton title:@"确定"];
}

+(XLFormRowDescriptor*)createSetting_forgetPwd
{
//    XLFormRowDescriptor* row = [XLFormRowDescriptor formRowDescriptorWithTag:@"forgetPwd" rowType:XLFormRowDescriptorType title:@"忘记登录密码?"];
    XLFormRowDescriptor* row = [XLFormRowDescriptor formRowDescriptorWithTag:@"forgetPwd" rowType:XLFormRowDescriptorTypeAddRelateForgetPwd];
    return row;
}

+(XLFormRowDescriptor*)createFeedback_textviewRow:(NSString*)tag
{
    XLFormRowDescriptor* row = [XLFormRowDescriptor formRowDescriptorWithTag:tag rowType:XLFormRowDescriptorTypeTextView title:nil];
    [row.cellConfigAtConfigure setObject:@"请填写你的意见" forKey:@"textView.placeholder"];
    return row;
}

+(XLFormRowDescriptor*)createFeedback_imgSelectRow:(NSString*)tag
{
    XLFormRowDescriptor* row = [XLFormRowDescriptor formRowDescriptorWithTag:tag rowType:XLFormRowDescriptorTypeSelectImage];
    return row;
}

+(XLFormRowDescriptor*)createFeedback_messageRow:(NSString*)msg
{
    XLFormRowDescriptor* row = [XLFormRowDescriptor formRowDescriptorWithTag:msg rowType:XLFormRowDescriptorTypeInfo title:msg];
//    row.action.formSegueIdenfifier = @"feedback2detail";
    return row;
}


+(XLFormRowDescriptor*)createMsgDetail_infoRow
{
    XLFormRowDescriptor* row = [XLFormRowDescriptor formRowDescriptorWithTag:@"messageinfo" rowType:XLFormRowDescriptorTypeInfo title:nil];
    return row;
}
+(XLFormRowDescriptor*)createMsgDetail_picRow
{
    XLFormRowDescriptor* row = [XLFormRowDescriptor formRowDescriptorWithTag:@"msgdetailpicrow" rowType:XLFormRowDescriptorTypeSelectImage title:nil];
    return row;
}

@end

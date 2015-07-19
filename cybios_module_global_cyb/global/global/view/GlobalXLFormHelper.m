//
//  GlobalXLFormHelper.m
//  global
//
//  Created by jbas on 15/4/19.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "GlobalXLFormHelper.h"
#import "LoginFooterView.h"


@implementation GlobalXLFormHelper

//手机号码
+(XLFormRowDescriptor *)createLogin_PhoneRow{
     return [XLFormRowDescriptor formRowDescriptorWithTag:@"phone" rowType:XLFormRowDescriptorTypePhone title:@"手机号码"];
}

//密码
+(XLFormRowDescriptor *)createLogin_PasswordRow{
    XLFormRowDescriptor *xl_password = [XLFormRowDescriptor formRowDescriptorWithTag:@"password" rowType:XLFormRowDescriptorTypePassword title:nil];
    [xl_password.cellConfigAtConfigure setObject:@"请输入密码" forKey:@"textField.placeholder"];
    return xl_password;
}

//登录按钮
+(XLFormRowDescriptor *)createLogin_LoginBtnRow{
    XLFormRowDescriptor *xl_login = [XLFormRowDescriptor formRowDescriptorWithTag:@"login" rowType:XLFormRowDescriptorTypeButton title:@"登录"];
    [xl_login.cellConfigAtConfigure setObject:[UIColor colorWithRed:100.0/255.0 green:122.0/255.0 blue:100.0/255.0 alpha:0.5] forKey:@"backgroundColor"];
    return xl_login;
}

//注册和登录遇到问题界面
+(XLFormRowDescriptor *)createLogin_LoginFooterRow{
    return [XLFormRowDescriptor formRowDescriptorWithTag:@"loginFooter" rowType:XLFormRowDescriptorTypeLoginFooter];
}

@end

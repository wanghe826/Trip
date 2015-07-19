//
//  AccountSecureViewController.m
//  global
//
//  Created by wanghe on 15-4-28.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "AccountSecureViewController.h"
#import "SettingXLFormHelper.h"
#import "AppUtil.h"
#import "UpdatePwdModel.h"
#import "GlobalApi.h"
#import "GlobalURLs.h"
#import "CYBLoginUser.h"
#import "HttpApiUtil.h"
@interface AccountSecureViewController ()
{
    UpdatePwdModel* _pwdModel;
    CYBLoginUser* _loginUser;
}
- (IBAction)commitUpdatePwd:(id)sender;
@property (nonatomic,strong) XLFormRowDescriptor* oldPassword;
@property (nonatomic,strong) XLFormRowDescriptor* nicePassword;
@property (nonatomic,strong) XLFormRowDescriptor* againPassword;
@end

@implementation AccountSecureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _pwdModel = [[UpdatePwdModel alloc] init];
    _loginUser = [CYBLoginUser sharedCYBLoginUser];
}


- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeForm];
    }
    return self;
}

- (id)init{
    self = [super init];
    if (self){
        [self initializeForm];
    }
    return self;
}


-(void)initializeForm{
    XLFormDescriptor* form = [XLFormDescriptor formDescriptor];
    
    XLFormSectionDescriptor* sec = [XLFormSectionDescriptor formSection];
    _oldPassword = [SettingXLFormHelper createSetting_oldPassword];
    [sec addFormRow:_oldPassword];
    
    _nicePassword = [SettingXLFormHelper createSetting_newPassword];
    [sec addFormRow:_nicePassword];
    
    _againPassword = [SettingXLFormHelper createSetting_againPassword];
    [sec addFormRow:_againPassword];
    
    [form addFormSection:sec];
    self.form = form;
}


-(BOOL)collectData{
    _pwdModel.oldpwd=_oldPassword.value;
    _pwdModel.pwd=_nicePassword.value;
    NSString *againPwd=_againPassword.value;
    if (![_pwdModel.pwd isEqualToString:againPwd]) {
        [AppUtil showAlert:@"两次输入的密码不相同"];
        return NO;
    }
    if (_pwdModel.oldpwd.length==0) {
        [AppUtil showAlert:@"请输入原密码!"];
        return NO;
    }
    if (_pwdModel.pwd.length==0) {
        [AppUtil showAlert:@"请输入新密码!"];
        return NO;
    }
    return YES;
}

- (IBAction)commitUpdatePwd:(id)sender
{
    if (![self collectData]) {
        return;
    }
    
    [HttpApiUtil httpSync:_pwdModel disPlayHud:NO finishedCallBack:^(id responseJSON)
    {
        NSLog(@"saved%@",responseJSON);
    }];
}
@end

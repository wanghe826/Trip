//
//  LoginViewController.m
//  global
//
//  Created by kunge on 15/4/16.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "LoginViewController.h"
#import <XLForm.h>
#import <YTKNetwork/YTKRequest.h>
#import "GlobalApi.h"
#import "GlobalURLs.h"
#import "CYBLoginUser.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "ForgetViewController.h"
#import "AppUtil.h"
#import "GlobalConfigViewController.h"
#import "LoginFooterView.h"
#import "GlobalXLFormHelper.h"
#import "YTKKeyValueStoreUtil.h"


@interface LoginViewController (){
    YTKKeyValueStoreUtil *_storeUtil;
}

@property (strong,nonatomic)XLFormRowDescriptor *xl_phone;
@property (strong,nonatomic)XLFormRowDescriptor *xl_password;
@property (strong,nonatomic)XLFormRowDescriptor *xl_login;
@property (strong,nonatomic)XLFormRowDescriptor *xl_footer;
@property (strong,nonatomic)CYBLoginUser *cybLoginUser;
@end

@implementation LoginViewController


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeForm];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self){
        [self initializeForm];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _storeUtil=[[YTKKeyValueStoreUtil alloc]init];
    _cybLoginUser=[_storeUtil readCYBLoginUser];
    if (_cybLoginUser) {
        _xl_phone.value=_cybLoginUser.mobile;
    }
}


-(void)initializeForm
{
    XLFormDescriptor * formDescriptor = [XLFormDescriptor formDescriptorWithTitle:@"使用手机号码登录"];
    XLFormSectionDescriptor * section;
    
    formDescriptor.assignFirstResponderOnShow = YES;
    
    // Basic Information - Section
    section = [XLFormSectionDescriptor formSectionWithTitle:nil];
    [formDescriptor addFormSection:section];
    
    
    // Phone
    _xl_phone = [GlobalXLFormHelper createLogin_PhoneRow];
    [section addFormRow:_xl_phone];
    
    // Password
    _xl_password=[GlobalXLFormHelper createLogin_PasswordRow];
    [section addFormRow:_xl_password];
    
    //登录
    _xl_login=[GlobalXLFormHelper createLogin_LoginBtnRow];
    _xl_login.action.formSelector = @selector(loginButton);
    [section addFormRow:_xl_login];
    
    //新注册和登录遇到问题
    _xl_footer=[GlobalXLFormHelper createLogin_LoginFooterRow];
    [section addFormRow:_xl_footer];
    
    self.form = formDescriptor;
}

//收集界面上填写的数据
-(BOOL)collectData{
    if(!_cybLoginUser){
        _cybLoginUser = [CYBLoginUser sharedCYBLoginUser];
    }
    _cybLoginUser.pwd = _xl_password.value;
    _cybLoginUser.mobile = _xl_phone.value;
    if (_cybLoginUser.pwd.length==0 ) {
        [AppUtil showAlert:@"请输入密码."];
        return NO;
    }
    if (_cybLoginUser.mobile.length==0) {
        [AppUtil showAlert:@"手机号码不能为空."];
        return NO;
    }
    return YES;
}

-(void)loginButton
{
    [self doLogin];
    [self deselectFormRow:_xl_login];
}

-(void)doLogin{
    if (![self collectData]) {
        return; 
    }
    
    NSMutableDictionary *paramDict = [[NSMutableDictionary alloc] init];
    [paramDict setObject:_cybLoginUser.mobile forKey:@"account"];
    [paramDict setObject:_cybLoginUser.pwd forKey:@"loginpwd"];
    GlobalApi *globalApi = [[GlobalApi alloc] initWithUrlParamDict:URL_GLOBAL_LOGIN withParamDict:paramDict andUseCache:NO];
    [globalApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        _cybLoginUser=[globalApi fetchLoginResult];
        if (!_cybLoginUser) {
            [AppUtil showAlert:@"用户名或密码不正确，请重新输入."];
        }else{
            _cybLoginUser.pwd=nil;
            [_storeUtil saveCYBLoginUser];  //保存登录用户信息到本地数据库
            [self performSegueWithIdentifier:@"login2config" sender:nil];
        }
    } failure:^(YTKBaseRequest *request) {
        [AppUtil showAppError];
        NSLog(@"login Error.");
    }];
     
}


@end

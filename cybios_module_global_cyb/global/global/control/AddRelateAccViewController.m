//
//  AddRelateAccViewController.m
//  global
//
//  Created by wanghe on 15-5-3.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "AddRelateAccViewController.h"
#import "SettingXLFormHelper.h"
#import "AppUtil.h"
#import "CYBUserLinker.h"
#import "CYBLoginUser.h"
#import "GlobalApi.h"
#import "GlobalURLs.h"
#import "HttpApiUtil.h"

@interface AddRelateAccViewController ()
@property (strong,nonatomic) XLFormRowDescriptor* addAcount;
@property (strong,nonatomic) XLFormRowDescriptor* loginPwd;
@property (strong,nonatomic) XLFormRowDescriptor* confirmBtn;
@property (strong,nonatomic) XLFormRowDescriptor* forgetPwd;

@property (strong,nonatomic) CYBUserLinker* linker;
@property (strong,nonatomic) CYBLoginUser* loginUser;

@end

@implementation AddRelateAccViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加关联手机号";
    _linker = [[CYBUserLinker alloc] init];
    _loginUser = [[CYBLoginUser alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

- (void)initializeForm
{
    XLFormDescriptor* form = [XLFormDescriptor formDescriptor];
    XLFormSectionDescriptor* sec = [XLFormSectionDescriptor formSection];
    _addAcount = [SettingXLFormHelper createSetting_addRelateAccount];
    [sec addFormRow:_addAcount];
    _loginPwd = [SettingXLFormHelper createSetting_loginPwd];
    [sec addFormRow:_loginPwd];
    
    _confirmBtn = [SettingXLFormHelper createSetting_confirmBtn];
    [sec addFormRow:_confirmBtn];
    
    _forgetPwd = [SettingXLFormHelper createSetting_forgetPwd];
    [sec addFormRow:_forgetPwd];

    [form addFormSection:sec];
    self.form = form;
}


//收集界面上填写的数据
-(BOOL)collectData{
    _loginUser.mobile = _addAcount.value;
    _loginUser.pwd = _loginPwd.value;
    if(!_loginUser.mobile){
        [AppUtil showAlert:@"手机号码不能为空."];
        return FALSE;
    }
    if(!_loginUser.pwd  || _loginUser.pwd.length==0){
        [AppUtil showAlert:@"请输入密码."];
        return FALSE;
    }
    else if (_loginUser.mobile.length != 11)
    {
        [AppUtil showAlert:@"请输入正确的手机号码."];
        return FALSE;
    }
    return TRUE;
}

-(void)didSelectFormRow:(XLFormRowDescriptor *)formRow
{
    if([formRow.tag isEqualToString:@"confirm"]){
        if([self collectData])
        {
            [self checkAccountAndCommit];
        }
    }
}


-(void)checkAccountAndCommit
{
    NSMutableDictionary *paramDict = [[NSMutableDictionary alloc] init];
    [paramDict setObject:_loginUser.mobile forKey:@"account"];
    [paramDict setObject:_loginUser.pwd forKey:@"loginpwd"];
    GlobalApi *globalApi = [[GlobalApi alloc] initWithUrlParamDict:URL_GLOBAL_LOGIN withParamDict:paramDict andUseCache:NO];
    [globalApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        _loginUser=[globalApi fetchLoginResult];
        if (!_loginUser) {
            [AppUtil showAlert:@"用户名或密码不正确，请重新输入."];
        }else{
            _linker.linkcid = _loginUser._id;
            _linker.linkuname = _loginUser.name;
            [HttpApiUtil httpSync:_linker disPlayHud:YES finishedCallBack:^(id responseJSON)
            {
                NSLog(@"saved%@",responseJSON);
//                [self performSegueWithIdentifier:@"add2RelateList" sender:nil];
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
    } failure:^(YTKBaseRequest *request) {
        [AppUtil showAppError];
    }];
}
@end

/*
1
{
    "mobile" : "13189264927",
    "name" : "3334",
    "pwd" : "1",
}

2
{
    "pwd" : "1",
    "mobile" : "18968291577",
    "name" : "李一44",
}

3
{
    "mobile" : "2",
    "name" : "李2",
    "pwd" : "2",
}

4
{
    "mobile" : "18968291565",
    "name" : "张11",
    "pwd" : "7375",
}

5
{
    "mobile" : "1",
    "name" : "之一2",
    "pwd" : "1",
}

6
{
    "mobile" : "13586532995",
    "name" : "胡1",
    "pwd" : "1234"
}
 
 */

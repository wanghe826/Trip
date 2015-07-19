//
//  GlobalConfigViewController.m
//  global
//
//  Created by jbas on 15/4/19.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "GlobalConfigViewController.h"
#import "CYBLoginUser.h"
#import "XLForm.h"
#import "SettingXLFormHelper.h"
#import "GlobalApi.h"
#import "GlobalURLs.h"
#import "AppUtil.h"
#import "AppGlobalConfig.h"
#import "HttpApiUtil.h"

@interface GlobalConfigViewController (){
    AppGlobalConfig *_appGlobalConfig;
}
@property (strong, nonatomic) XLFormRowDescriptor* accountSecureRow;
@property (strong, nonatomic) XLFormRowDescriptor* msgHintRow;
@property (strong, nonatomic) XLFormRowDescriptor* privationRow;
@property (strong, nonatomic) XLFormRowDescriptor* customSetRow;
@property (strong, nonatomic) XLFormRowDescriptor* accountRelateRow;
@property (strong, nonatomic) XLFormRowDescriptor* aboutAppRow;
@property (strong, nonatomic) XLFormRowDescriptor* quitRow;
@end


@implementation GlobalConfigViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getGlobalConfig];
}

-(void)getGlobalConfig{
    GlobalApi *globalApi = [[GlobalApi alloc] initWithUrlParamDict:URL_GLOBAL_GLOBALCONFIG withParamDict:nil andUseCache:NO];
    [globalApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        _appGlobalConfig=[globalApi fetchAppGlobalConfig];
        if (_appGlobalConfig) {
            if (_appGlobalConfig.newcomingnotalert==0) {
                _msgHintRow.value=@NO;
            }else{
                _msgHintRow.value=@YES;
            }
            [self reloadFormRow:_msgHintRow];
        }
    } failure:^(YTKBaseRequest *request) {
        [AppUtil showAppError];
        NSLog(@"getGlobalConfig Error.");
    }];
}

-(void) initializeForm{
    XLFormDescriptor* formDescForm = [XLFormDescriptor formDescriptorWithTitle:@"配置"];
    
    XLFormSectionDescriptor* sec1 = [XLFormSectionDescriptor formSection];
    _accountSecureRow = [SettingXLFormHelper createSetting_accountSecure];
    _msgHintRow = [SettingXLFormHelper createSetting_newMsgHint];
    _privationRow = [SettingXLFormHelper createSetting_privation];
    _customSetRow = [SettingXLFormHelper createSetting_customSet];
    [sec1 addFormRow:_accountSecureRow];
    [sec1 addFormRow:_msgHintRow];
    [sec1 addFormRow:_privationRow];
    [sec1 addFormRow:_customSetRow];
    [formDescForm addFormSection:sec1];
    
    XLFormSectionDescriptor* sec2 = [XLFormSectionDescriptor formSection];
    _accountRelateRow = [SettingXLFormHelper createSetting_accountRelate];
    [sec2 addFormRow:_accountRelateRow];
    [formDescForm addFormSection:sec2];
    
    XLFormSectionDescriptor* sec3 = [XLFormSectionDescriptor formSection];
    _aboutAppRow = [SettingXLFormHelper createSetting_aboutApp];
    [sec3 addFormRow:_aboutAppRow];
    [formDescForm addFormSection:sec3];
    
    XLFormSectionDescriptor* sec4 = [XLFormSectionDescriptor formSection];
    _quitRow = [SettingXLFormHelper createSetting_quit];
    [sec4 addFormRow:_quitRow];
    [formDescForm addFormSection:sec4];
    
    
    self.form = formDescForm;
}

-(void)formRowDescriptorValueHasChanged:(XLFormRowDescriptor *)formRow oldValue:(id)oldValue newValue:(id)newValue
{
    if([formRow.tag isEqualToString:@"newMsgHint"])
    {
        AppGlobalConfig *appGlobalConfig=[[AppGlobalConfig alloc]init];
        int open;
        NSString *b=[NSString stringWithFormat:@"%@",newValue];
        if ([b isEqualToString:@"0"]) {
            open=0;
        }else{
            open=1;
        }
        appGlobalConfig.newcomingnotalert=open;
        [HttpApiUtil httpSync:appGlobalConfig disPlayHud:NO finishedCallBack:^(id responseJSON) {
            NSLog(@"saved=%@",responseJSON);
        }];
        
    }
}


@end

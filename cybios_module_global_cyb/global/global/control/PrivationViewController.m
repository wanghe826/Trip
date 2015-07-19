//
//  PrivationViewController.m
//  global
//
//  Created by wanghe on 15-4-28.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "PrivationViewController.h"
#import "XLForm.h"
#import "SettingXLFormHelper.h"
#import "GlobalApi.h"
#import "AppGlobalConfig.h"
#import "HttpApiUtil.h"
#import "AppUtil.h"
#import "GlobalURLs.h"

@interface PrivationViewController ()
{
    AppGlobalConfig* _globalConfig;
}
@property (strong,nonatomic) XLFormRowDescriptor* verifyRow;
@property (strong,nonatomic) XLFormRowDescriptor* clearChatRecord;
@property (strong,nonatomic) XLFormRowDescriptor* clearAllCache;
@end

@implementation PrivationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"隐私";
    [self getGlobConfig];
}

- (void)getGlobConfig
{
    GlobalApi *globalApi = [[GlobalApi alloc] initWithUrlParamDict:URL_GLOBAL_GLOBALCONFIG withParamDict:nil andUseCache:NO];
    [globalApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        _globalConfig=[globalApi fetchAppGlobalConfig];
        if (_globalConfig) {
            if (_globalConfig.addfriendnotconfirm==0) {
                _verifyRow.value=@NO;
            }else{
                _verifyRow.value=@YES;
            }
            [self reloadFormRow:_verifyRow];
        }
    } failure:^(YTKBaseRequest *request) {
        [AppUtil showAppError];
        NSLog(@"getGlobalConfig Error.");
    }];
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

-(void) initializeForm
{
    XLFormDescriptor* form = [XLFormDescriptor formDescriptor];
    
    XLFormSectionDescriptor* sec1 = [XLFormSectionDescriptor formSection];
    _verifyRow = [SettingXLFormHelper createSetting_verify];
    [sec1 addFormRow:_verifyRow];
    
    XLFormSectionDescriptor* sec2 = [XLFormSectionDescriptor formSection];
    _clearChatRecord = [SettingXLFormHelper createSetting_clearChat];
    [sec2 addFormRow:_clearChatRecord];
    
    _clearAllCache = [SettingXLFormHelper createSetting_clearCache];
    [sec2 addFormRow:_clearAllCache];
    [form addFormSection:sec1];
    [form addFormSection:sec2];
    self.form = form;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void) formRowDescriptorValueHasChanged:(XLFormRowDescriptor *)formRow oldValue:(id)oldValue newValue:(id)newValue
{
    if([formRow.tag isEqualToString:@"verify"])
    {
        AppGlobalConfig *appGlobalConfig=[[AppGlobalConfig alloc]init];
        int open;
        NSString *b=[NSString stringWithFormat:@"%@",newValue];
        if ([b isEqualToString:@"0"]) {
            open=0;
        }else{
            open=1;
        }
        appGlobalConfig.addfriendnotconfirm=open;
        [HttpApiUtil httpSync:appGlobalConfig disPlayHud:NO finishedCallBack:^(id responseJSON) {
            NSLog(@"saved=%@",responseJSON);
        }];
    }
}

@end

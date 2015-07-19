//
//  CustomSettingViewController.m
//  global
//
//  Created by wanghe on 15-4-28.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "CustomSettingViewController.h"
#import "XLForm.h"
#import "HttpApiUtil.h"
#import "AppGlobalConfig.h"
#import "SettingXLFormHelper.h"
#import "GlobalURLs.h"
#import "GlobalApi.h"
#import "AppGlobalConfig.h"
#import "AppUtil.h"

@interface CustomSettingViewController()
{
    AppGlobalConfig* _globalConfig;
}

@property (nonatomic,strong) XLFormRowDescriptor* micRow;
@end

@implementation CustomSettingViewController

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
    [self getGlobalConfig];
}
- (void) getGlobalConfig
{
    GlobalApi *globalApi = [[GlobalApi alloc] initWithUrlParamDict:URL_GLOBAL_GLOBALCONFIG withParamDict:nil andUseCache:NO];
    [globalApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        _globalConfig=[globalApi fetchAppGlobalConfig];
        if (_globalConfig) {
            if (_globalConfig.chatreceivernearnotopen==0) {
                _micRow.value=@NO;
            }else{
                _micRow.value=@YES;
            }
            [self reloadFormRow:_micRow];
        }
    } failure:^(YTKBaseRequest *request) {
        [AppUtil showAppError];
    }];
}

-(void) initializeForm{
    XLFormDescriptor* form = [XLFormDescriptor formDescriptor];
    XLFormSectionDescriptor* sec = [XLFormSectionDescriptor formSection];
    _micRow=[SettingXLFormHelper createSetting_customSet_miclistener];
    [sec addFormRow:_micRow];
    [form addFormSection:sec];
    self.form = form;
}


-(void)formRowDescriptorValueHasChanged:(XLFormRowDescriptor *)formRow oldValue:(id)oldValue newValue:(id)newValue{
    if ([formRow.tag isEqualToString:@"mic"]) {
        AppGlobalConfig *appGlobalConfig=[[AppGlobalConfig alloc]init];
        int open;
        NSString *b=[NSString stringWithFormat:@"%@",newValue];
        if ([b isEqualToString:@"0"]) {
            open=0;
        }else{
            open=1;
        }
        appGlobalConfig.chatreceivernearnotopen=open;
        [HttpApiUtil httpSync:appGlobalConfig disPlayHud:NO finishedCallBack:^(id responseJSON) {
            NSLog(@"saved=%@",responseJSON);
        }];
    }
}

@end

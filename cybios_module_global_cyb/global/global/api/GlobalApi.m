//
//  GlobalApi.m
//  global
//
//  Created by jbas on 15/4/15.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "GlobalApi.h"
#import "AppUtil.h"
#import "YTKAnimatingRequestAccessory.h"
#import "StringUtil.h"
#import "SmsInfo.h"
#import "CYBLoginUser.h"
#import "GlobalURLs.h"
#import "AppGlobalConfig.h"
#import "CYBUserLinker.h"
#import "CYBDevice.h"
#import "CYBAdviceReply.h"

@interface GlobalApi(){
    NSDictionary *_paramDict;
    NSString *_apiURL;
}
@end

@implementation GlobalApi

-(id)initWithUrlParamDict:(NSString *)apiURL withParamDict:(NSDictionary *)paramDict andUseCache:(BOOL)useCache{
    self = [super init];
    if (self) {
        _paramDict = paramDict;
    }
    _apiURL = apiURL;
    self.ignoreCache =! useCache;
    [self addAccessory:[YTKAnimatingRequestAccessory accessoryWithAnimatingText:nil]];
    return self;
}

-(NSString *)requestUrl{
    NSString *apiurl = [AppUtil createApiURL:_apiURL params:_paramDict];
    return apiurl;
}

-(NSInteger)cacheTimeInSeconds{
    return NSIntegerMax;
}

-(NSDictionary *)requestHeaderFieldValueDictionary{
    NSString *sid=[CYBLoginUser sharedCYBLoginUser].sid;
    if (!sid) {
        return nil;
    }
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObject:sid forKey:@"sid"];
    if ([_apiURL isEqualToString:URL_GLOBAL_LOGIN]) {
        if (_paramDict.count==0) { //表示自动登录的，需要设置header头中的token
            NSString *token=[CYBLoginUser sharedCYBLoginUser].token;
            if (token) {
                [dict setValue:token forKey:@"token"];
            }
        }
    }
    return dict;
}


-(CYBLoginUser *)fetchLoginResult{
    id responseJSON = [self responseJSONObject];
    CYBLoginUser *user=nil;
    if (responseJSON) {
        user = [[CYBLoginUser alloc] initWithDictionary:responseJSON error:nil];
    }
    return user;
}

-(SmsInfo *)fetchForgotPwdResult{
    id responseJSON= [self responseJSONObject];
    SmsInfo *smsInfo;
    if (responseJSON) {
        smsInfo = [[SmsInfo alloc] initWithDictionary:responseJSON error:nil];
    }
    return smsInfo;
}

-(AppGlobalConfig *)fetchAppGlobalConfig{
    id responseJSON = [self responseJSONObject];
    AppGlobalConfig *appGlobalConfig=nil;
    if (responseJSON) {
        appGlobalConfig = [[AppGlobalConfig alloc] initWithDictionary:responseJSON error:nil];
    }
    return appGlobalConfig;
}

-(NSMutableArray*)fetchCybUserLinkerArray
{
    id responseJSON = [self responseJSONObject];
    NSMutableArray* linkerArray = nil;
    if(responseJSON)
    {
        linkerArray = [CYBUserLinker arrayOfModelsFromDictionaries:responseJSON];
    }
    return linkerArray;
}

-(NSMutableArray*)fetchAlreadyFeedback
{
    id responseJSON = [self responseJSONObject];
    NSLog(@"打印---》%@",responseJSON);
    NSMutableArray* feedbackArr = nil;
    if(responseJSON)
    {
        feedbackArr = [CYBDevice arrayOfModelsFromDictionaries:responseJSON];
    }
    return feedbackArr;
}

-(NSMutableArray*)fetchSingleAllReply
{
    id responseJSON = [self responseJSONObject];
    NSLog(@"打印---》%@",responseJSON);
    NSMutableArray* feedbackArr = nil;
    if(responseJSON)
    {
        feedbackArr = [CYBAdviceReply arrayOfModelsFromDictionaries:responseJSON];
    }
    return feedbackArr;
}

@end

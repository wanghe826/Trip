//
//  TripnoteApi.m
//  tripnote
//
//  Created by wanghe on 15-5-19.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "TripnoteApi.h"
#import "AppUtil.h"
#import "YTKAnimatingRequestAccessory.h"
#import "SecNoteCellModel.h"

@implementation TripnoteApi{
    NSDictionary *_paramDict;
    NSString *_apiURL;
}

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


-(NSMutableArray*)fetchNote
{
    id responseJSON = [self responseJSONObject];
    NSMutableArray* feedbackArr = nil;
    if(responseJSON)
    {
        feedbackArr = [SecNoteCellModel arrayOfModelsFromDictionaries:responseJSON];
    }
    return feedbackArr;
}

@end

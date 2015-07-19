//
//  TripnoteApi.h
//  tripnote
//
//  Created by wanghe on 15-5-19.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "YTKRequest.h"

@interface TripnoteApi : YTKRequest

-(id)initWithUrlParamDict:(NSString *)apiURL withParamDict:(NSDictionary *)paramDict andUseCache:(BOOL)useCache;
-(NSMutableArray*)fetchNote;
@end

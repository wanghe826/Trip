//
//  YTKAnimatingRequestAccessory.m
//  notice
//
//  Created by jbas on 15/2/2.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "YTKAnimatingRequestAccessory.h"
#import "HUD.h"


@implementation YTKAnimatingRequestAccessory

-(id)initWithAnimatingText:(NSString *)animatingText{
    self=[super init];
    if (self) {
        _animatingText=animatingText;
    }
    return self;
}

+(id)accessoryWithAnimatingText:(NSString *)animatingText{
    return [[self alloc]initWithAnimatingText:animatingText];
}

- (void)requestWillStart:(id)request {
        [HUD showUIBlockingIndicator];
}

- (void)requestWillStop:(id)request {
        [HUD hideUIBlockingIndicator];
}

@end
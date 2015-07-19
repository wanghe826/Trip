//
//  YTKAnimatingRequestAccessory.h
//  notice
//
//  Created by jbas on 15/2/2.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTKRequest.h"

@interface YTKAnimatingRequestAccessory : NSObject <YTKRequestAccessory>

@property(nonatomic, strong) NSString *animatingText;

- (id)initWithAnimatingText:(NSString *)animatingText;

+ (id)accessoryWithAnimatingText:(NSString *)animatingText;


@end

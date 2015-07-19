//
//  NSString+Helper.m
//  reportarrival
//
//  Created by jbas on 15/5/3.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "NSString+Helper.h"

static NSDateFormatter *inputFormatter;

@implementation NSString (Helper)

-(NSString *)parseDate:(NSString *)formatter{
    if (!inputFormatter) {
        inputFormatter=[[NSDateFormatter alloc]init];
        [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    NSDate *inputDate = [inputFormatter dateFromString:self];
    
    NSDateFormatter *cformat=[[NSDateFormatter alloc]init];
    [cformat setDateFormat:formatter];
    
    NSString *result=[cformat stringFromDate:inputDate];
    return result;
}

@end

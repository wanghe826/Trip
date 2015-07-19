//
//  StringUtil.h
//  CYBIOS_module_cost
//
//  Created by jbas on 15/2/6.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface StringUtil : NSObject

+(NSString *)parseShortDate:(NSString *)date;

+(NSString *)parseFriendlyDate:(NSString *)dateString;

+(CGFloat)calcStringHeight:(NSString *)content withFontSize:(int)fontSize withpadding:(int) padding;

+(CGFloat)calcStringWidth:(NSString *)content withFontSize:(int)fontSize withpadding:(int) padding;

+(NSString *)nullToEmpty:(NSString *)val;

+(NSString *)nowDate;

+(BOOL)isStandardId:(NSString *)idstring;

+(NSString *)nillToEmpty:(NSString *)string;

+(NSString *)dictToJsonString:(NSMutableDictionary *)dict;
@end

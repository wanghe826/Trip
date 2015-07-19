//
//  StringUtil.m
//  CYBIOS_module_cost
//
//  Created by jbas on 15/2/6.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "StringUtil.h"
#import <UIKit/UIKit.h>

@implementation StringUtil

+(NSString *)parseShortDate:(NSString *)date{
    NSString *st= [date substringToIndex:10];
    return st;
}

+(NSString *)parseFriendlyDate:(NSString *)dateString{
    NSDateFormatter *inputFormatter=[[NSDateFormatter alloc]init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* inputDate = [inputFormatter dateFromString:dateString];
    
    NSDateFormatter *cformat=[[NSDateFormatter alloc]init];
    [cformat setDateFormat:@"HH"];
    NSString *strhh=[cformat stringFromDate:inputDate];    //小时
    [cformat setDateFormat:@"mm"];
    NSString *strmm = [cformat stringFromDate:inputDate];  //分
    [cformat setDateFormat:@"ss"];
    NSString *strss = [cformat stringFromDate:inputDate];  //秒
    
    NSInteger timeInterval = -[inputDate timeIntervalSinceNow];
    if (timeInterval < 3600) { //1小时内
        return [NSString stringWithFormat:@"%@'%@\"",strmm,strss];
    } else {
        return [NSString stringWithFormat:@"%@:%@",strhh,strmm];
    }
}

+(CGFloat)calcStringHeight:(NSString *)content withFontSize:(int)fontSize withpadding:(int)padding{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15.0] , NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    CGFloat ct =screenSize.width - padding;
    CGSize labelSize = [content boundingRectWithSize:CGSizeMake(ct, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    labelSize.height = ceil(labelSize.height);
    labelSize.width = ceil(labelSize.width);
    return labelSize.height;
}

+(CGFloat)calcStringWidth:(NSString *)content withFontSize:(int)fontSize withpadding:(int)padding{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15.0] , NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    CGFloat ct =screenSize.width - padding;
    CGSize labelSize = [content boundingRectWithSize:CGSizeMake(ct, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    labelSize.height = ceil(labelSize.height);
    labelSize.width = ceil(labelSize.width);
    return labelSize.width;
}

+(NSString *)nullToEmpty:(NSString *)val{
    NSString *result=val;
    if (!result) {
        result=@"";
    }
    return result;
}

+(NSString *)nillToEmpty:(NSString *)string{
    if (string == nil || string == NULL) {
        return @"";
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return @"";
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return @"";
    }
    return string;
}

+(NSString *)nowDate{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *datestr = [formatter stringFromDate:[NSDate date]];
    return datestr;
}

+(BOOL)isStandardId:(NSString *)idstring{
    if (idstring.length==24) {
        return YES;
    }
    return NO;
}

+(NSString *)dictToJsonString:(NSMutableDictionary *)dict{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

@end

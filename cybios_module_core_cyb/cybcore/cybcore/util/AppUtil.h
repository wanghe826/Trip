//
//  AppUtil.h
//  notice
//
//  Created by jbas on 15/1/27.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIView,UITableViewCell,UIViewController;

@interface AppUtil : NSObject

#pragma mark 根据url及参数格式化URL
+(NSString *) createApiURL:(NSString *) p_url params:(NSDictionary *)params;


+ (void)alertWithTitle:(NSString *)title message:(NSString *)message cancelButtonWithTitle:(NSString *)cancelTitle cancelBlock:(void (^)())cancelblock confirmButtonWithTitle:(NSString *)confirmTitle confrimBlock:(void (^)())confirmBlock;

+(void)showAlert:(NSString *)alertText;

+(void)showAppError;

+(void)appendBottomLine:(UITableViewCell *)tableViewCell andVivider:(UIView *)divider;

+(void)reLayoutBottomLine:(UITableViewCell *)tableViewCell andVivider:(UIView *)divider;

+(void)callPhone:(UIViewController *)controller andTelephone:(NSString *)telephone;

+(NSString *)getDeviceId;

+(NSString *)getErrCodeDesc:(NSString *)errCode;

@end

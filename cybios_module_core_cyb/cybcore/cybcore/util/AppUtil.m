//
//  AppUtil.m
//  notice
//
//  Created by jbas on 15/1/27.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "AppUtil.h"
#import <UIKit/UIKit.h>
#import "BlockAlertView.h"

@implementation AppUtil


+(NSString *)createApiURL:(NSString *)p_url params:(NSDictionary *)params{
    if(!params){
        return p_url;
    }
    NSMutableString *originUrl=[[NSMutableString alloc]initWithString:p_url];
    NSString *apiparam=nil;
    NSRange foundRange;
    NSMutableArray *needtoremove=[[NSMutableArray alloc]init];
    NSString *ritem=nil;
    for (NSString* key in [[params allKeys] sortedArrayUsingSelector:@selector(compare:)]) {
        apiparam=[NSString stringWithFormat:@":%@",[key lowercaseString]];
        foundRange = [originUrl rangeOfString:apiparam];
        if(foundRange.location != NSNotFound){
            ritem=[NSString stringWithFormat:@"%@",params[key]];
            [originUrl replaceCharactersInRange:foundRange withString:ritem];
            [needtoremove addObject:key];
        }
    }
    NSMutableDictionary *appendDict=[[NSMutableDictionary alloc]initWithDictionary:params];
    [appendDict removeObjectsForKeys:needtoremove];
    NSMutableString *url=[[NSMutableString alloc]initWithString:originUrl];
    if (appendDict.count>0) {
        [url appendString:@"?"];
    }
    for (NSString* key in [[appendDict allKeys] sortedArrayUsingSelector:@selector(compare:)]) {
        [url appendFormat:@"&%@=%@&", key, appendDict[key]];
    }
    if ([url hasSuffix:@"&"]) {
        url = [[NSMutableString alloc] initWithString: [url substringToIndex: url.length-1]];
    }
    return url;
}

+(void)alertWithTitle:(NSString *)title message:(NSString *)message cancelButtonWithTitle:(NSString *)cancelTitle cancelBlock:(void (^)())cancelblock confirmButtonWithTitle:(NSString *)confirmTitle confrimBlock:(void (^)())confirmBlock{
    
    [BlockAlertView alertWithTitle:title message:message cancelButtonWithTitle:cancelTitle cancelBlock:cancelblock confirmButtonWithTitle:confirmTitle confrimBlock:confirmBlock];

}

+(void)showAlert:(NSString *)alertText{
    [[[UIAlertView alloc] initWithTitle:@"提示"
                                message:alertText
                               delegate:nil
                      cancelButtonTitle:@"关闭"
                      otherButtonTitles:nil] show];
}

+(void)showAppError{
    [self showAlert:@"网络未连接，请检查！"];
}


+(void)appendBottomLine:(UITableViewCell *)tableViewCell andVivider:(UIView *)divider{
    UIView *bottomLineView=[[UIView alloc]init];
    bottomLineView.backgroundColor=[UIColor darkGrayColor];
    bottomLineView.alpha=0.3;
    [tableViewCell.contentView addSubview:bottomLineView];
    divider=bottomLineView;
//    
//    UIView *bottomLineView=[[UIView alloc]init];
//    bottomLineView.backgroundColor=[UIColor darkGrayColor];
//    bottomLineView.alpha=0.3;
//    [self.contentView addSubview:bottomLineView];
//    self.divider=bottomLineView;

    
}

+(void)reLayoutBottomLine:(UITableViewCell *)tableViewCell andVivider:(UIView *)divider{
    CGFloat x=0;
    CGFloat h=1;
    CGFloat w=tableViewCell.frame.size.width;     // self.frame.size.width;
    CGFloat y=tableViewCell.frame.size.height-h;  //<#int *#> self.frame.size.height -h;
    divider.frame=CGRectMake(x, y, w, h);
}

+(void)callPhone:(UIViewController *)controller andTelephone:(NSString *)telephone{
    if (telephone.length!=11) {
        return;
    }
    UIWebView *callWebview =[[UIWebView alloc] init];
    NSString *tel=[NSString stringWithFormat:@"tel:%@",telephone];
    NSURL *telURL =[NSURL URLWithString:tel];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [controller.view addSubview:callWebview];
}

//获取设备唯一识别码
+(NSString *)getDeviceId{
    UIDevice *device = [UIDevice currentDevice];//创建设备对象
    NSUUID *UUID = [device identifierForVendor];
    NSString *deviceID = [UUID UUIDString];
    deviceID = [deviceID stringByReplacingOccurrencesOfString:@"-" withString:@""];
    deviceID = [NSString stringWithFormat:@"O%@",deviceID];
    return deviceID;
}

//根据错误代码返回错误描述信息
+(NSString *)getErrCodeDesc:(NSString *)errCode{
    if ([errCode isEqualToString:@"0"]) {
        return @"操作成功";
    }
    if ([errCode isEqualToString:@"1"]){
        return @"操作异常";
    }
    if ([errCode isEqualToString:@"2"]){
        return @"校验失败";
    }
    if ([errCode isEqualToString:@"3"]){
        return @"记录不存在";
    }
    if ([errCode isEqualToString:@"4"]){
        return @"记录已存在";
    }
    if ([errCode isEqualToString:@"5"]){
        return @"无需执行操作";
    }
    if ([errCode isEqualToString:@"6"]){
        return @"内部系统api调用异常";
    }
    if ([errCode isEqualToString:@"7"]){
        return @"外部系统api调用异常";
    }
    if ([errCode isEqualToString:@"11"]){
        return @"记录重复删除";
    }
    if ([errCode isEqualToString:@"21"]){
        return @"验证码错误";
    }
    if ([errCode isEqualToString:@"22"]){
        return @"用户名或密码错误";
    }
    if ([errCode isEqualToString:@"23"]){
        return @"设置密码不符合规范";
    }
    if ([errCode isEqualToString:@"24"]){
        return @"session失效";
    }
    if ([errCode isEqualToString:@"25"]){
        return @"session被踢";
    }
    if ([errCode isEqualToString:@"26"]){
        return @"用户没有权限";
    }
    return @"未知错误";
}

@end

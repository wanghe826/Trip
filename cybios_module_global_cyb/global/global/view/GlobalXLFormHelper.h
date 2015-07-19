//
//  GlobalXLFormHelper.h
//  global
//
//  Created by jbas on 15/4/19.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLForm.h"

@interface GlobalXLFormHelper : NSObject

+(XLFormRowDescriptor *)createLogin_PhoneRow;
+(XLFormRowDescriptor *)createLogin_PasswordRow;
+(XLFormRowDescriptor *)createLogin_LoginBtnRow;
+(XLFormRowDescriptor *)createLogin_LoginFooterRow;
@end

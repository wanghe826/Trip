//
//  AddRelateForgetPwdView.m
//  global
//
//  Created by wanghe on 15-5-5.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "AddRelateForgetPwdView.h"

NSString * const XLFormRowDescriptorTypeAddRelateForgetPwd = @"XLFormRowDescriptorTypeAddRelateForgetPwd";

@implementation AddRelateForgetPwdView

+(void)load{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:NSStringFromClass([AddRelateForgetPwdView class]) forKey:XLFormRowDescriptorTypeAddRelateForgetPwd];
}

-(void)configure{
    [super configure];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
}

- (IBAction)forgetPwd:(id)sender {
    [self.formViewController performSegueWithIdentifier:@"add2forget" sender:nil];
}
@end

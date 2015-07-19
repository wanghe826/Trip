//
//  LoginFooterView.m
//  global
//
//  Created by jbas on 15/4/19.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "LoginFooterView.h"

@implementation LoginFooterView

NSString * const XLFormRowDescriptorTypeLoginFooter = @"XLFormRowDescriptorTypeLoginFooter";

+(void)load{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:NSStringFromClass([LoginFooterView class]) forKey:XLFormRowDescriptorTypeLoginFooter];
}

-(void)configure{
    [super configure];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
}


- (IBAction)doSignup:(id)sender {
    [self.formViewController performSegueWithIdentifier:@"login2Signup" sender:nil];
}

- (IBAction)forgotPwd:(id)sender {
    [self.formViewController performSegueWithIdentifier:@"LoginToForget" sender:nil];
}


@end

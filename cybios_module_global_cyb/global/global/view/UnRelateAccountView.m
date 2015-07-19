//
//  UnRelateAccountView.m
//  global
//
//  Created by wanghe on 15-5-5.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "UnRelateAccountView.h"
NSString * const XLFormRowDescriptorTypeUnRelateAccount = @"XLFormRowDescriptorTypeUnRelateAccount";
@implementation UnRelateAccountView


+(void)load{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:NSStringFromClass([UnRelateAccountView class]) forKey:XLFormRowDescriptorTypeUnRelateAccount];
}

-(void)configure{
    [super configure];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
}

- (IBAction)unRelateAccount:(id)sender {
}
@end

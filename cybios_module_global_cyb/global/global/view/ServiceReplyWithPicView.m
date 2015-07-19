//
//  ServiceReplyWithPicView.m
//  global
//
//  Created by wanghe on 15-5-12.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "ServiceReplyWithPicView.h"
NSString * const XLFormRowDescriptorTypeSerReplyWithPic = @"XLFormRowDescriptorTypeSerReplyWithPic";
@implementation ServiceReplyWithPicView


+(void)load{
    
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:NSStringFromClass([ServiceReplyWithPicView class]) forKey:XLFormRowDescriptorTypeSerReplyWithPic];
}

-(void)configure{
    [super configure];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
}

-(void)update
{
    [super update];
}

+(CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor{
    return 150.0f;
}

@end

//
//  ServiceReplyWithPicView.h
//  global
//
//  Created by wanghe on 15-5-12.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "XLFormRowDescriptor.h"

extern NSString * const XLFormRowDescriptorTypeSerReplyWithPic;

@interface ServiceReplyWithPicView : XLFormBaseCell
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UILabel *service;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UILabel *serComments;
@end

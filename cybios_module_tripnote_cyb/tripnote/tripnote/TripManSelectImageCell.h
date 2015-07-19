//
//  TripManSelectImageCell.h
//  tripman
//
//  Created by jack on 15/5/2.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLFormBaseCell.h"

extern NSString * const XLFormRowDescriptorTypeSelectImage;

@interface TripManSelectImageCell : XLFormBaseCell
-(NSMutableArray *) getToUploadImageArray;  //待上传的图片列表
@end

//
//  upLoadImage.h
//  Notice
//
//  Created by apple on 15/1/20.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UpLoadImage : NSObject
@property(nonatomic)BOOL isUpload;
@property(nonatomic)BOOL isRemove;
@property(nonatomic,strong)NSString* url;
@property(nonatomic,strong)UIImage* image;
@end

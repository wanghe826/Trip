//
//  IconTypeItem.m
//  cost
//
//  Created by jbas on 14/11/3.
//  Copyright (c) 2014年 cyb. All rights reserved.
//

#import "IconTypeItem.h"

@implementation IconTypeItem

-(instancetype)initWithTitle:(NSString *)title andImgurl:(NSString *)imgurl{
    self=[super init];
    if (self) {
        _title=title;
        _imgurl=imgurl;
    }
    return self;
}

@end

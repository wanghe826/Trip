//
//  MenuItem.m
//  CYBIOS_module_imgmanager
//
//  Created by zhangbo on 15-3-12.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "MenuItem.h"

@implementation MenuItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       _title = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height-20,frame.size.width,20)];
        [self addSubview:_title];
        _title.adjustsFontSizeToFitWidth = YES;
        _title.font =[UIFont systemFontOfSize:10];
        _title.textAlignment = NSTextAlignmentCenter;
        
        _icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 4, frame.size.width-20, frame.size.height-2-20)];
        _icon.image = [UIImage imageNamed:@"unknown_icon.png"];
        [self addSubview:_icon];
        
        _selected = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width-22, 2, 20, 20)];
        _selected.image = [UIImage imageNamed:@"kakalib_url_white.png"];
        [self addSubview:_selected];
    }
    return self;
}
@end

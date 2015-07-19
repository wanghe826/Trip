//
//  MenuItem.h
//  CYBIOS_module_imgmanager
//
//  Created by zhangbo on 15-3-12.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuItem : UIView

@property (nonatomic,strong) UILabel *title;
@property (nonatomic,strong) UIImageView *icon;
@property (nonatomic,strong) UIImageView *selected;
@end

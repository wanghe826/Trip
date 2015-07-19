//
//  CYBViewDetailViewController.h
//
//  Created by jack on 15/5/14.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "XLFormViewController.h"


typedef void (^SubImageDetailBlock)();

@interface CYBViewDetailViewController : XLFormViewController
@property(nonatomic,strong)NSString *displayText;
@property(nonatomic,strong)NSArray *dispalyImageURLs;

@property (copy, nonatomic) SubImageDetailBlock requestDataBlock;
- (void)reloadFormView;

@end

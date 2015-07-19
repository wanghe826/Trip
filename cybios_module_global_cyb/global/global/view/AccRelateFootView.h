//
//  AccRelateFootView.h
//  global
//
//  Created by wanghe on 15-5-4.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Push2AddRelate <NSObject>

- (void) push2Add;

@end


@interface AccRelateFootView : UIView

+(instancetype) accRelateFootView;
- (IBAction)push2AddRelate:(id)sender;

@property (nonatomic,strong) id<Push2AddRelate> delegate;
@end

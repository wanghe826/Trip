//
//  AccRelateFootView.m
//  global
//
//  Created by wanghe on 15-5-4.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "AccRelateFootView.h"

@implementation AccRelateFootView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype) accRelateFootView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"AccRelateFootView" owner:nil options:nil] lastObject];
}

- (IBAction)push2AddRelate:(id)sender {
    if(self.delegate != nil)
    {
        [self.delegate push2Add];
    }
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //添加新的关联账号
    if(self.delegate != nil)
    {
        [self.delegate push2Add];
    }
}

@end

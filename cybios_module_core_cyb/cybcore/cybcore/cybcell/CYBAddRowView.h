//
//  CYBAddRowView.h
//  global
//
//  Created by jbas on 15/5/15.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CBYAddRowBlock)();

@interface CYBAddRowView : UIView

+(CYBAddRowView *)rowView:(NSString *)title;

+(CYBAddRowView *)rowView:(NSString *)title andImgName:(NSString *)imgName;

@property(strong,nonatomic) CBYAddRowBlock clickBtnBlock;

@end

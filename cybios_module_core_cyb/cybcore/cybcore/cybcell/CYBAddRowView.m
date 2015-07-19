//
//  CYBAddRowView.m
//  global
//
//  Created by jbas on 15/5/15.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "CYBAddRowView.h"

@interface CYBAddRowView(){
    
}
@property (strong, nonatomic) IBOutlet UIButton *rowBtn;

@end

@implementation CYBAddRowView

+(CYBAddRowView *)rowView:(NSString *)title{
    CYBAddRowView *view=[[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CYBAddRowView class]) owner:nil options:nil] lastObject];
    [view.rowBtn setTitle:title forState:UIControlStateNormal];
    return view;
}

+(CYBAddRowView *)rowView:(NSString *)title andImgName:(NSString *)imgName{
    CYBAddRowView *view=[[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CYBAddRowView class]) owner:nil options:nil] lastObject];
    [view.rowBtn setTitle:title forState:UIControlStateNormal];
    [view.rowBtn.imageView setImage:[UIImage imageNamed:imgName]];
    return view;
}

- (IBAction)rowBtnClick:(id)sender {
    if (_clickBtnBlock) {
        _clickBtnBlock();
    }
}


@end

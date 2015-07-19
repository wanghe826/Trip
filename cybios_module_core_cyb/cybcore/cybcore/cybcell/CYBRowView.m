//
//  CYBRowView.m
//  reportarrival
//
//  Created by jbas on 15/4/28.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "CYBRowView.h"
#import "CYBCellModel.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

@interface CYBRowView()
@property (strong, nonatomic) IBOutlet UIImageView *rowImageView;
@property (strong, nonatomic) IBOutlet UIButton *leftTitleBtn;
@property (strong, nonatomic) IBOutlet UILabel *leftTitleDescLabel;
@property (strong, nonatomic) IBOutlet UIButton *rightValueBtn;
@property (strong, nonatomic) IBOutlet UILabel *rightDescLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *leftTitleBtnTopConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *rightValueBtnTopConstraint;
//@property (strong, nonatomic) IBOutlet NSLayoutConstraint *leftTitleDescLabelWidthConstraint;
//@property (strong, nonatomic) IBOutlet NSLayoutConstraint *rightValueDeseWidthConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *rowImageViewWidthConstraint;

@end

//static const CGFloat KDefaultDescWidth = 113.0;           //默认的左边和左边的DescLabel的宽度
static const CGFloat KDefaultRowImageWidth=55.0;          //默认的RowImage的宽度

@implementation CYBRowView

+(instancetype)cybRowView{
    CYBRowView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CYBRowView class]) owner:nil options:nil] lastObject];
    return view;
}

-(void)setCybCellModel:(CYBCellModel *)cybCellModel{
    _cybCellModel=cybCellModel;
    if (_cybCellModel.titleSubText.length==0) { //左边无TitleSub文字时，要把整个TitleButton居中显示
        [self removeConstraint:_leftTitleBtnTopConstraint];
    //    _leftTitleDescLabelWidthConstraint.constant=0;
    }else{
        [self addConstraint:_leftTitleBtnTopConstraint];
     //   _leftTitleDescLabelWidthConstraint.constant=KDefaultDescWidth;
    }
    
    if (_cybCellModel.valueSubText.length==0) { //右边无ValueSub文字时，要把整个ValueButton居中显示
  //      [self removeConstraint:_rightValueBtnTopConstraint];
   //     _rightValueDeseWidthConstraint.constant=0;
    }else{
        [self addConstraint:_rightValueBtnTopConstraint];
   //     _rightValueDeseWidthConstraint.constant=KDefaultDescWidth;
    }
    
    if (_cybCellModel.cellImagePath.length==0) { //无图片显示
        _rowImageViewWidthConstraint.constant=0;
    }else{
        _rowImageViewWidthConstraint.constant=KDefaultRowImageWidth;
    }
    
    [_leftTitleBtn setTitle:_cybCellModel.title forState:UIControlStateNormal];
    _leftTitleDescLabel.text=_cybCellModel.titleSubText;
    //设置右边文字属性值
    [_rightValueBtn setTitle:_cybCellModel.value forState:UIControlStateNormal];
    
    _rightDescLabel.text=_cybCellModel.valueSubText;
    
    // 设置图片属性值
    [self setLocalImageOrUrlImage:_cybCellModel];
}

//设置图片信息
-(void)setLocalImageOrUrlImage:(CYBCellModel *)cybCellModel{
    if (cybCellModel.cellImagePath) {   //设置Cell的图片
        if ([cybCellModel.cellImagePath hasPrefix:@"http"]) { //表示是网络图片
            [self.rowImageView sd_setImageWithURL:[NSURL URLWithString:cybCellModel.cellImagePath]];
        }else{
            [self.rowImageView setImage:[UIImage imageNamed:cybCellModel.cellImagePath]];
        }
    }else{
        [self.rowImageView setImage:nil];
    }
    if (cybCellModel.titleImagePath) { //设置标题中的图片
        if ([cybCellModel.titleImagePath hasPrefix:@"http"]) { //表示是网络图片
            [_leftTitleBtn sd_setImageWithURL:[NSURL URLWithString:cybCellModel.titleImagePath] forState:UIControlStateNormal];
        }else{
            [_leftTitleBtn setImage:[UIImage imageNamed:cybCellModel.titleImagePath] forState:UIControlStateNormal];
        }
    }else{
        [_leftTitleBtn setImage:nil forState:UIControlStateNormal];
    }
    if (cybCellModel.valueImagePath) { //设置Value中的图片
        if ([cybCellModel.valueImagePath hasPrefix:@"http"]) { //表示是网络图片
            [_rightValueBtn sd_setImageWithURL:[NSURL URLWithString:cybCellModel.valueImagePath] forState:UIControlStateNormal];
        }else{
            [_rightValueBtn setImage:[UIImage imageNamed:cybCellModel.valueImagePath] forState:UIControlStateNormal];
        }
    }else{
        [_rightValueBtn setImage:nil forState:UIControlStateNormal];
    }
}

@end

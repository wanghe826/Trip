//
//  CYBRowView.m
//  reportarrival
//
//  Created by jbas on 15/4/28.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "CYBXLFormCell.h"
#import "CYBCellModel.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

@interface CYBXLFormCell()
@property (strong, nonatomic) IBOutlet UIImageView *rowImageView;
@property (strong, nonatomic) IBOutlet UIButton *leftTitleBtn;
@property (strong, nonatomic) IBOutlet UILabel *leftTitleDescLabel;
@property (strong, nonatomic) IBOutlet UIButton *rightValueBtn;
@property (strong, nonatomic) IBOutlet UILabel *rightDescLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *leftTitleBtnTopConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *rightValueBtnTopConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *rowImageViewWidthConstraint;

@end

////static const CGFloat KDefaultDescWidth = 113.0;           //默认的左边和左边的DescLabel的宽度
static const CGFloat KDefaultRowImageWidth=55.0;          //默认的RowImage的宽度

@implementation CYBXLFormCell

//NSString * const XLFormRowDescriptorTypeCYBCell = @"XLFormRowDescriptorTypeCYBCell";
//
//+(void)load{
//    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:NSStringFromClass([CYBXLFormCell class]) forKey:XLFormRowDescriptorTypeCYBCell];
//}

-(void)configure{
    [super configure];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
}

-(void)setCybCellModel:(CYBCellModel *)cybCellModel{
    _cybCellModel=cybCellModel;
    if (_cybCellModel.titleSubText.length==0) { //左边无TitleSub文字时，要把整个TitleButton居中显示
        [self removeConstraint:_leftTitleBtnTopConstraint];
    }else{
        [self addConstraint:_leftTitleBtnTopConstraint];
    }
    
    if (_cybCellModel.valueSubText.length==0) { //右边无ValueSub文字时，要把整个ValueButton居中显示
        [self removeConstraint:_rightValueBtnTopConstraint];
    }else{
        [self addConstraint:_rightValueBtnTopConstraint];
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
    
    if (_cybCellModel.didClickCell) {
        _leftTitleBtn.userInteractionEnabled=NO;
        _rightValueBtn.userInteractionEnabled=NO;
    }else{
        _leftTitleBtn.userInteractionEnabled=YES;
        _rightValueBtn.userInteractionEnabled=YES;
    }
    
    if (_cybCellModel.didClickLeftBtn) {
        _leftTitleBtn.userInteractionEnabled=YES;
    }else{
        _leftTitleBtn.userInteractionEnabled=NO;
    }
    
    if (_cybCellModel.didClickRightBtn) {
        _rightValueBtn.userInteractionEnabled=YES;
    }else{
        _rightValueBtn.userInteractionEnabled=NO;
    }

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

+(CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor{
    return 48.0f;
}

-(void)setRowDescriptor:(XLFormRowDescriptor *)rowDescriptor{
    self.cybCellModel=rowDescriptor.value;
}

- (IBAction)leftBtnActionClick:(id)sender {
    if (_cybCellModel.didClickLeftBtn) {
        _cybCellModel.didClickLeftBtn();
    }else{
        _leftTitleBtn.userInteractionEnabled=NO;
    }
}

- (IBAction)rightBtnActionClick:(id)sender {
    if (_cybCellModel.didClickRightBtn) {
        _cybCellModel.didClickRightBtn();
    }else{
        _rightValueBtn.userInteractionEnabled=NO;
    }
}

-(void)formDescriptorCellDidSelectedWithFormController:(XLFormViewController *)controller{
    if (_cybCellModel.didClickCell) {
        _cybCellModel.didClickCell();
    }
}

@end

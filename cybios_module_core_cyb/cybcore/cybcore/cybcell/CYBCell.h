//
//  CYBCell.h
//  cybCell
//
//  Created by wxl on 15/3/25.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYBCellModel.h"
#import "XLFormBaseCell.h"

//typedef NS_OPTIONS(NSUInteger, CYBCellStyle) {
//    CYBCellStyleNone            = 0,
//    CYBCellStyleLeftTitle       = 1 << 0,
//    CYBCellStyleRightValue      = 1 << 1,
//    CYBCellStyleLeftSubTitle    = 1 << 2,
//    CYBCellStyleRightSubValue   = 1 << 3,
//    CYBCellStyleXLFormCell      = 1 << 4
//};

extern NSString * const XLFormRowDescriptorTypeCYBCell;

@protocol CYBCellDidClickDelegate <NSObject>
@optional
-(void)didClickLeftTitleBtn:(CYBCellModel *)cybCellModel;
-(void)didClickRightValueBtn:(CYBCellModel *)cybCellModel;

@end

@interface CYBCell : XLFormBaseCell
@property (strong, nonatomic) CYBCellModel *cellModel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
+ (CGFloat) getCellHeightWithCybModel:(CYBCellModel *)cybCellModel;
@property (assign, nonatomic) int leftTitleDescLines; //左边titleSubLabel的lines值，默认值1
@property (assign, nonatomic) int rightValueDescLines;//右边valueSubLabel的lines值，默认值1
@property (strong, nonatomic) id<CYBCellDidClickDelegate> delegate;
@end

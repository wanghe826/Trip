//
//  CYBRowView.h
//  reportarrival
//
//  Created by jbas on 15/4/28.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLFormBaseCell.h"
@class CYBCellModel;

extern NSString * const XLFormRowDescriptorTypeCYBCell;

@interface CYBXLFormCell : XLFormBaseCell

@property(strong,nonatomic)CYBCellModel *cybCellModel;
@end

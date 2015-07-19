//
//  CYBRowView.h
//  reportarrival
//
//  Created by jbas on 15/4/28.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYBCellModel;

@interface CYBRowView : UIView

@property(strong,nonatomic)CYBCellModel *cybCellModel;

+(instancetype)cybRowView;

@end

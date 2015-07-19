//
//  CYBCellModel.h
//  CYBIOS_module_imgmanager
//
//  Created by jbas on 15/4/23.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CYBCellModel;

typedef NS_OPTIONS(NSUInteger, CYBCellStyle) {
    CYBCellStyleNone            = 0,
    CYBCellStyleLeftTitle       = 1 << 0,
    CYBCellStyleRightValue      = 1 << 1,
    CYBCellStyleLeftSubTitle    = 1 << 2,
    CYBCellStyleRightSubValue   = 1 << 3,
    CYBCellStyleXLFormCell      = 1 << 4
};

typedef void (^CYBCellDidClick)();

@interface CYBCellModel : NSObject
@property (strong, nonatomic) NSIndexPath *indexPath;           //对应section和row的值
@property (strong, nonatomic) NSString *title;                  //左边的标题
@property (strong, nonatomic) NSString *titleSubText;           //左边标题下方文字
@property (strong, nonatomic) NSString *titleImagePath;         //左边标题的本地图片名字或网络图片URL
@property (strong, nonatomic) NSString *value;                  //右边显示的值
@property (strong, nonatomic) NSString *valueSubText;           //右边显示的值下方的文字
@property (strong, nonatomic) NSString *valueImagePath;         //右边显示的本地图片名字或网络图片URL
@property (strong, nonatomic) NSString *cellImagePath;          //Cell自带图片名字或网络图片URL
@property (assign, nonatomic) NSString *cellImageBadgeText;     //cellImagePath图片上展示的Badge内容
@property (strong, nonatomic) CYBCellDidClick didClickLeftBtn;  //点击左边按钮后的事件
@property (strong, nonatomic) CYBCellDidClick didClickRightBtn; //点击右边按钮后的事件
//点击Cell后的事件，如果设置了此值，则didClickLeftBtn,didClickRightBtn都无效
@property (strong, nonatomic) CYBCellDidClick didClickCell;
@property (assign, nonatomic) CYBCellStyle cellStyle;
@end

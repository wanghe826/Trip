//
//  MenuView.h
//  MenuViewDemo
//
//  Created by zhangbo on 15/3/12.
//  Copyright (c) 2015年 zhangbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuViewDelegate <NSObject>

- (void)menuViewDidSelected:(int) index;

@end

@interface MenuView : UIView
@property (weak,nonatomic) id<MenuViewDelegate> delegate;
- (void)initMenuViewWithData:(NSArray *)array;
@end

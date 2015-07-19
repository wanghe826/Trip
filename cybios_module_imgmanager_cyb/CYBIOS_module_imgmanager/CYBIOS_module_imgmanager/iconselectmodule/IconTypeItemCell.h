//
//  IconTypeItemCell.h
//
//  Created by jbas on 15/2/8.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IconTypeItem,IconTypeItemCell;

@protocol IconTypeItemCellDelegate <NSObject>

-(void)didSelectedButton:(IconTypeItemCell *)iconTypeItemCell selectedIconType:(IconTypeItem *) selectedIconType;

@end

@interface IconTypeItemCell : UICollectionViewCell

@property(nonatomic,strong) IconTypeItem *iconTypeItem;

@property(strong,nonatomic) id<IconTypeItemCellDelegate> delegate;
@end

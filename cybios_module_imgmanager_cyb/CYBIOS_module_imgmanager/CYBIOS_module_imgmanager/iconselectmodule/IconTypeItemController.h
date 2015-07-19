//
//  IconTypeItemController.h
//
//  Created by jbas on 15/2/7.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconTypeItem.h"

@interface IconTypeItemController : UICollectionViewController

-(instancetype)initWithCollectionView:(UICollectionView *)collectionView;

-(void)setDataSource:(NSArray *)dataSource;

-(IconTypeItem *)getSelectedTypeItem;

@end

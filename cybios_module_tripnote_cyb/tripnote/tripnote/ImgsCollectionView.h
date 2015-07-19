//
//  ImgsCollectionView.h
//  trip
//
//  Created by jbas on 15/2/15.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImgsCollectionView : UICollectionView

+(instancetype)collectionView;

-(void)setImgsArray:(NSMutableArray *)imgsArray withViewController:(UIViewController *)viewController;

@end

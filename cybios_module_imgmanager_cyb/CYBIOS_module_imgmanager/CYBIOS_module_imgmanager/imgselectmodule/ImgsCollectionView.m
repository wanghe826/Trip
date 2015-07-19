//
//  ImgsCollectionView.m
//  trip
//
//  Created by jbas on 15/2/15.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "ImgsCollectionView.h"
#import "ImageCollectionViewController.h"

@interface ImgsCollectionView(){
    NSMutableArray *_imgsArray;
}

@property (strong, nonatomic) ImageCollectionViewController *imageCollectionViewController;

@end


@implementation ImgsCollectionView

+(instancetype)collectionView{
     return [[[NSBundle mainBundle]loadNibNamed:@"ImgsCollectionView" owner:nil options:nil]lastObject];
}

-(void)setImgsArray:(NSMutableArray *)imgsArray withViewController:(UIViewController *)viewController{
    _imgsArray=imgsArray;
    _imageCollectionViewController=[[ImageCollectionViewController alloc]initWithCollectionView:self showPlus:NO showDelete:NO andUploadServer:NO andQiNiuBucket:nil];
    
//    _imageCollectionViewController=[[ImageCollectionViewController alloc]initWithCollectionView:self showPlus:NO showDelete:NO andUploadServer:NO];
    [_imageCollectionViewController setDataSource:_imgsArray andSuperC:viewController];
}

@end

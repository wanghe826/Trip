//
//  TripManSelectImageCell.m
//  tripman
//
//  Created by jack on 15/5/2.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "TripManSelectImageCell.h"
#import "ImgsCollectionView.h"
#import "ImageCollectionViewController.h"
NSString * const XLFormRowDescriptorTypeSelectImage = @"XLFormRowDescriptorTypeSelectImage";

@interface TripManSelectImageCell()

@property (strong, nonatomic) ImageCollectionViewController *imageCollectionViewController;
@property (strong, nonatomic) UICollectionView *collectionView;

@end


@implementation TripManSelectImageCell

+(void)load{
    
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:NSStringFromClass([TripManSelectImageCell class]) forKey:XLFormRowDescriptorTypeSelectImage];
    
    
}

-(void)configure{
    [super configure];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    _collectionView.backgroundColor = [UIColor whiteColor];
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        flowLayout.itemSize = CGSizeMake(100, 100);
//        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.minimumInteritemSpacing = 0.0f;
        flowLayout.minimumLineSpacing = 0.0f;

        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_collectionView];
    }

}

-(void)update
{
    [super update];
    

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    

    if(!_imageCollectionViewController)
    {
        _imageCollectionViewController=[[ImageCollectionViewController alloc]initWithCollectionView:_collectionView showPlus:YES showDelete:YES andUploadServer:YES andQiNiuBucket:@"cybup"];
        _imageCollectionViewController.maxSelected=3; //最多选择3张图片

    }
    [_imageCollectionViewController setDataSource:self.rowDescriptor.value andSuperC:self.formViewController];
}

-(NSMutableArray *) getToUploadImageArray
{
    NSMutableArray *toUploadImageArray = [_imageCollectionViewController viewImageArray];
    return toUploadImageArray;
}



+(CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor{
    
    return 100.0f;
}

@end

//
//  MyCollectionViewController.h
//  celldemo1
//
//  Created by jbas on 15/1/29.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCollectionViewController : UICollectionViewController

-(instancetype)initWithCollectionView:(UICollectionView *)collectionView showPlus:(BOOL)showPlus showDelete:(BOOL)showDelete andUploadServer:(BOOL)isToServer andQiNiuBucket:(NSString *)qiniuBucket;

-(void)setDataSource:(NSMutableArray *)dataSource andSuperC:(UIViewController*)superC;

@property(nonatomic,assign) int maxSelected;
@property(nonatomic,strong) NSMutableArray *removedImageArray;  //需要被删除的图片地址数组

//-(NSMutableArray *)getToUploadImageArray;  //获取待上传的图片列表
@property(nonatomic,strong) NSMutableArray *toUploadImageArray;  //待上传的图片列表
//-(NSMutableArray<ImageSelectItem> *)getViewImageArray;      //获取所有的图片列表，包括未上传和已经上传的

@property(nonatomic,strong) NSMutableArray *viewImageArray;     //界面上显示的所有图片数组
@end

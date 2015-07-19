//
//  MyCollectionViewController.m
//  celldemo1
//
//  Created by jbas on 15/1/29.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "ImageCollectionViewController.h"
#import "ImageCollectionCell.h"
#import "DKModalImageBrowser.h"
#import "DKImageBrowser.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "ImagePickerViewController.h"
#import "HttpApiUtil.h"
#import "CybCoreURLs.h"

@interface ImageCollectionViewController(){
    UIViewController *_superC;
    NSMutableArray *_dataArray;
    UICollectionView *_imgCollectionView;
    BOOL _isShowPlus;
    BOOL _isShowDelete;
    //是否上传图片到服务器
    BOOL _isToServer;
    NSString *_qiniuBucket;
    ImagePickerViewController *_imagePickerViewController;
}

@end


@implementation ImageCollectionViewController

static NSString * const reuseIdentifier = @"myCollectionCell";


-(void)setDataSource:(NSMutableArray *)dataSource andSuperC:(UIViewController*)superC{
    _superC = superC;
    _removedImageArray=[[NSMutableArray alloc]init];
    if (!dataSource) {
        _dataArray=[[NSMutableArray alloc]init];
    }else{
        _dataArray=[dataSource mutableCopy];
    }
    if (_isShowPlus) {
        [self addPlus];
    }
}

-(void)addPlus{
//    UIImage *plusimage = [UIImage imageNamed:@"plus"];
    [_dataArray addObject:@"plus"];
}

-(instancetype)initWithCollectionView:(UICollectionView *)collectionView showPlus:(BOOL)showPlus showDelete:(BOOL)showDelete andUploadServer:(BOOL)toServer andQiNiuBucket:(NSString *)qiniuBucket{
    self=[super init];
    if (self) {
        _imgCollectionView=collectionView;
        _imgCollectionView.delegate = self;
        _imgCollectionView.dataSource = self;
        _isShowPlus=showPlus;
        _isShowDelete=showDelete;
        _isToServer=toServer;
        _qiniuBucket=qiniuBucket;
        [_imgCollectionView registerNib:[UINib nibWithNibName:@"imgcellview" bundle:nil]forCellWithReuseIdentifier:reuseIdentifier];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Collection View Data Source
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCollectionCell *cell = (ImageCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSString *imgurl =_dataArray[indexPath.row];
    UIImage *image=[UIImage imageNamed:@"unknown_icon"];
    if ([imgurl hasPrefix:@"asset"]) {
//        image=[UIImage imageWithCGImage:selectItem.alAsset.thumbnail];
        NSURL *url=[NSURL URLWithString:imgurl];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            @autoreleasepool {
                @try {
                    ALAssetsLibrary *assetslibrary = [[ALAssetsLibrary alloc] init];
                    [assetslibrary assetForURL:url
                                   resultBlock:^(ALAsset *asset){
                                       ALAssetRepresentation *rep = [asset defaultRepresentation];
                                       CGImageRef iref = [rep fullScreenImage];
                                       if (iref) {
                                           dispatch_sync(dispatch_get_main_queue(), ^{
                                               [cell.cellImgButton setBackgroundImage:[UIImage imageWithCGImage:asset.thumbnail] forState:UIControlStateNormal];
                                           });
                                       }
                                   }
                                  failureBlock:^(NSError *error) {
                                      NSLog(@"Photo from asset library error: %@",error);
                                  }];
                } @catch (NSException *e) {
                    NSLog(@"Photo from asset library error: %@", e);
                }
            }
        });
        
    }else if([imgurl hasPrefix:@"http:"]){
        [cell.cellImgButton sd_setBackgroundImageWithURL:[NSURL URLWithString:imgurl] forState:UIControlStateNormal];

    }else{
        image=[UIImage imageNamed:imgurl];
        [cell.cellImgButton setBackgroundImage:image forState:UIControlStateNormal];
    }
    
    cell.imgButtonBLK = ^(){
        if (_isShowPlus && indexPath.row ==_dataArray.count-1) { //点击的是添加图片
            _imagePickerViewController=[[ImagePickerViewController alloc]initWithSuperController:_superC];

            [_imagePickerViewController pickAssets:self.maxSelected withHasSelected:(int)_dataArray.count-1 withFinishedSelect:^(NSArray *selectedAssets) {
                //需要上图片的数组
                NSMutableArray *uploadImgary = [[NSMutableArray alloc] init];
                if ([selectedAssets count]>0) {
                    for (ALAsset *asset in selectedAssets) {
                        ALAssetRepresentation *representation = [asset defaultRepresentation];
                        UIImage *image = [UIImage imageWithCGImage:[representation fullResolutionImage]];
                        [uploadImgary addObject:image];
                        NSURL* url = [representation url];
                        [_dataArray insertObject:[url absoluteString] atIndex:(_dataArray.count-1)];
                        [_imgCollectionView reloadData];
                    }
                }
                //上传图片到七牛
                if (_isToServer) {
                    [HttpApiUtil qiniuUploadImg:uploadImgary withQiNiuBucket:_qiniuBucket disPlayHud:YES withDone:^(NSMutableArray *uploadedImages) {
                        if (uploadedImages.count > 0) {
                            NSLog(@"上传图片到七牛服务器 uploadedImages is ===> %@",uploadedImages);
                            NSRange range =  NSMakeRange(_dataArray.count-uploadImgary.count-1, uploadImgary.count);
                            NSLog(@"range is ==>%@",NSStringFromRange(range));
                            [_dataArray replaceObjectsInRange:range withObjectsFromArray:uploadedImages];
//                            [imgCollectionView reloadData];
                        }
                    }];
                }
            }];
        }else{
            DKModalImageBrowser *modalImageBrowser = [[DKModalImageBrowser alloc] init];
            modalImageBrowser.imageBrowser.DKImageDataSource = _dataArray;
            [_superC presentViewController:modalImageBrowser animated:YES completion:nil];
        }
    };
   
   
    cell.cellclose.tag = [indexPath row];
    [cell.cellclose setHidden:!_isShowDelete];
    if (_isShowDelete && [self isPlusImage:(int)indexPath.row]) {  //显示的是加号图标
        [cell.cellclose setHidden:YES];
    }

    cell.deleteImgBLK = ^(){
        NSString *imgurl = [_dataArray objectAtIndex:indexPath.row];
        //TODO:上传图片过程中，操作同一个数组，需要处理
        if ([imgurl hasPrefix:@"http:"]) {//远程图片,需要被删除
            [_removedImageArray addObject:imgurl];
        }
        [_dataArray removeObjectAtIndex:indexPath.row];
        [_imgCollectionView reloadData];
    };
    return cell;
};

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 0, 0);
}


#pragma mark 获取待上传的图片
-(NSMutableArray *)toUploadImageArray{
    NSMutableArray *toUploadImageArray=[[NSMutableArray alloc]init];
    NSArray *viewArray=self.viewImageArray;// [self getViewImageArray];
    for (NSString *imgurl in viewArray) {
        if ([imgurl hasPrefix:@"asset"]) {
            [toUploadImageArray addObject:imgurl];
        }
        //        if ([obj isKindOfClass:[UIImage class]]) {
        //            [toUploadImageArray addObject:obj];
        //        }
    }
    return toUploadImageArray;
}

//-(NSMutableArray *)getToUploadImageArray{
//    NSMutableArray *toUploadImageArray=[[NSMutableArray alloc]init];
//    NSArray *viewArray=self.viewImageArray;// [self getViewImageArray];
//    for (NSString *imgurl in viewArray) {
//        if ([imgurl hasPrefix:@"asset"]) {
//            [toUploadImageArray addObject:imgurl];
//        }
////        if ([obj isKindOfClass:[UIImage class]]) {
////            [toUploadImageArray addObject:obj];
////        }
//    }
//    return toUploadImageArray;
//}

-(NSMutableArray *)viewImageArray{
 //   NSMutableArray *resultArr = [[NSMutableArray alloc]init];
//    for (NSString *imgurl in dataArray) {
//        if (![imgurl hasPrefix:@"http:"] || ![imgurl hasPrefix:@"asset"]) {
//            [resultArr addObject:imgurl];
//        }
//    }
//    return resultArr;
        if (_isShowPlus) {
            NSRange range = NSMakeRange(0, _dataArray.count-1);
            NSArray *arr= [_dataArray subarrayWithRange:range];
            return [NSMutableArray arrayWithArray:arr];
        }
        return _dataArray;
    
}

//-(NSMutableArray<ImageSelectItem> *)getViewImageArray{
//    NSMutableArray<ImageSelectItem> *resultArr=(NSMutableArray<ImageSelectItem>*)[[NSMutableArray alloc]init];
//    for (ImageSelectItem *selectItem in dataArray) {
//        if (selectItem.restype!=IMAGERESTYPE_IMGNAME) {
//            [resultArr addObject:selectItem];
//        }
//    }
//    return resultArr;
////    if (isShowPlus) {
////        NSRange range = NSMakeRange(0, dataArray.count-1);
////        NSArray *arr= [dataArray subarrayWithRange:range];
////        return [NSMutableArray arrayWithArray:arr];
////    }
////    return dataArray;
//}

#pragma mark 判断当前位置的图片是否是加号
-(BOOL) isPlusImage:(int)imageIndex{
    if (_isShowPlus && imageIndex==(_dataArray.count-1)) {
        return YES;
    }
    return NO;
}

@end

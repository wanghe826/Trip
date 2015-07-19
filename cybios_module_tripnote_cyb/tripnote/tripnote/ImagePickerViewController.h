//
//  ImagePickerViewController.h
//  CYBIOS_module_imgmanager
//
//  Created by jbas on 15/1/31.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTAssetsPickerController.h"
#import "CTAssetsPageViewController.h"

typedef void (^FinishedSelect)(NSArray *selectedAssets);

//#pragma mark - 图片选择后的代码
//@protocol SelectPhotoFromAssetDelegate
//-(void)didFinishedSelectPhotos:(NSArray *)aLAsset;
//@end

@interface ImagePickerViewController : UIViewController<CTAssetsPickerControllerDelegate, UIPopoverControllerDelegate>

@property (nonatomic, copy) NSArray *assets;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) UIPopoverController *popover;

-(id)initWithSuperController:(UIViewController *)superViewController;

-(void)pickAssets:(int)maxSelected withHasSelected:(int)hasSelected withFinishedSelect:(FinishedSelect)finishedSelect;
@end

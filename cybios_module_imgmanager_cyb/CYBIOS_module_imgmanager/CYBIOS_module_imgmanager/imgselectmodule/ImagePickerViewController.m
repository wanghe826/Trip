//
//  ImagePickerViewController.m
//  CYBIOS_module_imgmanager
//
//  Created by jbas on 15/1/31.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "ImagePickerViewController.h"

@interface ImagePickerViewController (){
    UIViewController *superUIViewController;
    FinishedSelect finishedPhotoSelect;
    int p_maxSelected;
    int p_hasSelected;
}

@end

@implementation ImagePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(id)initWithSuperController:(UIViewController *)superViewController{
    superUIViewController=superViewController;
    return [super init];
}

#pragma mark - 打开相册选择图片
-(void)pickAssets:(int)maxSelected withHasSelected:(int)hasSelected withFinishedSelect:(FinishedSelect)finishedSelect{
    if (!self.assets)
        self.assets = [[NSMutableArray alloc] init];
    p_hasSelected = hasSelected;
    
    CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
    picker.assetsFilter         = [ALAssetsFilter allAssets];
    picker.showsCancelButton    = (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad);
    picker.delegate             = self;
    picker.selectedAssets       = [NSMutableArray arrayWithArray:self.assets];
    finishedPhotoSelect         = finishedSelect;
    if (maxSelected<=0) {
        p_maxSelected=10;
    }else{
        p_maxSelected               = maxSelected;
    }
    [superUIViewController presentViewController:picker animated:YES completion:nil];
}

#pragma mark - Popover Controller Delegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.popover = nil;
}


#pragma mark - Assets Picker Delegate

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker isDefaultAssetsGroup:(ALAssetsGroup *)group
{
    return ([[group valueForProperty:ALAssetsGroupPropertyType] integerValue] == ALAssetsGroupSavedPhotos);
}

- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    if (self.popover != nil)
        [self.popover dismissPopoverAnimated:YES];
    else
        [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
    self.assets = [NSMutableArray arrayWithArray:assets];
    finishedPhotoSelect(self.assets);
}

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldEnableAsset:(ALAsset *)asset
{
    // Enable video clips if they are at least 5s
    if ([[asset valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo])
    {
        NSTimeInterval duration = [[asset valueForProperty:ALAssetPropertyDuration] doubleValue];
        return lround(duration) >= 5;
    }
    else
    {
        return YES;
    }
}

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(ALAsset *)asset
{
    if (picker.selectedAssets.count >= p_maxSelected - p_hasSelected)
    {
        UIAlertView *alertView =
        [[UIAlertView alloc] initWithTitle:nil
                                   message:[NSString stringWithFormat:@"最多只能选择 %d 张照片",p_maxSelected]
                                  delegate:nil
                         cancelButtonTitle:nil
                         otherButtonTitles:@"确定", nil];
        
        [alertView show];
        return NO;
    }
    
    if (!asset.defaultRepresentation)
    {
        UIAlertView *alertView =
        [[UIAlertView alloc] initWithTitle:nil
                                   message:@"暂无照片可选择"
                                  delegate:nil
                         cancelButtonTitle:nil
                         otherButtonTitles:@"确定", nil];
        
        [alertView show];
        return NO;
    }
    
    return (picker.selectedAssets.count < p_maxSelected && asset.defaultRepresentation != nil);
}


@end

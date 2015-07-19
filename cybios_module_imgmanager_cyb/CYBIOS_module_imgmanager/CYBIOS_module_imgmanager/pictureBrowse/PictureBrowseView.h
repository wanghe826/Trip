//
//  PictureBrowseView.h
//  CYBIOS_module_imgmanager
//
//  Created by sven on 2/27/15.
//  Copyright (c) 2015 cyb. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PictureBrowseView;

@interface PictureBrowseView : UIView

+(instancetype)pictureBroseViewWithView:(PictureBrowseView *)pictureBrowseView;

- (void)setDataSource:(NSArray *)arrDatas;
@end

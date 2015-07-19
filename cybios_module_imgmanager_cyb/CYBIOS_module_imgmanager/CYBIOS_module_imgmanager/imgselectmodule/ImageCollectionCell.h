//
//  OneCell.h
//  celldemo1
//
//  Created by jbas on 15/1/29.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCollectionCell : UICollectionViewCell


//@property (weak, nonatomic) IBOutlet UIImageView *cellimg;
@property (weak, nonatomic) IBOutlet UIButton *cellclose;
@property (weak, nonatomic) IBOutlet UIButton *cellImgButton;
@property (copy, nonatomic) void(^imgButtonBLK)();
@property (copy, nonatomic) void(^deleteImgBLK)();
- (IBAction)onImgButtonPressed:(id)sender;
@end

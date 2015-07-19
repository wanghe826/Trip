//
//  OneCell.m
//  celldemo1
//
//  Created by jbas on 15/1/29.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "ImageCollectionCell.h"

@implementation ImageCollectionCell


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [_cellImgButton addTarget:self action:@selector(onImgButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_cellclose addTarget:self action:@selector(onImgButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}


- (IBAction)onImgButtonPressed:(id)sender {
    
    if (sender == _cellImgButton) {
        if (self.imgButtonBLK) self.imgButtonBLK();
    }else{
        if (self.deleteImgBLK) self.deleteImgBLK();
    }
}

@end

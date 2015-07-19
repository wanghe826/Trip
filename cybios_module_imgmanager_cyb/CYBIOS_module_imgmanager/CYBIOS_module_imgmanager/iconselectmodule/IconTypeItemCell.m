//
//  IconTypeItemCell.m
//
//  Created by jbas on 15/2/8.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "IconTypeItemCell.h"
#import "IconTypeItem.h"
#import "UIButton+WebCache.h"


@interface IconTypeItemCell()

@property (weak, nonatomic) IBOutlet UIButton *typeimg;
@property (weak, nonatomic) IBOutlet UILabel *typelabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImg;

- (IBAction)onClickTypeItem:(id)sender;

@end


@implementation IconTypeItemCell


-(void)setIconTypeItem:(IconTypeItem *)iconTypeItem{
    _iconTypeItem=iconTypeItem;
    [_typeimg sd_setImageWithURL:[NSURL URLWithString:_iconTypeItem.imgurl]
                   forState:UIControlStateNormal];
    _typelabel.text=_iconTypeItem.title;
    [_selectedImg setHidden:!_iconTypeItem.checked];
}

- (IBAction)onClickTypeItem:(id)sender {
    _iconTypeItem.checked=!_iconTypeItem.checked;
    [_delegate didSelectedButton:self selectedIconType:_iconTypeItem];
}
@end

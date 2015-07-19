//
//  NotePicCollectionViewCell.m
//  tripnote
//
//  Created by wanghe on 15-5-19.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "NotePicCollectionViewCell.h"

@implementation NotePicCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self = [[[NSBundle mainBundle] loadNibNamed:@"NotePicCollectionViewCell" owner:nil options:nil] lastObject];
    }
    return self;
}

@end

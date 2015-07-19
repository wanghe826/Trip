//
//  TripMultiLineTextCell.m
//  tripfirst
//
//  Created by jack on 15/5/14.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "CYBXLFormSimpleCell.h"
NSString * const XLFormRowDescriptorTypeSimpleCell = @"XLFormRowDescriptorTypeSimpleCell";

@implementation CYBXLFormSimpleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

+(void)load{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:NSStringFromClass([CYBXLFormSimpleCell class]) forKey:XLFormRowDescriptorTypeSimpleCell];
}

#pragma mark - XLFormDescriptorCell

-(void)configure
{
    [super configure];
}

-(void)update
{
    [super update];
    self.textLabel.text = self.rowDescriptor.title;
}

-(void)formDescriptorCellDidSelectedWithFormController:(XLFormViewController *)controller
{
    [controller.tableView deselectRowAtIndexPath:[controller.form indexPathOfFormRow:self.rowDescriptor] animated:YES];

}


@end

//
//  CYBViewDetailViewController.m
//
//  Created by jack on 15/5/14.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "CYBViewDetailViewController.h"
#import "ImageSelectXLFormCellModel.h"
#import "CYBXLFormSimpleCell.h"
#import "ImageSelectXLFormCell.h"

@interface CYBViewDetailViewController (){
    XLFormRowDescriptor *_titleDetailRow;
    XLFormRowDescriptor *_imageArrRow;
}

@end

@implementation CYBViewDetailViewController

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeForm];
    }
    return self;
}

-(void)initializeForm{
    XLFormDescriptor *mainForm = [XLFormDescriptor formDescriptor];
    
    XLFormSectionDescriptor *section = [XLFormSectionDescriptor formSection];
    [mainForm addFormSection:section];
    _titleDetailRow = [XLFormRowDescriptor formRowDescriptorWithTag:nil rowType:XLFormRowDescriptorTypeSimpleCell];
    [_titleDetailRow.cellConfigAtConfigure setObject:@0 forKey:@"textLabel.numberOfLines"];

    [section addFormRow:_titleDetailRow];
    _imageArrRow=[XLFormRowDescriptor formRowDescriptorWithTag:nil rowType:XLFormRowDescriptorTypeSelectImage];
    [section addFormRow:_imageArrRow];
    self.form = mainForm;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self reloadFormView];
    if (_requestDataBlock) {
        _requestDataBlock();
    }
}

- (void)reloadFormView{
    _titleDetailRow.title = _displayText;
    //是否显示图片
    if (_dispalyImageURLs.count>0) {
        ImageSelectXLFormCellModel *cellModel = _imageArrRow.value;
        if (!cellModel) {
            cellModel=[[ImageSelectXLFormCellModel alloc]init];
        }
        cellModel.dataSource = [NSMutableArray arrayWithArray:_dispalyImageURLs];
        _imageArrRow.value=cellModel;
        _imageArrRow.hidden = @NO;
    }else{
        _imageArrRow.hidden  = @YES;
    }
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

@end

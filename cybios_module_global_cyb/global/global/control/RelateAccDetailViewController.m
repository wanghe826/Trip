//
//  RelateAccDetailViewController.m
//  global
//
//  Created by wanghe on 15-5-3.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "RelateAccDetailViewController.h"
#import "SettingXLFormHelper.h"
#import "CYBUserLinker.h"
#import "HttpApiUtil.h"
@interface RelateAccDetailViewController ()
@property (strong,nonatomic) XLFormRowDescriptor* nameRow;
@property (strong,nonatomic) XLFormRowDescriptor* accountRow;
@property (strong,nonatomic) XLFormRowDescriptor* relateDateRow;
@property (strong,nonatomic) XLFormRowDescriptor* unrelateRow;
@property (strong,nonatomic) CYBUserLinker* curLinker;
@end

@implementation RelateAccDetailViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self){
    }
    return self;
}

- (void)initializeForm
{
    XLFormDescriptor* form = [XLFormDescriptor formDescriptor];
    XLFormSectionDescriptor* sec = [XLFormSectionDescriptor formSection];
    _nameRow = [SettingXLFormHelper createSetting_relateName];
    _nameRow.value = self.curLinker.linkuname;
    [sec addFormRow:_nameRow];
    _accountRow = [SettingXLFormHelper createSetting_relateAccount];
    _accountRow.value = self.curLinker.linkaccount;
    [sec addFormRow:_accountRow];
    _relateDateRow = [SettingXLFormHelper createSetting_relateDate];
    _relateDateRow.value = self.curLinker.linkdate;
    [sec addFormRow:_relateDateRow];
    _unrelateRow = [SettingXLFormHelper createSetting_unrelate];
    [sec addFormRow:_unrelateRow];
    [form addFormSection:sec];
    self.form = form;
}
- (void)unRelate
{
    self.curLinker.isDeleted = YES;
    [HttpApiUtil httpSync:self.curLinker disPlayHud:YES finishedCallBack:^(id responseJSON)
    {
//        [self performSegueWithIdentifier:@"detail2relate" sender:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关联的账号";
    [self initializeForm];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)didSelectFormRow:(XLFormRowDescriptor *)formRow
{
    if([formRow.tag isEqualToString:@"unrelate"])
    {
//        [self unRelate];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"确定要解除关联吗？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        [self unRelate];
    }
}


@end

//
//  AboutAppViewController.m
//  global
//
//  Created by wanghe on 15-4-28.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "AboutAppViewController.h"
#import "XLForm.h"
#import "SettingXLFormHelper.h"
@interface AboutAppViewController ()
@property (strong,nonatomic) XLFormRowDescriptor* logoRow;
@property (strong,nonatomic) XLFormRowDescriptor* upgradeRow;
@property (strong,nonatomic) XLFormRowDescriptor* upgradeLogRow;
@property (strong,nonatomic) XLFormRowDescriptor* scoreRow;
@property (strong,nonatomic) XLFormRowDescriptor* givePointRow;


@end

@implementation AboutAppViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeForm];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self){
        [self initializeForm];
    }
    return self;
}

- (void) initializeForm
{
    XLFormDescriptor* form = [XLFormDescriptor formDescriptor];
    XLFormSectionDescriptor* sec = [XLFormSectionDescriptor formSection];
    _logoRow = [SettingXLFormHelper createSetting_aboutAppTitle];
    [sec addFormRow:_logoRow];
    
    _upgradeRow = [SettingXLFormHelper createSetting_version];
    [sec addFormRow:_upgradeRow];
    
    _upgradeLogRow = [SettingXLFormHelper createSetting_upgradeLog];
    [sec addFormRow:_upgradeLogRow];
    
    _scoreRow = [SettingXLFormHelper createSetting_giveScore];
    [sec addFormRow:_scoreRow];
    
    _givePointRow = [SettingXLFormHelper createSetting_givePoint];
    [sec addFormRow:_givePointRow];
    
    [form addFormSection:sec];
    self.form = form;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于App";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

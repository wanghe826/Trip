//
//  NewNoteViewController.m
//  tripnote
//
//  Created by wanghe on 15-5-17.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "NewNoteViewController.h"
#import "TripManSelectImageCell.h"
#import "SecNoteCellModel.h"
#import "HttpApiUtil.h"
#import "AppUtil.h"
@interface NewNoteViewController ()
@property (nonatomic,strong) XLFormRowDescriptor* textViewRow;
@property (nonatomic,strong) XLFormRowDescriptor* imgSelectRow;

@end

@implementation NewNoteViewController

- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self initialForm];
    }
    return self;
}

- (instancetype) init
{
    self = [super init];
    if(self){
        [self initialForm];
    }
    return self;
}

- (void)initialForm
{
    XLFormDescriptor* form = [XLFormDescriptor formDescriptor];
    XLFormSectionDescriptor* sec = [XLFormSectionDescriptor formSection];
    _textViewRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"textview" rowType:XLFormRowDescriptorTypeTextView title:nil];
    [_textViewRow.cellConfigAtConfigure setObject:@"请输入内容" forKeyedSubscript:@"textView.placeholder"];
    [sec addFormRow:_textViewRow];
    
    _imgSelectRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"imgselect" rowType:XLFormRowDescriptorTypeSelectImage title:nil];
    [sec addFormRow:_imgSelectRow];
    
    [form addFormSection:sec];
    self.form = form;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender {
    [self collectData];
}

- (void) collectData{
    if(!_textViewRow.value){
        [AppUtil showAlert:@"请输入内容"];
        return;
    }
    SecNoteCellModel* noteModel = [[SecNoteCellModel alloc] init];
    noteModel.notebody = _textViewRow.value;
    TripManSelectImageCell* cell = (TripManSelectImageCell*)[[self.form formRowWithTag:@"imgselect"] cellForFormController:self];
    noteModel.imgurls = [cell getToUploadImageArray];
    [HttpApiUtil httpSync:noteModel disPlayHud:YES finishedCallBack:^(id responseJSON) {
        NSLog(@"saved:%@", responseJSON);
    }];
}
@end

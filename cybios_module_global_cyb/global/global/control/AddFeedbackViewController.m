//
//  AddFeedbackViewController.m
//  global
//
//  Created by wanghe on 15-5-12.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "AddFeedbackViewController.h"
#import "SettingXLFormHelper.h"
#import "CYBAdviceReply.h"
#import "TripManSelectImageCell.h"
#import "AppUtil.h"
#import "CYBLoginUser.h"
#import "HttpApiUtil.h"

@interface AddFeedbackViewController ()
@property (strong,nonatomic) XLFormRowDescriptor* textViewRow;
@property (strong,nonatomic) XLFormRowDescriptor* imageSelectRow;
@property (strong,nonatomic) CYBAdviceReply* curAdviceReply;
@end

@implementation AddFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _curAdviceReply = [[CYBAdviceReply alloc] init];
    [self addNavigationBar];
    [self initialForm];
}


-(void)addNavigationBar{
    //创建一个导航栏
    UINavigationBar *navigationBar=[[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    [self.view addSubview:navigationBar];
    //创建导航控件内容
    UINavigationItem *navigationItem=[[UINavigationItem alloc] initWithTitle:@"补充"];
    
    //左侧添加登录按钮
    UIBarButtonItem *loginButton= [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveSupply)];
    navigationItem.leftBarButtonItem = loginButton;
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(cencelSupply)];
    navigationItem.rightBarButtonItem = saveButton;
    [navigationBar pushNavigationItem:navigationItem animated:NO];
}

-(void) saveSupply
{
    [self collectData];
}

-(void)cencelSupply
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void) initialForm
{
    XLFormDescriptor* form = [XLFormDescriptor formDescriptor];
    XLFormSectionDescriptor* sec = [XLFormSectionDescriptor formSection];
    _textViewRow = [SettingXLFormHelper createFeedback_textviewRow:@"textview_supply"];
    [sec addFormRow:_textViewRow];
    [form addFormSection:sec];
    _imageSelectRow = [SettingXLFormHelper createFeedback_imgSelectRow:@"imgselect_supply"];
    [sec addFormRow:_imageSelectRow];
    self.form = form;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)collectData
{
    if(!_textViewRow.value || [_textViewRow isEqual:@""]){
        [AppUtil showAlert:@"请补充你的意见"];
        return;
    }
    TripManSelectImageCell* selectImageCell = (TripManSelectImageCell*)[[self.form formRowWithTag:@"imgselect_supply"] cellForFormController:self];
    _curAdviceReply.imgurls = [selectImageCell getToUploadImageArray];
    _curAdviceReply.replycid = [[CYBLoginUser sharedCYBLoginUser] account];
    _curAdviceReply.replycomments = _textViewRow.value;

    [HttpApiUtil httpSync:_curAdviceReply disPlayHud:YES finishedCallBack:^(id requestJSON)
     {
         NSLog(@"saved-->%@",requestJSON);
     }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

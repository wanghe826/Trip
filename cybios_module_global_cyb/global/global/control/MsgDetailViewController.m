//
//  MsgDetailViewController.m
//  global
//
//  Created by wanghe on 15-5-10.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "MsgDetailViewController.h"
#import "SettingXLFormHelper.h"
#import "TripManSelectImageCell.h"
#import "CYBDevice.h"
#import "ServiceReplyWithPicView.h"
#import "GlobalApi.h"
#import "GlobalURLs.h"
#import "AddFeedbackViewController.h"
#import "CYBXLFormCell.h"
#import "CYBCellModel.h"
#import "CYBAdviceReply.h"

@interface MsgDetailViewController ()
@property (nonatomic,strong) XLFormRowDescriptor* msgInfoRow;
@property (nonatomic,strong) XLFormRowDescriptor* picRow;
@property (nonatomic,strong) XLFormSectionDescriptor* replySection;

@property (nonatomic,strong) CYBDevice* curDevice;

@property (nonatomic,strong) NSMutableArray* allMsgArray;

@end

@implementation MsgDetailViewController


-(void) initializeForm
{
    XLFormDescriptor* form = [XLFormDescriptor formDescriptor];
    XLFormSectionDescriptor* section1 = [XLFormSectionDescriptor formSection];
    _msgInfoRow = [SettingXLFormHelper createMsgDetail_infoRow];
    _msgInfoRow.title = self.curDevice.comments;
    [section1 addFormRow:_msgInfoRow];
    
    _picRow = [SettingXLFormHelper createMsgDetail_picRow];
    _picRow.value = self.curDevice.imgurls;
    [section1 addFormRow:_picRow];
    [form addFormSection:section1];
    
    _replySection = [XLFormSectionDescriptor formSection];
    _replySection.title = @"回复信息";
    XLFormRowDescriptor* row = [XLFormRowDescriptor formRowDescriptorWithTag:@"lsdkjflk" rowType:XLFormRowDescriptorTypeSerReplyWithPic title:nil];
    [_replySection addFormRow:row];
    [row.cellConfig setObject:@"注释01" forKey:@"service.text"];
    [row.cellConfig setObject:[UIImage imageNamed:@"unRelateAcc.png"] forKey:@"img1.image"];
    [row.cellConfig setObject:[UIImage imageNamed:@"addRelateAcc.png"] forKey:@"img2.image"];
    [form addFormSection:_replySection];
    self.form = form;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见详情";
    [self initializeForm];
    _allMsgArray = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self fetchMessage];
}

-(void)fetchMessage
{
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.curDevice._id forKey:@"id"];
    GlobalApi* gloApi = [[GlobalApi alloc] initWithUrlParamDict:URL_GLOBAL_FEEDBACK_REPLAY withParamDict:dic andUseCache:NO];
    [gloApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        _allMsgArray = [gloApi fetchSingleAllReply];
        for(CYBAdviceReply* reply in _allMsgArray){
            CYBCellModel* model = [[CYBCellModel alloc] init];
        }
    } failure:^(YTKBaseRequest* request)
     {
         
     }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)supplyBtn:(id)sender {
//    [self performSegueWithIdentifier:@"feeddetail2add" sender:nil];
    UIStoryboard* mainStory = [UIStoryboard storyboardWithName:@"global" bundle:nil];
    UIViewController* viewController = [mainStory instantiateViewControllerWithIdentifier:@"addFeedback"];
//    AddFeedbackViewController* viewController = [[AddFeedbackViewController alloc] init];
    viewController.modalPresentationStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:viewController  animated:YES completion:nil];
}
@end

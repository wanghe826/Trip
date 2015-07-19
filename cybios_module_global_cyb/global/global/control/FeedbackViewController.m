//
//  FeedbackViewController.m
//  global
//
//  Created by wanghe on 15-5-10.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "FeedbackViewController.h"
#import "SettingXLFormHelper.h"
#import "AppUtil.h"
#import "CYBDevice.h"
#import "TripManSelectImageCell.h"
#import "CYBLoginUser.h"
#import "HttpApiUtil.h"
#import "GlobalApi.h"
#import "GlobalURLs.h"
@interface FeedbackViewController ()
{
    CYBDevice* _curDevice;
    CYBDevice* _passDevice;
}
@property (strong,nonatomic) XLFormRowDescriptor* textViewRow;
@property (strong,nonatomic) XLFormSectionDescriptor* messageSection;
@property (strong,nonatomic) XLFormRowDescriptor* imageSelectRow;
@property (strong,nonatomic) XLFormRowDescriptor* feedbackRow;
@property (strong,nonatomic) NSMutableArray* feedbackArray;
@property (strong,nonatomic) NSString* currentMsg;

@end

@implementation FeedbackViewController

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
//XLFormSectionOptionCanReorder | XLFormSectionOptionCanInsert | XLFormSectionOptionCanDelete

- (void) initializeForm
{
    XLFormDescriptor* form = [XLFormDescriptor formDescriptorWithTitle:@"提意见"];
    XLFormSectionDescriptor* section1 = [XLFormSectionDescriptor formSection];
    _textViewRow = [SettingXLFormHelper createFeedback_textviewRow:@"textview_feedback"];
    _imageSelectRow = [SettingXLFormHelper createFeedback_imgSelectRow:@"imgselect_feedback"];
    [section1 addFormRow:_textViewRow];
    [section1 addFormRow:_imageSelectRow];
    [form addFormSection:section1];
    _messageSection = [XLFormSectionDescriptor formSection];
    _messageSection.title = @"已提的意见";
    [form addFormSection:_messageSection];
    self.form = form;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提意见";
    _feedbackArray = [[NSMutableArray alloc] init];
    GlobalApi* globalApi = [[GlobalApi alloc] initWithUrlParamDict:URL_GLOBAL_FEEDBACK withParamDict:nil andUseCache:NO];
    [globalApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest* request){
        _feedbackArray = [globalApi fetchAlreadyFeedback];
        [self showFeedbackMessage];
    }failure:^(YTKBaseRequest* request)
    {
        
    }];
    
    _curDevice = [[CYBDevice alloc] init];      //要上传的对象
    _passDevice = [[CYBDevice alloc] init];     //要传递到下一个页面的对象
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)confirmBtn:(id)sender {
    [self collectMessage];
}

- (void) collectMessage
{
    if(!_textViewRow.value || [_textViewRow isEqual:@""]){
        [AppUtil showAlert:@"请填写你的意见"];
        return;
    }
    _currentMsg = _textViewRow.value;
    TripManSelectImageCell* selectImageCell = (TripManSelectImageCell*)[[self.form formRowWithTag:@"imgselect_feedback"] cellForFormController:self];
    _curDevice.imgurls = [selectImageCell getToUploadImageArray];
    _curDevice.cid = [[CYBLoginUser sharedCYBLoginUser] account];
    _curDevice.comments = _currentMsg;
    _curDevice.cname = [[CYBLoginUser sharedCYBLoginUser] name];
    [_feedbackArray addObject:_curDevice];
    
    XLFormRowDescriptor* row = [SettingXLFormHelper createFeedback_messageRow:_currentMsg];
    [_messageSection addFormRow:row];
    [HttpApiUtil httpSync:_curDevice disPlayHud:YES finishedCallBack:^(id requestJSON)
     {
         NSLog(@"saved-->%@",requestJSON);
     }];
    [self.tableView reloadData];
}


-(void)didSelectFormRow:(XLFormRowDescriptor *)formRow
{
    for(CYBDevice* dev in _feedbackArray)
    {
        if([dev.comments isEqualToString:formRow.tag])
        {
            _passDevice = dev;
        }
    }
    [self performSegueWithIdentifier:@"feedback2detail" sender:nil];
}

-(void)showFeedbackMessage
{
    if(_feedbackArray == nil || [_feedbackArray count] == 0){
        return;
    }
    for(CYBDevice* device in _feedbackArray)
    {
        XLFormRowDescriptor* row = [SettingXLFormHelper createFeedback_messageRow:device.comments];
        [_messageSection addFormRow:row];
    }
}

//传递数据到下一个页面
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"feedback2detail"])
    {
        UIViewController* send = segue.destinationViewController;
        if([send respondsToSelector:@selector(setValue:forKey:)])
        {
            [send setValue:_passDevice forKey:@"curDevice"];
        }
    }
}

@end

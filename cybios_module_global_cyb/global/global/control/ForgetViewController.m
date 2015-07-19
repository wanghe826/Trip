//
//  ForgetViewController.m
//  global
//
//  Created by kunge on 15/4/17.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "ForgetViewController.h"
#import <XLForm.h>
#import <YTKNetwork/YTKRequest.h>
#import "GlobalApi.h"
#import "GlobalURLs.h"
#import "SmsInfo.h"

NSString *const kTelephone = @"telephone";
NSString *const kSend = @"send";

@interface ForgetViewController ()
@property (strong,nonatomic)XLFormRowDescriptor *xl_telephone;
@property (nonatomic,strong)XLFormRowDescriptor *xl_send;
@property (strong,nonatomic)SmsInfo *forgetPWForm;
@end

@implementation ForgetViewController

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

- (void)viewDidLoad {
    
    [super viewDidLoad];
    if(!_forgetPWForm){
        _forgetPWForm = [[SmsInfo alloc] init];
        [self initializeForm];
    }else{
        
    }

}


-(void)initializeForm
{
    XLFormDescriptor * formDescriptor = [XLFormDescriptor formDescriptorWithTitle:@"找回密码"];
    XLFormSectionDescriptor * section;
    
    formDescriptor.assignFirstResponderOnShow = YES;
    
    // Basic Information - Section
    section = [XLFormSectionDescriptor formSectionWithTitle:nil];
    [formDescriptor addFormSection:section];
    
    
    // Phone
    _xl_telephone = [XLFormRowDescriptor formRowDescriptorWithTag:kTelephone rowType:XLFormRowDescriptorTypePhone title:@"手机号码"];
    [section addFormRow:_xl_telephone];
    
       //按钮
    section = [XLFormSectionDescriptor formSectionWithTitle:nil];
    [formDescriptor addFormSection:section];
    
    //发送
    _xl_send = [XLFormRowDescriptor formRowDescriptorWithTag:kSend rowType:XLFormRowDescriptorTypeButton title:@"发送"];
    [_xl_send.cellConfig setObject:[UIColor colorWithRed:0.0/255.0 green:122.0/255.0 blue:1.0 alpha:1.0] forKey:@"textLabel.textColor"];
    
    _xl_send.action.formSelector = @selector(sendButton);
    [section addFormRow:_xl_send];
    
   
    
    self.form = formDescriptor;
    
}

-(void)sendButton
{
    NSLog(@"------send");
    [self getForgetPWData:NO];
    [self deselectFormRow:_xl_send];
}

-(void)getForgetPWData:(BOOL)useCaache{
    _forgetPWForm.mobile = _xl_telephone.value;
    NSLog(@"_forgetPWForm.mobile=====%@,_xl_send.value====%@",_forgetPWForm.mobile,_xl_telephone.value);
    if (_forgetPWForm.mobile.length > 0) {
        NSMutableDictionary *paramDict = [[NSMutableDictionary alloc] init];
        [paramDict setObject:_forgetPWForm.mobile forKey:@"account"];
        GlobalApi *globalApi = [[GlobalApi alloc] initWithUrlParamDict:URL_GLOBAL_FORGOTPWD withParamDict:paramDict andUseCache:useCaache];
        [globalApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            SmsInfo *result = [globalApi fetchForgotPwdResult];
            NSLog(@"----%@", result);
        } failure:^(YTKBaseRequest *request) {
            NSLog(@"error");
        }];
    }else{
        NSLog(@"手机号码不能为空");
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

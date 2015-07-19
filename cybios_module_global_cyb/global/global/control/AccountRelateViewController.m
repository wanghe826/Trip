//
//  AccountRelateViewController.m
//  global
//
//  Created by wanghe on 15-4-28.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "AccountRelateViewController.h"
#import "GlobalURLs.h"
#import "GlobalApi.h"
#import "CYBCell.h"
#import "CYBCellModel.h"
#import "AccRelateFootView.h"
#import "AppUtil.h"
#import "CYBUserLinker.h"

@interface AccountRelateViewController ()
{
    CYBUserLinker* _sendLinker;
}
@property (strong,nonatomic) NSMutableArray* cybUserLinkerArray;

@end

@implementation AccountRelateViewController

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

-(void) fetchLinkerArray
{
    GlobalApi* api = [[GlobalApi alloc] initWithUrlParamDict:URL_GLOBAL_LINKERUSER withParamDict:nil andUseCache:NO];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest* request){
        _cybUserLinkerArray = [api fetchCybUserLinkerArray];
        [self.tableView reloadData];
    }failure:^(YTKBaseRequest* request)
    {
        [AppUtil showAppError];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账号关联";
    AccRelateFootView* accFoot = [AccRelateFootView accRelateFootView];
    accFoot.delegate = self;
    self.tableView.tableFooterView = accFoot;
    // Do any additional setup after loading the view.
    
    _cybUserLinkerArray = [[NSMutableArray alloc] init];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self fetchLinkerArray];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)push2Add
{
    [self performSegueWithIdentifier:@"relate2addRelate" sender:nil];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_cybUserLinkerArray)
    {
        return [_cybUserLinkerArray count];
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger curRow = [indexPath row];
    CYBUserLinker* linker = [_cybUserLinkerArray objectAtIndex:curRow];
    CYBCell *cell=[CYBCell cellWithTableView:self.tableView];
    CYBCellModel* cellModel = [[CYBCellModel alloc] init];
    cellModel.title = linker.linkuname;
    cellModel.titleSubText = linker.linkaccount;
    cellModel.value = @"";
    cellModel.valueSubText = @"已关联";
    cell.cellModel = cellModel;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"relate2detail"])
    {
        UIViewController* send = segue.destinationViewController;
        if([send respondsToSelector:@selector(setValue:forKey:)])
        {
            [send setValue:_sendLinker forKey:@"curLinker"];
        }
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _sendLinker = [_cybUserLinkerArray objectAtIndex:[indexPath row]];
    [self performSegueWithIdentifier:@"relate2detail" sender:nil];
}

@end

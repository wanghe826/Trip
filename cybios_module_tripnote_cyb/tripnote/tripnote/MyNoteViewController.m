//
//  MyNoteViewController.m
//  tripnote
//
//  Created by wanghe on 15-5-17.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "MyNoteViewController.h"
#import "SecNoteCellModel.h"
#import "SecNoteTableViewCell.h"
#import "TripnoteApi.h"
#import "TripNoteApiUrls.h"

@interface MyNoteViewController ()
@property (nonatomic,strong) NSMutableArray* modelArray;
@end

@implementation MyNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchNoteMessageWithPic];
}

-(void)fetchNoteMessageWithPic
{
//    tripid/:page/:pagesize"]
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
    [dic setValue:@"1" forKey:@"tripid"];
    [dic setValue:@"2" forKey:@"page"];
    [dic setValue:@"3" forKey:@"pagesize"];
    TripnoteApi* api = [[TripnoteApi alloc] initWithUrlParamDict:URL_TRIPNOTE_MESSAGEADNPIC withParamDict:nil andUseCache:NO];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        _modelArray = [api fetchNote];
        if(_modelArray && _modelArray.count!=0){
            [self.tableView reloadData];
        }
    } failure:^(YTKBaseRequest *request) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SecNoteTableViewCell* cell = [SecNoteTableViewCell secNoteTableViewCell:tableView];
    cell.cellModel = [_modelArray objectAtIndex:[indexPath row]];
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _modelArray.count;
}


- (IBAction)addNewNot:(id)sender {
    [self performSegueWithIdentifier:@"note2addNote" sender:nil];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}
@end

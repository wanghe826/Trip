//
//  SecNoteTableViewCell.h
//  tripnote
//
//  Created by wanghe on 15-5-18.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecNoteCellModel.h"
@interface SecNoteTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

+ (SecNoteTableViewCell*) secNoteTableViewCell:(UITableView*)tableView;

@property (weak, nonatomic) IBOutlet UICollectionView *picCollectView;
@property (nonatomic,strong) SecNoteCellModel* cellModel;
@end

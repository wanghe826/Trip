//
//  SecNoteTableViewCell.m
//  tripnote
//
//  Created by wanghe on 15-5-18.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "SecNoteTableViewCell.h"
#import "NotePicCollectionViewCell.h"

@implementation SecNoteTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (SecNoteTableViewCell*) secNoteTableViewCell:(UITableView*)tableView
{
    static NSString* cellIdentifier = @"cellIdentifier";
    SecNoteTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SecNoteTableViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
}


- (void) setCellModel:(SecNoteCellModel *)cellModel
{
    [_picCollectView registerClass:[NotePicCollectionViewCell class] forCellWithReuseIdentifier:@"collectViewCell"];
    _cellModel = cellModel;
    _picCollectView.dataSource = self;
    _picCollectView.delegate = self;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_cellModel.imgurls count];
}

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NotePicCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectViewCell" forIndexPath:indexPath];
    cell.imageView.image = [_cellModel.imgurls objectAtIndex:[indexPath row]];
    return cell;
}

- (UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

@end

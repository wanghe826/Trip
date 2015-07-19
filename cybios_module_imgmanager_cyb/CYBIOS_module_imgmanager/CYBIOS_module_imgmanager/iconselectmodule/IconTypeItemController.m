//
//  IconTypeItemController.m
//
//  Created by jbas on 15/2/7.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "IconTypeItemController.h"
#import "IconTypeItemCell.h"

#define CELLIDENTIFIER @"icontypeColcell"

@interface IconTypeItemController ()<IconTypeItemCellDelegate>{
    NSArray *_iconTypeArray;
}

@property(nonatomic,weak)UICollectionView *iconTypeCollectionView;
@end

@implementation IconTypeItemController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(instancetype)initWithCollectionView:(UICollectionView *)collectionView{
    self=[super init];
    if (self) {
        _iconTypeCollectionView=collectionView;
        [_iconTypeCollectionView registerNib:[UINib nibWithNibName:@"IconTypeItemCell" bundle:nil] forCellWithReuseIdentifier:CELLIDENTIFIER];
        _iconTypeCollectionView.delegate=self;
        _iconTypeCollectionView.dataSource=self;
    }
    return self;
}

-(void)setDataSource:(NSArray *)dataSource{
    _iconTypeArray=dataSource;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _iconTypeArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IconTypeItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELLIDENTIFIER forIndexPath:indexPath];
    cell.iconTypeItem=_iconTypeArray[indexPath.row];
    cell.delegate=self;
    return cell;
}

-(void)didSelectedButton:(IconTypeItemCell *)iconTypeItemCell selectedIconType:(IconTypeItem *)selectedIconType{
    BOOL checked=selectedIconType.checked;
    for (IconTypeItem *item in _iconTypeArray) {
        item.checked=NO;
    }
    selectedIconType.checked=checked;
    [_iconTypeCollectionView reloadData];
}

-(IconTypeItem *)getSelectedTypeItem{
    for (IconTypeItem *item in _iconTypeArray) {
        if (item.checked) {
            return item;
        }
    }
    return nil;
}

@end

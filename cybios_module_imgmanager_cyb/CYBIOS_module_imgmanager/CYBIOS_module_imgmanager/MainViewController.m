//
//  MainViewController.m
//  celldemo1
//
//  Created by jbas on 15/1/29.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "MainViewController.h"
#import "ImageCollectionCell.h"
#import "ImageCollectionViewController.h"
#import "PictureBrowseView.h"
#import "IconTypeItem.h"
#import "IconTypeItemController.h"
#import "MenuView.h"
#import "MenViewController.h"

@interface MainViewController (){
    ImageCollectionViewController *collectionViewController;
    IconTypeItemController *_iconTypeItemController;
    MenViewController *controller;
}

@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (strong, nonatomic) IBOutlet PictureBrowseView *myPictureBrowseView;
@property (strong, nonatomic) IBOutlet UICollectionView *iconSelectView;

@property (weak, nonatomic) IBOutlet MenuView *menBarView;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpCollection];
    [self setUpPictureBrowser];
    [self setupIconSelect];
}

-(void)setUpCollection{
    NSMutableArray *dataArray = [NSMutableArray array];
    NSString *url=@"http://i0.sinaimg.cn/dy/2015/0116/U11594P1DT20150116185811.jpg";
    NSString *url1=@"http://n.sinaimg.cn/default/20150326/7FiG-cczmvun7153348.png";
    NSString *url2=@"http://n.sinaimg.cn/default/20150326/TB7S-avxeafs2438140.png";
    [dataArray addObject:url];
    [dataArray addObject:url1];
    [dataArray addObject:url2];
    
    collectionViewController=[[ImageCollectionViewController alloc]initWithCollectionView:_myCollectionView showPlus:YES showDelete:YES andUploadServer:YES];
    collectionViewController.maxSelected=4; //最多选择3张图片
    [collectionViewController setDataSource:dataArray andSuperC:self];
}

-(void)setupIconSelect{
    NSMutableArray *dataArray = [NSMutableArray array];
    IconTypeItem *item1=[[IconTypeItem alloc]initWithTitle:@"基本费用" andImgurl:@"http://cybup.qiniudn.com/mc_tab_icon_add_normal.png"];
    IconTypeItem *item2=[[IconTypeItem alloc]initWithTitle:@"交通费" andImgurl:@"http://cybup.qiniudn.com/level60.png"];
    IconTypeItem *item3=[[IconTypeItem alloc]initWithTitle:@"费用分类1" andImgurl:@"http://cybup.qiniudn.com/level60.png"];
    IconTypeItem *item4=[[IconTypeItem alloc]initWithTitle:@"住宿费" andImgurl:@"http://cybup.qiniudn.com/mc_feed_fav_enable.png"];
    IconTypeItem *item5=[[IconTypeItem alloc]initWithTitle:@"伙食费" andImgurl:@"http://cybup.qiniudn.com/mc_feed_status_new.png"];
    IconTypeItem *item6=[[IconTypeItem alloc]initWithTitle:@"费用分类2" andImgurl:@"http://cybup.qiniudn.com/mc_feed_status_new.png"];
    IconTypeItem *item7=[[IconTypeItem alloc]initWithTitle:@"费用分类3" andImgurl:@"http://cybup.qiniudn.com/mc_feed_status_new.png"];
    IconTypeItem *item8=[[IconTypeItem alloc]initWithTitle:@"费用分类5" andImgurl:@"http://cybup.qiniudn.com/icon_calender_d.png"];
    IconTypeItem *item9=[[IconTypeItem alloc]initWithTitle:@"费用分类6" andImgurl:@"http://cybup.qiniudn.com/level60.png"];
    IconTypeItem *item10=[[IconTypeItem alloc]initWithTitle:@"费用分类10" andImgurl:@"http://cybup.qiniudn.com/mc_feed_status_new.png"];
    IconTypeItem *item11=[[IconTypeItem alloc]initWithTitle:@"费用分类14" andImgurl:@"http://cybup.qiniudn.com/icon_calender_d.png"];
    IconTypeItem *item12=[[IconTypeItem alloc]initWithTitle:@"费用分类16" andImgurl:@"http://cybup.qiniudn.com/mc_feed_status_new.png"];
    IconTypeItem *item13=[[IconTypeItem alloc]initWithTitle:@"费用分类17" andImgurl:@"http://cybup.qiniudn.com/level60.png"];
    IconTypeItem *item14=[[IconTypeItem alloc]initWithTitle:@"门票" andImgurl:@"http://cybup.qiniudn.com/ic_tab_promo_hot_unselected.png"];
    IconTypeItem *item15=[[IconTypeItem alloc]initWithTitle:@"市内交通费" andImgurl:@"http://cybup.qiniudn.com/icon_calender_d.png"];
    IconTypeItem *item16=[[IconTypeItem alloc]initWithTitle:@"飞机票" andImgurl:@"http://cybup.qiniudn.com/icon_calender_d.png"];
    [dataArray addObject:item1];
    [dataArray addObject:item2];
    [dataArray addObject:item3];
    [dataArray addObject:item4];
    [dataArray addObject:item5];
    [dataArray addObject:item6];
    [dataArray addObject:item7];
    [dataArray addObject:item8];
    [dataArray addObject:item9];
    [dataArray addObject:item10];
    [dataArray addObject:item11];
    [dataArray addObject:item12];
    [dataArray addObject:item13];
    [dataArray addObject:item14];
    [dataArray addObject:item15];
    [dataArray addObject:item16];
    
    [_menBarView initMenuViewWithData:dataArray];
    controller = [[MenViewController alloc] init];
    _menBarView.delegate = controller;
    
}

-(void)setUpPictureBrowser{
    NSArray *arrPictures = @[@"http://i0.sinaimg.cn/dy/2015/0116/U11594P1DT20150116185811.jpg",
                             @"http://i0.sinaimg.cn/dy/2015/0129/U3093P1DT20150129111154.jpg",
                             @"http://i3.sinaimg.cn/dy/2015/0129/U9298P1DT20150129105940.jpg"];
    
    _myPictureBrowseView=[PictureBrowseView pictureBroseViewWithView:_myPictureBrowseView];
    [_myPictureBrowseView setDataSource:arrPictures];
}




@end

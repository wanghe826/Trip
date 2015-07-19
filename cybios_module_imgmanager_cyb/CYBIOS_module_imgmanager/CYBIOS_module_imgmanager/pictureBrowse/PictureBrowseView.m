//
//  PictureBrowseView.m
//  CYBIOS_module_imgmanager
//
//  Created by sven on 2/27/15.
//  Copyright (c) 2015 cyb. All rights reserved.
//

#import "PictureBrowseView.h"
#import "UIImageView+WebCache.h"

@interface PictureBrowseView ()<UIScrollViewDelegate>
{
    NSArray *_imgUrls;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@end

@implementation PictureBrowseView

+(instancetype)pictureBroseViewWithView:(PictureBrowseView *)pictureBrowseView{
    PictureBrowseView *picView=[[[NSBundle mainBundle]loadNibNamed:@"PictureBrowseView" owner:nil options:nil]lastObject];
    picView.frame=pictureBrowseView.bounds;

    [pictureBrowseView addSubview:picView];
    
    return picView;
}

- (void)customSelfUI
{
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width*_imgUrls.count, _scrollView.frame.size.height);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    
    _pageControl.numberOfPages = _imgUrls.count;
    _pageControl.currentPage = 0;
    
    for (NSInteger i = 0; i < [_imgUrls count]; i++) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(_scrollView.frame.size.width*i, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
        [img sd_setImageWithURL:[NSURL URLWithString:_imgUrls[i]]];
        [_scrollView addSubview:img];
    }
}

- (void)setDataSource:(NSArray *)arrDatas{
    _imgUrls=[arrDatas copy];
    [self customSelfUI];
}

#pragma mark - UIScrollView Delegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _pageControl.currentPage = (NSInteger)(scrollView.contentOffset.x/_scrollView.frame.size.width);
}

@end

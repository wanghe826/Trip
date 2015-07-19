//
//  MenuView.m
//  MenuViewDemo
//
//  Created by zhangbo on 15/3/12.
//  Copyright (c) 2015年 zhangbo. All rights reserved.
//

#import "MenuView.h"
#import "MenuItem.h"
#import "IconTypeItem.h"
#import "UIImageView+WebCache.h"

#define MARGIN  2

const int Margin = 2;
const int columnsOneInPage = 5;
const int rowsOneInPage = 2;

@interface MenuView()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIView *_contentView;
    NSArray *_array;
    UIPageControl *_pageControl;
    NSInteger _currentPage;
}

@end

@implementation MenuView

- (void)initMenuViewWithData:(NSArray *)array
{
    _array = array;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    for (UIView *obj in self.subviews) {
        [obj removeFromSuperview];
    }
    
    int itemsCount = (int)_array.count;
    
    CGFloat width = self.frame.size.width;//一个page的宽度
    CGFloat height = self.frame.size.height;//一个page的高度
    
    int pagesNum = itemsCount/(columnsOneInPage *rowsOneInPage);
    

    if(itemsCount%(columnsOneInPage *rowsOneInPage) != 0)
    {
        pagesNum += 1;
    }
    
    CGFloat itemWidth = (width-Margin/2)/columnsOneInPage;
    CGFloat itemHeight = (height-Margin/2)/rowsOneInPage;
    
    
   
    //实例化一次
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    
    CGFloat contentViewWidth = self.frame.size.width * pagesNum;
    _scrollView.contentSize = CGSizeMake(contentViewWidth, self.frame.size.height);
    [self addSubview:_scrollView];
    
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _scrollView.contentSize.width, _scrollView.contentSize.height)];
    [_scrollView addSubview:_contentView];
    _contentView.backgroundColor = [UIColor whiteColor];

    BOOL flag = YES;
    for (int page = 0; page < pagesNum && flag; page++) {
        for (int row = 0; row < rowsOneInPage && flag; row++) {
            for ( int column = 0; column < columnsOneInPage; column++)
            {
                
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(column *itemWidth+Margin/2 + page * self.frame.size.width, row * itemHeight+Margin/2, itemWidth-Margin, itemHeight-Margin)];
                
                 int index =row*columnsOneInPage+column +page *(rowsOneInPage*columnsOneInPage);
                if(index> itemsCount-1)
                {
                    flag = NO;
                    break;
                }
                MenuItem *item = [[MenuItem alloc] initWithFrame:view.bounds];
                item.backgroundColor = [UIColor clearColor];
                [view addSubview:item];
                item.tag = 100+index;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
                [item addGestureRecognizer:tap];
                
                IconTypeItem *itemInfo = [_array objectAtIndex:index];
                item.title.text = itemInfo.title;
                [item.icon sd_setImageWithURL:[NSURL URLWithString: itemInfo.imgurl ]];
                item.selected.hidden = !itemInfo.checked;
                view.backgroundColor = [UIColor clearColor];
                [_contentView addSubview:view];
            }
        }
    }
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.frame.size.width/2-40, self.frame.size.height-22, 40,20)];
    _pageControl.numberOfPages = pagesNum;
    _pageControl.pageIndicatorTintColor = [UIColor redColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
    [self addSubview:_pageControl];
    
    //所在页不变
    [_scrollView scrollRectToVisible:CGRectMake(self.frame.size.width*_currentPage, 0,self.frame.size.width, self.frame.size.height) animated:NO];
    
}

#pragma mark- UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int pagesIndex = scrollView.contentOffset.x/self.frame.size.width;
    NSLog(@"pagesIndex:%d",pagesIndex);
    
    _pageControl.currentPage = pagesIndex;
    _currentPage = pagesIndex;
}

- (void)tapClick:(UITapGestureRecognizer *)tap
{
    int index = (int)(tap.view.tag-100);
    NSLog(@"index:%d",index);
    //去掉所有的选中
    for (IconTypeItem *obj in _array)
    {
        obj.checked = NO;
    }
    

   
    //单选
    IconTypeItem *itemInfo =  [_array objectAtIndex:index];
    itemInfo.checked = !itemInfo.checked;
    [self setNeedsLayout];
    if(self.delegate  && [self.delegate respondsToSelector:@selector(menuViewDidSelected:)])
    {
        [self.delegate menuViewDidSelected:index];
    }
}


@end

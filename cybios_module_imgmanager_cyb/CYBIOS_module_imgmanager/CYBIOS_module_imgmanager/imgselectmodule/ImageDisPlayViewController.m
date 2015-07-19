//
//  ImageDisPlayViewController.m
//  CYBIOS_module_imgmanager
//
//  Created by apple on 15/2/3.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "ImageDisPlayViewController.h"
#import "UIImageView+WebCache.h"
@interface ImageDisPlayViewController ()<UIScrollViewDelegate>
{
    CGRect oldFrame;
    CGRect largeFrame;
    int _currentImage;
    UIImageView* imageView;
}
@end

@implementation ImageDisPlayViewController

- (void)viewDidLoad {
    _currentImage = 0;
    [super viewDidLoad];
    [self initUI];
    [self initPhotos];
    // Do any additional setup after loading the view.
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    
    if (scrollView.tag == 1000) {
       return nil;
    }else
    {
//        UIView* view = [scrollView viewWithTag:scrollView.tag];
//        imageView = (UIImageView*)view;
        
        return scrollView.subviews[0];
    }
    
    
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
//    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
//    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
//    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
//    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
//    iv.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
//                            scrollView.contentSize.height * 0.5 + offsetY);
    
    if (scrollView.tag == 1000) {
        
        _currentImage = scrollView.contentOffset.x/self.SV.frame.size.width;
    }
    
}
-(void)initUI
{
    self.view.backgroundColor = [UIColor blackColor];
    self.SV =[[UIScrollView alloc]init];
    self.SV.tag = 1000;
    self.SV.delegate = self;
    self.SV.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self.view addSubview:self.SV];
    
}
-(void)initPhotos
{
    for (int i =0; i<self.photosArry.count; i++) {
        UIScrollView* imageSV = [[UIScrollView alloc]init];
        imageSV.tag = i;
        imageSV.delegate = self;
        UIImageView* imageV = [[UIImageView alloc]init];
        imageV.tag = i;
        imageV.userInteractionEnabled = YES;
//        UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
//        [imageV addGestureRecognizer:pinchGestureRecognizer];
        imageV.contentMode = UIViewContentModeScaleAspectFit;
        if([self.photosArry[i] isKindOfClass:[UIImage class]]){
        imageV.image = self.photosArry[i];
        }else
        {
            [imageV sd_setImageWithURL:[NSURL URLWithString:self.photosArry[i]] placeholderImage:nil];
        }
        
        imageSV.frame = CGRectMake(i*self.view.frame.size.width, -64, self.view.frame.size.width, self.view.frame.size.height);
        imageV.frame = imageSV.bounds;
        oldFrame = imageV.frame;
        imageV.backgroundColor = [UIColor whiteColor];
        [imageSV addSubview:imageV];
        [imageSV setMaximumZoomScale:2.0];
        [imageSV setMinimumZoomScale:1.0];

        [self.SV addSubview:imageSV];
        
    }
    self.SV.contentSize = CGSizeMake(self.photosArry.count*self.view.frame.size.width, 0);
    self.SV.pagingEnabled = YES;
}

-(void)pinchView:(UIPinchGestureRecognizer*)pinchGestureRecognizer
{
//    UIView *view = sender.view;
//    if (sender.state == UIGestureRecognizerStateBegan || sender.state == UIGestureRecognizerStateChanged) {
//        
//        view.transform = CGAffineTransformScale(view.transform, sender.scale, sender.scale);
//        sender.scale = 1;
//    }
    
    UIView *view = pinchGestureRecognizer.view;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged || pinchGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        if (view.frame.size.width < oldFrame.size.width) {
            view.frame = oldFrame;
            //让图片无法缩得比原图小
        }
        if (view.frame.size.width > 3 * oldFrame.size.width) {
            largeFrame = CGRectMake(0, 0, 320,568);
            view.frame = largeFrame;
        }
        pinchGestureRecognizer.scale = 1;
    }

    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

//
//  ImageViewController.m
//  dd_homework_final
//
//  Created by Admin on 03.12.17.
//  Copyright © 2017 Alex Agaev. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController () <UIScrollViewDelegate>
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIImage *image;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;




@property (nonatomic, getter = isAutoZoomed) BOOL autoZoomed;

@end

@implementation ImageViewController

-(void)setScrollView:(UIScrollView *)scrollView
{
    _scrollView = scrollView;
    _scrollView.minimumZoomScale = 0.2;
    _scrollView.maximumZoomScale = 2.0;
    _scrollView.delegate =self;
    self.scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}


- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    self.autoZoomed = NO;
}

-(void)setImageURL:(NSURL *)imageURL
{
    _imageURL =imageURL;
    [self startDownLoadImage];
}

-(void)startDownLoadImage
{
    self.image =nil;
    if (self.imageURL) {
        [self.spinner startAnimating];
        NSURLRequest *request = [NSURLRequest requestWithURL:self.imageURL];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
                                                        completionHandler:
        ^(NSURL *localfile, NSURLResponse *response, NSError *error) {
            if (!error) {
                if ([request.URL isEqual:self.imageURL]) {
                    UIImage *image = [UIImage
                            imageWithData:[NSData dataWithContentsOfURL:localfile]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.image =image;
                    });
                }
            }
        }];
        [task resume];
    }
}

-(UIImageView *)imageView
{
    if (!_imageView)_imageView=[[UIImageView alloc] init];
    return _imageView;
}

-(UIImage *)image
{
    return self.imageView.image;
}

-(void)setImage:(UIImage *)image
{
    self.scrollView.zoomScale =1.0;
    self.imageView.image =image;
    self.imageView.frame =CGRectMake(0, 0, image.size.width, image.size.height);
    self.scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
    self.autoZoomed = YES;
    [self zoomScaleToFit];
    [self.spinner stopAnimating];
}

- (void)zoomScaleToFit
{
    if ((self.isAutoZoomed)&&(self.imageView.bounds.size.width)
                           &&(self.scrollView.bounds.size.width)) {
        CGFloat widthRatio  = self.scrollView.bounds.size.width
                                                       / self.imageView.bounds.size.width;
        CGFloat heightRatio = (self.scrollView.bounds.size.height
                               - self.navigationController.navigationBar.frame.size.height
                               - self.tabBarController.tabBar.frame.size.height
                               - MIN([UIApplication sharedApplication].statusBarFrame.size.height,
                                     [UIApplication sharedApplication].statusBarFrame.size.width)
                               )/ self.imageView.bounds.size.height;
        self.scrollView.zoomScale = (widthRatio > heightRatio) ? widthRatio : heightRatio;
    }
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self zoomScaleToFit];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.image == nil) {
        [self startDownLoadImage];
    }
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.scrollView addSubview:self.imageView];
}

@end

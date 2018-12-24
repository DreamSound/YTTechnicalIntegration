//
//  XYPhotoPickerBrowserPhotoScrollView.m
//  浏览器相册
//
//  Created by cyp on 16/3/15.
//  Copyright (c) 2016年 XY. All rights reserved.
//

#import "XYPhotoPickerBrowserPhotoScrollView.h"

#import <WebImage/WebImage.h>
#import "DACircularProgressView.h"
#import "SSMBProgressHUD.h"


#import "XYPhotoPickerBrowserPhoto.h"

#define XYPickerProgressViewW 50
#define XYPickerProgressViewH 50

@interface XYPhotoPickerBrowserPhotoScrollView()<SSMBProgressHUDDelegate>
{
    CGFloat maxScale;
    CGFloat minScale;
    CGFloat zoomScaleFromInit;
    BOOL isBigScale;
    SSMBProgressHUD* _hud;
}


//图片下载进度
@property (nonatomic ,weak) DACircularProgressView *progressView;

@end

@implementation XYPhotoPickerBrowserPhotoScrollView

- (id)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}
- (void)initView{
    // Image view
    _photoImageView = [[XYPhotoPickerBrowserPhotoImageView alloc] initWithFrame:self.bounds];
    _photoImageView.tapDelegate = self;
    _photoImageView.contentMode = UIViewContentModeCenter;
    _photoImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:_photoImageView];
    
    // Setup
    self.backgroundColor = [UIColor blackColor];
    self.delegate = self;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.decelerationRate = UIScrollViewDecelerationRateFast;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    //进度
//    DACircularProgressView *progressView = [[DACircularProgressView alloc] init];
//    progressView.frame = CGRectMake(0, 0, XYPickerProgressViewW, XYPickerProgressViewH);
//    progressView.center = CGPointMake([UIScreen mainScreen].bounds.size.width * 0.5, [UIScreen mainScreen].bounds.size.height * 0.5);
//    progressView.roundedCorners = YES;
//    progressView.thicknessRatio = 0.1;
//    progressView.roundedCorners = NO;
//    progressView.hidden = YES;
//    [self addSubview:progressView];
//    self.progressView = progressView;
    
    
    _hud = [[SSMBProgressHUD alloc]initWithView:self];
    _hud.delegate = self;
    _hud.mode = SSMBProgressHUDModeDeterminate;
    [self addSubview:_hud];
}

- (void)setPhoto:(XYPhotoPickerBrowserPhoto *)photo{
    _photo = photo;
    __weak typeof(self) weakSelf = self;
    if (photo.photoURL.absoluteString.length) {
        _photoImageView.contentMode = UIViewContentModeScaleAspectFit;
        if (_photoImageView.image == nil) {
//            [_hud show:YES];
            [_hud showAnimated:YES];
            [self setProgress:0.01];
        }
        // 网络URL
        [_photoImageView sd_setImageWithURL:photo.photoURL placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            [self setProgress:(double)receivedSize / expectedSize];
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [self setProgress:1.0];
            if (image) {
                _photoImageView.image = image;
                [weakSelf displayImage];
            }else{
                [_photoImageView removeScaleBigAndLongTap];
                [weakSelf displayImage];
            }
        }];
    }  else {
        _photoImageView.image = photo.photoImage;
        [self displayImage];
    }
}

- (UIImage *)getVisibleImage{
    return _photoImageView.image;
}

// Get and display image
- (void)displayImage {
    // Reset
    self.maximumZoomScale = 1;
    self.minimumZoomScale = 1;
    self.zoomScale = 1;
    self.contentSize = CGSizeMake(0, 0);
    // Get image from browser as it handles ordering of fetching
    UIImage *img = _photoImageView.image;
    if (img) {
        // Set image
        _photoImageView.image = img;
        _photoImageView.hidden = NO;
        // Setup photo frame
        CGRect photoImageViewFrame;
        photoImageViewFrame.origin = CGPointZero;
        photoImageViewFrame.size = img.size;
        _photoImageView.frame = photoImageViewFrame;
        self.contentSize = photoImageViewFrame.size;
        // Set zoom to minimum zoom
        [self setMaxMinZoomScalesForCurrentBounds];
    }
    [self setNeedsLayout];
}
- (void)setMaxMinZoomScalesForCurrentBounds {
    // Reset
    self.maximumZoomScale = 1;
    self.minimumZoomScale = 1;
    self.zoomScale = 1;
    // Bail
    if (_photoImageView.image == nil) return;
    // Sizes
    CGSize boundsSize = self.bounds.size;
    CGSize imageSize = _photoImageView.frame.size;
    _photoImageView.contentMode = UIViewContentModeCenter;
    
    // Calculate Min
    CGFloat xScale = boundsSize.width / imageSize.width;    // the scale needed to perfectly fit the image width-wise
    CGFloat yScale = boundsSize.height / imageSize.height;  // the scale needed to perfectly fit the image height-wise
    minScale = MIN(xScale, yScale);                 // use minimum of these to allow the image to become fully visible
    // If image is smaller than the screen then ensure we show it at
    // min scale of 1
    if (xScale > 1 && yScale > 1) {
        minScale = 1.0;
    }
    maxScale = 2*minScale;
    
    if (imageSize.height > imageSize.width) {//超长图特殊处理
        if (imageSize.height/imageSize.width > [[UIScreen mainScreen] bounds].size.height/[UIScreen mainScreen].bounds.size.width) {
            minScale = xScale;
            maxScale = xScale*2;
        }
    }else if (imageSize.height < imageSize.width) {//超宽图特殊处理
        _photoImageView.contentMode = UIViewContentModeScaleAspectFill;
        if ((CGFloat)imageSize.width/imageSize.height > (CGFloat)16.0f/9.0f) {
            minScale = xScale;
            
            //            minScale = yScale/2; //超宽图默认高度为屏幕高度一半
        }
        maxScale = yScale;
    }
    
    // Set
    self.maximumZoomScale = maxScale;
    self.minimumZoomScale = minScale;
    self.zoomScale = minScale;
    zoomScaleFromInit = minScale;
    // Reset position
    _photoImageView.frame = CGRectMake(0, 0, _photoImageView.frame.size.width, _photoImageView.frame.size.height);
    [self setNeedsLayout];
}
#pragma mark - Layout
- (void)layoutSubviews {
    // Super
    [super layoutSubviews];
    // Center the image as it becomes smaller than the size of the screen
    CGSize boundsSize = self.bounds.size;
    CGRect frameToCenter = _photoImageView.frame;
    // Horizontally
    if (frameToCenter.size.width < boundsSize.width) {
        frameToCenter.origin.x = floorf((boundsSize.width - frameToCenter.size.width) / 2.0);
    } else {
        frameToCenter.origin.x = 0;
    }
    // Vertically
    if (frameToCenter.size.height < boundsSize.height) {
        frameToCenter.origin.y = floorf((boundsSize.height - frameToCenter.size.height) / 2.0);
    } else {
        frameToCenter.origin.y = 0;
    }
    // Center
    if (!CGRectEqualToRect(_photoImageView.frame, frameToCenter))
        _photoImageView.frame = frameToCenter;
}
#pragma mark - 设置进度
- (void)setProgress:(CGFloat)progress{
    _hud.progress = progress;
    if (progress == 0) return ;
    if (progress / 1.0 != 1.0) {
        _hud.progress = progress;
    }else{
        [_hud setHidden:YES];
    }
    
    
//    self.progressView.hidden = NO;
//    if (progress == 0) return ;
//    if (progress / 1.0 != 1.0) {
//        [self.progressView setProgress:progress animated:YES];
//    }else{
//        [self.progressView removeFromSuperview];
//        self.progressView = nil;
//    }
}
#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _photoImageView;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark -- XYPhotoPickerBrowserPhotoImageViewDelegate
//单击
- (void)imageView:(UIImageView *)imageView singleTapDetected:(UITapGestureRecognizer *)touch{
    if ([self.photoScrollViewDelegate respondsToSelector:@selector(pickerPhotoScrollViewDidSingleClick:)]) {
        [self.photoScrollViewDelegate performSelector:@selector(pickerPhotoScrollViewDidSingleClick:) withObject:nil];
    }
}
//双击
- (void)imageView:(UIImageView *)imageView doubleTapDetected:(UITapGestureRecognizer *)touch{
    CGSize imageViewSize = _photoImageView.frame.size;
    if (imageViewSize.height < imageViewSize.width) {//宽图特殊处理  宽图放大 高要变成屏幕高度
        [self handleImageViewDoubleTap:[touch locationInView:nil]];//locationInView:传nil 传gesture.view坐标不对
    }else{
        [self handleImageViewDoubleTap:[touch locationInView:imageView]];
    }
}
//长按
- (void)imageView:(UIImageView *)imageView longTapDetected:(UILongPressGestureRecognizer *)touch{
    if ([self.photoScrollViewDelegate respondsToSelector:@selector(pickerPhotoScrollViewDidLongPressed:)]) {
        [self.photoScrollViewDelegate performSelector:@selector(pickerPhotoScrollViewDidLongPressed:) withObject:self];
    }
}
- (void)handleImageViewDoubleTap:(CGPoint)touchPoint
{
    CGSize imageViewSize = _photoImageView.frame.size;
//    CGSize imageSize = _photoImageView.image.size;
//    CGSize boundsSize = self.bounds.size;
    if (imageViewSize.height > imageViewSize.width) {//宽图特殊处理  宽图放大 高要变成屏幕高度
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:0.30];
//        CGFloat photoImageViewX = 0;
//        CGFloat photoImageViewY = 0;
//        CGFloat photoImageViewWidth = 0;
//        CGFloat photoImageViewHeight = 0;
//        if (!isBigScale) {
//            photoImageViewWidth = boundsSize.height * ((CGFloat)imageSize.width/imageSize.height);
//            photoImageViewHeight = boundsSize.height;
//            isBigScale = YES;
//        }else{
//            photoImageViewWidth = boundsSize.width;
//            photoImageViewHeight =  boundsSize.width * ((CGFloat)imageSize.height/imageSize.width);
//            isBigScale = NO;
//        }
//        // Horizontally
//        if (photoImageViewWidth < boundsSize.width) {
//            photoImageViewX = floorf((boundsSize.width - photoImageViewWidth) / 2.0);
//        } else {
//            photoImageViewX = 0;
//        }
//        // Vertically
//        if (photoImageViewHeight < boundsSize.height) {
//            photoImageViewY = floorf((boundsSize.height - photoImageViewHeight) / 2.0);
//        } else {
//            photoImageViewY = 0;
//        }
//        _photoImageView.frame = CGRectMake(photoImageViewX, photoImageViewY, photoImageViewWidth, photoImageViewHeight);
//        CGFloat touchPointToImageViewX = touchPoint.x + self.contentOffset.x;
//        CGFloat contentOffsetX = touchPointToImageViewX * photoImageViewWidth/imageViewSize.width - touchPoint.x;
//        self.contentSize = _photoImageView.frame.size;
//
//        if (contentOffsetX > photoImageViewWidth) {
//            contentOffsetX = photoImageViewWidth;
//        }
//        if (contentOffsetX < 0) {
//            contentOffsetX = 0;
//        }
//        [self setContentOffset:CGPointMake(contentOffsetX, 0)];
//        NSLog(@"contentOffsetX = %f \n touchPointToImageViewX = %f \n photoImageViewWidth = %f \n imageViewSize = %f \n",contentOffsetX,touchPointToImageViewX,photoImageViewWidth,imageViewSize.width);
//        [UIView commitAnimations];
        if (!isBigScale) {
            float newScale = maxScale;
            CGRect zoomRect = [self zoomRectForScale:newScale withCenter:touchPoint];
            [self zoomToRect:zoomRect animated:YES];
            isBigScale = YES;
        }else{
            float newScale = minScale;
            CGRect zoomRect = [self zoomRectForScale:newScale withCenter:touchPoint];
            [self zoomToRect:zoomRect animated:YES];
            isBigScale = NO;
        }
    }else{
        if (!isBigScale) {
            float newScale = maxScale;
            CGRect zoomRect = [self zoomRectForScale:newScale withCenter:touchPoint];
            [self zoomToRect:zoomRect animated:YES];
            isBigScale = YES;
        }else{
            float newScale = minScale;
            CGRect zoomRect = [self zoomRectForScale:newScale withCenter:touchPoint];
            [self zoomToRect:zoomRect animated:YES];
            isBigScale = NO;
        }
    }
}
- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
{
    CGRect zoomRect;
    zoomRect.size.height = self.frame.size.height / scale;
    zoomRect.size.width  = self.frame.size.width / scale;
    zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}
#pragma mark -- MBProgressHUDDelegate
- (void)hudWasHidden:(SSMBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [_hud removeFromSuperview];
    _hud = nil;
}

@end

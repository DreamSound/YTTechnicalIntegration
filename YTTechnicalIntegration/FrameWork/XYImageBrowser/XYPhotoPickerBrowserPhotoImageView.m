//
//  XYPhotoPickerBrowserPhotoImageView.m
//  浏览器相册
//
//  Created by cyp on 16/3/15.
//  Copyright (c) 2016年 XY. All rights reserved.
//

#import "XYPhotoPickerBrowserPhotoImageView.h"

@interface XYPhotoPickerBrowserPhotoImageView()

@property (nonatomic ,weak) UITapGestureRecognizer* scaleBigTap;

@property (nonatomic ,weak) UILongPressGestureRecognizer* longTap;

@end

@implementation XYPhotoPickerBrowserPhotoImageView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.userInteractionEnabled = YES;
        // 监听手势
        [self addGesture];
    }
    return self;
}

- (id)initWithImage:(UIImage *)image {
    if ((self = [super initWithImage:image])) {
        self.userInteractionEnabled = YES;
        // 监听手势
        [self addGesture];
    }
    return self;
}
#pragma mark -监听手势
- (void) addGesture{
    self.contentMode = UIViewContentModeScaleAspectFit;
    // 双击手势
    UITapGestureRecognizer *scaleBigTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    scaleBigTap.numberOfTapsRequired = 2;
    scaleBigTap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:scaleBigTap];
    self.scaleBigTap = scaleBigTap;
    // 单击手势
    UITapGestureRecognizer *disMissTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    disMissTap.numberOfTapsRequired = 1;
    disMissTap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:disMissTap];
    // 只能有一个手势存在
    [disMissTap requireGestureRecognizerToFail:scaleBigTap];
    // 长按手势
    UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongTap:)];
    [self addGestureRecognizer:longTap];
    self.longTap = longTap;
}
#pragma mark -- 手势实现
- (void)handleSingleTap:(UITapGestureRecognizer *)touch {
    if ([_tapDelegate respondsToSelector:@selector(imageView:singleTapDetected:)])
        [_tapDelegate imageView:self singleTapDetected:touch];
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)touch {
    if ([_tapDelegate respondsToSelector:@selector(imageView:doubleTapDetected:)])
        [_tapDelegate imageView:self doubleTapDetected:touch];
}
- (void)handleLongTap:(UILongPressGestureRecognizer *)touch {
    if (touch.state == UIGestureRecognizerStateBegan) {
        if ([_tapDelegate respondsToSelector:@selector(imageView:longTapDetected:)])
            [_tapDelegate imageView:self longTapDetected:touch];
    }
    
}
- (void)removeScaleBigAndLongTap{
    [self removeGestureRecognizer:self.scaleBigTap];
    [self removeGestureRecognizer:self.longTap];
}
@end

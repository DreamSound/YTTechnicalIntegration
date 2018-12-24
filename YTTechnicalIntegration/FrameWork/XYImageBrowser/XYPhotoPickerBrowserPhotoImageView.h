//
//  XYPhotoPickerBrowserPhotoImageView.h
//  浏览器相册
//
//  Created by cyp on 16/3/15.
//  Copyright (c) 2016年 XY. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XYPhotoPickerBrowserPhotoImageViewDelegate <NSObject>

@optional
//单击
- (void)imageView:(UIImageView *)imageView singleTapDetected:(UITapGestureRecognizer *)touch;
//双击
- (void)imageView:(UIImageView *)imageView doubleTapDetected:(UITapGestureRecognizer *)touch;
//长按
- (void)imageView:(UIImageView *)imageView longTapDetected:(UILongPressGestureRecognizer *)touch;
@end

@interface XYPhotoPickerBrowserPhotoImageView : UIImageView

@property (nonatomic, weak) id <XYPhotoPickerBrowserPhotoImageViewDelegate> tapDelegate;


- (void)removeScaleBigAndLongTap;


@end

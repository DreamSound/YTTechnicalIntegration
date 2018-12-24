//
//  XYPhotoPickerBrowserPhotoScrollView.h
//  浏览器相册
//
//  Created by cyp on 16/3/15.
//  Copyright (c) 2016年 XY. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XYPhotoPickerBrowserPhotoImageView.h"

@class XYPhotoPickerBrowserPhoto;
@class XYPhotoPickerBrowserPhotoScrollView;


@protocol XYPhotoPickerBrowserPhotoScrollViewDelegate <NSObject>
@optional
// 单击调用
- (void) pickerPhotoScrollViewDidSingleClick:(XYPhotoPickerBrowserPhotoScrollView *)photoScrollView;
// 长按调用
- (void) pickerPhotoScrollViewDidLongPressed:(XYPhotoPickerBrowserPhotoScrollView *)photoScrollView;
@end



@interface XYPhotoPickerBrowserPhotoScrollView : UIScrollView<XYPhotoPickerBrowserPhotoImageViewDelegate,UIScrollViewDelegate>

/**
 *  数据源
 */
@property (nonatomic ,strong) XYPhotoPickerBrowserPhoto* photo;
/**
 *  图片显示器
 */
@property (nonatomic ,strong) XYPhotoPickerBrowserPhotoImageView* photoImageView;


@property (nonatomic ,weak) id<XYPhotoPickerBrowserPhotoScrollViewDelegate> photoScrollViewDelegate;

//获取当前显示的image对象
- (UIImage *)getVisibleImage;
@end

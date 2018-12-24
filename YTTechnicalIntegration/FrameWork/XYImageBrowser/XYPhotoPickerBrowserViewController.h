//
//  XYPhotoPickerBrowserViewController.h
//  浏览器相册
//
//  Created by cyp on 16/3/15.
//  Copyright (c) 2016年 XY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYPhotoPickerBrowserViewController : UIViewController
/**
 *  初始化
 *
 *  @param photosArr     数据源
 *  @param currentNumber 当前显示number  0开始
 *
 *  @return self
 */
- (instancetype)initWithPhotoArr:(NSArray *)photosArr andCurrentNumber:(int)currentNumber;

@end

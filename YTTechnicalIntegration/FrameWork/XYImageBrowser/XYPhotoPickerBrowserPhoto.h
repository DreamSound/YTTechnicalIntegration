//
//  XYPhotoPickerBrowserPhoto.h
//  浏览器相册
//
//  Created by cyp on 16/3/15.
//  Copyright (c) 2016年 XY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface XYPhotoPickerBrowserPhoto : NSObject

/**
 *  传值支持URL Image 本地路径
 */
@property (nonatomic, strong) id photoObj;

/**
 *  URL地址
 */
@property (nonatomic, strong) NSURL *photoURL;
/**
 *  本地路径
 */
@property (nonatomic, copy) NSString *photoPath;
/**
 *  原图或全屏图，也就是要显示的图
 */
@property (nonatomic, strong) UIImage *photoImage;
/**
 *  缩略图
 */
@property (nonatomic, strong) UIImage *thumbImage;
/**
 *  传入一个图片对象，可以是URL/UIImage/NSString，返回一个实例
 */
+ (instancetype)photoAnyImageObj:(id)imageObj;
- (instancetype)initWithAnyObj:(id)imageObj;

@end

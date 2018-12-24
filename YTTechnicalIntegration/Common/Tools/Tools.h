//
//  Tools.h
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/11/13.
//  Copyright © 2018 hiteam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Tools : NSObject


#pragma mark - Date
/*!
 将Date转换为指定格式的字符串
 @param  date        需要转换的date对象
 @param  formatter   对应的时间格式
 */
+ (NSString *)dateStrWithDate:(NSDate *)date formatter:(NSString *)formatter;

#pragma mark - Image
/*!
 通过颜色与大小获取一张纯色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/*!
 通过贝塞尔曲线与大小获取一张图片
 */
+ (UIImage *)imageWithBezierPath:(UIBezierPath *)path size:(CGSize)size;

/*!
 获取视图的一部分截图
 @param  view   获取截图的view
 @param  rect   截图的位置和大小
 */
+ (UIImage *)snapshot:(UIView *)view rect:(CGRect)rect;

@end


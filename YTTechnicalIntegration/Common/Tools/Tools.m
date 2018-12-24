//
//  Tools.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/11/13.
//  Copyright © 2018 hiteam. All rights reserved.
//

#import "Tools.h"

@implementation Tools


+ (NSString *)dateStrWithDate:(NSDate *)date formatter:(NSString *)formatter{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatter;
    
    return [dateFormatter stringFromDate:date];
    
}


+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size{
    
    UIGraphicsBeginImageContext(size);
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    return UIGraphicsGetImageFromCurrentImageContext();
    
}

+ (UIImage *)imageWithBezierPath:(UIBezierPath *)path size:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    [bezierPath appendPath:path];
    [bezierPath fill];
    
    return UIGraphicsGetImageFromCurrentImageContext();
}

+ (UIImage *)snapshot:(UIView *)view rect:(CGRect)rect{
    
    UIGraphicsBeginImageContextWithOptions(rect.size,YES,0);
    [view drawViewHierarchyInRect:rect afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

@end

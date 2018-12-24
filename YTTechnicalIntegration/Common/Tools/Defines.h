//
//  Defines.h
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/7/17.
//  Copyright © 2018年 hiteam. All rights reserved.
//

#ifndef Defines_h
#define Defines_h

#pragma mark - Bounds

#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

#pragma mark - View

#define rootWindow [UIApplication sharedApplication].keyWindow

#pragma mark - 适配
//iPhone X
#define kIsIphoneX screenHeight==812
#define kBottomSafeSpace (screenHeight==812 ? 34 : 0)
#define kTopSafeSpace (screenHeight==812 ? 44 : 20)
#define kTopSlimSafeSpace (screenHeight==812 ? 24 : 0)

#pragma mark - 颜色

#define colorFromHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000)>>16))/255.0 green:((float)((rgbValue & 0xFF00)>>8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define colorFromRGB(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]


#pragma mark - Other

#define weak_self __weak typeof (self) weakSelf = self;
#define kWindow [UIApplication sharedApplication].keyWindow

#endif /* Defines_h */

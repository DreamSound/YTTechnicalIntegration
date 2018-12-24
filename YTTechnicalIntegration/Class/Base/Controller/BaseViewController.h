//
//  BaseViewController.h
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/7/18.
//  Copyright © 2018年 hiteam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@interface BaseViewController : UIViewController

/*
 * 设置item
 */
-(UIButton *)addItemWithTitle:(NSString *)title imageName:(NSString *)imageName selector:(SEL)selector location:(BOOL)isLeft;

@end

//
//  BaseListViewItem.h
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/11/19.
//  Copyright © 2018 hiteam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseListViewItem : NSObject

@property (nonatomic ,strong)NSString *controllerName;
@property (nonatomic ,strong)NSString *title;

+ (BaseListViewItem *)listItemWithTitle:(NSString *)title controllerName:(NSString *)controllerName;

@end

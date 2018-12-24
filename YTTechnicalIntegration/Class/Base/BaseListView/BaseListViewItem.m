//
//  BaseListViewItem.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/11/19.
//  Copyright © 2018 hiteam. All rights reserved.
//

#import "BaseListViewItem.h"

@implementation BaseListViewItem

+ (BaseListViewItem *)listItemWithTitle:(NSString *)title controllerName:(NSString *)controllerName{
    
    BaseListViewItem *item = [[BaseListViewItem alloc] init];
    item.title = title;
    item.controllerName = controllerName;
    return item;
    
}

@end

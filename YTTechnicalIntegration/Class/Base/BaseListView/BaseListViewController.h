//
//  BaseListViewController.h
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/11/15.
//  Copyright © 2018 hiteam. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseListViewItem.h"

@interface BaseListViewController : BaseViewController

@property (nonatomic ,strong) NSArray <BaseListViewItem *>*items;

@end




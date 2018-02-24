//
//  AppDelegate.h
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/2/24.
//  Copyright © 2018年 hiteam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

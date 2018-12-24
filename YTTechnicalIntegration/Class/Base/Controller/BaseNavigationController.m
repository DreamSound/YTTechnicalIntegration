//
//  BaseNavigationController.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/11/20.
//  Copyright © 2018 hiteam. All rights reserved.
//

#import "BaseNavigationController.h"
#import "Tools.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = YES;
    [self.navigationBar setBackgroundImage:[Tools imageWithColor:colorFromHex(0x1350cd) size:CGSizeMake(1, 64)] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:17]};
    self.interactivePopGestureRecognizer.delegate = (id)self;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.viewControllers.count > 0 ) {
        UIButton  *goBack = [UIButton buttonWithType:UIButtonTypeCustom];
        goBack.frame = CGRectMake(0, 0, 40, 24);
        goBack.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 25);
        [goBack addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
        [goBack setImage:[UIImage imageNamed:@"nav_left_return"] forState:UIControlStateNormal];
        viewController.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithCustomView:goBack];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (self.childViewControllers.count == 1) {
        return NO;
    }
    return YES;
}

#pragma mark - 返回
-(void)clickBack
{
    [self popViewControllerAnimated:YES];
}


@end

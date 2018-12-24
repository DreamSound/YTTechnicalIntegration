//
//  DrawViewController.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/11/13.
//  Copyright © 2018 hiteam. All rights reserved.
//

#import "DrawViewController.h"
#import "DrawTestViewController.h"
#import "GradientColorViewController.h"
#import "ChangeImageColorViewController.h"
#import "ThermoSensitiveViewController.h"
#import "HeatMapViewController.h"

@implementation DrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setItem];
}

#pragma mark - Create Item

- (void)setItem{
    
    self.items = @[[BaseListViewItem listItemWithTitle:@"渐变色" controllerName:@"GradientColorViewController"],
                   [BaseListViewItem listItemWithTitle:@"openGL" controllerName:@"DrawTestViewController"],
                   [BaseListViewItem listItemWithTitle:@"图片变色" controllerName:@"ChangeImageColorViewController"],
                   [BaseListViewItem listItemWithTitle:@"温感图" controllerName:@"ThermoSensitiveViewController"],
                   [BaseListViewItem listItemWithTitle:@"热力图" controllerName:@"HeatMapViewController"]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

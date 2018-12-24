//
//  HomeViewController.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/11/19.
//  Copyright © 2018 hiteam. All rights reserved.
//

#import "HomeViewController.h"

#import "BaseControlVC.h"
#import "DrawViewController.h"
#import "NetVC.h"
#import "ThreeDimensionalViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createListData];
    self.navigationItem.title = @"示例列表";
}

#pragma mark - Create ListData
- (void)createListData{
    
    self.items = @[[BaseListViewItem listItemWithTitle:@"基础控件" controllerName:@"BaseControlVC"],
                   [BaseListViewItem listItemWithTitle:@"绘制" controllerName:@"DrawViewController"],
                   [BaseListViewItem listItemWithTitle:@"网络" controllerName:@"NetVC"],
                   [BaseListViewItem listItemWithTitle:@"3D" controllerName:@"ThreeDimensionalViewController"]];
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

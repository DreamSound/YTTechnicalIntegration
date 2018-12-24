//
//  BaseControlVC.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/7/16.
//  Copyright © 2018年 hiteam. All rights reserved.
//

#import "BaseControlVC.h"

#import "LayerVC.h"
#import "ViewVC.h"
#import "TableViewVC.h"
#import "CollectionViewVC.h"

@implementation BaseControlVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

#pragma mark - Set Up
- (void)setUp{
    
    self.items = @[[BaseListViewItem listItemWithTitle:@"图层" controllerName:@"LayerVC"],
                   [BaseListViewItem listItemWithTitle:@"视图" controllerName:@"ViewVC"],
                   [BaseListViewItem listItemWithTitle:@"TableView" controllerName:@"TableViewVC"],
                   [BaseListViewItem listItemWithTitle:@"CollectionView" controllerName:@"CollectionViewVC"]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

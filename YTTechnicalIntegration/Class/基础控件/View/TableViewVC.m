//
//  TableViewVC.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/7/24.
//  Copyright © 2018年 hiteam. All rights reserved.
//

#import "TableViewVC.h"
#import "TableViewRotateVC.h"
#import "TableViewMoveCellVC.h"
@interface TableViewVC ()


@end

@implementation TableViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUp];
}
#pragma mark - Set up
- (void)setUp{
    self.items = @[[BaseListViewItem listItemWithTitle:@"可编辑cell" controllerName:@"TableViewMoveCellVC"],
                   [BaseListViewItem listItemWithTitle:@"翻转Tableview" controllerName:@"TableViewRotateVC"]];
}

@end

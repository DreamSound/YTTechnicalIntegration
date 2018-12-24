//
//  CollectionViewVC.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/11/23.
//  Copyright © 2018 hiteam. All rights reserved.
//

#import "CollectionViewVC.h"
#import "CalendarViewController.h"

@interface CollectionViewVC ()

@end

@implementation CollectionViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setItem];
}

#pragma mark - Set Item
- (void)setItem{
    
    self.items = @[[BaseListViewItem listItemWithTitle:@"日历" controllerName:@"CalendarViewController"]];
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

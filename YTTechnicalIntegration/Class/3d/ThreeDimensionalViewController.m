//
//  ThreeDimensionalViewController.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/11/15.
//  Copyright © 2018 hiteam. All rights reserved.
//

#import "ThreeDimensionalViewController.h"
#import "LookScenceViewController.h"

@interface ThreeDimensionalViewController ()

@end

@implementation ThreeDimensionalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setData];
}


#pragma mark - Set Data
- (void)setData{
    
    BaseListViewItem *lookScenceItem = [[BaseListViewItem alloc] init];
    lookScenceItem.title = @"3D场景";
    lookScenceItem.controllerName = @"LookScenceViewController";
    self.items = @[lookScenceItem];
    
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

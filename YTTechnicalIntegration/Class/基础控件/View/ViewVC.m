//
//  ViewVC.m
//  YTTechnicalIntegration
//
//  Created by 杨玥桐 on 2018/12/11.
//  Copyright © 2018 hiteam. All rights reserved.
//

#import "ViewVC.h"
#import "MaskGifViewController.h"
#import "CutImageViewController.h"

@interface ViewVC ()

@end

@implementation ViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUp];
}
#pragma mark - Set up
- (void)setUp{
    self.items = @[[BaseListViewItem listItemWithTitle:@"遮罩GIf" controllerName:@"MaskGifViewController"],
                   [BaseListViewItem listItemWithTitle:@"切割图片" controllerName:@"CutImageViewController"]];
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

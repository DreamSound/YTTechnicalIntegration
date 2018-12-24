//
//  LineViewController.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/11/24.
//  Copyright © 2018 hiteam. All rights reserved.
//

#import "LineChartViewController.h"

@interface LineChartViewController ()

@end

@implementation LineChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawBack];
    [self drawLine];
    
}

#pragma mark - 绘制背景图

- (void)drawBack{
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 2;
    [path moveToPoint:CGPointMake(50, 100)];
    [path addLineToPoint:CGPointMake(50, screenHeight - 100)];
    [path addLineToPoint:CGPointMake(screenWidth-50, screenHeight - 100)];
    [[UIColor blackColor] set];
    [path stroke];
}

#pragma mark - 绘制折线

- (void)drawLine{
    
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

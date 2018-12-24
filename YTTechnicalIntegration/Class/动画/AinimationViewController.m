//
//  AinimationViewController.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/2/24.
//  Copyright © 2018年 hiteam. All rights reserved.
//

#import "AinimationViewController.h"
#import "CanvasView.h"
@interface AinimationViewController ()

@property (nonatomic ,strong)NSArray *pointArray;

@end

@implementation AinimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
    CanvasView * canvasView = [[CanvasView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:canvasView];
    
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

//
//  DynamicViewController.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/3/26.
//  Copyright © 2018年 hiteam. All rights reserved.
//

#import "DynamicViewController.h"

@interface DynamicViewController ()

@property (nonatomic ,strong) UIView *boll;
@property (nonatomic ,strong) UIView *line;

@end

@implementation DynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)createUI{
    _boll = [[UIView alloc] init];
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

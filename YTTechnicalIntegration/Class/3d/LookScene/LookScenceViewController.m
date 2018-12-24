//
//  LookScenceViewController.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/11/15.
//  Copyright © 2018 hiteam. All rights reserved.
//

#import "LookScenceViewController.h"
#import "SPCreateScnenPointView.h"
#import "Masonry.h"
@interface LookScenceViewController ()

@property (nonatomic ,strong) SPCreateScnenPointView *scnenView;

@end

@implementation LookScenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
    
    
}
#pragma mark - Create UI
- (void)createUI{
    UIButton *open3DButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [open3DButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [open3DButton setTitle:@"打开3D界面" forState:UIControlStateNormal];
    [open3DButton addTarget:self action:@selector(open3DAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:open3DButton];
    [open3DButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

#pragma mark - Button Action
- (void)open3DAction{
    SPCreateScnenPointView *scnenView = [[SPCreateScnenPointView alloc] init];
    [scnenView show];
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

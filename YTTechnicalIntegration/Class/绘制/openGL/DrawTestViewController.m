//
//  DrawTestViewController.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/2/27.
//  Copyright © 2018年 hiteam. All rights reserved.
//

#import "DrawTestViewController.h"
#import "OpenGLView.h"



@interface DrawTestViewController (){
    GLuint colorBuffer;
    GLuint frameBuffer;
}

@property (nonatomic ,strong)OpenGLView *glView;

@end

@implementation DrawTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup{
    
    _glView = [[OpenGLView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    self.view = _glView;
   
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

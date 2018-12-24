//
//  BaseViewController.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/7/18.
//  Copyright © 2018年 hiteam. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
}


-(UIButton *)addItemWithTitle:(NSString *)title imageName:(NSString *)imageName selector:(SEL)selector location:(BOOL)isLeft
{
    UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
    if (imageName!=nil&&![imageName isEqualToString:@""]) {
        UIImage *image=[UIImage imageNamed:imageName];
        image=[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0,0, 0, -40)];
        [btn setImage:image forState:UIControlStateNormal];
        if (isLeft) {
            [btn setImageEdgeInsets:UIEdgeInsetsMake(0,-27, 0, 0)];
        }
    }else{
        if (isLeft) {
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0,-27, 0, 0)];
        }else{
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0,0, 0, -30)];
        }
    }
    
    [btn setFrame:CGRectMake(0,30,45,40)];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.textAlignment=NSTextAlignmentRight;
    btn.titleLabel.font =[UIFont systemFontOfSize:15];
    [btn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * item=[[UIBarButtonItem alloc]initWithCustomView:btn];
    if (isLeft==YES) {
        btn.left = 10;
        self.navigationItem.leftBarButtonItem=item;
    }else{
        btn.left = screenWidth - 50;
        btn.top = 23;
        self.navigationItem.rightBarButtonItem=item;
    }
    
    return btn;
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

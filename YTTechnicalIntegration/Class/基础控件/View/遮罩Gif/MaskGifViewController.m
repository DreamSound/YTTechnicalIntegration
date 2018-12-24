//
//  MaskGifViewController.m
//  YTTechnicalIntegration
//
//  Created by 杨玥桐 on 2018/12/11.
//  Copyright © 2018 hiteam. All rights reserved.
//

#import "MaskGifViewController.h"
#import <WebImage/WebImage.h>
#import "Tools.h"

@interface MaskGifViewController ()

@property (nonatomic ,strong)UIImageView *backImageView; //背景图片
@property (nonatomic ,strong)UIImageView *gifImageView;  //gif图片
@property (nonatomic ,strong)UIImageView *maskView;      //gif上的蒙层

@end

@implementation MaskGifViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.backImageView];
    [self.view addSubview:self.gifImageView];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:pan];
}

#pragma mark - Pan Action
- (void)panAction:(UIPanGestureRecognizer *)pan{
    CGPoint point = [pan locationInView:self.view];
    _maskView.frame = CGRectMake(point.x-100, point.y-64-100, 200, 200);
}


#pragma mark - Get Method
- (UIImageView *)backImageView{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ViewVC_backImage"]];
        _backImageView.frame = CGRectMake(0, 64, screenWidth, screenHeight-64);
        _backImageView.userInteractionEnabled = true;
    }
    return _backImageView;
}

- (UIImageView *)gifImageView{
    if (!_gifImageView) {
        _gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, screenWidth, screenHeight - 64)];
        NSString * filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:@"DaGeChiFan" ofType:@"GIF"];
        NSData * imageData = [NSData dataWithContentsOfFile:filePath];
        _gifImageView.image = [UIImage sd_animatedGIFWithData:imageData];
//        _gifImageView.maskView = self.maskView;
        _gifImageView.maskView = [[UIImageView alloc] initWithImage:[self imageWithBezier]];
    }
    return _gifImageView;
}

- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth/2 - 100, screenHeight/2 - 100, 200, 200)];
        _maskView.backgroundColor = [UIColor whiteColor];
        _maskView.layer.cornerRadius = 100;
    }
    return _maskView;
}

- (UIImage *)imageWithBezier{
    
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 10, 160, 300) cornerRadius:10];
    UIBezierPath *path2 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(180, 10, 160, 300) cornerRadius:10];
    UIBezierPath *path3 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 320, 160, 300) cornerRadius:10];
    UIBezierPath *path4 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(180, 320, 160, 300) cornerRadius:10];
    
    UIBezierPath *allPath = [UIBezierPath bezierPath];
    [allPath appendPath:path1];
    [allPath appendPath:path2];
    [allPath appendPath:path3];
    [allPath appendPath:path4];
    
    return [Tools imageWithBezierPath:allPath size:CGSizeMake(screenWidth,screenHeight-64)];
    
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

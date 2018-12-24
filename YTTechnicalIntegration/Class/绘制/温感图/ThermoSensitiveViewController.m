//
//  ThermoSensitiveViewController.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/11/15.
//  Copyright © 2018 hiteam. All rights reserved.
//

#import "ThermoSensitiveViewController.h"

@interface ThermoSensitiveViewController ()
@property (nonatomic ,strong) CAGradientLayer *gradientlayer;
@property (nonatomic ,strong) UIImageView *imageView;

@end

@implementation ThermoSensitiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageView];
    NSDate *start = [NSDate date];
    UIImage * image = [self imageWithBezier];
    self.imageView.image = image;
    NSDate *end = [NSDate date];
    
    NSLog(@"绘制用时%f秒",end.timeIntervalSince1970 - start.timeIntervalSince1970);
    
    //    [self.view.layer addSublayer:self.gradientlayer];
    //    [self setGradientColor];
    
}

#pragma mark - Set Gradien Color
- (void)setGradientColor{
    _gradientlayer.colors = @[(id)[UIColor redColor].CGColor ,(id)[UIColor yellowColor].CGColor,(id)[UIColor blueColor].CGColor];
    _gradientlayer.locations = @[@0.0,@0.5,@1.0];
    _gradientlayer.startPoint = CGPointMake(0, 0);
    _gradientlayer.endPoint = CGPointMake(1, 1);
    
}

#pragma mark - UIBezierPath 绘制渐变
- (UIImage *)imageWithBezier{
    
    
    
    NSArray <NSValue *>*points = @[[NSValue valueWithCGPoint:CGPointMake(50, 110)],
                                   [NSValue valueWithCGPoint:CGPointMake(50, 330)],
                                   [NSValue valueWithCGPoint:CGPointMake(50, 550)],
                                   [NSValue valueWithCGPoint:CGPointMake(340, 220)],
                                   [NSValue valueWithCGPoint:CGPointMake(340, 330)],
                                   [NSValue valueWithCGPoint:CGPointMake(340, 440)],
                                   ];
    NSArray <NSNumber *> *temperatures = @[@20,@30,@20,@50,@40,@30];

    CGSize size = CGSizeMake(screenWidth, screenHeight - 64);
    
    UIGraphicsBeginImageContext(size);
    
    
    //遍历所有的点
    for (int i = 0; i<size.width; i++) {
        
        for (int j = 0; j<size.height; j++) {
            
            NSMutableArray <NSNumber *>*lens = [NSMutableArray array];
            //计算该点到各个数据点的距离
            CGFloat lensum = 0;
            for (NSValue *value in points) {
                CGPoint point = value.CGPointValue;
                CGFloat len = sqrt(fabs(point.x - i)*fabs(point.x - i) + fabs(point.y - j)*fabs(point.y - j));
                len = 1/(len*len*len);
                [lens addObject:@(len)];
                lensum += len;
            }
            
            CGFloat pointTemp = 0;
            for (int i = 0; i < points.count; i++) {
                pointTemp += temperatures[i].floatValue*(lens[i].floatValue/lensum);
                //                NSLog(@"%f",(lens[i].floatValue/lensum));
            }
            
            //绘制点
            UIBezierPath *path = [UIBezierPath bezierPath];
            path.lineWidth = 1;
            path.lineCapStyle = kCGLineCapRound;
            path.lineJoinStyle = kCGLineCapRound;
            [path moveToPoint:CGPointMake(i, j)];
            [path addLineToPoint:CGPointMake(i, j)];
            
            [[self getColorWithTemperature:pointTemp] set];
            [path stroke];
        }
    }
    // 声明UIImage对象
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


#pragma mark - Get Method
- (CAGradientLayer *)gradientlayer{
    if (!_gradientlayer) {
        _gradientlayer = [CAGradientLayer layer];
        _gradientlayer.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    }
    return _gradientlayer;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, screenWidth, screenHeight - 64)];
        _imageView.contentMode = UIViewContentModeCenter;
        //        _imageView.image = [self imageWithBezier];
    }
    return _imageView;
}

#pragma mark - Tools
- (UIColor *)getColorWithTemperature:(CGFloat)temperature{
    // 颜色 765  温度 40 (50C°~10C°)
    CGFloat color = (temperature - 10)*765/40;
    
    if (color<255) {
        return colorFromRGB(0, color, 255 - color);
    }else if(color<510){
        return colorFromRGB(color - 255, color, 0);
    }else{
        return colorFromRGB(255, 765 - color, 0);
    }
    
    
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

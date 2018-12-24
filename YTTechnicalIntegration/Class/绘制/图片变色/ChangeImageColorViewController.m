//
//  ChangeImageColorViewController.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/3/29.
//  Copyright © 2018年 hiteam. All rights reserved.
//

#import "ChangeImageColorViewController.h"

@interface ChangeImageColorViewController ()

@property (nonatomic ,strong)UISlider *redSlider;
@property (nonatomic ,strong)UISlider *blueSlider;
@property (nonatomic ,strong)UISlider *greenSlider;

@property (nonatomic ,strong)UILabel *redLb;
@property (nonatomic ,strong)UILabel *blueLb;
@property (nonatomic ,strong)UILabel *greenLb;

@property (nonatomic ,strong)UIImageView *imageView;
@property (nonatomic ,strong)UIImage *image;

@end

@implementation ChangeImageColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    _image = [UIImage imageNamed:@"qq"];
    _imageView.image = _image;
}

#pragma mark - Create UI

- (void)createUI{
    _redSlider = [[UISlider alloc] initWithFrame:CGRectMake(40, 200, 200, 10)];
    _blueSlider = [[UISlider alloc] initWithFrame:CGRectMake(40, 300, 200, 10)];
    _greenSlider = [[UISlider alloc] initWithFrame:CGRectMake(40, 400, 200, 10)];

    _redSlider.minimumValue = 0.f;// 设置最小值
    _redSlider.maximumValue = 255.f;// 设置最大值
    _redSlider.value = (_redSlider.minimumValue + _redSlider.maximumValue) / 2;// 设置初始值
    _redSlider.continuous = YES;// 设置可连续变化
    
    _blueSlider.minimumValue = 0.f;// 设置最小值
    _blueSlider.maximumValue = 255.f;// 设置最大值
    _blueSlider.value = (_redSlider.minimumValue + _redSlider.maximumValue) / 2;// 设置初始值
    _blueSlider.continuous = YES;// 设置可连续变化
    
    _greenSlider.minimumValue = 0.f;// 设置最小值
    _greenSlider.maximumValue = 255.f;// 设置最大值
    _greenSlider.value = (_redSlider.minimumValue + _redSlider.maximumValue) / 2;// 设置初始值
    _greenSlider.continuous = YES;// 设置可连续变化
    
    [_redSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_blueSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_greenSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];

    [self.view addSubview:_redSlider];
    [self.view addSubview:_blueSlider];
    [self.view addSubview:_greenSlider];
    
    
    _redLb = [[UILabel alloc] initWithFrame:CGRectMake(250, 200, 60, 20)];
    _blueLb = [[UILabel alloc] initWithFrame:CGRectMake(250, 300, 60, 20)];
    _greenLb = [[UILabel alloc] initWithFrame:CGRectMake(250, 400, 60, 20)];
    
    [self.view addSubview:_redLb];
    [self.view addSubview:_blueLb];
    [self.view addSubview:_greenLb];
    
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(120, 550, 50, 50)];
    [self.view addSubview:_imageView];
    
}

- (void)sliderValueChanged:(UISlider *)slider{
    
    _imageView.image = [self imageWithColor:[UIColor colorWithRed:_redSlider.value/255.f green:_greenSlider.value/255.f blue:_blueSlider.value/255.f alpha:1.f] image:_image];
    
    if (slider == _redSlider) {
        _redLb.text = [NSString stringWithFormat:@"%d",(int)slider.value];
        return;
    }
    
    if (slider == _blueSlider) {
        _blueLb.text = [NSString stringWithFormat:@"%d",(int)slider.value];
        return;
    }
    
    if (slider == _greenSlider) {
        _greenLb.text = [NSString stringWithFormat:@"%d",(int)slider.value];
        return;
    }
    
}


- (UIImage *)imageWithColor:(UIColor *)color image:(UIImage *)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, image.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextClipToMask(context, rect, image.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
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

//
//  LayerVC.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/7/16.
//  Copyright © 2018年 hiteam. All rights reserved.
//

#import "LayerVC.h"
#import "ShowFuctionView.h"
#import <WebImage/WebImage.h>
#import <WebImage/UIImage+GIF.h>

@interface LayerVC ()

@property (nonatomic ,strong)CALayer *layer;
@property (nonatomic ,strong)CALayer *subLayer;
@property (nonatomic ,strong)CALayer *maskLayer;

@property (nonatomic ,strong)ShowFuctionView *showFucView;
@property (nonatomic ,strong)NSArray <ShowFuctionViewModel *>*dataArray;

//手势操作
@property (nonatomic ,assign)CGPoint angle;//3D旋转角度
@property (nonatomic ,assign)CGPoint tempLayerPoint;//layer坐标变化起点
@property (nonatomic ,assign)CGPoint startPoint;//手势起始坐标
@property (nonatomic ,assign)BOOL is3Dstede;//是否为3d旋转模式

//正方体的其他面
@property (nonatomic ,strong)CALayer *leftLayer;
@property (nonatomic ,strong)CALayer *rightLayer;
@property (nonatomic ,strong)CALayer *topLayer;
@property (nonatomic ,strong)CALayer *bottomLayer;
@property (nonatomic ,strong)CALayer *backLayer;

@end

@implementation LayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    [self createLayer];
    [self setNav];
    [self addGestureRecognizer];
    [self createData];
    
    // Do any additional setup after loading the view.
}

#pragma mark - Set up
- (void)setUp{
    
}

#pragma mark - Create Layer
- (void)createLayer{
    
    //主layer
    self.layer = [CALayer layer];
    self.layer.frame = CGRectMake(100, 300, 100, 100);
    self.layer.backgroundColor = [UIColor darkGrayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(10, 10);
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.masksToBounds = NO;
    self.layer.shadowOpacity = 0.5;
    [self.view.layer addSublayer:self.layer];
    
    //子layer (小方块)
    _subLayer = [CALayer layer];
    _subLayer.frame = CGRectMake(0, -10, 20, 20);
    _subLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.layer addSublayer:_subLayer];
    
    //蒙层
    _maskLayer = [CALayer layer];
    _maskLayer.contents = (__bridge id)[UIImage imageNamed:@"maskTest"].CGImage;
    _maskLayer.frame = CGRectMake(0, 0, 100, 100);
    
    //3D其他面
    
    CATransform3D diceTransform = CATransform3DIdentity;
    
    _leftLayer = [CALayer layer];
    _leftLayer.frame = CGRectMake(100, 300, 100, 100);
    _leftLayer.backgroundColor = [UIColor blueColor].CGColor;
    diceTransform = CATransform3DRotate(CATransform3DIdentity, (M_PI / 2.f), 0, 1, 0);
    diceTransform = CATransform3DTranslate(diceTransform, 50, 0, -50);
    _leftLayer.transform = diceTransform;
    [self.view.layer addSublayer:_leftLayer];
    
    _rightLayer = [CALayer layer];
    _rightLayer.frame = CGRectMake(100, 300, 100, 100);
    _rightLayer.backgroundColor = [UIColor redColor].CGColor;
    diceTransform = CATransform3DRotate(CATransform3DIdentity, (M_PI / 2.f), 0, 1, 0);
    diceTransform = CATransform3DTranslate(diceTransform, 50, 0, 50);
    _rightLayer.transform = diceTransform;
    [self.view.layer addSublayer:_rightLayer];
    
    _topLayer = [CALayer layer];
    _topLayer.frame = CGRectMake(100, 300, 100, 100);
    _topLayer.backgroundColor = [UIColor yellowColor].CGColor;
    diceTransform = CATransform3DRotate(CATransform3DIdentity, (M_PI / 2.f), 1, 0, 0);
    diceTransform = CATransform3DTranslate(diceTransform, 0, -50, 50);
    _topLayer.transform = diceTransform;
    [self.view.layer addSublayer:_topLayer];
    
    _bottomLayer = [CALayer layer];
    _bottomLayer.frame = CGRectMake(100, 300, 100, 100);
    _bottomLayer.backgroundColor = [UIColor darkTextColor].CGColor;
    diceTransform = CATransform3DRotate(CATransform3DIdentity, (M_PI / 2.f), 1, 0, 0);
    diceTransform = CATransform3DTranslate(diceTransform, 0, -50, -50);
    _bottomLayer.transform = diceTransform;
    [self.view.layer addSublayer:_bottomLayer];
    
    _backLayer = [CALayer layer];
    _backLayer.frame = CGRectMake(100, 300, 100, 100);
    _backLayer.backgroundColor = [UIColor greenColor].CGColor;
    diceTransform = CATransform3DRotate(CATransform3DIdentity, (M_PI), 1, 1, 0);
    diceTransform = CATransform3DTranslate(diceTransform, 0, 0, 100);
    _backLayer.transform = diceTransform;
    [self.view.layer addSublayer:_backLayer];
    
}

#pragma mark - Nav
- (void)setNav{
    [self addItemWithTitle:@"功能演示" imageName:nil selector:@selector(rightNavAction) location:NO];
}

- (void)rightNavAction{
    [_showFucView show];
}

#pragma mark - GestureRecognizer
- (void)addGestureRecognizer{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:tap];
    [self.view addGestureRecognizer:pan];
}

#pragma mark - GestureRecognizer Action
- (void)tapAction:(UITapGestureRecognizer *)tap{
    CGPoint tPoint = [tap locationInView:self.view];
    tPoint = CGPointMake(tPoint.x-self.layer.frame.origin.x, tPoint.y-self.layer.frame.origin.y);
//    NSLog(@"%f%f",tPoint.x,tPoint.y);
    NSLog(@"点击位置是否在layer上%d",[self.layer containsPoint:tPoint]);
}

- (void)panAction:(UIPanGestureRecognizer *)pan{
    CGPoint tPoint = [pan locationInView:self.view];
    
    if (pan.state == UIGestureRecognizerStateBegan){
        _startPoint = tPoint;
        _tempLayerPoint = self.layer.frame.origin;
    }
    
    if (_is3Dstede){
        CGFloat angleX = _angle.x + ((tPoint.x - _startPoint.x)/60);
        CGFloat angleY = _angle.y - ((tPoint.y - _startPoint.y)/60);
        
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = -1 / 500.f;
        transform = CATransform3DRotate(transform, angleX, 0, 1, 0);
        transform = CATransform3DRotate(transform, angleY, 1, 0, 0);
        self.view.layer.sublayerTransform = transform;
        
        if (pan.state == UIGestureRecognizerStateEnded) {
            _angle.x = angleX;
            _angle.y = angleY;
        }
    }else{
        CGFloat newx = _tempLayerPoint.x + (tPoint.x - _startPoint.x);
        CGFloat newy = _tempLayerPoint.y + (tPoint.y - _startPoint.y);
        self.layer.frame = CGRectMake(newx, newy, self.layer.frame.size.width, self.layer.frame.size.height);
    }
}

#pragma mark - Create Data
- (void)createData{
    ShowFuctionViewModel *model1 = [ShowFuctionViewModel modelWithTitle:@"宽" value:@"100" type:ShowFuctionViewModelTypeValue action:^(NSString *newValue) {
        self.layer.frame = CGRectMake(self.layer.frame.origin.x, self.layer.frame.origin.y, [newValue floatValue], self.layer.frame.size.height);
    }];
    
    ShowFuctionViewModel *model2 = [ShowFuctionViewModel modelWithTitle:@"高" value:@"100" type:ShowFuctionViewModelTypeValue action:^(NSString *newValue) {
        self.layer.frame = CGRectMake(self.layer.frame.origin.x, self.layer.frame.origin.y, self.layer.frame.size.width, [newValue floatValue]);
    }];
    
    ShowFuctionViewModel *model3 = [ShowFuctionViewModel modelWithTitle:@"圆角角度" value:@"0" type:ShowFuctionViewModelTypeValue action:^(NSString *newValue) {
        self.layer.cornerRadius = [newValue floatValue];
    }];
    
    ShowFuctionViewModel *model4 = [ShowFuctionViewModel modelWithTitle:@"阴影透明度" value:@"0.5" type:ShowFuctionViewModelTypeValue action:^(NSString *newValue) {
        self.layer.shadowOpacity = [newValue floatValue];
    }];
    
    ShowFuctionViewModel *model5 = [ShowFuctionViewModel modelWithTitle:@"裁剪超出部分" value:@"0" type:ShowFuctionViewModelTypeSwitch action:^(NSString *newValue) {
        self.layer.masksToBounds = [newValue boolValue];
    }];
    
    ShowFuctionViewModel *model6 = [ShowFuctionViewModel modelWithTitle:@"设置图片" value:@"0" type:ShowFuctionViewModelTypeSwitch action:^(NSString *newValue) {
        if ([newValue isEqualToString:@"1"]) {
            self.layer.contents = (__bridge id)[UIImage imageNamed:@"layerContent"].CGImage;
        }else{
            self.layer.contents = nil;
        }
    }];
    
    ShowFuctionViewModel *model7 = [ShowFuctionViewModel modelWithTitle:@"添加蒙层" value:@"0" type:ShowFuctionViewModelTypeSwitch action:^(NSString *newValue) {
        if ([newValue isEqualToString:@"1"]) {
            self.layer.mask = self.maskLayer;
        }else{
            self.layer.mask = nil;
        }
    }];
    
    ShowFuctionViewModel *model8 = [ShowFuctionViewModel modelWithTitle:@"翻转模式" value:@"0" type:ShowFuctionViewModelTypeSwitch action:^(NSString *newValue) {
        if ([newValue isEqualToString:@"1"]) {
            self.is3Dstede = true;
        }else{
            self.is3Dstede = false;
        }
    }];
    
    self.showFucView.dataArray = @[model1,model2,model3,model4,model5,model6,model7,model8];
}
#pragma mark - Move Action
- (void)moveLayerAction:(CGPoint)point{
    self.layer.frame = CGRectMake(point.x, point.y, self.layer.frame.size.width, self.layer.frame.size.height);
}

#pragma mark - Get Method
- (ShowFuctionView *)showFucView{
    if (!_showFucView) {
        _showFucView = [[ShowFuctionView alloc] init];
    }
    return _showFucView;
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

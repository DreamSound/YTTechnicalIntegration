//
//  SPCreateScnenPointBaseView.m
//  Alarm
//
//  Created by hiteam on 2018/10/11.
//  Copyright © 2018 Sspaas. All rights reserved.
//

#import "SPCreateScnenPointView.h"
#import "Masonry.h"
#import "SPScnenMsgView.h"

@interface SPCreateScnenPointView () <UIGestureRecognizerDelegate,SCNSceneRendererDelegate>

@property (nonatomic ,strong)UIView *backView;
@property (nonatomic ,strong)SCNScene *mainScene;
@property (nonatomic ,strong)SCNView *sceneView;

//摄像机
@property (nonatomic ,strong)SCNNode *cameraNode;

//光源
@property (nonatomic ,strong)SCNNode *topLight;
@property (nonatomic ,strong)SCNNode *bottomLight;
@property (nonatomic ,strong)SCNNode *leftLight;
@property (nonatomic ,strong)SCNNode *rightLight;
@property (nonatomic ,strong)SCNNode *frontLight;
@property (nonatomic ,strong)SCNNode *backLight;

//辅助坐标
//一次移动的长度
@property (nonatomic ,assign)NSInteger moveLen;
@property (nonatomic ,strong)UILabel *showMoveLen;

@property (nonatomic ,strong)SCNNode *moveNode;
@property (nonatomic ,strong)SCNNode *changeColorNode;
@property (nonatomic ,strong)NSArray <SCNMaterial *>*movTempMtl;

//屏幕外接圆的直径
@property (nonatomic ,assign)CGFloat screenRadius;

//显示报警信息界面
@property (nonatomic ,strong)SPScnenMsgView *msgView;

//3D文字
@property (nonatomic ,strong)NSMutableArray <SCNNode *>*textArray;


@end

@implementation SPCreateScnenPointView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    if (self) {
        
        self.textArray = [NSMutableArray arrayWithCapacity:7];
        
        [self addSubview:self.backView];
        [self addSubview:self.sceneView];
        //添加摄像机
        [_rootNode addChildNode:self.cameraNode];
        //添加灯光
        [_rootNode addChildNode:self.topLight];
        [_rootNode addChildNode:self.bottomLight];
        [_rootNode addChildNode:self.leftLight];
        [_rootNode addChildNode:self.rightLight];
        [_rootNode addChildNode:self.frontLight];
        [_rootNode addChildNode:self.backLight];

        [self setLayout];
        [self addModels];
        [self addAuxiliary];
        
    }
    return self;
}
#pragma mark - Set Layout
- (void)setLayout{
    [self.sceneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(@(screenHeight));
        make.height.equalTo(@0);
    }];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self);
    }];
    [self layoutIfNeeded];
}

#pragma mark - 坐标辅助
- (void)addAuxiliary{
    
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(100, 40, 40, 60);
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.sceneView addSubview:backButton];
    
    UIButton * frontBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    frontBtn.frame = CGRectMake(screenHeight - 200, 100, 40, 60);
    [frontBtn setTitle:@"向前" forState:UIControlStateNormal];
    frontBtn.tag = 100;
    [frontBtn addTarget:self action:@selector(moveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(screenHeight - 200, 20, 40, 60);
    [backBtn setTitle:@"向后" forState:UIControlStateNormal];
    backBtn.tag = 101;
    [backBtn addTarget:self action:@selector(moveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(screenHeight - 260, 60, 40, 60);
    [leftBtn setTitle:@"向左" forState:UIControlStateNormal];
    leftBtn.tag = 102;
    [leftBtn addTarget:self action:@selector(moveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(screenHeight - 140, 60, 40, 60);
    [rightBtn setTitle:@"向右" forState:UIControlStateNormal];
    rightBtn.tag = 103;
    [rightBtn addTarget:self action:@selector(moveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * upBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    upBtn.frame = CGRectMake(screenHeight - 80, 60, 40, 60);
    [upBtn setTitle:@"向上" forState:UIControlStateNormal];
    upBtn.tag = 104;
    [upBtn addTarget:self action:@selector(moveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomBtn.frame = CGRectMake(screenHeight - 40, 60, 40, 60);
    [bottomBtn setTitle:@"向下" forState:UIControlStateNormal];
    bottomBtn.tag = 105;
    [bottomBtn addTarget:self action:@selector(moveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * addTenTimesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addTenTimesBtn.frame = CGRectMake(screenHeight - 160, 150, 80, 60);
    [addTenTimesBtn setTitle:@"增加10倍" forState:UIControlStateNormal];
    addTenTimesBtn.tag = 106;
    [addTenTimesBtn addTarget:self action:@selector(moveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * delTenTimesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    delTenTimesBtn.frame = CGRectMake(screenHeight - 80, 150, 80, 60);
    [delTenTimesBtn setTitle:@"减少10倍" forState:UIControlStateNormal];
    delTenTimesBtn.tag = 107;
    [delTenTimesBtn addTarget:self action:@selector(moveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _showMoveLen = [[UILabel alloc] initWithFrame:CGRectMake(screenHeight - 200, 60, 40, 60)];
    _moveLen = 10;
    _showMoveLen.text = @"10";
    
    [_sceneView addSubview:frontBtn];[_sceneView addSubview:backBtn];[_sceneView addSubview:leftBtn];[_sceneView addSubview:rightBtn];[_sceneView addSubview:upBtn];[_sceneView addSubview:bottomBtn];
    [_sceneView addSubview:addTenTimesBtn];[_sceneView addSubview:delTenTimesBtn];
    [_sceneView addSubview:_showMoveLen];
    
    [_rootNode addChildNode:[self createEquipmentWithPosition:SCNVector3Make(0, 0, 0) eulerAngles:SCNVector3Zero]];
}

#pragma mark - 添加模型
- (void)addModels{
    
    SCNVector3 posintion = SCNVector3Make(1400, 1300, 0);
    //创建墙 与 地面
    SCNScene *scene = [SCNScene sceneNamed:@"Art.scnassets/A1-M4-F2-centerfloor.scn"];
    SCNNode * floorNode = scene.rootNode.childNodes[0];
    floorNode.position = posintion;
    
    SCNScene *wallScene = [SCNScene sceneNamed:@"Art.scnassets/A1-M4-F2-centerwall.scn"];
    SCNNode *wallNode = wallScene.rootNode.childNodes[0];
    wallNode.position = SCNVector3Make(0, 0, 0);
    
    [floorNode addChildNode:wallNode];
    [self.rootNode addChildNode:floorNode];
    
    
    //创建文字
    [self createTextWithPosition:SCNVector3Make(posintion.x + 1060     ,posintion.y - 1400 ,posintion.z -1100) content:@"机房一"];
    
    [self createTextWithPosition:SCNVector3Make(posintion.x - 940 + 400,posintion.y - 1400 ,posintion.z -1100) content:@"机房二"];
    [self createTextWithPosition:SCNVector3Make(posintion.x - 2940+ 400,posintion.y - 1400 ,posintion.z -1100) content:@"北电力室"];
    [self createTextWithPosition:SCNVector3Make(posintion.x - 2940+ 400,posintion.y - 1400 ,posintion.z + 900) content:@"南电力室"];
    [self createTextWithPosition:SCNVector3Make(posintion.x - 2490+ 400,posintion.y - 1400 ,posintion.z - 320) content:@"北电池室"];
    [self createTextWithPosition:SCNVector3Make(posintion.x - 2490+ 400,posintion.y - 1400 ,posintion.z + 300) content:@"南电池室"];
    
    //创建详细信息面板
    self.msgView = [[SPScnenMsgView alloc] initWithFrame:CGRectMake(0, 0, 240, 180)];
    self.msgView.position = SCNVector3Make(0, 0, 0);
    [self.sceneView addSubview:self.msgView];
    
    //添加机柜
    for (int i = 0; i < 10; i++) {
        for (int j = 0; j < 20; j++) {
            if ((i == 0 && j >=6 && j <= 7 ) || ((i == 2 || i == 3|| i == 6) && j >= 6 && j <= 8)) {
                continue;
            }
            CGFloat xp = j*65 + 1950;
            CGFloat zp = 1280 - i*262;
            [self.rootNode addChildNode:[self createEquipmentWithPosition:SCNVector3Make(xp, -700, zp) eulerAngles: SCNVector3Zero]];
        }
    }
    
    for (int i = 0; i < 10; i++) {
        for (int j = 0; j < 17; j++) {
            if ( (i == 0 && j < 7)|| ((i == 3 || i == 2 || i == 6 || i == 7) && j >= 6 && j <= 8) || (i == 9 && j < 8) ) {
                continue;
            }
            CGFloat xp = 200 + j*63;
            CGFloat zp = 1250 - i*255;
            [self.rootNode addChildNode:[self createEquipmentWithPosition:SCNVector3Make(xp, -700, zp) eulerAngles: SCNVector3Zero]];
        }
    }
    
}

#pragma mark - buttonAction
//100.前  101.后  102.左  103.右  104.上  105.下 106.增加10倍 107.减少10倍
- (void)moveButtonAction:(UIButton *)button{
    
    if (!_moveNode) {
        return;
    }
    
    CGFloat x = _moveNode.position.x;
    CGFloat y = _moveNode.position.y;
    CGFloat z = _moveNode.position.z;
    
    switch (button.tag) {
        case 100:
        {
            _moveNode.position = SCNVector3Make(x+_moveLen, y, z);
        }
            break;
        case 101:
        {
            _moveNode.position = SCNVector3Make(x-_moveLen, y, z);
        }
            break;
        case 102:
        {
            _moveNode.position = SCNVector3Make(x, y, z+_moveLen);
        }
            break;
        case 103:
        {
            _moveNode.position = SCNVector3Make(x, y, z-_moveLen);
        }
            break;
        case 104:
        {
            _moveNode.position = SCNVector3Make(x, y+_moveLen, z);
        }
            break;
        case 105:
        {
            _moveNode.position = SCNVector3Make(x, y-_moveLen, z);
        }
            break;
        case 106:
        {
            _moveLen = _moveLen*10;
            if (_moveLen>1000) {
                _moveLen = 1000;
            }
            _showMoveLen.text = [NSString stringWithFormat:@"%ld",(long)_moveLen];
        }
            break;
        case 107:
        {
            _moveLen = _moveLen/10;
            if (_moveLen<1) {
                _moveLen = 1;
            }
            _showMoveLen.text = [NSString stringWithFormat:@"%ld",(long)_moveLen];
        }
            break;
        default:
            break;
    }
    
    self.msgView.position = _moveNode.position;
    self.msgView.hidden = true;
    NSLog(@"%.0f,%.0f,%.0f",_moveNode.position.x,_moveNode.position.y,_moveNode.position.z);
    
}

- (void)backButtonAction{
    [self close];
}

#pragma mark - Tap GestureRecognizer Action
- (void)backTapAction{
    [self close];
}

- (void)tapSceneAction:(UITapGestureRecognizer *)tap{
    
    self.msgView.hidden = true;
    
    if (_changeColorNode) {
        _changeColorNode.geometry.materials = _movTempMtl;
    }
    
    
    NSArray<SCNHitTestResult *> * hitArray = [_sceneView hitTest:[tap locationInView:_sceneView] options:nil];
//    NSLog(@"%@",hitArray);
    _moveNode = hitArray.firstObject.node;
    _changeColorNode = _moveNode;
    _movTempMtl = _moveNode.geometry.materials;
    SCNMaterial * material = [[SCNMaterial alloc] init];
    material.lightingModelName = SCNLightingModelBlinn;
    material.diffuse.contents = UIColor.redColor;
    material.ambient.contents = [UIColor colorWithWhite:0.1 alpha:1];
    material.locksAmbientWithDiffuse = false;
    _moveNode.geometry.materials = @[material];
    if (_moveNode.parentNode && _moveNode.parentNode != _rootNode) {
        _moveNode = _moveNode.parentNode;
    }
    
    if ([_moveNode.name isEqualToString:@"box"]) {
        self.msgView.hidden = false;
        self.msgView.position = _moveNode.position;
    }
    
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[UIButton class]]) {
        return false;
    }
    return true;
}


#pragma mark - SCNSceneRenderer Delegate
- (void)renderer:(id<SCNSceneRenderer>)renderer updateAtTime:(NSTimeInterval)time{
    if (@available(iOS 11.0, *)) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            CGPoint viewPoint = [self change3DPointTo2DPoint:self.msgView.position];
            self.msgView.x = viewPoint.x;
            self.msgView.y = viewPoint.y;
            
            SCNVector3 mapEuler =  self.sceneView.defaultCameraController.pointOfView.eulerAngles;
            NSString *yAngles = [NSString stringWithFormat:@"%f",mapEuler.y];
            if ( [yAngles isEqualToString:@"1.570796"]) {
                mapEuler.y = -mapEuler.y;
            }
            
            if ([yAngles isEqualToString:@"-1.570796"]){
                mapEuler.y = -(M_PI - mapEuler.y);
                mapEuler.x = -mapEuler.x;
            }
            
            for (SCNNode *testNode in self.textArray) {
                testNode.eulerAngles = mapEuler;
            }
            
        });
    }
}


#pragma mark - Public Method
- (void)show{
    [kWindow addSubview:self];
    [self.sceneView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(screenWidth));
    }];
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
        self.backView.alpha = 0.53;
    }];
}

- (void)close{
    
    [self.sceneView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        self.backView.alpha = 0;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

#pragma mark - Get Method
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:self.bounds];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0;
        //添加点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backTapAction)];
        tap.delegate = self;
        [_backView addGestureRecognizer:tap];
    }
    return _backView;
}

- (SCNView *)sceneView{
    if (!_sceneView) {
        _sceneView  = [[SCNView alloc]initWithFrame:CGRectZero];
        _sceneView.allowsCameraControl = true;
        _sceneView.backgroundColor  = [UIColor lightGrayColor];
        _sceneView.clipsToBounds = true;
        _sceneView.scene = self.mainScene;
        _sceneView.delegate = self;
        if (@available(iOS 11.0, *)) {
            SCNCameraController *cameraController = _sceneView.defaultCameraController;
//            cameraController.minimumVerticalAngle = 0;
//            cameraController.maximumVerticalAngle = 85;
            cameraController.pointOfView = self.cameraNode;
            cameraController.pointOfView.position = SCNVector3Make(597, 5103, 498.23);
            cameraController.pointOfView.eulerAngles = SCNVector3Make(-1.5, 0, 0);
            cameraController.pointOfView.camera.fieldOfView = 33;
            cameraController.pointOfView.camera.focalLength = 39;
            cameraController.inertiaEnabled = false;
        } else {
            // Fallback on earlier versions
        }
        
        _sceneView.transform = CGAffineTransformMakeRotation(90 *M_PI / 180.0);
        
        
        //添加点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSceneAction:)];
        tap.delegate = self;
        [_sceneView addGestureRecognizer:tap];
    }
    return _sceneView;
}

- (SCNScene *)mainScene{
    if (!_mainScene) {
        _mainScene = [SCNScene new];
        _rootNode = _mainScene.rootNode;
    }
    return _mainScene;
}

// Camera
- (SCNNode *)cameraNode{
    if (!_cameraNode) {
        _cameraNode = [SCNNode node];
        _cameraNode.camera = [SCNCamera camera];
        _cameraNode.camera.zFar = 1000.f;
        _cameraNode.camera.zNear = 0.1f;
        _cameraNode.camera.automaticallyAdjustsZRange = YES;
        
        _cameraNode.position = SCNVector3Make(6000, 2000, 0);
        _cameraNode.eulerAngles = SCNVector3Make(-0.4, 3.14/2, 0);
        
    }
    return _cameraNode;
}


// Light
-(SCNNode *)topLight {
    if (!_topLight) {
        _topLight = [self createLightWithPosition:SCNVector3Make(0, 10000, 0)];
    }
    return _topLight;
}

-(SCNNode *)bottomLight {
    if (!_bottomLight) {
        _bottomLight = [self createLightWithPosition:SCNVector3Make(0, -10000, 0)];
    }
    return _bottomLight;
}

-(SCNNode *)leftLight {
    if (!_leftLight) {
        _leftLight = [self createLightWithPosition:SCNVector3Make(0, 0, -10000)];
    }
    return _leftLight;
}

-(SCNNode *)rightLight {
    if (!_rightLight) {
        _rightLight = [self createLightWithPosition:SCNVector3Make(0, 0, 10000)];
    }
    return _rightLight;
}

- (SCNNode *)frontLight{
    if (!_frontLight) {
        _frontLight = [self createLightWithPosition:SCNVector3Make(10000, 0, 0)];
    }
    return _frontLight;
}

- (SCNNode *)backLight{
    if (!_backLight) {
        _backLight = [self createLightWithPosition:SCNVector3Make(-10000, 0, 0)];
    }
    return _backLight;
}

#pragma mark - Tools
//创建灯光
- (SCNNode *)createLightWithPosition:(SCNVector3) posintion{
    SCNNode *lightNode = [SCNNode node];
    SCNLight *light = [SCNLight light];
    light.zFar = 10000;
    light.color = UIColor.whiteColor;
    light.type = SCNLightTypeOmni;
    lightNode.light = light;
    lightNode.position = posintion;
    return lightNode;
}

//通过名字创建模型 并加入根节点
- (void)createModWithPosition:(SCNVector3) posintion eulerAngles:(SCNVector3)eulerAngles objId:(NSArray<NSString*> *)objId  path:(NSString *)path{
    
    
    SCNScene *scene = [SCNScene sceneNamed:[NSString stringWithFormat:@"Art.scnassets/%@",path]];
    SCNNode * equipNode = scene.rootNode.childNodes[0];
    equipNode.position = posintion;
    SCNNode *parentNode = [SCNNode node];
    [parentNode addChildNode:equipNode];
    
    parentNode.position = posintion;
    parentNode.eulerAngles = eulerAngles;
    [self.rootNode addChildNode:parentNode];
    
}


//创建机柜模型
- (SCNNode *)createEquipmentWithPosition:(SCNVector3) posintion eulerAngles:(SCNVector3)eulerAngles{
    
    SCNNode *boxNode = [SCNNode node];
    boxNode.name = @"box";
    SCNBox *box = [SCNBox boxWithWidth:60 height:240 length:110 chamferRadius:0];
    box.firstMaterial.diffuse.contents = colorFromHex(0x333333);
    box.firstMaterial.lightingModelName = SCNLightingModelBlinn;
    box.firstMaterial.specular.contents = UIColor.whiteColor;
    box.firstMaterial.shininess = 1.0;
    boxNode.geometry = box;
    boxNode.position = posintion;
    boxNode.eulerAngles = eulerAngles;
    
    return boxNode;
    
}

//创建文字
- (void)createTextWithPosition:(SCNVector3)position content:(NSString *)content{
    
    SCNNode *node = [SCNNode node];
    SCNText *text = [SCNText textWithString:content extrusionDepth:10];
    text.firstMaterial.diffuse.contents = UIColor.lightGrayColor;
    text.firstMaterial.lightingModelName = SCNLightingModelBlinn;
    text.firstMaterial.specular.contents = UIColor.whiteColor;
    text.firstMaterial.shininess = 1.0;
    text.font = [UIFont systemFontOfSize:200];
    text.alignmentMode = kCAAlignmentCenter;
    text.containerFrame = CGRectMake(-400, -1000, 2000, 1000);
    node.geometry = text;
    node.position = position;
    [self.rootNode addChildNode:node];
    [self.textArray addObject:node];
    
}

//获取选中时的材质
- (SCNMaterial *)getWarningMaterial{
    SCNMaterial * material = [SCNMaterial material];
    material.lightingModelName = SCNLightingModelBlinn;
    material.diffuse.contents = UIColor.redColor;
    material.ambient.contents = [UIColor colorWithWhite:0.1 alpha:1];
    material.locksAmbientWithDiffuse = false;
    return material;
}

- (CGFloat)screenRadius{
    if (_screenRadius == 0) {
        _screenRadius = sqrt ((screenHeight*screenHeight + screenWidth*screenWidth));
    }
    return _screenRadius;
}

#pragma mark - Tools
- (CGPoint)change3DPointTo2DPoint:(SCNVector3)position{
    CGPoint rs = CGPointZero;
    if (@available(iOS 11.0, *)) {
        //需要显示信息的模型 与摄像机的相对点
        SCNVector3 changePoint =  [self.mainScene.rootNode convertPosition:position toNode:self.sceneView.defaultCameraController.pointOfView];
        //计算场景在摄像头中的比例
        CGFloat viewScale = tan(M_PI*self.sceneView.defaultCameraController.pointOfView.camera.fieldOfView/360)*(-changePoint.z) * 2;
        //转换为屏幕比例
        CGFloat screenRadius =  self.screenRadius/(2*viewScale);
        //转换为屏幕上的点
        rs.x = (changePoint.x *screenRadius) + screenHeight/2;
        rs.y = (-changePoint.y*screenRadius) + screenWidth/2;
    } else {
        // Fallback on earlier versions
    }
    
    return rs;
}

@end

//
//  SPCreateScnenPointBaseView.h
//  Alarm
//
//  Created by hiteam on 2018/10/11.
//  Copyright © 2018 Sspaas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SceneKit/SceneKit.h>

@interface SPCreateScnenPointView : UIView

@property (nonatomic ,strong)SCNNode *rootNode;

- (void)show;
- (void)close;

//创建机柜模型
- (SCNNode *)createEquipmentWithPosition:(SCNVector3) posintion eulerAngles:(SCNVector3)eulerAngles;
//创建文字
- (void)createTextWithPosition:(SCNVector3)position content:(NSString *)content;
//获取选中时的材质
- (SCNMaterial *)getWarningMaterial;

@end


@interface SPSCNText : NSObject

@property (nonatomic, assign)SCNVector3 posintion;
@property (nonatomic, copy)  NSString   *content;

@end

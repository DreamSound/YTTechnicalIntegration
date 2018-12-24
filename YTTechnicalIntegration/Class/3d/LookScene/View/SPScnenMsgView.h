//
//  SPScnenMsgView.h
//  Alarm
//
//  Created by hiteam on 2018/10/15.
//  Copyright © 2018 Sspaas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SceneKit/SceneKit.h>

@interface SPScnenMsgView : UIView

//需要显示信息的3d位置
@property (nonatomic ,assign)SCNVector3 position;
@property (nonatomic ,strong)NSString *name;
@property (nonatomic ,strong)NSString *content;

@end

@interface SPScnenMsgViewCell : UITableViewCell

@property (nonatomic ,strong)UILabel *titleLb;
@property (nonatomic ,strong)UILabel *contentLb;

@end

//
//  YYTSegmentView.h
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/8/7.
//  Copyright © 2018年 hiteam. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YYTSegmentDidSelected)(NSInteger index);

@interface YYTSegmentView : UIView

///标签名数组 对该属性赋值会自动刷新该控件的UI
@property (nonatomic ,strong)NSArray <NSString *>*titles;
///当前选中的标签的下标 默认选中第一个 没有任何标签时时该值为 -1
@property (nonatomic ,assign)NSInteger index;
///选择标签时触发此代码块
@property (nonatomic ,copy) YYTSegmentDidSelected selectAction;

@end

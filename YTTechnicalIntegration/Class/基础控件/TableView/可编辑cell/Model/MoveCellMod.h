//
//  MoveCellMod.h
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/11/22.
//  Copyright © 2018 hiteam. All rights reserved.
//

#import "BaseMod.h"

//typedef NS_ENUM(NSInteger ,MoveCellModState) {
//    MoveCellModStateDefault,
//    MoveCellModStateSelect
//};

@interface MoveCellMod : BaseMod

@property (nonatomic ,strong)NSString *content;
@property (nonatomic ,assign)BOOL isSelected;

@end

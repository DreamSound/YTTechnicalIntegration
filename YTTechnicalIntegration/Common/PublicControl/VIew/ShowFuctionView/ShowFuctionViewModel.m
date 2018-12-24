//
//  ShowFuctionViewModel.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/7/17.
//  Copyright © 2018年 hiteam. All rights reserved.
//

#import "ShowFuctionViewModel.h"

@implementation ShowFuctionViewModel

+ (ShowFuctionViewModel *)modelWithTitle:(NSString *)title value:(NSString *)value type:(ShowFuctionViewModelType)type action:(ShowFuctionViewValueChangeAction)action{
    ShowFuctionViewModel *model = [[ShowFuctionViewModel alloc] init];
    model.title = title;
    model.value = value;
    model.type = type;
    model.valueChangeAction = action;
    return model;
}

@end

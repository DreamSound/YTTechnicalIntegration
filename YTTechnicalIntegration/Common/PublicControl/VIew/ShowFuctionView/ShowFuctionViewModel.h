//
//  ShowFuctionViewModel.h
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/7/17.
//  Copyright © 2018年 hiteam. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ShowFuctionViewModelTypeSwitch,
    ShowFuctionViewModelTypeValue,
} ShowFuctionViewModelType;

typedef void(^ShowFuctionViewValueChangeAction)(NSString *newValue);

@interface ShowFuctionViewModel : NSObject

@property (nonatomic ,copy)   NSString *title;
@property (nonatomic ,copy)   NSString *value;
@property (nonatomic ,assign) ShowFuctionViewModelType type;
@property (nonatomic ,copy)   ShowFuctionViewValueChangeAction valueChangeAction;

//快速构造
+ (ShowFuctionViewModel *)modelWithTitle:(NSString *)title value:(NSString *)value type:(ShowFuctionViewModelType)type action:(ShowFuctionViewValueChangeAction)action;

@end

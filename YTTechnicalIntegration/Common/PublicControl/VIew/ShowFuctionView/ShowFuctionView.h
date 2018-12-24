//
//  ShowFuctionView.h
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/7/17.
//  Copyright © 2018年 hiteam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowFuctionViewModel.h"

@interface ShowFuctionView : UIView

@property (nonatomic ,strong)NSArray <ShowFuctionViewModel*>*dataArray;

- (void)show;
- (void)close;

@end




//
//  TipView.h
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/11/20.
//  Copyright © 2018 hiteam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TipView : UIView

@property (nonatomic ,strong) UIColor *backColor;
@property (nonatomic ,assign) CGFloat backAlpha;
@property (nonatomic ,strong) UIColor *contentColor;
@property (nonatomic ,strong) UILabel *contentLb;

//- (void)show;
- (void)close;

+ (TipView *)showInView:(UIView *)view content:(NSString *)content;

@end


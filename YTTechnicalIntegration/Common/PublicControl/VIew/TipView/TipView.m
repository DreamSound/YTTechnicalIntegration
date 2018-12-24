//
//  TipView.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/11/20.
//  Copyright © 2018 hiteam. All rights reserved.
//

#import "TipView.h"
#import "Masonry.h"

@interface TipView ()

@property (nonatomic ,strong)UIButton *closeBtn;
@property (nonatomic ,strong)UIView *backView;

@end

@implementation TipView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backColor = [UIColor clearColor];
        [self addSubview:self.backView];
        [self addSubview:self.contentLb];
        [self addSubview:self.closeBtn];
        [self setLayout];
    }
    return self;
}
#pragma mark - Set Layout
- (void)setLayout{
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
    
    [self.contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10);
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self);
    }];
}

#pragma mark - Show & Close
- (void)show{
    
}

- (void)close{
    [self removeFromSuperview];
}

#pragma mark - Button Action
- (void)closeBtnAction{
    [self close];
}

#pragma mark - Get Method
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = colorFromHex(0x1568d5);
        _backView.alpha = 0.4;
    }
    return _backView;
    
}

- (UILabel *)contentLb{
    if (!_contentLb) {
        _contentLb = [[UILabel alloc] init];
        _contentLb.textAlignment = NSTextAlignmentLeft;
        _contentLb.font = [UIFont systemFontOfSize:11];
        _contentLb.textColor = [UIColor whiteColor];
    }
    return _contentLb;
}

- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setTitle:@"x" forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

#pragma mark - Set Method
- (void)setContentColor:(UIColor *)contentColor{
    _contentColor = contentColor;
    [self.closeBtn setTitleColor:contentColor forState:UIControlStateNormal];
    self.contentLb.textColor = contentColor;
}

- (void)setBackColor:(UIColor *)backColor{
    _backColor = backColor;
    _backView.backgroundColor = backColor;
}

- (void)setBackAlpha:(CGFloat)backAlpha{
    _backView.alpha = backAlpha;
}

#pragma mark - Class Method
+ (TipView *)showInView:(UIView *)view content:(NSString *)content{
    TipView *tip = [[TipView alloc] initWithFrame:CGRectMake(0, 64, screenWidth, 50)];
    tip.contentLb.text = content;
    [view addSubview:tip];
    return tip;
}

@end

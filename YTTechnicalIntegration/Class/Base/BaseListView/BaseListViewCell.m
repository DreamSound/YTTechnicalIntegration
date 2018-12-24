//
//  BaseListViewCell.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/11/19.
//  Copyright © 2018 hiteam. All rights reserved.
//

#import "BaseListViewCell.h"
#import "Masonry.h"

@interface BaseListViewCell ()

@property (nonatomic ,strong) UIView *backView;
@property (nonatomic ,strong) UILabel *titleLb;


@end

@implementation BaseListViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.backView];
        [self addSubview:self.titleLb];
        [self setLaout];
    }
    return self;
}

#pragma mark - Set Layout
- (void)setLaout{
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.right.equalTo(self).offset(-5);
        make.top.equalTo(self).offset(5);
        make.bottom.equalTo(self).offset(-5);
    }];
    
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(self);
    }];
    
    [self layoutIfNeeded];
}

#pragma mark - Get Method
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.alpha = 0.53;
        _backView.layer.cornerRadius = 10;
    }
    return _backView;
}

- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = [UIFont systemFontOfSize:12];
        _titleLb.textColor = [UIColor whiteColor];
        _titleLb.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLb;
}

#pragma mark - Set Method
- (void)setTitle:(NSString *)title{
    _title = title;
    _titleLb.text = title;
}

@end

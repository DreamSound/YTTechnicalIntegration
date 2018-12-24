//
//  YYTSegmentCell.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/8/7.
//  Copyright © 2018年 hiteam. All rights reserved.
//

#import "YYTSegmentCell.h"
#import "Masonry.h"

@interface YYTSegmentCell ()

@property (nonatomic ,strong)UILabel *titleLb;

@end

@implementation YYTSegmentCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLb];
        [self setLayout];
    }
    return self;
}

#pragma mark - Set Layout
- (void)setLayout{
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
}

#pragma mark - Get Method
- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = [UIFont systemFontOfSize:10];
        _titleLb.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLb;
}

#pragma Set Method
- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    if (_isSelected) {
        self.titleLb.textColor = [UIColor redColor];
    }else{
        self.titleLb.textColor = [UIColor blackColor];
    }
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLb.text = title;
}

@end

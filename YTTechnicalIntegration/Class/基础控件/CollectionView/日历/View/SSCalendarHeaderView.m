//
//  SSCalendarHeaderView.m
//  Alarm
//
//  Created by hiteam on 2017/11/6.
//  Copyright © 2017年 Sspaas. All rights reserved.
//

#import "SSCalendarHeaderView.h"
#import "Masonry.h"

@implementation SSCalendarHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.contentView];
        [self addSubview:self.titleLable];
        [self setLayout];
        self.backgroundColor = colorFromHex(0x1351cc);
    }
    return self;
}

#pragma mark - Set Layout
- (void)setLayout{
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self);
    }];
}

- (UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 60)];
        _titleLable.font = [UIFont systemFontOfSize:17];
        _titleLable.textColor = [UIColor whiteColor];
        
    }
    return _titleLable;
}

-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = colorFromHex(0x1351cc);

    }
    return _contentView;
}

@end

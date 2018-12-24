//
//  SSCalendarCell.m
//  Alarm
//
//  Created by hiteam on 2017/11/6.
//  Copyright © 2017年 Sspaas. All rights reserved.
//

#import "SSCalendarCell.h"
#import "Masonry.h"

@implementation SSCalendarCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLb];
        [self addSubview:self.subLb];
        [self setLayout];
    }
    return self;
}

#pragma mark - set Layout
- (void)setLayout{
    
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [_subLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.centerX.equalTo(self);
    }];
}

- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
    }
    return _titleLb;
}

- (UILabel *)subLb{
    if (!_subLb) {
        _subLb = [[UILabel alloc] init];
        _subLb.font = [UIFont systemFontOfSize:10];
        _subLb.textColor = [UIColor blackColor];
    }
    return _subLb;
}

- (void)setSelected:(BOOL)selected{
    if (selected) {
        self.backgroundColor = colorFromHex(0x1351cc);
    }else{
        self.backgroundColor = [UIColor whiteColor];
    }
}

- (void)setType:(NSInteger)type{
    switch (type) {
        case SSCalendarCellTypeFill:
        {
            self.backgroundColor = [UIColor lightGrayColor];
        }
            break;
        case SSCalendarCellTypeLeftArc:
        {
            
        }
            break;
        case SSCalendarCellTypeRightArc:
        {
            
        }
            break;
        case SSCalendarCellTypeLeftHalf:
        {
            
        }
            break;
        case SSCalendarCellTypeRightHalf:
        {
            
        }
            break;
        default:
            self.backgroundColor = [UIColor whiteColor];
            break;
    }
}


@end

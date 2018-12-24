//
//  PickTableViewCell.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/11/24.
//  Copyright © 2018 hiteam. All rights reserved.
//

#import "PickTableViewCell.h"
#import "Masonry.h"

@implementation PickTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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
    
    [self layoutIfNeeded];
}

#pragma mark - Get Method
- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = [UIFont systemFontOfSize:12];
        _titleLb.textColor = [UIColor blackColor];
    }
    return _titleLb;
}


@end

//
//  TableViewRotateCell.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/7/31.
//  Copyright © 2018年 hiteam. All rights reserved.
//

#import "TableViewRotateCell.h"
#import "Masonry.h"

@interface TableViewRotateCell ()

@end

@implementation TableViewRotateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.transform = CGAffineTransformMakeRotation(M_PI_2);
        [self addSubview:self.titleLb];
        [self setLayout];
        [self addGestureRecognizer];
        
    }
    return self;
}

#pragma mark - Set Layout
- (void)setLayout{
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(@20);
    }];
    [self layoutIfNeeded];
}

#pragma mark - Gesture Recognizer
- (void)addGestureRecognizer{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    CGPoint point = [tap locationInView:self];
    NSLog(@"%f/%f",point.x,point.y);
    NSLog(@"%f/%f",_titleLb.frame.origin.x,_titleLb.frame.origin.y);
    
}

#pragma mark - Get Method
- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.numberOfLines = 0;
    }
    return _titleLb;
}

- (void)setFrame:(CGRect)frame{
    CGRect nframe = CGRectMake(frame.origin.x, frame.origin.y, screenHeight - 64, frame.size.height);
    [super setFrame:nframe];
}

@end

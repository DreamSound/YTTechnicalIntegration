//
//  HTMLAnalysisCell.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/8/8.
//  Copyright © 2018年 hiteam. All rights reserved.
//

#import "HTMLAnalysisCell.h"
#import "Masonry.h"
#import <WebImage/WebImage.h>

@interface HTMLAnalysisCell ()

@property (nonatomic ,strong)UILabel *contentLb;
@property (nonatomic ,strong)UIImageView *iconImageView;

@end

@implementation HTMLAnalysisCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.contentLb];
        [self addSubview:self.iconImageView];
        [self setLayout];
    }
    return self;
}

#pragma mark - Set Layout
- (void)setLayout{
    
    [_contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self);
        make.left.equalTo(self).offset(40);
    }];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.top.bottom.equalTo(self);
        make.width.equalTo(@30);
    }];
    
    [self layoutIfNeeded];
}

#pragma mark - Get Method
- (UILabel *)contentLb{
    if (!_contentLb) {
        _contentLb = [[UILabel alloc] init];
        _contentLb.font = [UIFont systemFontOfSize:10];
        _contentLb.numberOfLines = 2;
    }
    return _contentLb;
}

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconImageView;
}

#pragma mark - Set Method
- (void)setContent:(NSString *)content{
    _content = content;
    _contentLb.text = content;
}

- (void)setImage:(NSString *)image{
    _image = image;
    if (image) {
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:_image]];
    }else{
        _iconImageView.image = nil;
    }
    
}

@end

//
//  TableViewMoveCellCell.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/8/1.
//  Copyright © 2018年 hiteam. All rights reserved.
//

#import "TableViewMoveCellCell.h"
#import "BEMCheckBox.h"
#import "Masonry.h"

@interface TableViewMoveCellCell ()

@property (nonatomic ,strong) BEMCheckBox *checkBox;
@property (nonatomic ,strong) UILabel *titleLb;

@end

@implementation TableViewMoveCellCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addGesture];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.titleLb];
        [self addSubview:self.checkBox];
        [self setLayout];
    }
    return self;
}

#pragma mark - Set Layout
- (void)setLayout{
    
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(self);
    }];
    
    [self.checkBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(self);
    }];
    
    [self layoutIfNeeded];
}

#pragma mark - Gesture Recognizer
- (void)addGesture{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self addGestureRecognizer:longPress];
}

- (void)longPressAction:(UILongPressGestureRecognizer *)longPress{
    if (_isEdit) {
        return;
    }
    [self.delegate moveCellLongPress:self press:longPress indexPath:self.indexPath];
}
#pragma mark - Public Method

- (void)setIsEdit:(BOOL)isEdit{
    [self setEdit:isEdit isAnimation:NO];
}

- (void)setEdit:(BOOL)isEdit isAnimation:(BOOL)isAnimation{
    _isEdit = isEdit;
    
    [self.titleLb mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(isEdit?40:10);
    }];
    
    if (isAnimation) {
        
        [UIView animateWithDuration:0.2 animations:^{
            self.checkBox.alpha = isEdit?1:0;
            [self layoutIfNeeded];
        }];
        
    }else{
        self.checkBox.alpha = isEdit?1:0;
        [self layoutIfNeeded];
    }
}

- (void)didSelectedCell{
    
    self.cellMod.isSelected = !self.cellMod.isSelected;
    [self.checkBox setOn:self.cellMod.isSelected animated:YES];
    
}

#pragma mark - Get Method

- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = [UIFont systemFontOfSize:12];
    }
    return _titleLb;
}

- (BEMCheckBox *)checkBox{
    if (!_checkBox) {
        _checkBox = [[BEMCheckBox alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _checkBox.alpha = 0;
        _checkBox.userInteractionEnabled = NO;
    }
    return _checkBox;
}

#pragma mark - Set Method

- (void)setCellMod:(MoveCellMod *)cellMod{
    _cellMod = cellMod;
    _titleLb.text = cellMod.content;
    _checkBox.on = cellMod.isSelected;
}

@end

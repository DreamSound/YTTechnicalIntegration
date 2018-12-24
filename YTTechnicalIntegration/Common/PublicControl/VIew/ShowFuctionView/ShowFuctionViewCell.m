//
//  ShowFuctionViewCell.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/7/17.
//  Copyright © 2018年 hiteam. All rights reserved.
//

#import "ShowFuctionViewCell.h"
#import "Masonry.h"

@interface ShowFuctionViewCell ()<UITextFieldDelegate,UINavigationControllerDelegate>

@property (nonatomic ,strong)UILabel *titleLb;
@property (nonatomic ,strong)UITextField *valueTf;
@property (nonatomic ,strong)UISwitch *switchBtn;

@end

@implementation ShowFuctionViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.titleLb];
        [self addSubview:self.valueTf];
        [self addSubview:self.switchBtn];
        [self setLayout];
    }
    return self;
}

#pragma mark - Set Layout
- (void)setLayout{
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(self);
    }];
    
    [_valueTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self);
        make.width.equalTo(@40);
    }];
    
    [_switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self);
    }];
}

#pragma mark - Action
- (void)switchBtnAction:(UISwitch *)btn{
    if (_model.valueChangeAction) {
        _model.value = [NSString stringWithFormat:@"%d",btn.on];
        _model.valueChangeAction([NSString stringWithFormat:@"%d",btn.on]);
    }
}


#pragma mark - Textfiled Delegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (_model.valueChangeAction) {
        _model.value = textField.text;
        _model.valueChangeAction(textField.text);
    }
}

#pragma mark - Get Method

- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
    }
    return _titleLb;
}

- (UITextField *)valueTf{
    if (!_valueTf) {
        _valueTf = [[UITextField alloc] init];
        _valueTf.delegate = self;
        _valueTf.keyboardType = UIKeyboardTypeDecimalPad;
        _valueTf.returnKeyType = UIReturnKeyDone;
    }
    return _valueTf;
}

- (UISwitch *)switchBtn{
    if (!_switchBtn) {
        _switchBtn = [[UISwitch alloc] init];
        [_switchBtn addTarget:self action:@selector(switchBtnAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchBtn;
}

#pragma mark - Set Method
- (void)setModel:(ShowFuctionViewModel *)model{
    _model = model;
    
    if (model.type == ShowFuctionViewModelTypeSwitch){
        _switchBtn.hidden = false;
        _valueTf.hidden = true;
        _switchBtn.on = [_model.value isEqualToString:@"1"];
    }else{
        _switchBtn.hidden = true;
        _valueTf.hidden = false;
        _valueTf.text = model.value;
    }
    
    _titleLb.text = model.title;
    
}

@end

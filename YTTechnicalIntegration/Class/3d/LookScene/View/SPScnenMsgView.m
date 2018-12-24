//
//  SPScnenMsgView.m
//  Alarm
//
//  Created by hiteam on 2018/10/15.
//  Copyright © 2018 Sspaas. All rights reserved.
//

#import "SPScnenMsgView.h"
#import "Masonry.h"

@interface SPScnenMsgView () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong)UIView *backView;
@property (nonatomic ,strong)UILabel *titleLb;
@property (nonatomic ,strong)UILabel *timeLb;
@property (nonatomic ,strong)UITableView *tableView;

@end

@implementation SPScnenMsgView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.backView];
        [self addSubview:self.titleLb];
//        [self addSubview:self.timeLb];
        [self addSubview:self.tableView];
        [self setLayout];
    }
    return self;
}

#pragma mark - Set Layout

- (void)setLayout{
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self);
    }];
    
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(10);
    }];
    
//    [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_titleLb.mas_bottom).offset(4);
//        make.left.equalTo(self).offset(20);
//    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLb.mas_bottom).offset(8);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(0);
        make.bottom.equalTo(self);
    }];
    
    [self layoutIfNeeded];
    
}

#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SPScnenMsgViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SPScnenMsgViewCell"];
    
    
    NSArray *datas = @[@{@"title":@"报警时间",@"content":@"2018-11-16 15:49"},
                       @{@"title":@"报警设备",@"content":@"机柜2-12"},
                       @{@"title":@"等级",@"content":@"紧急报警"},
                       @{@"title":@"报警事件",@"content":@"机柜过热报警"},
                       @{@"title":@"监控项",@"content":@"温度"},
                       @{@"title":@"报警值",@"content":@"60C°"}];
    
    cell.titleLb.text = datas[indexPath.row][@"title"];
    cell.contentLb.text = datas[indexPath.row][@"content"];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width-10, 1)];
    header.backgroundColor = [UIColor whiteColor];
    header.alpha = 0.5;
    return header;
}


#pragma mark - Get method

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0.7;
    }
    return _backView;
}


- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = [UIFont systemFontOfSize:10];
        _titleLb.textColor = [UIColor whiteColor];
        _titleLb.text = @"共有2条数据";

    }
    return _titleLb;
}

- (UILabel *)timeLb{
    if (!_timeLb) {
        _timeLb = [[UILabel alloc] init];
        _timeLb.font = [UIFont systemFontOfSize:9];
        _timeLb.textColor = [UIColor whiteColor];
        _timeLb.text = @"2018-09-10 15:57:32";
    }
    return _timeLb;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, 100) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.bounces = false;
        [_tableView registerClass:[SPScnenMsgViewCell class] forCellReuseIdentifier:@"SPScnenMsgViewCell"];
    }
    return _tableView;
}


#pragma mark - Set Method
- (void)setName:(NSString *)name {
    _name = name;
}

- (void)setContent:(NSString *)content{
    _content = content;
}

@end


#pragma mark - =========SPScnenMsgViewCell==========

@implementation SPScnenMsgViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.titleLb];
        [self addSubview:self.contentLb];
        [self setLayout];
        
    }
    return self;
}
#pragma mark - Set Layout
- (void)setLayout{
    
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(self);
        make.width.equalTo(@50);
    }];
    
    [_contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLb.mas_right).offset(10);
        make.centerY.equalTo(self);
    }];
    
    [self layoutIfNeeded];
}

#pragma mark - Get Method

- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = [UIFont systemFontOfSize:9];
        _titleLb.textColor = [UIColor whiteColor];
    }
    return _titleLb;
}

- (UILabel *)contentLb{
    if (!_contentLb) {
        _contentLb = [[UILabel alloc] init];
        _contentLb.font = [UIFont systemFontOfSize:9];
        _contentLb.textColor = [UIColor whiteColor];
    }
    return _contentLb;
}

@end

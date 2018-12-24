//
//  ShowFuctionView.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/7/17.
//  Copyright © 2018年 hiteam. All rights reserved.
//

#import "ShowFuctionView.h"
#import "ShowFuctionViewCell.h"
#import "Masonry.h"

#define kTableViewWidth 170

@interface ShowFuctionView ()<UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic ,strong) UIImageView *backView;
@property (nonatomic ,strong) UITableView *tableView;

@end

@implementation ShowFuctionView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    if (self) {
        [self addSubview:self.backView];
        [self addSubview:self.tableView];
        [self setLayout];
    }
    return self;
}

#pragma mark - Set Layout
- (void)setLayout{
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self).offset(64);
        make.left.equalTo(self).offset(screenWidth);
        make.width.equalTo(@kTableViewWidth);
    }];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
    
    [self layoutIfNeeded];
}

#pragma mark - Tap Action
- (void)tapAction{
    [self close];
}

#pragma mark - TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShowFuctionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShowFuctionViewCell"];
    cell.model = _dataArray[indexPath.row];
    return cell;
}

#pragma mark - Get Method
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[ShowFuctionViewCell class] forCellReuseIdentifier:@"ShowFuctionViewCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (UIImageView *)backView{
    if (!_backView) {
        _backView = [[UIImageView alloc] init];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.userInteractionEnabled = true;
        _backView.alpha = 0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [_backView addGestureRecognizer:tap];
    }
    return _backView;
}

#pragma mark - Public Method
- (void)show{
    
    [rootWindow addSubview:self];
    
    [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(screenWidth-kTableViewWidth);
    }];
    
    [UIView animateWithDuration:0.5 animations:^{
        [self layoutIfNeeded];
        self.backView.alpha = 0.5;
    }];
    
}

- (void)close{
    [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(screenWidth);
    }];
    
    [UIView animateWithDuration:0.5 animations:^{
        [self layoutIfNeeded];
        self.backView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

#pragma mark - Set Method
- (void)setDataArray:(NSArray<ShowFuctionViewModel *> *)dataArray{
    _dataArray = dataArray;
    [self.tableView reloadData];
}

@end



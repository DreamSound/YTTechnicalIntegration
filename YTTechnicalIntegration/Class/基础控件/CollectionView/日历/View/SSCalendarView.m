//
//  SSCalendarView.m
//  Alarm
//
//  Created by hiteam on 2017/11/6.
//  Copyright © 2017年 Sspaas. All rights reserved.
//

#import "SSCalendarView.h"
#import "SSCalendarCell.h"
#import "SSCalendarHeaderView.h"
#import "Masonry.h"

#define ContentHeight 400

@interface SSCalendarView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic ,strong)NSDate *firstDate;
@property (nonatomic ,strong)NSCalendar *calendar;
@property (nonatomic ,strong)NSMutableDictionary *monthDateDic;


@property (nonatomic ,strong)UIView *backView;
@property (nonatomic ,strong)UIView *contentView;

@property (nonatomic ,strong)UIView *toolsView;
@property (nonatomic ,strong)UIDatePicker *dataPick;
@property (nonatomic ,strong)UILabel *titleLb;
@property (nonatomic ,strong)UIButton *cancelBtn;

@property (nonatomic ,strong)UICollectionView *collectionView;

@property (nonatomic ,strong)UIButton *finishBtn;

@property (nonatomic ,strong)NSDate *startDate;
@property (nonatomic ,strong)NSDate *endDate;

@end

@implementation SSCalendarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

#pragma mark - Set Up
- (void)setUp{
    [self addSubview:self.backView];
    [self addSubview:self.contentView];
    [self setLayout];
}

#pragma mark - Set Layout
- (void)setLayout{
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(ContentHeight);
        make.left.right.equalTo(self);
        make.height.equalTo(@(ContentHeight));
    }];
    
    [_toolsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.equalTo(@(50));
    }];
    
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.toolsView);
    }];
    
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.toolsView);
        make.right.equalTo(self.toolsView).offset(-10);
        make.width.height.equalTo(@(50));
    }];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.toolsView.mas_bottom);
        make.bottom.equalTo(self.contentView);
    }];
    
    [_finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(100);
        make.right.equalTo(self.contentView).offset(-100);
        make.bottom.equalTo(self.contentView).offset(-20);
        make.height.equalTo(@(30));
    }];
    
    [self layoutIfNeeded];
}

#pragma mark - Button Action
- (void)cancelBtnAction{
    [self close];
}

- (void)finishBtnAction{
    if (_finish) {
        _finish(self,_startDate,_endDate);
    }
    [self close];
}

#pragma mark - GestureRecognizer
- (void)backViewTapAction{
    [self close];
}

#pragma mark - Show/Close
- (void)show{
    [kWindow addSubview:self];
    [_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
    }];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.backView.alpha = 0.23;
        [self layoutIfNeeded];
    }];
}

- (void)close{
    [_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(ContentHeight);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        [self layoutIfNeeded];
        self.backView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark - Collection View DataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SSCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    NSDateComponents* comps = [self.calendar components:NSCalendarUnitWeekday fromDate:self.monthDateDic[[NSString stringWithFormat:@"%ld",indexPath.section]]];
    
    if (indexPath.row - comps.weekday + 1 >= 0) {
        cell.titleLb.text = [NSString stringWithFormat:@"%ld",indexPath.row-comps.weekday+2];
    }else{
        cell.titleLb.text = @"";
    }
    
    [cell setSelected:NO];
    cell.subLb.text = @"";
    cell.type = SSCalendarCellTypeNull;
    if (cell.titleLb.text.length > 0) {
        
        NSDate * cellDate = [self getDateWithIndexPath:indexPath];
        
        if (_startDate && cellDate.timeIntervalSince1970 == _startDate.timeIntervalSince1970) {
            [cell setSelected:YES];
            cell.subLb.text = @"起始";
        }
        
        if (_endDate && cellDate.timeIntervalSince1970 == _endDate.timeIntervalSince1970) {
            [cell setSelected:YES];
            cell.subLb.text = @"终止";
        }
        
        if (_endDate && _startDate){
            if (cellDate.timeIntervalSince1970 > _startDate.timeIntervalSince1970 && cellDate.timeIntervalSince1970< _endDate.timeIntervalSince1970) {
                cell.type = SSCalendarCellTypeFill;
            }
        }
        
    }
    
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    NSDateComponents *compt = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self.firstDate toDate:[NSDate date] options:0];
    return compt.month;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self.firstDate];
    [dateComponents setMonth:section];
    
    NSDate *newdate = [self.calendar dateByAddingComponents:dateComponents toDate:_firstDate options:0];
    NSRange days = [self.calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:newdate];
    NSDateComponents* comps = [self.calendar components:NSCalendarUnitWeekday fromDate:newdate];
    
    
    self.monthDateDic[[NSString stringWithFormat:@"%ld",section]] = newdate;
    
    return days.length+comps.weekday - 1;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    SSCalendarHeaderView* reusableView;
    
    if (kind==UICollectionElementKindSectionHeader) {
        reusableView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SSCalendarHeaderView" forIndexPath:indexPath];
        
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月"];
    
    reusableView.titleLable.text = [formatter stringFromDate:self.monthDateDic[[NSString stringWithFormat:@"%ld",indexPath.section]]];
    reusableView.backgroundColor=[UIColor clearColor];
    return reusableView;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={320,40};
    return size;
}

#pragma mark - Collection View Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDate *didDate = [self getDateWithIndexPath:indexPath];
    NSLog(@"选中的时间是%@",didDate);
    
    if (_startDate&&_endDate) {
        _startDate = nil;
        _endDate = nil;
        [collectionView reloadData];
        return;
    }
    
    if (_startDate) {
        if (_startDate.timeIntervalSince1970 == didDate.timeIntervalSince1970) {
            return;
        }
        
        if (_startDate.timeIntervalSince1970 > didDate.timeIntervalSince1970) {
            _endDate = _startDate;
            _startDate = didDate;
        }else{
            _endDate = didDate;
        }
        [collectionView reloadData];
        return;
    }
    
    _startDate = didDate;
    [collectionView reloadData];
}


#pragma mark - Get Method


- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backViewTapAction)];
        [_backView addGestureRecognizer:tap];
    }
    return _backView;
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];
        [_contentView addSubview:self.toolsView];
        [_contentView addSubview:self.collectionView];
        [_contentView addSubview:self.finishBtn];
    }
    return _contentView;
}

- (UIView *)toolsView{
    if (!_toolsView) {
        _toolsView = [[UIView alloc] init];
        _toolsView.backgroundColor = colorFromHex(0xf0f0f0);
        [_toolsView addSubview:self.titleLb];
        [_toolsView addSubview:self.cancelBtn];
    }
    return _toolsView;
}

- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = [UIFont systemFontOfSize:16];
        _titleLb.text = @"选择日期";
    }
    return _titleLb;
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_cancelBtn setTitle:@"X" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}


- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(screenWidth/7, screenWidth/7);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[SSCalendarCell class] forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerClass:[SSCalendarHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SSCalendarHeaderView"];
    }
    return _collectionView;
}

- (NSDate *)firstDate{
    if (!_firstDate) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        _firstDate = [formatter dateFromString:@"2016-01-01"];
    }
    return _firstDate;
}

- (NSCalendar *)calendar{
    if (!_calendar) {
        _calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }
    return _calendar;
}

- (NSMutableDictionary *)monthDateDic{
    if (!_monthDateDic) {
        _monthDateDic = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _monthDateDic;
}

- (UIButton *)finishBtn{
    if (!_finishBtn) {
        _finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _finishBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_finishBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_finishBtn addTarget:self action:@selector(finishBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_finishBtn setBackgroundColor:colorFromHex(0x1043c6)];
        _finishBtn.layer.cornerRadius = 5;
        _finishBtn.layer.masksToBounds = YES;
    }
    return _finishBtn;
}

#pragma mark - Tools
- (NSDate *)getDateWithIndexPath:(NSIndexPath *)indexPath{
    
    
    NSDate *tempDate = self.monthDateDic[[NSString stringWithFormat:@"%ld",indexPath.section]];
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:tempDate];
    NSDateComponents* comps = [self.calendar components:NSCalendarUnitWeekday fromDate:tempDate];
    
    if (indexPath.row +1  < comps.weekday) {
        return nil;
    }
    
    [dateComponents setDay:indexPath.row + 1 - comps.weekday];
    return [self.calendar dateByAddingComponents:dateComponents toDate:tempDate options:0];
}

@end

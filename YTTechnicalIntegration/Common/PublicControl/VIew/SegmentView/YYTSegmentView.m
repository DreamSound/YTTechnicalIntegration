//
//  YYTSegmentView.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/8/7.
//  Copyright © 2018年 hiteam. All rights reserved.
//

#import "YYTSegmentView.h"
#import "YYTSegmentCell.h"
#import "Masonry.h"
@interface YYTSegmentView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic ,strong)UICollectionView *collectionView;

@end

@implementation YYTSegmentView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _index = -1;
        [self addSubview:self.collectionView];
        [self setLayout];
    }
    return self;
}

- (void)setLayout{
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
}

#pragma mark - Collection Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YYTSegmentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YYTSegmentCell" forIndexPath:indexPath];
    cell.title = _titles[indexPath.row];
    cell.isSelected = (_index == indexPath.row);
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.index = indexPath.row;
    if (self.selectAction) {
        self.selectAction(indexPath.row);
    }
    [collectionView reloadData];
}

#pragma mark - Get Method
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(screenWidth/2 -10, 20);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UIAccessibilityScrollDirectionLeft;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[YYTSegmentCell class] forCellWithReuseIdentifier:@"YYTSegmentCell"];
    }
    return _collectionView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

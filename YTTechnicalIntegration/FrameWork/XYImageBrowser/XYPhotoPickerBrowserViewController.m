//
//  XYPhotoPickerBrowserViewController.m
//  浏览器相册
//
//  Created by cyp on 16/3/15.
//  Copyright (c) 2016年 XY. All rights reserved.
//

#import "XYPhotoPickerBrowserViewController.h"
#import "XYPhotoPickerBrowserCollectionViewCell.h"
//#import "SSFileManage.h"

static NSString *_cellIdentifier = @"collectionViewCell";

//单元格之间的最小行间距
static CGFloat const XYPickerColletionViewPadding = 20;

@interface XYPhotoPickerBrowserViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,XYPhotoPickerBrowserPhotoScrollViewDelegate,UIActionSheetDelegate>{
    UIImage *needSaveImage;
}

//相册视图控制器
@property (nonatomic, weak)  UICollectionView *collectionView;


//photo数据源
@property (nonatomic ,strong) NSArray* photosArr;

//当前显示
@property (nonatomic ,assign) int currentNumber;
//tap事件
@property (nonatomic ,strong) UITapGestureRecognizer *tap;
@end

@implementation XYPhotoPickerBrowserViewController
- (instancetype)initWithPhotoArr:(NSArray *)photosArr andCurrentNumber:(int)currentNumber{
    self = [super init];
    if (self) {
        self.photosArr = photosArr;
        self.currentNumber = currentNumber;
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.collectionView reloadData];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[[UIView alloc]init]];
    [self initCollectionView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)initCollectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        //最小行间距
        flowLayout.minimumLineSpacing = XYPickerColletionViewPadding;
        //最小列间距
        flowLayout.minimumInteritemSpacing = 0;
        //单元格大小
        flowLayout.itemSize = self.view.frame.size;
        //横向滑动
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CGRect frame = self.view.bounds;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width + XYPickerColletionViewPadding,frame.size.height) collectionViewLayout:flowLayout];
        //显示水平滑动条
        collectionView.showsHorizontalScrollIndicator = YES;
        //隐藏垂直滑动条
        collectionView.showsVerticalScrollIndicator = NO;
        //分页
        collectionView.pagingEnabled = YES;
        collectionView.backgroundColor = [UIColor blackColor];
        collectionView.bounces = YES;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[XYPhotoPickerBrowserCollectionViewCell class] forCellWithReuseIdentifier:_cellIdentifier];
        [self.view addSubview:collectionView];
        self.collectionView = collectionView;
        self.collectionView.contentOffset = CGPointMake((self.view.frame.size.width + XYPickerColletionViewPadding)*self.currentNumber, 0);
        self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backTapAction)];
        [self.view addGestureRecognizer:self.tap];
    }
}

#pragma mark -- UICollectionViewDataSource
//返回cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photosArr.count;
}
//自定义cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XYPhotoPickerBrowserCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_cellIdentifier forIndexPath:indexPath];
    cell.scrollView.photoScrollViewDelegate = self;
    [cell reloadViewWithPhotosArr:self.photosArr andIndexPath:indexPath];
    return cell;
}
//该方法返回的CGSize将控制指定分区的页脚控制的大小；
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(XYPickerColletionViewPadding, self.view.frame.size.height);
}
#pragma mark - XYPhotoPickerBrowserPhotoScrollViewDelegate
- (void)pickerPhotoScrollViewDidLongPressed:(XYPhotoPickerBrowserPhotoScrollView *)photoScrollView{
    
    needSaveImage = [photoScrollView getVisibleImage];
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:@"保存图片"
                                  otherButtonTitles:nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

- (void)pickerPhotoScrollViewDidSingleClick:(XYPhotoPickerBrowserPhotoScrollView *)photoScrollView{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)backTapAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
//        [SSFileManage addImageToAlbum:needSaveImage];
    }
//    [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
}

- (void)dealloc{
}



@end

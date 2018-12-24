//
//  XYPhotoPickerBrowserCollectionViewCell.m
//  浏览器相册
//
//  Created by cyp on 16/3/15.
//  Copyright (c) 2016年 XY. All rights reserved.
//

#import "XYPhotoPickerBrowserCollectionViewCell.h"

@interface XYPhotoPickerBrowserCollectionViewCell()



@end

@implementation XYPhotoPickerBrowserCollectionViewCell

- (instancetype)init{
    self = [super init];
    if (self) {
        [self makeView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeView];
    }
    return self;
}

- (void)makeView{
    XYPhotoPickerBrowserPhotoScrollView *scrollView =  [[XYPhotoPickerBrowserPhotoScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.contentView addSubview:scrollView];
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.scrollView = scrollView;
}
- (void)reloadViewWithPhotosArr:(NSArray *)photosArr andIndexPath:(NSIndexPath *)indexPath{
    self.scrollView.photo = photosArr[indexPath.item];
}
@end

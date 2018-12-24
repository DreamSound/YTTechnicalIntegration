//
//  XYPhotoPickerBrowserCollectionViewCell.h
//  浏览器相册
//
//  Created by cyp on 16/3/15.
//  Copyright (c) 2016年 XY. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XYPhotoPickerBrowserPhotoScrollView.h"

@interface XYPhotoPickerBrowserCollectionViewCell : UICollectionViewCell

@property (nonatomic ,weak) XYPhotoPickerBrowserPhotoScrollView* scrollView;

- (void)reloadViewWithPhotosArr:(NSArray *)photosArr andIndexPath:(NSIndexPath *)indexPath;

@end

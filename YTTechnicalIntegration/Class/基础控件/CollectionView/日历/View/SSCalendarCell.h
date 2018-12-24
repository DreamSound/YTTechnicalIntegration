//
//  SSCalendarCell.h
//  Alarm
//
//  Created by hiteam on 2017/11/6.
//  Copyright © 2017年 Sspaas. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,SSCalendarCellType) {
    SSCalendarCellTypeNull = 0,
    SSCalendarCellTypeLeftArc,
    SSCalendarCellTypeRightArc,
    SSCalendarCellTypeLeftHalf,
    SSCalendarCellTypeRightHalf,
    SSCalendarCellTypeFill,
};

@interface SSCalendarCell : UICollectionViewCell

@property (nonatomic ,strong) UILabel *titleLb;
@property (nonatomic ,strong) UILabel *subLb;
@property (nonatomic ,assign) NSInteger type;
@property (nonatomic ,strong) UIView *shadowView;

@end

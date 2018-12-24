//
//  TableViewMoveCellCell.h
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/8/1.
//  Copyright © 2018年 hiteam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "MoveCellMod.h"
@class TableViewMoveCellCell;

@protocol TableViewMoveCellCellDelegate <NSObject>

- (void)moveCellLongPress:(TableViewMoveCellCell *)movecell press:(UILongPressGestureRecognizer *)press indexPath:(NSIndexPath *)indexPath;

@end

@interface TableViewMoveCellCell : BaseTableViewCell

@property (nonatomic ,strong)NSIndexPath *indexPath;
@property (nonatomic ,weak) id <TableViewMoveCellCellDelegate> delegate;
@property (nonatomic ,strong)MoveCellMod *cellMod;
@property (nonatomic ,assign)BOOL isEdit;

- (void)setEdit:(BOOL)isEdit isAnimation:(BOOL)isAnimation;

- (void)didSelectedCell;

@end

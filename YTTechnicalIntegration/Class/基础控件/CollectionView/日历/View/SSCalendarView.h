//
//  SSCalendarView.h
//  Alarm
//
//  Created by hiteam on 2017/11/6.
//  Copyright © 2017年 Sspaas. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SSCalendarView;
typedef void(^SSCalendarDidSelected)(SSCalendarView*datePicker,NSDate *startDate ,NSDate *endDate);

@interface SSCalendarView : UIView

@property (strong ,nonatomic)SSCalendarDidSelected finish;

- (void)show;
- (void)close;

@end

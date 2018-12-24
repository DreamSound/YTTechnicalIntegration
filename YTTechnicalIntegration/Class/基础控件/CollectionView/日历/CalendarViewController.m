//
//  CalendarViewController.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/11/23.
//  Copyright © 2018 hiteam. All rights reserved.
//

#import "CalendarViewController.h"
#import "SSCalendarView.h"
#import "Tools.h"

@interface CalendarViewController ()

@property (nonatomic ,strong) UILabel *dateLb;
@property (nonatomic ,strong) UIButton *selectDateBtn;

@property (nonatomic ,strong) SSCalendarView *datePicker;

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.dateLb];
    [self.view addSubview:self.selectDateBtn];
    [self setLayout];
}

#pragma mark - Set Layout
- (void)setLayout{
    [_dateLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.left.equalTo(self.view).offset(20);
    }];
    
    [_selectDateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dateLb);
        make.top.equalTo(self.dateLb.mas_bottom).offset(10);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];
    
    [self.view layoutIfNeeded];
}

#pragma mark - Button Action
- (void)selectDateAction{
    [self.datePicker show];
}

#pragma mark - Get Method
- (UILabel *)dateLb{
    if (!_dateLb) {
        _dateLb = [[UILabel alloc] init];
        _dateLb.font = [UIFont systemFontOfSize:12];
        _dateLb.textAlignment = NSTextAlignmentCenter;
        _dateLb.text = @"请选择时间";
    }
    return _dateLb;
}

- (UIButton *)selectDateBtn{
    if (!_selectDateBtn) {
        _selectDateBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_selectDateBtn setTitle:@"选择时间" forState:UIControlStateNormal];
        [_selectDateBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_selectDateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_selectDateBtn addTarget:self action:@selector(selectDateAction) forControlEvents:UIControlEventTouchUpInside];
        [_selectDateBtn setBackgroundColor:colorFromHex(0x1043c6)];
        _selectDateBtn.layer.cornerRadius = 5;
        _selectDateBtn.layer.masksToBounds = YES;
    }
    return _selectDateBtn;
}

- (SSCalendarView *)datePicker{
    if (!_datePicker) {
        _datePicker = [[SSCalendarView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
        NSString *formatter = @"yyyy-MM-dd";
        weak_self
        _datePicker.finish = ^(SSCalendarView *datePicker, NSDate *startDate, NSDate *endDate) {
            weakSelf.dateLb.text = [NSString stringWithFormat:@"%@~%@",[Tools dateStrWithDate:startDate formatter:formatter],[Tools dateStrWithDate:endDate formatter:formatter]];
        };
    }
    return _datePicker;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  NetVC.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/8/3.
//  Copyright © 2018年 hiteam. All rights reserved.
//

#import "NetVC.h"
#import "HTMLAnalysisVC.h"
#import "Masonry.h"

@interface NetVC ()<UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic ,strong)UITableView *tableView;

@property (nonatomic ,strong)NSArray <NSString *>*dataArray;
@property (nonatomic ,strong)NSArray <UIViewController *>*controllerArray;

@end

@implementation NetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    [self.view addSubview:self.tableView];
    [self setLayout];
}

#pragma mark - Set Up
- (void)setUp{
    _dataArray = @[@"网页解析"];
    _controllerArray = @[[[HTMLAnalysisVC alloc] init]];
}

#pragma mark - Set Layout
- (void)setLayout{
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark - TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController * nextVC = _controllerArray[indexPath.row];
    nextVC.navigationItem.title = _dataArray[indexPath.row];
    [self.navigationController pushViewController:nextVC animated:YES];
}

#pragma mark - Get Method
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 200, 200) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

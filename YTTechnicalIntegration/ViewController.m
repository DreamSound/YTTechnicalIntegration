//
//  ViewController.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/2/24.
//  Copyright © 2018年 hiteam. All rights reserved.
//

#import "ViewController.h"
#import "BaseControlVC.h"
#import "DrawViewController.h"
#import "NetVC.h"
#import "ThreeDimensionalViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)NSArray <UIViewController *>*dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableView];
    [self createDatasource];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) style:UITableViewStylePlain];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"itemCell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
#pragma mark - DataSource

- (void)createDatasource{
    BaseControlVC *bcVC = [[BaseControlVC alloc] init];
    bcVC.title = @"基础控件";
    
    DrawViewController *drawVC = [[DrawViewController alloc] init];
    drawVC.title = @"绘制";
    
    NetVC *netVC = [[NetVC alloc] init];
    netVC.title = @"网络";
    
    ThreeDimensionalViewController *threeDimensionVC = [[ThreeDimensionalViewController alloc] init];
    threeDimensionVC.title = @"3D";
    
    _dataSource = @[bcVC,drawVC,netVC,threeDimensionVC];
}


#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *itemCell = [tableView dequeueReusableCellWithIdentifier:@"itemCell"];
    itemCell.textLabel.text = _dataSource[indexPath.row].title;
    return itemCell;
    
}

#pragma mark - TableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIViewController *nextVC = _dataSource[indexPath.row];
    [self.navigationController pushViewController:nextVC animated:nextVC];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end




//
//  BaseListViewController.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/11/15.
//  Copyright © 2018 hiteam. All rights reserved.
//

#import "BaseListViewController.h"
#import "BaseListViewCell.h"

@interface BaseListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView *tableView;

@end

@implementation BaseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = colorFromHex(0x208ae1);
    [self createTableView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, screenWidth, screenHeight-64) style:UITableViewStylePlain];
    [_tableView registerClass:[BaseListViewCell class] forCellReuseIdentifier:@"BaseListViewCell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BaseListViewCell *itemCell = [tableView dequeueReusableCellWithIdentifier:@"BaseListViewCell"];
    itemCell.title = _items[indexPath.row].title;
    return itemCell;
    
}

#pragma mark - TableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BaseListViewItem *item = _items[indexPath.row];
    UIViewController *controller = [[NSClassFromString(item.controllerName) alloc] init];
    controller.title = item.title;
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

#pragma mark - Set Method
- (void)setItems:(NSArray<BaseListViewItem *> *)items{
    _items = items.copy;
    [self.tableView reloadData];
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

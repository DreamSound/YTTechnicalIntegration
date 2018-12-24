//
//  TableViewMoveCellVC.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/8/1.
//  Copyright © 2018年 hiteam. All rights reserved.
//

#import "TableViewMoveCellVC.h"
#import "TableViewMoveCellCell.h"
#import "MoveCellMod.h"
#import "Tools.h"


@interface TableViewMoveCellVC ()<UITableViewDelegate ,UITableViewDataSource,TableViewMoveCellCellDelegate>

@property (nonatomic ,weak)  UIButton *rightNavBtn;
@property (nonatomic ,assign)BOOL isEdit;

@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)NSMutableArray<MoveCellMod *> *cellMods;

@property (nonatomic ,strong)UIImageView *snapImageView; //正在移动的cell的截图
@property (nonatomic ,strong)NSIndexPath *moveIndexPath; //正在移动的cell的位置
@property (nonatomic ,strong)TableViewMoveCellCell *moveCell; //正在移动的cell对象

@end

@implementation TableViewMoveCellVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self.view addSubview:self.tableView];
    
    _rightNavBtn = [self addItemWithTitle:@"多选" imageName:nil selector:@selector(rightNavAction) location:false];
    
    // Do any additional setup after loading the view.
}
#pragma mark - Set up
- (void)setup{
    
    self.cellMods = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 20; i++) {
        MoveCellMod *cellMod = [[MoveCellMod alloc] init];
        cellMod.content = [NSString stringWithFormat:@"%ld",(long)i];
        [self.cellMods addObject:cellMod];
    }
}

#pragma mark - Nav Button Action
- (void)rightNavAction{
    _isEdit = !_isEdit;
    for (TableViewMoveCellCell *cell in _tableView.visibleCells) {
        [cell setEdit:_isEdit isAnimation:YES];
    }
    [_rightNavBtn setTitle:_isEdit?@"完成":@"多选" forState:UIControlStateNormal];
}

#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cellMods.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewMoveCellCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewMoveCellCell"];
    cell.cellMod = _cellMods[indexPath.row];
    cell.isEdit = _isEdit;
    cell.indexPath = indexPath;
    cell.delegate = self;
    return cell;
}


#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isEdit) {
        TableViewMoveCellCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell didSelectedCell];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    MoveCellMod *temp = _cellMods[sourceIndexPath.row];
    [_cellMods removeObject:_cellMods[sourceIndexPath.row]];
    [_cellMods insertObject:temp atIndex:destinationIndexPath.row];
}

#pragma mark - MoveCell Delegate
- (void)moveCellLongPress:(TableViewMoveCellCell *)movecell press:(UILongPressGestureRecognizer *)press indexPath:(NSIndexPath *)indexPath{
    if (press.state == 1) {
        CGPoint pressPoint = [press locationInView:self.view];
        [self.view addSubview:self.snapImageView];
        self.snapImageView.frame = CGRectMake(0, pressPoint.y-movecell.height/2, movecell.width, movecell.height);
        self.snapImageView.image = [Tools snapshot:movecell rect:movecell.bounds];
        _moveCell = movecell;
        _moveIndexPath = indexPath;
        _moveCell.hidden = true;
        //震动反馈
        UIImpactFeedbackGenerator *impactLight = [[UIImpactFeedbackGenerator alloc]initWithStyle:UIImpactFeedbackStyleLight];
        [impactLight impactOccurred];
        
    } else if (press.state == 2){
        
        CGPoint pressPoint = [press locationInView:self.view];
        self.snapImageView.frame = CGRectMake(0, pressPoint.y-movecell.height/2 , movecell.width, movecell.height);
        
        CGPoint inTablePoint = [press locationInView:_tableView];
        
        NSIndexPath *nowIndexPath = [_tableView indexPathForRowAtPoint:inTablePoint];
        
        if (!(nowIndexPath.row == _moveIndexPath.row && nowIndexPath.section == _moveIndexPath.section)) {
            [_tableView moveRowAtIndexPath:_moveIndexPath toIndexPath:nowIndexPath];
            [self tableView:_tableView moveRowAtIndexPath:_moveIndexPath toIndexPath:nowIndexPath];
            _moveIndexPath = nowIndexPath;
            
            //震动反馈
            UIImpactFeedbackGenerator*impactLight = [[UIImpactFeedbackGenerator alloc]initWithStyle:UIImpactFeedbackStyleLight];
            [impactLight impactOccurred];
            
        }
        
    }else{
        _moveCell.hidden = false;
        [self.snapImageView removeFromSuperview];
        [_tableView reloadData];
    }
}

#pragma mark - Get Method
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, screenWidth, screenHeight - 64) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[TableViewMoveCellCell class] forCellReuseIdentifier:@"TableViewMoveCellCell"];
//        _tableView.editing = true;
    }
    return _tableView;
}

- (UIImageView *)snapImageView{
    if (!_snapImageView) {
        _snapImageView = [[UIImageView alloc] init];
        _snapImageView.layer.shadowOpacity = 0.5;
        _snapImageView.layer.shadowOffset = CGSizeMake(0, 0);
        _snapImageView.layer.shadowRadius = 10;
        _snapImageView.alpha = 0.8;
    }
    return _snapImageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

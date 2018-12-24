//
//  TableViewRotateVC.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/8/1.
//  Copyright © 2018年 hiteam. All rights reserved.
//

#import "TableViewRotateVC.h"

#import "TableViewRotateCell.h"
#import "Masonry.h"
#import "TipView.h"

@interface TableViewRotateVC ()<UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)NSArray *data;

@end

@implementation TableViewRotateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUp];
    [self.view addSubview:self.tableView];
    [TipView showInView:self.view content:@"然而横过来并没有什么意义 还是CollectionView方便一些"];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_data.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

#pragma mark - Set Up
- (void)setUp{
    _data = @[@"",
              @"\n\n\n\n\n\n\n\n\n\n\n\n岳阳楼记",
              @"\n\n庆历四年春，滕子京谪守巴陵郡。越明年，政通人和，百废",
              @"具兴。乃重修岳阳楼，增其旧制，刻唐贤今人诗赋于其上。属予",
              @"作文以记之。",
              @"\n\n予观夫巴陵胜状，在洞庭一湖。衔远山，吞长江，浩浩汤",
              @"汤，横无际涯；朝晖夕阴，气象万千。此则岳阳楼之大观也，前",
              @"人之述备矣。然则北通巫峡，南极潇湘，迁客骚人，多会于此，",
              @"览物之情，得无异乎？",
              @"\n\n若夫霪雨霏霏，连月不开，阴风怒号，浊浪排空；日星隐曜",
              @"，山岳潜形；商旅不行，樯倾楫摧；薄暮冥冥，虎啸猿啼。登斯",
              @"楼也，则有去国怀乡，忧谗畏讥，满目萧然，感极而悲者矣。",
              @"\n\n至若春和景明，波澜不惊，上下天光，一碧万顷；沙鸥翔集",
              @"，锦鳞游泳；岸芷汀兰，郁郁青青。而或长烟一空，皓月千里，",
              @"浮光跃金，静影沉璧，渔歌互答，此乐何极！登斯楼也，则有心",
              @"旷神怡，宠辱偕忘，把酒临风，其喜洋洋者矣。",
              @"\n\n嗟夫！予尝求古仁人之心，或异二者之为，何哉？不以物喜",
              @"，不以己悲；居庙堂之高则忧其民；处江湖之远则忧其君。是进",
              @"亦忧，退亦忧。然则何时而乐耶？其必曰“先天下之忧而忧，后",
              @"天下之乐而乐”乎。噫！微斯人，吾谁与归？",
              @"\n\n\n\n\n时六年九月十五日",
              @""];
}

#pragma mark - TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewRotateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewRotateCell"];
    cell.titleLb.text = _data[_data.count - indexPath.row - 1];
    [cell layoutIfNeeded];
    return cell;
}

#pragma mark - TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

#pragma mark - Get Method

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, screenHeight - 64, screenHeight - 64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[TableViewRotateCell class] forCellReuseIdentifier:@"TableViewRotateCell"];//翻转用cell
        _tableView.transform = CGAffineTransformMakeRotation(-M_PI_2);
        _tableView.frame = CGRectMake(0, 64, screenWidth, screenHeight-64);
    }
    return _tableView;
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

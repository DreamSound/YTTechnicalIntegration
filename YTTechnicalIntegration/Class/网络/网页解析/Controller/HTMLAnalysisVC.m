//
//  HTMLAnalysisVC.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/8/3.
//  Copyright © 2018年 hiteam. All rights reserved.
//

#import "HTMLAnalysisVC.h"
#import "HTMLAnalysisCell.h"
#import "Masonry.h"
#import "YYTSegmentView.h"

typedef  NS_ENUM(NSInteger,AnalysisState){
    AnalysisStateLink,
    AnalysisStateImage,
};

@interface HTMLAnalysisVC ()<UITableViewDataSource,UITableViewDelegate>

//ui
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)YYTSegmentView *segementView;

//data
@property (nonatomic ,strong)NSString *htmlStr;
@property (nonatomic ,strong)NSString *htmlTitle;
@property (nonatomic ,strong)NSArray <NSString *>*htmlImageArray;
@property (nonatomic ,strong)NSArray <NSString *>*htmlLinkArray;

@property (nonatomic ,assign)AnalysisState state;

@end

@implementation HTMLAnalysisVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.segementView];
    [self setLayout];
    //获取网页数据
    weak_self
    [self analysisHTML:[NSURL URLWithString:@"http://www.hao123.com/gaoxiao?pn=1"] finish:^(NSString *htmlStr) {
        weakSelf.htmlLinkArray = [weakSelf getHtmlStrLinks:htmlStr];
        weakSelf.htmlImageArray = [weakSelf getImageStrLinks:htmlStr];
        [weakSelf.tableView reloadData];
    }];
    
    
    
    
}

#pragma mark - Set Layout
- (void)setLayout{
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64 + kTopSlimSafeSpace + 30);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    
    [self.view layoutIfNeeded];
}

#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (_state) {
        case AnalysisStateLink:{
            return _htmlLinkArray.count;
        }
            break;
        case AnalysisStateImage:{
            return _htmlImageArray.count;
        }
            break;
        default:
            return 0;
            break;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HTMLAnalysisCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTMLAnalysisCell"];
    
    if (self.state == AnalysisStateLink) {
        cell.content = _htmlLinkArray[indexPath.row];
        cell.image = nil;
    }else{
        cell.content = _htmlImageArray[indexPath.row];
        cell.image = _htmlImageArray[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

#pragma mark - Get Method
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, screenWidth, screenHeight - 64) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[HTMLAnalysisCell class] forCellReuseIdentifier:@"HTMLAnalysisCell"];
    }
    return _tableView;
}

- (YYTSegmentView *)segementView{
    if (!_segementView) {
        _segementView = [[YYTSegmentView alloc] initWithFrame:CGRectMake(0, 64, screenWidth, 30)];
        _segementView.titles = @[@"二级网页",@"图片"];
        weak_self
        _segementView.selectAction = ^(NSInteger index) {
            weakSelf.state = index;
            [weakSelf.tableView reloadData];
        };
    }
    return _segementView;
}

#pragma mark - Tools

//获取html网址的内容
- (void)analysisHTML:(NSURL *)url finish:(void(^)(NSString *htmlStr))finish{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *htmlStr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            finish(htmlStr);
        });
    });
}
//筛选图片
- (NSArray <NSString *>*)getImageStrLinks:(NSString *)htmlStr{
    
    NSRegularExpression *regularExpretion= [NSRegularExpression regularExpressionWithPattern:@"https?\\S*.(jpg|png)" options:0 error:nil];
    
    NSArray *resultArray = [regularExpretion matchesInString:htmlStr options:0 range:NSMakeRange(0, htmlStr.length)];
    NSMutableArray *imageStrArray = [NSMutableArray arrayWithCapacity:50];
    for (NSTextCheckingResult * result in resultArray) {
        [imageStrArray addObject:[htmlStr substringWithRange:result.range]];
    }
    
    return imageStrArray;
}
//筛选网址
- (NSArray <NSString *>*)getHtmlStrLinks:(NSString *)htmlStr{
    
    NSRegularExpression *regularExpretion= [NSRegularExpression regularExpressionWithPattern:@"(http|ftp|https):\\/\\/[\\w\\-_]+(\\.[\\w\\-_]+)+([\\w\\-\\.,@?^=%&amp;:/~\\+#]*[\\w\\-\\@?^=%&amp;/~\\+#])?" options:0 error:nil];
    
    NSArray *resultArray = [regularExpretion matchesInString:htmlStr options:0 range:NSMakeRange(0, htmlStr.length)];
    NSMutableArray *htmlStrArray = [NSMutableArray arrayWithCapacity:50];
    for (NSTextCheckingResult * result in resultArray) {
        [htmlStrArray addObject:[htmlStr substringWithRange:result.range]];
    }
    return htmlStrArray;
}

//去除标签
- (NSString *)getDelDivwithString:(NSString *)string{
    NSRegularExpression *regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"<[^>]*>|\n" options:0 error:nil];
    string = [regularExpretion stringByReplacingMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length) withTemplate:@""];
    return string;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

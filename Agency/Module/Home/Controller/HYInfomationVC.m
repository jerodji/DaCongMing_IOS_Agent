//
//  HYInfomationVC.m
//  Agency
//
//  Created by Jack on 2017/11/21.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYInfomationVC.h"
#import "HYInfoTableViewCell.h"
#import "HYInformationDetailVC.h"

@interface HYInfomationVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *datalist;
@property (nonatomic,assign) NSInteger pageNo;

@end

@implementation HYInfomationVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubviews];
    [self requestNetWork];
}

- (void)setupSubviews{
    
    self.pageNo = 1;
    self.title = @"资讯";
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self.view);
    }];
}

- (void)requestNetWork{
    
    [self.datalist removeAllObjects];
    _pageNo = 1;
    [HYUserRequestHandle getAllArticleListWithPageNo:_pageNo ComplectionBlock:^(NSArray *datalist) {
       
        if (datalist) {
            
            [self.datalist addObjectsFromArray:datalist];
            [_tableView reloadData];
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_footer endRefreshing];
        }
    }];
}

- (void)requestDataMore{
    
    _pageNo += 1;
    [HYUserRequestHandle getAllArticleListWithPageNo:_pageNo ComplectionBlock:^(NSArray *datalist) {
        
        if (datalist.count) {
            
            [self.datalist addObjectsFromArray:datalist];
            [_tableView reloadData];
            [_tableView.mj_footer endRefreshing];
        }
        else{
            
            [_tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }];
    
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.datalist.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *informationCellID = @"informationCellID";
    HYInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:informationCellID];
    if (!cell) {
        cell = [[HYInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:informationCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    HYInfomationDetailModel *model = [HYInfomationDetailModel modelWithDictionary:self.datalist[indexPath.section]];
    cell.model = model;
    
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HYInformationDetailVC *detailVC = [HYInformationDetailVC new];
    HYInfomationDetailModel *model = [HYInfomationDetailModel modelWithDictionary:self.datalist[indexPath.section]];
    detailVC.url = model.url;
    detailVC.model = model;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 10 * WIDTH_MULTIPLE)];
    headerView.backgroundColor = KAPP_TableView_BgColor;
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10 * WIDTH_MULTIPLE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100 * WIDTH_MULTIPLE;
}


#pragma mark - lazyload
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = KAPP_TableView_BgColor;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestNetWork)];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestDataMore)];
    }
    return _tableView;
}

- (NSMutableArray *)datalist{
    
    if (!_datalist) {
        _datalist = [NSMutableArray array];
    }
    return _datalist;
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

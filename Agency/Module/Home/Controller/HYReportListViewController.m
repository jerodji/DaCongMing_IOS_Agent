//
//  HYReportListViewController.m
//  Agency
//
//  Created by 胡勇 on 2017/11/6.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYReportListViewController.h"
#import "HYReportListHeaderView.h"
#import "HYReportListCell.h"

@interface HYReportListViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *viewModelArray;

@end

@implementation HYReportListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupData];
    [self setupSubviews];
}

- (void)setupSubviews{
    
    self.title = @"报表列表";
    [self.view addSubview:self.tableView];
}

- (void)setupData{
    
    [self.viewModelArray removeAllObjects];
    for (NSDictionary *dict in self.model.dataList) {
        
        HYReportModel *model = [HYReportModel modelWithDictionary:dict];
        HYReportCellViewModel *viewModel = [[HYReportCellViewModel alloc] initWithModel:model];
        [self.viewModelArray addObject:viewModel];
    }
}

- (void)viewDidLayoutSubviews{
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.viewModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reportListCellID = @"reportListCellID";
    HYReportListCell *cell = [tableView dequeueReusableCellWithIdentifier:reportListCellID];
    if (!cell) {
        cell = [[HYReportListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reportListCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.indexPath = indexPath;
    [cell setWithViewModel:self.viewModelArray[indexPath.row]];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    static NSString *headerViewCellID = @"headerViewCellID";
    HYReportListHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewCellID];
    if (!headerView) {
        headerView = [[HYReportListHeaderView alloc] initWithReuseIdentifier:headerViewCellID];
    }
    headerView.allOrderLabel.text = [NSString stringWithFormat:@"订单总量:%@单",_model.orderCount];
    headerView.allAmountLabel.text = [NSString stringWithFormat:@"总金额:%@",_model.totalAmount];
    return headerView;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60 * WIDTH_MULTIPLE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 80 * WIDTH_MULTIPLE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.0001;
}


#pragma mark - lazyload
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = KAPP_TableView_BgColor;
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 0.001)];
        _tableView.tableFooterView = footerView;
    }
    return _tableView;
}

- (NSMutableArray *)viewModelArray{
    
    if (!_viewModelArray) {
        _viewModelArray = [NSMutableArray array];
    }
    return _viewModelArray;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

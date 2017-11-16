//
//  HYBankCardViewController.m
//  Agency
//
//  Created by 胡勇 on 2017/11/3.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBankCardViewController.h"
#import "HYBankInfoTableViewCell.h"
#import "HYUploadIDCardViewController.h"

@interface HYBankCardViewController () <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *datalist;

@end

@implementation HYBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubviews];
    [self requestBankInfo];
}

- (void)setupSubviews{
    
    self.title = @"银行卡";
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *addBankCard = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add_bank"] style:UIBarButtonItemStylePlain target:self action:@selector(addBankCardAction)];
    self.navigationItem.rightBarButtonItem = addBankCard;
}

- (void)requestBankInfo{
    
    
}

- (void)viewDidLayoutSubviews{
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - action
- (void)addBankCardAction{
    
    HYUploadIDCardViewController *uploadVC = [[HYUploadIDCardViewController alloc] init];
    [self.navigationController pushViewController:uploadVC animated:YES];
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 0;
    //return self.datalist.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *bankCellID = @"bankCellID";
    HYBankInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:bankCellID];
    if (!cell) {
        cell = [[HYBankInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:bankCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.layer.cornerRadius = 6 * WIDTH_MULTIPLE;
    cell.layer.masksToBounds = YES;
    return cell;
}

#pragma mark - emptyDelegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    
    UIImage *image = [UIImage imageNamed:@"bank_gray"];
    return image;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    
    NSString *text = @"暂无绑定的银行卡\n点击右上角添加银行卡";
    NSDictionary *attributes = @{NSFontAttributeName : KFitFont(16),NSForegroundColorAttributeName : KAPP_7b7b7b_COLOR};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 170 * WIDTH_MULTIPLE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10 * WIDTH_MULTIPLE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 10 * WIDTH_MULTIPLE)];
    headerView.backgroundColor = KAPP_TableView_BgColor;
    return headerView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == _tableView){
        
        CGFloat sectionHeaderHeight = 10 * WIDTH_MULTIPLE;
        if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        }
        else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}


#pragma mark - lazyload
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = KAPP_TableView_BgColor;
        _tableView.emptyDataSetSource = self;
        
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



@end

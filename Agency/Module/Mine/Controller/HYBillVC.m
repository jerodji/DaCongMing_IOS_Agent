//
//  HYBillVC.m
//  Agency
//
//  Created by 胡勇 on 2017/11/8.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBillVC.h"
#import "HYBillModel.h"
#import "HYBillTableViewCell.h"

@interface HYBillVC () <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *datalist;

@end

@implementation HYBillVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubviews];
    [self requestBillData];
}

- (void)setupSubviews{
    
    self.title = @"账单";
    self.view.backgroundColor = KAPP_TableView_BgColor;
    [self.view addSubview:self.tableView];
}

- (void)requestBillData{
    
    [self.datalist removeAllObjects];
    [HYUserRequestHandle getBillDataWithPageNo:1 ComplectionBlock:^(NSArray *datalist) {
        
        if (datalist) {
            
            for (NSDictionary *dict in datalist) {
                
                HYBillModel *model = [HYBillModel modelWithDictionary:dict];
                [self.datalist addObject:model];
            }
            [_tableView reloadData];
        }
    }];
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
    
    return self.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *billCellID = @"billCellID";
    HYBillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:billCellID];
    if (!cell) {
        cell = [[HYBillTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:billCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.model = self.datalist[indexPath.row];
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60 * WIDTH_MULTIPLE;
}


#pragma mark - emptyDelegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    
    UIImage *image = [UIImage imageNamed:@"noBillData"];
    return image;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    
    NSString *text = @"暂无任何账单信息";
    NSDictionary *attributes = @{NSFontAttributeName : KFitFont(16),NSForegroundColorAttributeName : KAPP_7b7b7b_COLOR};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}


#pragma mark - lazyload
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
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
}



@end

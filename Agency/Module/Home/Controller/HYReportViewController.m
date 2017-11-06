//
//  HYReportViewController.m
//  Agency
//
//  Created by 胡勇 on 2017/11/3.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYReportViewController.h"
#import "HYReportViewModel.h"

#import "HYReportSelectCell.h"
#import "HYReportAllOrderCell.h"
#import "HYReportAllAmountCell.h"
#import "HYReportSelectCellModel.h"

@interface HYReportViewController () <HYTableViewManagerDelegate>

@property (nonatomic,strong) HYTableViewManager *tableViewManager;
/** tableView */
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) HYReportViewModel *viewModel;
@property (nonatomic,strong) HYReportSelectCellModel *cellModel;

@end

@implementation HYReportViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubviews];
}

- (void)setupSubviews{
    
    self.title = @"报表";
    [self bindViewModel];
}

- (void)bindViewModel{
    
    _viewModel = [HYReportViewModel new];
    _tableViewManager = [[HYTableViewManager alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - KNAV_HEIGHT) andViewModel:_viewModel];
    _tableViewManager.delegate = self;
    _tableView = _tableViewManager.tableView;
    [self.view addSubview:self.tableView];
    
    _cellModel = [HYReportSelectCellModel new];
}

#pragma mark - HYTableViewManagerDelegate
- (NSInteger)HYTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (NSInteger)HYNumberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (CGFloat)HYTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
            return 260 * WIDTH_MULTIPLE;
            break;
        case 1:
            return 55 * WIDTH_MULTIPLE;
            break;
        case 2:case 3:
            return 45 * WIDTH_MULTIPLE;
            break;
        default:
            return 40 * WIDTH_MULTIPLE;
            break;
    }
}

- (UITableViewCell *)HYTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
        {
            static NSString *selectCellID = @"selectCellID";
            HYReportSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:selectCellID];
            if (!cell) {
                cell = [[HYReportSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:selectCellID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell setCellWithViewModel:_cellModel];
            return cell;
        }
            break;
        case 1:
        {
            static NSString *allOrderCellID = @"allOrderCellID";
            HYReportAllOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:allOrderCellID];
            if (!cell) {
                cell = [[HYReportAllOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:allOrderCellID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        }
            break;
        case 2:case 3:
        {
            static NSString *allAmountCellID = @"allAmountCellID";
            HYReportAllAmountCell *cell = [tableView dequeueReusableCellWithIdentifier:allAmountCellID];
            if (!cell) {
                cell = [[HYReportAllAmountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:allAmountCellID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        }
            break;
        default:
            break;
    }
    
    return nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

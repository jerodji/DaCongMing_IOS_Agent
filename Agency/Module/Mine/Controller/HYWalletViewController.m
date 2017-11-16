//
//  HYWalletViewController.m
//  Agency
//
//  Created by 胡勇 on 2017/11/3.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYWalletViewController.h"
#import "HYMyWalletHeaderCell.h"
#import "HYIconTitleCell.h"
#import "HYMyWalletViewModel.h"
#import "HYBillVC.h"
#import "HYDepositVC.h"
#import "HYAuthPhoneVC.h"
#import "HYBaseNavController.h"
#import "HYMyWalletModel.h"
#import "HYBandPhoneVC.h"

@interface HYWalletViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) HYMyWalletViewModel *viewModel;

@property (nonatomic,copy) NSArray *iconArray;
@property (nonatomic,copy) NSArray *titleArray;
@property (nonatomic,copy) NSArray *headerBtnTitleArray;

@end

@implementation HYWalletViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubviews];
    [self bindViewModel];
}

- (void)setupSubviews{
    
    self.title = @"钱包";
    self.edgesForExtendedLayout = UIRectEdgeTop;
    self.view.backgroundColor = KAPP_TableView_BgColor;
    
    _iconArray = @[@"deposit",@"bill",@"setting"];
    _titleArray = @[@"提现",@"账单",@"设置提现密码"];
    _headerBtnTitleArray = @[@"本月销售额(元)\n12306",@"本月佣金收入(元)\n12306",@"今日销售额(元)\n12306"];
    
    [self.view addSubview:self.tableView];
}

- (void)bindViewModel{
    
    __weak typeof (self)weakSelf = self;
    HYMyWalletModel *model = [HYMyWalletModel new];
    _viewModel = [HYMyWalletViewModel new];
    [_viewModel getMyWalletInfo];
    [_viewModel setWithModel:model];
    
    [self.viewModel.backActionSubject subscribeNext:^(id x) {
        
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
            static NSString *myWalletHeaderCellID = @"myWalletHeaderCellID";
            HYMyWalletHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:myWalletHeaderCellID];
            if (!cell) {
                cell = [[HYMyWalletHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myWalletHeaderCellID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            //cell.titleArray = _headerBtnTitleArray;
            [cell setWithViewModel:self.viewModel];
            return cell;
            
        }
            break;
        default:
        {
            static NSString *iconTitleCellID = @"iconTitleCellID";
            HYIconTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:iconTitleCellID];
            if (!cell) {
                cell = [[HYIconTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iconTitleCellID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.titleLabel.text = _titleArray[indexPath.section - 1];
            cell.iconImgView.image = [UIImage imageNamed:_iconArray[indexPath.section - 1]];
            return cell;
            
        }
            break;
    }
    
    return nil;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    switch (indexPath.section) {
        case 1:
        {
            if ([self.viewModel.balance integerValue] <= 0) {
                
                [JRToast showWithText:@"你目前没有余额可以提现"];
                return;
            }
            
            HYDepositVC *depositVC = [HYDepositVC new];
            HYBaseNavController *nav = [[HYBaseNavController alloc] initWithRootViewController:depositVC];
            depositVC.balance = self.viewModel.balance;
            depositVC.isSetaccountPwd = self.viewModel.isSetaccountPwd;
            [self presentViewController:nav animated:YES completion:nil];
        }
            break;
        case 2:
        {
            HYBillVC *billVC = [HYBillVC new];
            HYBaseNavController *nav = [[HYBaseNavController alloc] initWithRootViewController:billVC];
            [self presentViewController:nav animated:YES completion:nil];
        }
            break;
        case 3:
        {
            //如果没绑定手机先绑定手机
            if ([[HYUserModel sharedInstance].userInfo.phone isNotBlank]) {
                
                HYAuthPhoneVC *authPhoneVC = [HYAuthPhoneVC new];
                HYBaseNavController *nav = [[HYBaseNavController alloc] initWithRootViewController:authPhoneVC];
                [self presentViewController:nav animated:YES completion:nil];
            }
            else{
                
                HYBandPhoneVC *bindVC = [HYBandPhoneVC new];
                HYBaseNavController *nav = [[HYBaseNavController alloc] initWithRootViewController:bindVC];
                [self presentViewController:nav animated:YES completion:nil];
            }
            
        }
            break;
        default:
            
            break;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
            
            return 280 * WIDTH_MULTIPLE;
            break;
            
        default:
            return 50 * WIDTH_MULTIPLE;
            break;
    }
    
    return 50 * WIDTH_MULTIPLE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 10 * WIDTH_MULTIPLE)];
    view.backgroundColor = KCOLOR(@"f4f4f4");
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 3) {
        
        return 10 * WIDTH_MULTIPLE;
    }
    return 0;
}


#pragma mark -lazyload
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, KSCREEN_WIDTH, KSCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = KAPP_TableView_BgColor;
        _tableView.bounces = NO;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

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
#import "HYBandPhoneVC.h"
#import "HYBankCardCellModel.h"
#import "HYWalletViewController.h"
#import "HYSetDispoitPwdVC.h"

@interface HYBankCardViewController () <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource>
{
    HYCustomAlert *alert;
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *datalist;
@property (nonatomic,strong) HYUploadIDCardViewController *uploadVC;
@property (nonatomic,copy) NSString * DrawCashPwd;
@end

@implementation HYBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"银行卡";
    
    self.datalist = [NSMutableArray array];
    
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *addBankCard = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add_bank"] style:UIBarButtonItemStylePlain target:self action:@selector(addBankCardAction)];
    self.navigationItem.rightBarButtonItem = addBankCard;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestBankInfo];
}

/* 获取绑定的银行卡列表 */
- (void)requestBankInfo
{
    [HYUserRequestHandle getBankCardListComplectionBlock:^(NSArray *datalist) {
        NSMutableArray* arr = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in datalist) {
            HYBankCardModel *model = [HYBankCardModel modelWithDictionary:dict];
            HYBankCardCellModel *cellModel = [[HYBankCardCellModel alloc] initWithModel:model];
            [arr addObject:cellModel];
        }
        self.datalist = arr;
        [self.tableView reloadData];
    }];
}

- (void)viewDidLayoutSubviews{
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - action
- (void)addBankCardAction{
    
    if (![[HYUserModel sharedInstance].userInfo.phone isNotBlank]) {
        
        HYBandPhoneVC *bindPhone = [HYBandPhoneVC new];
        [self.navigationController pushViewController:bindPhone animated:YES];
        
        [JRToast showWithText:@"请先绑定手机后在添加银行卡"];
        return;
    }
    
    _uploadVC = [[HYUploadIDCardViewController alloc] init];
    _uploadVC.title = @"添加银行卡";
    _uploadVC.isBindBankCard = YES;
    [self.navigationController pushViewController:_uploadVC animated:YES];
}

- (void)backBtnAction {
    if (_uploadVC.UploadSucc) {
        delog(@"111111")
        [super backBtnAction];
    } else {
        delog(@"000000");
        [super backBtnAction];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadCardFail" object:nil];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    if (_uploadVC.UploadSucc) {
        
    } else {
        
    }
}


#pragma mark- ==================== 解除绑定 ====================

- (void)relieveBindWith:(HYBankCardModel*)cardModel atSection:(NSInteger)section{
    if (alert) {
        [HYCustomAlert removeAlert:alert];
    }
    
    alert = [[HYCustomAlert alloc] initWithFrame:KEYWINDOW.frame WithTitle:@"温馨提示" content:@"确认要解除绑定吗？" confirmBlock:^{
        [self showCashPwdWith:cardModel atSection:section];
    }];
    [KEYWINDOW addSubview:alert];
}

/* 输入提现密码 */
- (void)showCashPwdWith:(HYBankCardModel*)cardModel atSection:(NSInteger)section {
    
    HYSetDispoitPwdVC *setPWdVC = [HYSetDispoitPwdVC new];
//    setPWdVC.authCode = viewModel.authCode;
    setPWdVC.removeBankCard = YES;
    [self.navigationController pushViewController:setPWdVC animated:YES];
    
    __weak typeof(self) wkself = self;
    setPWdVC.PWDCB = ^(NSString *crashPWD) {
        //确定回调
        wkself.DrawCashPwd = crashPWD;
        [wkself removeBankCard:cardModel atSection:section];
    };
}

/* 解绑 */
- (void)removeBankCard:(HYBankCardModel*)cardModel atSection:(NSInteger)section
{
    NSDictionary* params =
    @{@"token":[HYUserModel sharedInstance].token,
      @"bankCard_id" : (cardModel.bankcard_id ? cardModel.bankcard_id : @" "),
      @"withDrawCashPwd":(_DrawCashPwd ? _DrawCashPwd : @" ")
      };
    delog(@"解除银行卡绑定 params==%@",params);

    [[HTTPManager shareHTTPManager] postDataFromUrl:API_bankCardUnbund withParameter:params isShowHUD:YES success:^(id returnData) {
        if (returnData) {
            if (IsNull(returnData[@"code"])) {
                [JRToast showWithText:@"数据错误"];
                return ;
            }
            if ([returnData[@"code"] integerValue] == 000) {
                if (section < self.datalist.count) {
                    [self.datalist removeObjectAtIndex:section];
                }
                [self.tableView reloadData];
            }
            if (NotNull(returnData[@"message"])) {
                [JRToast showWithText:returnData[@"message"]];
            }
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYBankCardCellModel *bankCardVM = self.datalist[indexPath.section];
    __weak typeof(self) wkself = self;
    
    static NSString *bankCellID = @"bankCellID";
    HYBankInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:bankCellID];
    if (!cell) {
        cell = [[HYBankInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:bankCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.targetVC = self;
        cell.clickRemoveCardCB = ^{ /* 解除绑定按钮的回调 */
            [wkself relieveBindWith:bankCardVM.model atSection:indexPath.section];
        };
    }

    [cell setupWithCellModel:bankCardVM];
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
    
    if (self.isSelectBankCard) {
        
        if (self.selectCardBlock) {
            
            HYBankCardCellModel *cellModel = self.datalist[indexPath.section];
            self.selectCardBlock(cellModel.model);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

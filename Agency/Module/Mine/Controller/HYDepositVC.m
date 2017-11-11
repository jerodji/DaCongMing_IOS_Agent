//
//  HYDepositVC.m
//  Agency
//
//  Created by 胡勇 on 2017/11/8.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYDepositVC.h"
#import "HYDispoitHeaderView.h"
#import "HYDispoitView.h"
#import "HYSetDepositTipsView.h"
#import "HYAuthPhoneVC.h"
#import "HYDepositViewModel.h"
#import "HYInputDepositPwdView.h"
#import "HYAuthPhoneVC.h"
#import "HYDepositWaitViewController.h"

@interface HYDepositVC ()

@property (nonatomic,strong) HYDispoitHeaderView *headerView;
@property (nonatomic,strong) HYDispoitView *dispoitView;
/** 提示设置提现密码 */
@property (nonatomic,strong) HYSetDepositTipsView *tipsView;
/** 输入密码 */
@property (nonatomic,strong) HYInputDepositPwdView *inputPwdView;

@property (nonatomic,strong) HYDepositViewModel *viewModel;

@end

@implementation HYDepositVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupSubviews];
    [self bindViewModel];
    //[self showTipsView];
    
}

- (void)setupSubviews{

    self.title = @"提现";
    self.view.backgroundColor = KAPP_TableView_BgColor;
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.dispoitView];
}

- (void)bindViewModel{
    
    HYDepositViewModel *viewModel = [HYDepositViewModel new];
    viewModel.balance = self.balance;
    [self.dispoitView setWithViewModel:viewModel];
    self.viewModel = viewModel;
    [viewModel.depositSubject subscribeNext:^(id x) {
       
        DLog(@"%@",x);
        [self showInputPwdView];
    }];
    
    [viewModel.depositSuccessSubject subscribeNext:^(id x) {
       
        [self.inputPwdView hideInputPwdView];
        HYDepositWaitViewController *depositWaitVC = [HYDepositWaitViewController new];
        depositWaitVC.amount = viewModel.inputBalance;
        [self.navigationController pushViewController:depositWaitVC animated:YES];
    }];
}

- (void)showInputPwdView{
    
    HYInputDepositPwdView *inputPwdView = [[HYInputDepositPwdView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT) WithAmount:self.viewModel.inputBalance];
    self.inputPwdView = inputPwdView;
    [KEYWINDOW addSubview:inputPwdView];
    [inputPwdView setWithViewModel:self.viewModel];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [inputPwdView showInputPasswordView];
    });
    inputPwdView.forgetPwdAction = ^{
       
        HYAuthPhoneVC *authPhoneVC = [HYAuthPhoneVC new];
        [self.navigationController pushViewController:authPhoneVC animated:YES];
    };
}

- (void)showTipsView{
    
    [self.view addSubview:self.tipsView];
    [self.tipsView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self.view);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.tipsView showTipsView];
    });
    
    __weak typeof (self)weakSelf = self;
    self.tipsView.jumpToSettingVCBlock = ^{
       
        HYAuthPhoneVC *authPhoneVC = [HYAuthPhoneVC new];
        [weakSelf.navigationController pushViewController:authPhoneVC animated:YES];
    };
}

- (void)viewDidLayoutSubviews{
    
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(10 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(60 * WIDTH_MULTIPLE);
    }];
    
    [_dispoitView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(_headerView.mas_bottom).offset(10 * WIDTH_MULTIPLE);
    }];
}


#pragma mark - lazyload
- (HYDispoitHeaderView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [HYDispoitHeaderView new];
    }
    return _headerView;
}

- (HYDispoitView *)dispoitView{
    
    if (!_dispoitView) {
        
        _dispoitView = [HYDispoitView new];
    }
    return _dispoitView;
}

- (HYSetDepositTipsView *)tipsView{
    
    if (!_tipsView) {
        
        _tipsView = [HYSetDepositTipsView new];
    }
    return _tipsView;
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

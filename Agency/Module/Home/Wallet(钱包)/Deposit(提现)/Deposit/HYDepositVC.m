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
#import "HYBankCardViewController.h"
#import "HYUploadIDCardViewController.h"

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

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"uploadCardFail" object:nil];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self GetBankCardList];
    [self setupSubviews];
    [self bindViewModel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadCardFailAction) name:@"uploadCardFail" object:nil];
    
    //设置提现密码
    if (!self.isSetaccountPwd) {
        
//        [self showTipsView];
    }
    
}

- (void)uploadCardFailAction {
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)GetBankCardList {
    [HYUserRequestHandle getBankCardListComplectionBlock:^(NSArray *datalist) {
        //没有绑定的银行卡
        if (IsNull(datalist)) {
            [self.navigationController pushViewController:[HYBankCardViewController new] animated:YES];
            [JRToast showWithText:@"请您先绑定银行卡"];
        }
    }];
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
    
    RAC(self.viewModel,depositBankID) = RACObserve(self.headerView.backCardModel, id);
    [viewModel.depositSubject subscribeNext:^(id x) {
       
        NSLog(@"%@",x);
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
        //[self.navigationController pushViewController:[HYBankCardViewController new] animated:YES];
        HYUploadIDCardViewController* vc =[HYUploadIDCardViewController new];
        vc.isBindBankCard = YES;
        [self.navigationController pushViewController:vc animated:YES];
        [JRToast showWithText:@"请绑定新的银行卡以重置提现密码!" duration:6];
//        //验证码
//        HYAuthPhoneVC *authPhoneVC = [HYAuthPhoneVC new];
//        [self.navigationController pushViewController:authPhoneVC animated:YES];
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
        _headerView.userInteractionEnabled = YES;
        _headerView.backCardModel = self.defaultBankCardModel;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            
            HYBankCardViewController *bankCardVC = [HYBankCardViewController new];
            bankCardVC.isSelectBankCard = YES;
            bankCardVC.selectCardBlock = ^(HYBankCardModel *bankCardModel) {
              
                NSLog(@"选择的银行卡是:%@",bankCardModel.bankcard_id);
                self.headerView.backCardModel = bankCardModel;
            };
            [self.navigationController pushViewController:bankCardVC animated:YES];
        }];
        [_headerView addGestureRecognizer:tap];
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

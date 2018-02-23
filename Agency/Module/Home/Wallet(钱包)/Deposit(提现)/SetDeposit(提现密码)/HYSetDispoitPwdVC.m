//
//  HYSetDispoitPwdVC.m
//  Agency
//
//  Created by 胡勇 on 2017/11/8.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYSetDispoitPwdVC.h"
#import "HYSetDespoitView.h"
#import "HYSetDepositViewModel.h"

@interface HYSetDispoitPwdVC ()

/** 设置提现密码 */
@property (nonatomic,strong) HYSetDespoitView *setDespoitView;
@property (nonatomic,strong) HYSetDepositViewModel * setDespositVM;
@end

@implementation HYSetDispoitPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
    [self bindViewModel];
}

- (void)setupSubviews{
    self.title = @"提现密码";
    self.view.backgroundColor = KAPP_TableView_BgColor;
    [self.view addSubview:self.setDespoitView];
}

- (void)bindViewModel{
    
    _setDespositVM = [HYSetDepositViewModel new];
    _setDespositVM.authCode = self.authCode;
    _setDespositVM.removeBankCard = self.removeBankCard;
    
    [self.setDespoitView setWithViewModel:_setDespositVM];
    
    [_setDespositVM.setPwdSuccessSubject subscribeCompleted:^{
       
//        NSArray *pushVCAry = [self.navigationController viewControllers];
//        UIViewController *popVC = [pushVCAry objectAtIndex:0];
//        [self.navigationController popToViewController:popVC animated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    __weak typeof(self) wkself = self;
    self.setDespoitView.infoCB = ^(NSString *crashPwd) {
        //确定回调
        [wkself.navigationController popViewControllerAnimated:YES];
        !wkself.PWDCB ? : wkself.PWDCB(crashPwd);
    };
}

- (void)viewDidLayoutSubviews{
    
    [_setDespoitView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - lazyload
- (HYSetDespoitView *)setDespoitView{
    
    if (!_setDespoitView) {
        
        _setDespoitView = [HYSetDespoitView new];
    }
    return _setDespoitView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

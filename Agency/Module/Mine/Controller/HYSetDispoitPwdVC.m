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
    
    HYSetDepositViewModel *viewModel = [HYSetDepositViewModel new];
    viewModel.authCode = self.authCode;
    [self.setDespoitView setWithViewModel:viewModel];
    
    [viewModel.setPwdSuccessSubject subscribeCompleted:^{
       
//        NSArray *pushVCAry = [self.navigationController viewControllers];
//        UIViewController *popVC = [pushVCAry objectAtIndex:0];
//        [self.navigationController popToViewController:popVC animated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
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
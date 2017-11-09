//
//  HYAuthPhoneVC.m
//  Agency
//
//  Created by 胡勇 on 2017/11/8.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYAuthPhoneVC.h"
#import "HYAuthPhoneView.h"
#import "HYBindPhoneViewModel.h"
#import "HYSetDispoitPwdVC.h"

@interface HYAuthPhoneVC ()

@property (nonatomic,strong) HYAuthPhoneView *authPhoneView;

@end

@implementation HYAuthPhoneVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubviews];
    [self bindViewModel];
}

- (void)setupSubviews{
    
    self.title = @"验证手机";
    self.view.backgroundColor = KAPP_TableView_BgColor;
    [self.view addSubview:self.authPhoneView];
}

- (void)bindViewModel{
    
    HYBindPhoneViewModel *viewModel = [HYBindPhoneViewModel new];
    [self.authPhoneView setWithViewModel:viewModel];
    
    [viewModel.AuthSuccessSubject subscribeCompleted:^{
       
        HYSetDispoitPwdVC *setPWdVC = [HYSetDispoitPwdVC new];
        [self.navigationController pushViewController:setPWdVC animated:YES];
    }];
}

- (void)viewDidLayoutSubviews{
    
    [_authPhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - lazyload
- (HYAuthPhoneView *)authPhoneView{
    
    if (!_authPhoneView) {
        
        _authPhoneView = [HYAuthPhoneView new];
    }
    return _authPhoneView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

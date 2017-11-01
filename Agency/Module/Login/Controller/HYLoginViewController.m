//
//  HYLoginViewController.m
//  Agency
//
//  Created by 胡勇 on 2017/11/1.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYLoginViewController.h"
#import "HYLoginView.h"
#import "HYLoginViewModel.h"

@interface HYLoginViewController ()

@property (nonatomic,strong) HYLoginView *loginView;


@end

@implementation HYLoginViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
  
    [self.view addSubview:self.loginView];
    [self bindViewModel];
}

- (void)bindViewModel{
    
    HYLoginViewModel *viewModel = [HYLoginViewModel new];
    [_loginView setWithViewModel:viewModel];
    
    [viewModel.loginSuccessSubject subscribeNext:^(id x) {
        
    }];
    
    [viewModel.loginErrorSubject subscribeNext:^(id x) {
        
    }];
}

- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
    [_loginView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.bottom.right.equalTo(self.view);
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

#pragma mark - lazyload
- (HYLoginView *)loginView{
    
    if (!_loginView) {
        
        _loginView = [HYLoginView new];
    }
    return _loginView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end

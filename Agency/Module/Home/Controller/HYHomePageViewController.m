//
//  HYHomePageViewController.m
//  Agency
//
//  Created by 胡勇 on 2017/11/2.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYHomePageViewController.h"
#import "HYHomeView.h"
#import "HYNoAccessView.h"
#import "HYHomeViewModel.h"

#import "HYReportViewController.h"
#import "HYBankCardViewController.h"
#import "HYAuthViewController.h"
#import "HYWalletViewController.h"
#import "HYAboutUSViewController.h"
#import "HYMineViewController.h"
#import "HYBaseNavController.h"
#import "HYJoinProtocolVC.h"


@interface HYHomePageViewController ()

@property (nonatomic,strong) HYHomeView *homeView;

@end

@implementation HYHomePageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubviews];
    [self bindViewModel];
}

- (void)setupSubviews{
    
    [self.view addSubview:self.homeView];
    [self setStatusBarBackgroundColor:KAPP_BLACK_COLOR];
}

- (void)bindViewModel{
    
    HYHomeViewModel *viewModel = [HYHomeViewModel new];
    [_homeView setWithViewModel:viewModel];
    [viewModel setWithUserModel:[HYUserModel sharedInstance]];
    
    [viewModel.jumpToReportVC subscribeNext:^(id x) {
       
        HYReportViewController *reportVC = [HYReportViewController new];
        HYBaseNavController *nav = [[HYBaseNavController alloc] initWithRootViewController:reportVC];
        [self presentViewController:nav animated:YES completion:nil];
    }];
    
    [viewModel.jumpToBankCardVC subscribeNext:^(id x) {
       
        HYBankCardViewController *bankVC = [HYBankCardViewController new];
        HYBaseNavController *nav = [[HYBaseNavController alloc] initWithRootViewController:bankVC];
        [self presentViewController:nav animated:YES completion:nil];
    }];
    
    [viewModel.jumpToAuthVC subscribeNext:^(id x) {
       
        HYAuthViewController *authVC = [HYAuthViewController new];
        HYBaseNavController *nav = [[HYBaseNavController alloc] initWithRootViewController:authVC];
        [self presentViewController:nav animated:YES completion:nil];
    }];
    
    NSArray *vcArray = @[@"HYWalletViewController",@"HYMineViewController",@"HYAboutUSViewController",@"HYAboutUSViewController"];
    [viewModel.buttonSubject subscribeNext:^(id x) {
       
        if ([x isKindOfClass:[NSNumber class]]) {
            
            NSInteger i = [x integerValue];
            HYBaseNavController *nav = [[HYBaseNavController alloc] initWithRootViewController:[NSClassFromString(vcArray[i]) new]];
            [self presentViewController:nav animated:YES completion:nil];
        }
        
    }];
    
}

- (void)viewDidLayoutSubviews{
    
    [_homeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.bottom.right.equalTo(self.view);
    }];
}



#pragma mark - lazyload
- (HYHomeView *)homeView{
    
    if (!_homeView) {
        
        _homeView = [HYHomeView new];
    }
    return _homeView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

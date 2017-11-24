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
#import "HYUploadIDCardViewController.h"
#import "HYBandPhoneVC.h"
#import "HYMyTeamViewController.h"
#import "HYInfomationVC.h"

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
    
    [viewModel.jumpToMyTeam subscribeNext:^(id x) {
        
        HYMyTeamViewController *myTeamVC = [HYMyTeamViewController new];
        HYBaseNavController *nav = [[HYBaseNavController alloc] initWithRootViewController:myTeamVC];
        [self presentViewController:nav animated:YES completion:nil];
    }];
    
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
       
//        HYAuthViewController *authVC = [HYAuthViewController new];
//        HYBaseNavController *nav = [[HYBaseNavController alloc] initWithRootViewController:authVC];
//        [self presentViewController:nav animated:YES completion:nil];
        if (![[HYUserModel sharedInstance].userInfo.phone isNotBlank]) {
            
            HYBandPhoneVC *bindVC = [HYBandPhoneVC new];
            HYBaseNavController *nav = [[HYBaseNavController alloc] initWithRootViewController:bindVC];
            [self presentViewController:nav animated:YES completion:nil];
            [JRToast showWithText:@"请先绑定手机"];
            return;
        }
        
        HYUploadIDCardViewController *authVC = [HYUploadIDCardViewController new];
        HYBaseNavController *nav = [[HYBaseNavController alloc] initWithRootViewController:authVC];
        authVC.title = @"认证";
        authVC.isBindBankCard = NO;
        [self presentViewController:nav animated:YES completion:nil];

    }];
    
    
    NSArray *vcArray = @[@"HYWalletViewController",@"HYMineViewController",@"HYAboutUSViewController",@"HYInfomationVC"];
    [viewModel.buttonSubject subscribeNext:^(id x) {
       
        if ([x isKindOfClass:[NSNumber class]]) {
            
            NSInteger i = [x integerValue];
            if (i == 0) {
                
                [self presentViewController:[NSClassFromString(vcArray[i]) new] animated:YES completion:nil];
                return ;
            }
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

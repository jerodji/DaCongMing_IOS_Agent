//
//  HYSetLoginPwdViewController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/20.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYSetLoginPwdViewController.h"
#import "HYSendAuthCodeView.h"
#import "HYSetPwdViewController.h"

@interface HYSetLoginPwdViewController ()

/** 发验证码 */
@property (nonatomic,strong) HYSendAuthCodeView *sendAuthView;

@end

@implementation HYSetLoginPwdViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubviews];
}

- (void)setupSubviews{
    
    self.title = @"请先验证手机号";
    self.view.backgroundColor = KAPP_TableView_BgColor;
    self.phone = [HYUserModel sharedInstance].userInfo.phone;
    [self.view addSubview:self.sendAuthView];
    self.sendAuthView.phone = self.phone;
    
    __weak typeof (self)weakSelf = self;
    self.sendAuthView.authSuccessBlock = ^(NSString *authCode) {
       
        HYSetPwdViewController *setPwdVC = [HYSetPwdViewController new];
        setPwdVC.phone = weakSelf.phone;
        setPwdVC.authCode = authCode;
        [weakSelf.navigationController pushViewController:setPwdVC animated:YES];
    };
}

- (void)viewDidLayoutSubviews{
    
    [_sendAuthView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.equalTo(self.view).offset(10 * WIDTH_MULTIPLE);
        make.right.equalTo(self.view).offset(-10 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(280 * WIDTH_MULTIPLE);
    }];
}

#pragma mark - lazyload
- (HYSendAuthCodeView *)sendAuthView{
    
    if (!_sendAuthView) {
        
        _sendAuthView = [[HYSendAuthCodeView alloc] initWithFrame:CGRectZero];
        
    }
    return _sendAuthView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  HYBandPhoneVC.m
//  Agency
//
//  Created by 胡勇 on 2017/11/7.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBandPhoneVC.h"
#import "HYBindPhoneView.h"
#import "HYBindPhoneViewModel.h"

@interface HYBandPhoneVC ()

@property (nonatomic,strong) HYBindPhoneView *bindView;

@end

@implementation HYBandPhoneVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubviews];
}

- (void)setupSubviews{
    
    self.title = @"绑定手机";
    [self.view addSubview:self.bindView];
    [self bindViewModel];
}

- (void)viewDidLayoutSubviews{
    
    [_bindView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(10 * WIDTH_MULTIPLE);
    }];
}

- (void)bindViewModel{
    
    HYBindPhoneViewModel *viewModel = [HYBindPhoneViewModel new];
    [_bindView setWithViewModel:viewModel];
    
    [viewModel.AuthSuccessSubject subscribeCompleted:^{
       
        if (self.navigationController.viewControllers.count > 1) {
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
        [JRToast showWithText:@"绑定手机成功" duration:2];
        [HYUserModel sharedInstance].userInfo.phone = viewModel.phone;
    }];
}

#pragma mark - lazyload
- (HYBindPhoneView *)bindView{
    
    if (!_bindView) {
        
        _bindView = [HYBindPhoneView new];
    }
    return _bindView;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}



@end

//
//  HYDepositWaitViewController.m
//  Agency
//
//  Created by 胡勇 on 2017/11/11.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYDepositWaitViewController.h"
#import "HYDepositWaitView.h"

@interface HYDepositWaitViewController ()

@property (nonatomic,strong) HYDepositWaitView *depositWaitView;

@end

@implementation HYDepositWaitViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubviews];
}


- (void)setupSubviews{
    
    self.title = @"提现申请中";
    self.view.backgroundColor = KAPP_TableView_BgColor;
    [self.view addSubview:self.depositWaitView];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)viewDidLayoutSubviews{
    
    [_depositWaitView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(10 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(130 * WIDTH_MULTIPLE);
    }];
}

- (void)rightItemAction{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - lazyload
- (HYDepositWaitView *)depositWaitView{
    
    if (!_depositWaitView) {
        
        _depositWaitView = [[HYDepositWaitView alloc] initWithFrame:CGRectZero withAmount:self.amount];
    }
    return _depositWaitView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

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

@interface HYDepositVC ()

@property (nonatomic,strong) HYDispoitHeaderView *headerView;
@property (nonatomic,strong) HYDispoitView *dispoitView;


@end

@implementation HYDepositVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupSubviews];
}

- (void)setupSubviews{

    self.title = @"提现";
    self.view.backgroundColor = KAPP_TableView_BgColor;
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.dispoitView];
}


#pragma mark - lazyload
- (HYDispoitHeaderView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [HYDispoitHeaderView new];
    }
    return _headerView;
}

- (HYDispoitView *)dispoitView{
    
    if (!_dispoitView) {
        
        _dispoitView = [HYDispoitView new];
    }
    return _dispoitView;
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

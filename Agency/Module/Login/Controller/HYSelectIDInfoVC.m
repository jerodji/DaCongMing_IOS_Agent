//
//  HYSelectIDInfoVC.m
//  Agency
//
//  Created by 胡勇 on 2017/11/7.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYSelectIDInfoVC.h"
#import "HYSelectInfoHeaderView.h"
#import "HYSelectInfoBtnView.h"

@interface HYSelectIDInfoVC ()

@property (nonatomic,strong) HYSelectInfoHeaderView *headerView;
@property (nonatomic,strong) HYSelectInfoBtnView *buttonView;

@end

@implementation HYSelectIDInfoVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubviews];
}

- (void)setupSubviews{
    
    self.view.backgroundColor = KAPP_WHITE_COLOR;
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.buttonView];
    
}

- (void)viewDidLayoutSubviews{
    
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(220 * WIDTH_MULTIPLE);
    }];
    
    [_buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.view);
        make.top.equalTo(_headerView.mas_bottom);
        make.bottom.equalTo(self.view).offset(-110 * WIDTH_MULTIPLE);
    }];
}

#pragma mark - override
- (void)showNoAccessView{
    
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleDefault;
}

#pragma mark - lazyload
- (HYSelectInfoHeaderView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [HYSelectInfoHeaderView new];
    }
    return _headerView;
}

- (HYSelectInfoBtnView *)buttonView{
    
    if (!_buttonView) {
        
        _buttonView = [HYSelectInfoBtnView new];
    }
    return _buttonView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

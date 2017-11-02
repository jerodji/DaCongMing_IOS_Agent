//
//  HYHomePageViewController.m
//  Agency
//
//  Created by 胡勇 on 2017/11/2.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYHomePageViewController.h"
#import "HYHomeView.h"

@interface HYHomePageViewController ()

@property (nonatomic,strong) HYHomeView *homeView;

@end

@implementation HYHomePageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubviews];
}

- (void)setupSubviews{
    
    [self.view addSubview:self.homeView];
    [self setStatusBarBackgroundColor:KAPP_BLACK_COLOR];
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

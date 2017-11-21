//
//  HYRecommendSuccessVC.m
//  Agency
//
//  Created by Jack on 2017/11/21.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYRecommendSuccessVC.h"

@interface HYRecommendSuccessVC ()

@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel *tipsLabel;

@end

@implementation HYRecommendSuccessVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubviews];
}

- (void)setupSubviews{
    
    self.title = @"推荐成功";
    self.view.backgroundColor = KAPP_TableView_BgColor;
    [self.view addSubview:self.iconImageView];
    [self.view addSubview:self.tipsLabel];
}

- (void)backBtnAction{
    
    NSArray *array = self.navigationController.viewControllers;
    [self.navigationController popToViewController:array[array.count - 3] animated:YES];
}

- (void)viewDidLayoutSubviews{
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(80 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(100 * WIDTH_MULTIPLE);
    }];
    
    [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.view);
        make.top.equalTo(_iconImageView.mas_bottom).offset(28 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(30 * WIDTH_MULTIPLE);
    }];
}

#pragma mark - lazyload
- (UIImageView *)iconImageView{
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"recommendSuccess"]];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconImageView;
}

- (UILabel *)tipsLabel{
    
    if (!_tipsLabel) {
        
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.font = KFitFont(14);
        _tipsLabel.textColor = KAPP_b7b7b7_COLOR;
        _tipsLabel.text = @"推荐成功";
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipsLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

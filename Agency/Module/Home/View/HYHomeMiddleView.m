//
//  HYHomeMiddleView.m
//  Agency
//
//  Created by 胡勇 on 2017/11/2.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYHomeMiddleView.h"

@interface HYHomeMiddleView()


@end

@implementation HYHomeMiddleView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.reportBtn];
    [self addSubview:self.bankCardBtn];
    [self addSubview:self.authBtn];
}

- (void)layoutSubviews{
    
    CGFloat itemWidth = (KSCREEN_WIDTH - 30 * WIDTH_MULTIPLE) / 3;
    [_reportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self);
        make.top.equalTo(self).offset(15 * WIDTH_MULTIPLE);
        make.bottom.equalTo(self).offset(-15 * WIDTH_MULTIPLE);
        make.width.mas_equalTo(itemWidth);
    }];
    
    [_bankCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_reportBtn.mas_right);
        make.top.bottom.equalTo(_reportBtn);
        make.width.mas_equalTo(itemWidth);
    }];
    
    [_authBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_bankCardBtn.mas_right);
        make.top.bottom.equalTo(_reportBtn);
        make.width.mas_equalTo(itemWidth);
    }];
}

#pragma mark - lazyload
- (HYButton *)reportBtn{
    
    if (!_reportBtn) {
        
        _reportBtn = [HYButton buttonWithType:UIButtonTypeCustom];
        [_reportBtn setImage:[UIImage imageNamed:@"report"] forState:UIControlStateNormal];
        [_reportBtn setTitle:@"销售报表" forState:UIControlStateNormal];
    }
    return _reportBtn;
}

- (HYButton *)bankCardBtn{
    
    if (!_bankCardBtn) {
        
        _bankCardBtn = [HYButton buttonWithType:UIButtonTypeCustom];
        [_bankCardBtn setImage:[UIImage imageNamed:@"bank_card"] forState:UIControlStateNormal];
        [_bankCardBtn setTitle:@"银行卡" forState:UIControlStateNormal];
    }
    return _bankCardBtn;
}

- (HYButton *)authBtn{
    
    if (!_authBtn) {
        
        _authBtn = [HYButton buttonWithType:UIButtonTypeCustom];
        [_authBtn setImage:[UIImage imageNamed:@"auth"] forState:UIControlStateNormal];
        [_authBtn setTitle:@"认证" forState:UIControlStateNormal];
    }
    return _authBtn;
}

@end

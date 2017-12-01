//
//  HYRecommendBottomView.m
//  Agency
//
//  Created by Jack on 2017/11/20.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYRecommendBottomView.h"
#import "UILabel+HYJustifyAlign.h"

@interface HYRecommendBottomView ()

@property (nonatomic,strong) UILabel *bankCardNoLabel;
@property (nonatomic,strong) UILabel *tipsLabel;

@end

@implementation HYRecommendBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = KAPP_WHITE_COLOR;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.bankCardNoLabel];
    [self addSubview:self.tipsLabel];
    [self addSubview:self.confirmBtn];
}

- (void)layoutSubviews{
    
    [_bankCardNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(30 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-30 * WIDTH_MULTIPLE);
        make.top.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(30 * WIDTH_MULTIPLE);
    }];
    
    [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self);
        make.top.equalTo(_bankCardNoLabel.mas_bottom).offset(10 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(36 * WIDTH_MULTIPLE);
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(30 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-30 * WIDTH_MULTIPLE);
        make.bottom.equalTo(self).offset(-20 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(50 * WIDTH_MULTIPLE);
    }];
}

#pragma mark - lazyload
- (UILabel *)bankCardNoLabel{
    
    if (!_bankCardNoLabel) {
        
        _bankCardNoLabel = [[UILabel alloc] init];
        _bankCardNoLabel.font = KFitFont(23);
        _bankCardNoLabel.textColor = KAPP_THEME_COLOR;
        _bankCardNoLabel.text = KBankCardNum;
        _bankCardNoLabel.textAlignment = NSTextAlignmentLeft;
        [_bankCardNoLabel LabelAlightLeftAndRightWithWidth:KSCREEN_WIDTH - 60 * WIDTH_MULTIPLE];
    }
    return _bankCardNoLabel;
}

- (UILabel *)tipsLabel{
    
    if (!_tipsLabel) {
        
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.font = KFitFont(14);
        _tipsLabel.textColor = KAPP_THEME_COLOR;
        _tipsLabel.text = KBankName;
        _tipsLabel.numberOfLines = 0;
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipsLabel;
}

- (UIButton *)confirmBtn{
    
    if (!_confirmBtn) {
        
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.backgroundColor = KAPP_THEME_COLOR;
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = KFitFont(18);
        [_confirmBtn setTitleColor:KAPP_WHITE_COLOR forState:UIControlStateNormal];
        _confirmBtn.layer.cornerRadius = 25 * WIDTH_MULTIPLE;
        _confirmBtn.layer.masksToBounds = YES;
    }
    return _confirmBtn;
}

@end

//
//  HYSetDespoitView.m
//  Agency
//
//  Created by 胡勇 on 2017/11/9.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYSetDespoitView.h"
#import "HYPasswordView.h"

@interface HYSetDespoitView() <HYPasswordViewDelegate>

/** 标题 */
@property (nonatomic,strong) UILabel *titleLabel;
/** 获取验证码 */
@property (nonatomic,strong) UIButton *confirmBtn;
/** autoCodeView */
@property (nonatomic,strong) HYPasswordView *authCodeView;

@property (nonatomic,strong) HYSetDepositViewModel *viewModel;

@end

@implementation HYSetDespoitView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = KAPP_WHITE_COLOR;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.authCodeView];
    [self addSubview:self.confirmBtn];
}

- (void)layoutSubviews{
    
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(50 * WIDTH_MULTIPLE);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(30 * WIDTH_MULTIPLE);
    }];
    
    [_authCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_titleLabel.mas_bottom).offset(30 * WIDTH_MULTIPLE);
        make.left.equalTo(self).offset(30 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-30 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(40 * WIDTH_MULTIPLE);
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_authCodeView.mas_bottom).offset(40 * WIDTH_MULTIPLE);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(180 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(50 * WIDTH_MULTIPLE);
    }];
}

#pragma mark - ViewModel
- (void)setWithViewModel:(HYSetDepositViewModel *)viewModel{
    
    self.viewModel = viewModel;
    RAC(self.confirmBtn,enabled) = [viewModel confirmButtonIsValid];
    RAC(self.confirmBtn,backgroundColor) = [[viewModel confirmButtonIsValid] map:^id(id value) {
        
        return [value boolValue] ? KAPP_THEME_COLOR : KAPP_b7b7b7_COLOR;
    }];
    
    [[self.confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [viewModel setDepositPasswordAction];
    }];
}

#pragma mark - 输入验证码delegate
- (void)passwordCompleteInput:(HYPasswordView *)passwordView{
    
    NSString *authCode = passwordView.passwordString;
    DLog(@"%@",authCode);
    self.viewModel.depositPwd = authCode;
    [self.viewModel setDepositPasswordAction];
}


#pragma mark - lazyload
- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = KFitFont(16);
        _titleLabel.textColor = KAPP_272727_COLOR;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"请设置提现密码";
    }
    return _titleLabel;
}

- (UIButton *)confirmBtn{
    
    if (!_confirmBtn) {
        
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = KFitFont(16);
        _confirmBtn.backgroundColor = KAPP_THEME_COLOR;
        _confirmBtn.layer.cornerRadius = 25 * WIDTH_MULTIPLE;
        _confirmBtn.layer.masksToBounds = YES;
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
    return _confirmBtn;
}

- (HYPasswordView *)authCodeView{
    
    if (!_authCodeView) {
        
        _authCodeView = [[HYPasswordView alloc] init];
        _authCodeView.isSetPassword = YES;
        _authCodeView.delegate = self;
    }
    return _authCodeView;
}

@end

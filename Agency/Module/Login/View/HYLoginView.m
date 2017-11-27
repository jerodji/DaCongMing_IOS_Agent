//
//  HYLoginView.m
//  Agency
//
//  Created by 胡勇 on 2017/11/1.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYLoginView.h"

@interface HYLoginView()

/** 背景 */
@property (nonatomic,strong) UIImageView *bgImageView;
/** iconImg */
@property (nonatomic,strong) UIImageView *iconImgView;
/** 手机输入框 */
@property (nonatomic,strong) UIView *phoneNumberView;
/** phoneIcon */
@property (nonatomic,strong) UIImageView *phoneIcon;
/** phoneTe */
@property (nonatomic,strong) UITextField *phoneTextField;

/** 手机输入框 */
@property (nonatomic,strong) UIView *passwordView;
/** passIcon  */
@property (nonatomic,strong) UIImageView *passwordIconImgView;
/** passwordTextField */
@property (nonatomic,strong) UITextField *passwordTextField;
/** loginBtn */
@property (nonatomic,strong) UIButton *loginBtn;
/** wechatLogin */
@property (nonatomic,strong) UIButton *weChatLoginBtn;
/** 快速登录 */
@property (nonatomic,strong) UILabel *loginLabel;

@end

@implementation HYLoginView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubviews];
    }
    return self;
}


- (void)setupSubviews{
    
    [self addSubview:self.bgImageView];
    [self addSubview:self.iconImgView];
    
    [self addSubview:self.phoneNumberView];
    [self.phoneNumberView addSubview:self.phoneIcon];
    [self.phoneNumberView addSubview:self.phoneTextField];
    
    [self addSubview:self.passwordView];
    [self.passwordView addSubview:self.passwordIconImgView];
    [self.passwordView addSubview:self.passwordTextField];
    
    [self addSubview:self.loginBtn];
    [self addSubview:self.weChatLoginBtn];
    [self addSubview:self.loginLabel];
}


- (void)layoutSubviews{
    
    
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.bottom.right.equalTo(self);
    }];
    
    [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(70 * WIDTH_MULTIPLE);
        make.left.right.equalTo(self);
        make.height.equalTo(@(180 * WIDTH_MULTIPLE));
    }];
    
    [_phoneNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_iconImgView.mas_bottom).offset(45 * WIDTH_MULTIPLE);
        make.left.equalTo(self).offset(15 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-15 * WIDTH_MULTIPLE);
        make.height.equalTo(@(40 * WIDTH_MULTIPLE));
    }];
    
    [_phoneIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.equalTo(_phoneNumberView).offset(10);
        make.bottom.equalTo(_phoneNumberView).offset(-10);
        make.width.equalTo(@30);
    }];
    
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_phoneIcon.mas_right).offset(10 * WIDTH_MULTIPLE);
        make.top.bottom.equalTo(_phoneNumberView);
        make.right.equalTo(_phoneNumberView).offset(-5);

    }];
    
    [_passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_phoneNumberView.mas_bottom).offset(10 * WIDTH_MULTIPLE);
        make.left.equalTo(self).offset(15 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-15 * WIDTH_MULTIPLE);
        make.height.equalTo(@(40 * WIDTH_MULTIPLE));
    }];
    
    [_passwordIconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.equalTo(_passwordView).offset(10);
        make.bottom.equalTo(_passwordView).offset(-10);
        make.width.equalTo(@30);
    }];
    
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_passwordIconImgView.mas_right).offset(10 * WIDTH_MULTIPLE);
        make.top.bottom.equalTo(_passwordView);
        make.right.equalTo(_passwordView).offset(-5);
    }];
    
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_passwordView.mas_bottom).offset(36 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(240 * WIDTH_MULTIPLE, 50 * WIDTH_MULTIPLE));
        make.centerX.equalTo(self);
    }];
    
    [_loginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self).offset(-30 * WIDTH_MULTIPLE);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(30 * WIDTH_MULTIPLE);
    }];
    
    [_weChatLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.bottom.equalTo(_loginLabel.mas_top).offset(-10 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(50 * WIDTH_MULTIPLE, 50 * WIDTH_MULTIPLE));
    }];
    
    [self hideWeChatLoginBtn];
}

- (void)hideWeChatLoginBtn{
    
    if (![WXApi isWXAppInstalled]) {
        
        _weChatLoginBtn.hidden = YES;
        _loginLabel.hidden = YES;
    }
}

#pragma mark - set
- (void)setWithViewModel:(HYLoginViewModel *)viewModel{
    
    RAC(viewModel,phone) = [_phoneTextField rac_textSignal];
    RAC(viewModel,password) = [_passwordTextField rac_textSignal];
    
    [_phoneTextField.rac_textSignal subscribeNext:^(NSString *x) {
       
        if (x.length > 11) {
            
            _phoneTextField.text = [x substringToIndex:11];
        }
    }];
    
    RAC(self.loginBtn,enabled) = [viewModel loginButtonIsValid];
    RAC(self.loginBtn,backgroundColor) = [[viewModel loginButtonIsValid] map:^id(id value) {
        
        return [value boolValue] ? KAPP_THEME_COLOR : KAPP_c2c2c2_COLOR;
    }];
    
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [viewModel loginAction];
    }];
    
    [[_weChatLoginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       
        [viewModel wechatLoginAction];
    }];
}

#pragma mark - lazyload
- (UIImageView *)bgImageView{
    
    if (!_bgImageView) {
        
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _bgImageView.image = [UIImage imageNamed:@"login_bg"];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageView.clipsToBounds = YES;
    }
    return _bgImageView;
}

- (UIImageView *)iconImgView{
    
    if (!_iconImgView) {
        
        _iconImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _iconImgView.image = [UIImage imageNamed:@"login_icon"];
        _iconImgView.contentMode = UIViewContentModeScaleAspectFit;
        _iconImgView.clipsToBounds = YES;
    }
    return _iconImgView;
}

- (UIView *)phoneNumberView{
    
    if (!_phoneNumberView) {
        
        _phoneNumberView = [[UIView alloc] initWithFrame:CGRectZero];
        _phoneNumberView.backgroundColor = KAPP_WHITE_COLOR;
        _phoneNumberView.layer.cornerRadius = 4 * WIDTH_MULTIPLE;
    }
    return _phoneNumberView;
}

- (UIImageView *)phoneIcon{
    
    if (!_phoneIcon) {
        
        _phoneIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
        _phoneIcon.image = [UIImage imageNamed:@"phone"];
        _phoneIcon.contentMode = UIViewContentModeScaleAspectFit;
        _phoneIcon.clipsToBounds = YES;
    }
    return _phoneIcon;
}

- (UITextField *)phoneTextField{
    
    if (!_phoneTextField) {
        
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _phoneTextField.backgroundColor = [UIColor whiteColor];
        _phoneTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入手机账号" attributes:@{NSForegroundColorAttributeName:KAPP_7b7b7b_COLOR,NSFontAttributeName : KFitFont(14)}];
        _phoneTextField.clearButtonMode = UITextFieldViewModeAlways;
        _phoneTextField.font = KFitFont(14);
        _phoneTextField.textColor = KAPP_272727_COLOR;
        _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
        [_phoneTextField rac_signalForControlEvents:UIControlEventEditingChanged];
    }
    return _phoneTextField;
}

- (UIView *)passwordView{
    
    if (!_passwordView) {
        
        _passwordView = [[UIView alloc] initWithFrame:CGRectZero];
        _passwordView.backgroundColor = KAPP_WHITE_COLOR;
        _passwordView.layer.cornerRadius = 4 * WIDTH_MULTIPLE;
    }
    return _passwordView;
}

- (UIImageView *)passwordIconImgView{
    
    if (!_passwordIconImgView) {
        
        _passwordIconImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _passwordIconImgView.image = [UIImage imageNamed:@"password"];
        _passwordIconImgView.contentMode = UIViewContentModeScaleAspectFit;
        _passwordIconImgView.clipsToBounds = YES;
    }
    return _passwordIconImgView;
}

- (UITextField *)passwordTextField{
    if (!_passwordTextField) {
        
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName:KAPP_7b7b7b_COLOR,NSFontAttributeName : KFitFont(14)}];
        _passwordTextField.backgroundColor = [UIColor whiteColor];
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
        _passwordTextField.font = KFitFont(14);
        _passwordTextField.textColor = KAPP_272727_COLOR;
        
    }
    return _passwordTextField;
}

- (UIButton *)loginBtn{
    
    if (!_loginBtn) {
        
        _loginBtn = [[UIButton alloc] init];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = KFitFont(18);
        _loginBtn.backgroundColor = KAPP_THEME_COLOR;
        _loginBtn.layer.cornerRadius = 25 * WIDTH_MULTIPLE;
        _loginBtn.layer.masksToBounds = YES;
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _loginBtn;
}


- (UIButton *)weChatLoginBtn{
    
    if (!_weChatLoginBtn) {
        
        _weChatLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_weChatLoginBtn setImage:[UIImage imageNamed:@"weChat_theme"] forState:UIControlStateNormal];
    }
    return _weChatLoginBtn;
}

- (UILabel *)loginLabel{
    
    if (!_loginLabel) {
        
        _loginLabel = [[UILabel alloc] init];
        _loginLabel.text = @"微信登录更加方便快捷";
        _loginLabel.font = KFitFont(16);
        _loginLabel.textColor = KAPP_WHITE_COLOR;
        _loginLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _loginLabel;
}

@end

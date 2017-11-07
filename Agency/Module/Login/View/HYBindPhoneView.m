//
//  HYBindPhoneView.m
//  Agency
//
//  Created by 胡勇 on 2017/11/7.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBindPhoneView.h"

@interface HYBindPhoneView()

/** 白色背景 */
@property (nonatomic,strong) UIView *whiteBgView;
/** phone */
@property (nonatomic,strong) UILabel *phoneLabel;
/** authCodeLabel */
@property (nonatomic,strong) UILabel *authCodeLabel;
/** phoneTextField */
@property (nonatomic,strong) UITextField *phoneTextField;
/** authCodeTextField */
@property (nonatomic,strong) UITextField *authCodeTextField;
/** 验证码 */
@property (nonatomic,strong) UIButton *getAuthCodeBtn;
/** 线 */
@property (nonatomic,strong) UIView *line1;
/** 确定 */
@property (nonatomic,strong) UIButton *confirmBtn;


@end


@implementation HYBindPhoneView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = KAPP_TableView_BgColor;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.whiteBgView];
    [self addSubview:self.phoneLabel];
    [self addSubview:self.authCodeLabel];
    [self addSubview:self.phoneTextField];
    [self addSubview:self.getAuthCodeBtn];
    [self addSubview:self.authCodeTextField];
    [self addSubview:self.confirmBtn];
    [self addSubview:self.line1];
    
}

- (void)layoutSubviews{
    
    
    [_whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(90 * WIDTH_MULTIPLE);
    }];
    
    [_getAuthCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_whiteBgView.mas_top).offset(7 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.width.equalTo(@(90 * WIDTH_MULTIPLE));
        make.height.equalTo(@(30 * WIDTH_MULTIPLE));
    }];
    
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_whiteBgView.mas_top);
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.width.equalTo(@(60 * WIDTH_MULTIPLE));
        make.height.equalTo(@(45 * WIDTH_MULTIPLE));
    }];
    
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_phoneLabel);
        make.right.equalTo(self.getAuthCodeBtn.mas_left);
        make.height.equalTo(_phoneLabel);
        make.left.equalTo(_phoneLabel.mas_right).offset(20 * WIDTH_MULTIPLE);
    }];
    
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(_phoneLabel.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    [_authCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.width.height.equalTo(_phoneLabel);
        make.top.equalTo(_line1);
    }];
    
    [_authCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.width.height.equalTo(_phoneTextField);
        make.top.equalTo(_line1);
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-15 * WIDTH_MULTIPLE);
        make.top.equalTo(_whiteBgView.mas_bottom).offset(50 * WIDTH_MULTIPLE);
        make.height.equalTo(@(50 * WIDTH_MULTIPLE));
    }];
    
}

#pragma mark - viewModel
- (void)setWithViewModel:(HYBindPhoneViewModel *)viewModel{
    
    [_phoneTextField.rac_textSignal subscribeNext:^(NSString *x) {
        
        if (x.length > 11) {
            
            _phoneTextField.text = [x substringToIndex:11];
        }
    }];
    [_authCodeTextField.rac_textSignal subscribeNext:^(NSString *x) {
        
        if (x.length > 6) {
            
            _authCodeTextField.text = [x substringToIndex:6];
        }
    }];
    RAC(viewModel,phone) = [_phoneTextField rac_textSignal];
    RAC(viewModel,authCode) = [_authCodeTextField rac_textSignal];
    RAC(self.getAuthCodeBtn,enabled) = [viewModel getAuthCodeButtonIsValid];
    //RAC(self.getAuthCodeBtn.titleLabel,text) = RACObserve(viewModel, authBtnTitle);
    RAC(self.getAuthCodeBtn,backgroundColor) = [[viewModel getAuthCodeButtonIsValid] map:^id(id value) {
        
        return [value boolValue] ? KAPP_THEME_COLOR : KAPP_b7b7b7_COLOR;
    }];
    
    RAC(self.confirmBtn,enabled) = [viewModel confirmButtonIsValid];
    RAC(self.confirmBtn,backgroundColor) = [[viewModel confirmButtonIsValid] map:^id(id value) {
        
        return [value boolValue] ? KAPP_THEME_COLOR : KAPP_b7b7b7_COLOR;
    }];
    
    [[self.getAuthCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       
        [viewModel getAuthCode];
    }];
    
    [[self.confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [viewModel confirmButtonIsValid];
    }];
}


#pragma mark - lazyload
- (UIView *)whiteBgView{
    
    if (!_whiteBgView) {
        
        _whiteBgView = [UIView new];
        _whiteBgView.backgroundColor = KAPP_WHITE_COLOR;
    }
    return _whiteBgView;
}


- (UITextField *)phoneTextField{
    
    if (!_phoneTextField) {
        
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _phoneTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入手机账号" attributes:@{NSForegroundColorAttributeName:KAPP_7b7b7b_COLOR,NSFontAttributeName : KFitFont(14)}];
        _phoneTextField.clearButtonMode = UITextFieldViewModeAlways;
        _phoneTextField.font = KFitFont(14);
        _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
        _phoneTextField.textColor = KAPP_272727_COLOR;
    }
    return _phoneTextField;
}

- (UIButton *)getAuthCodeBtn{
    
    if (!_getAuthCodeBtn) {
        
        _getAuthCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_getAuthCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _getAuthCodeBtn.layer.cornerRadius = 15 * WIDTH_MULTIPLE;
        _getAuthCodeBtn.backgroundColor = KCOLOR(@"b7b7b7");
        _getAuthCodeBtn.clipsToBounds  = YES;
        [_getAuthCodeBtn setTitleColor:KAPP_WHITE_COLOR forState:UIControlStateNormal];
        _getAuthCodeBtn.titleLabel.font = KFont(14);
    }
    return _getAuthCodeBtn;
}

- (UIView *)line1{
    
    if (!_line1) {
        
        _line1 = [[UIView alloc] initWithFrame:CGRectZero];
        _line1.backgroundColor = KAPP_SEPERATOR_COLOR;
    }
    return _line1;
}

- (UITextField *)authCodeTextField{
    
    if (!_authCodeTextField) {
        
        _authCodeTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        
        _authCodeTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName:KAPP_7b7b7b_COLOR,NSFontAttributeName : KFitFont(14)}];
        _authCodeTextField.clearButtonMode = UITextFieldViewModeAlways;
        _authCodeTextField.font = KFitFont(14);
        _authCodeTextField.keyboardType = UIKeyboardTypePhonePad;
        _authCodeTextField.textColor = KAPP_272727_COLOR;
    }
    return _authCodeTextField;
}


- (UIButton *)confirmBtn{
    
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc] init];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = KCOLOR(@"c2c2c2");
        _confirmBtn.layer.cornerRadius = 25 * WIDTH_MULTIPLE;
        _confirmBtn.layer.masksToBounds = YES;
        _confirmBtn.titleLabel.font = KFitFont(18);
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
    return _confirmBtn;
}

- (UILabel *)phoneLabel{
    
    if (!_phoneLabel) {
        
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.text = @"手机号";
        _phoneLabel.font = KFont(14);
        _phoneLabel.textColor = KAPP_272727_COLOR;
        _phoneLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _phoneLabel;
}

- (UILabel *)authCodeLabel{
    
    if (!_authCodeLabel) {
        
        _authCodeLabel = [[UILabel alloc] init];
        _authCodeLabel.text = @"验证码";
        _authCodeLabel.font = KFont(14);
        _authCodeLabel.textColor = KAPP_272727_COLOR;
        _authCodeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _authCodeLabel;
}

@end

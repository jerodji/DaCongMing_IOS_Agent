//
//  HYBindCardPhoneAuthView.m
//  Agency
//
//  Created by Jack on 2017/11/27.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBindCardPhoneAuthView.h"

@interface HYBindCardPhoneAuthView()

@property (nonatomic,strong) UIView *whiteBgView;
@property (nonatomic,strong) UILabel *phoneLabel;
@property (nonatomic,strong) UITextField *phoneField;
/** 底部黑线 */
@property (nonatomic,strong) UIView *bottomLine;
@property (nonatomic,strong) UILabel *authLabel;
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UIButton *getAuthBtn;

@end

@implementation HYBindCardPhoneAuthView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.whiteBgView];
    [self addSubview:self.phoneLabel];
    [self addSubview:self.phoneField];
    [self addSubview:self.bottomLine];
    [self addSubview:self.authLabel];
    [self addSubview:self.textField];
    [self addSubview:self.getAuthBtn];
}

#pragma mark - setModel
- (void)setWithViewModel:(HYUploadIDCardViewModel *)viewModel{
    
    [_phoneField.rac_textSignal subscribeNext:^(NSString *x) {
        
        if (x.length >= 6) {
            
            _phoneField.text = [x substringToIndex:6];
        }
        viewModel.phoneNum = _phoneField.text;
    }];
    
    [_textField.rac_textSignal subscribeNext:^(NSString *x) {
        
        if (x.length >= 6) {
            
            _textField.text = [x substringToIndex:6];
        }
        viewModel.authNum = _textField.text;

    }];
    
    RAC(self.getAuthBtn,enabled) = [viewModel getAuthCodeButtonIsValid];
    [[_getAuthBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [viewModel getAuthCodeAction];
    }];
    
    [[viewModel rac_valuesForKeyPath:@"authBtnTitle" observer:nil] subscribeNext:^(id x) {
        
        [self.getAuthBtn setTitle:x forState:UIControlStateNormal];
    }];
}

- (void)layoutSubviews{

    
    
    [_whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self).offset(5 * WIDTH_MULTIPLE);
    }];
    
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(_whiteBgView);
        make.width.mas_equalTo(80 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(50 * WIDTH_MULTIPLE);
    }];
    
    [_phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.height.equalTo(_phoneLabel);
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.left.equalTo(_phoneLabel.mas_right);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self);
        make.height.mas_equalTo(1);
        make.top.equalTo(_phoneLabel.mas_bottom);
    }];
    
    [_authLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.height.equalTo(_phoneLabel);
        make.top.equalTo(_bottomLine.mas_bottom);
        make.width.mas_equalTo(80 * WIDTH_MULTIPLE);
    }];
    
    [_getAuthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.top.bottom.equalTo(_authLabel);
        make.width.mas_equalTo(100 * WIDTH_MULTIPLE);
    }];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.height.equalTo(_authLabel);
        make.right.equalTo(_getAuthBtn.mas_left).offset(-10 * WIDTH_MULTIPLE);
        make.left.equalTo(_authLabel.mas_right);
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

- (UILabel *)phoneLabel{
    
    if (!_phoneLabel) {
        
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.font = KFitFont(16);
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
        _phoneLabel.text = @"手机号";
        _phoneLabel.textColor = KAPP_272727_COLOR;
    }
    return _phoneLabel;
}

- (UILabel *)authLabel{
    
    if (!_authLabel) {
        
        _authLabel = [[UILabel alloc] init];
        _authLabel.font = KFitFont(16);
        _authLabel.textAlignment = NSTextAlignmentLeft;
        _authLabel.text = @"验证码";
        _authLabel.textColor = KAPP_272727_COLOR;
    }
    return _authLabel;
}

- (UITextField *)phoneField{
    
    if (!_phoneField) {
        
        _phoneField = [[UITextField alloc] initWithFrame:CGRectZero];
        _phoneField.backgroundColor = [UIColor whiteColor];
        _phoneField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneField.font = KFitFont(14);
        _phoneField.textColor = KAPP_7b7b7b_COLOR;
        _phoneField.keyboardType = UIKeyboardTypePhonePad;
        _phoneField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入银行预留手机号" attributes:@{NSForegroundColorAttributeName:KAPP_b7b7b7_COLOR,NSFontAttributeName : KFitFont(14)}];
    }
    return _phoneField;
}

- (UIView *)bottomLine{
    
    if (!_bottomLine) {
        
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = KAPP_SEPERATOR_COLOR;
    }
    return _bottomLine;
}

- (UITextField *)textField{
    
    if (!_textField) {
        
        _textField = [[UITextField alloc] initWithFrame:CGRectZero];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.font = KFitFont(14);
        _textField.textColor = KAPP_7b7b7b_COLOR;
        _textField.keyboardType = UIKeyboardTypePhonePad;
        _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName:KAPP_b7b7b7_COLOR,NSFontAttributeName : KFitFont(14)}];
    }
    return _textField;
}

- (UIButton *)getAuthBtn{
    
    if (!_getAuthBtn) {
        
        _getAuthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_getAuthBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _getAuthBtn.titleLabel.font = KFitFont(14);
        [_getAuthBtn setTitleColor:KAPP_THEME_COLOR forState:UIControlStateNormal];
        _getAuthBtn.backgroundColor = KAPP_WHITE_COLOR;
    }
    return _getAuthBtn;
}

@end

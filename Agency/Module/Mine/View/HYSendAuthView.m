//
//  HYSendAuthView.m
//  Agency
//
//  Created by 胡勇 on 2017/11/8.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYSendAuthView.h"

@interface HYSendAuthView()

/** tipsLabel */
@property (nonatomic,strong) UILabel *tipsLabel;
/** 背景 */
@property (nonatomic,strong) UIView *whiteBgView;
@property (nonatomic,strong) UILabel *authLabel;
/** textField */
@property (nonatomic,strong) UITextField *textField;
/** getAuthBtn */
@property (nonatomic,strong) UIButton *getAuthBtn;

@end

@implementation HYSendAuthView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.tipsLabel];
    [self addSubview:self.whiteBgView];
    [self addSubview:self.authLabel];
    [self addSubview:self.textField];
    [self addSubview:self.getAuthBtn];
}

#pragma mark - setModel
- (void)setWithViewModel:(HYUploadIDCardViewModel *)viewModel{
    
    [_textField.rac_textSignal subscribeNext:^(NSString *x) {
        
        if (x.length >= 6) {
            
            _textField.text = [x substringToIndex:6];
        }
    }];
    
    RAC(self.tipsLabel,text) = RACObserve(viewModel, tipsLabelText);
    RAC(viewModel,authNum) = [_textField rac_textSignal];
    
    RAC(self.getAuthBtn,enabled) = [viewModel getAuthCodeButtonIsValid];
    [[_getAuthBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       
        [viewModel getAuthCodeAction];
    }];
    
    [[viewModel rac_valuesForKeyPath:@"authBtnTitle" observer:nil] subscribeNext:^(id x) {
        
        [self.getAuthBtn setTitle:x forState:UIControlStateNormal];
    }];
}

- (void)layoutSubviews{
    
    [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.right.equalTo(self);
        make.top.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(30 * WIDTH_MULTIPLE);
    }];
    
    [_whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(50 * WIDTH_MULTIPLE);
    }];
    
    [_authLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_tipsLabel);
        make.top.bottom.equalTo(_whiteBgView);
        make.width.mas_equalTo(80 * WIDTH_MULTIPLE);
    }];
    
    [_getAuthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.top.bottom.equalTo(_whiteBgView);
        make.width.mas_equalTo(100 * WIDTH_MULTIPLE);
    }];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.height.equalTo(_whiteBgView);
        make.right.equalTo(_getAuthBtn.mas_left).offset(10 * WIDTH_MULTIPLE);
        make.left.equalTo(_authLabel.mas_right);
    }];
    
    
}

#pragma mark - lazyload
- (UILabel *)tipsLabel{
    
    if (!_tipsLabel) {
        
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.font = KFitFont(14);
        _tipsLabel.textAlignment = NSTextAlignmentLeft;
        NSString *phone = [HYUserModel sharedInstance].userInfo.phone;
        phone = [phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        NSString *str = [NSString stringWithFormat:@"我们将发送验证码到:%@",phone];
        _tipsLabel.text = str;
        _tipsLabel.textColor = KAPP_b7b7b7_COLOR;
    }
    return _tipsLabel;
}

- (UIView *)whiteBgView{
    
    if (!_whiteBgView) {
        
        _whiteBgView = [UIView new];
        _whiteBgView.backgroundColor = KAPP_WHITE_COLOR;
    }
    return _whiteBgView;
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

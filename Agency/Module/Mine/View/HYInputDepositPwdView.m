//
//  HYInputDepositPwdView.m
//  Agency
//
//  Created by 胡勇 on 2017/11/10.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYInputDepositPwdView.h"
#import "HYPasswordView.h"

@interface HYInputDepositPwdView() <HYPasswordViewDelegate>

/** 半透明背景 */
@property (nonatomic,strong) UIView *blackBgView;
/** 白色背景 */
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIView *topLine;
/** 标题 */
@property (nonatomic,strong) UILabel *titleLabel;
/** 提现 */
@property (nonatomic,strong) UILabel *depositLabel;
/** 金额 */
@property (nonatomic,strong) UILabel *amountLabel;
/** passwordView */
@property (nonatomic,strong) HYPasswordView *passwordView;
/** 提示 */
@property (nonatomic,strong) UILabel *tipsLabel;
/** 忘记密码 */
@property (nonatomic,strong) UIButton *forgetPwdBtn;
@property (nonatomic,strong) UIButton *closeBtn;
/** viewModel */
@property (nonatomic,strong) HYDepositViewModel *viewModel;

@end

@implementation HYInputDepositPwdView

- (instancetype)initWithFrame:(CGRect)frame WithAmount:(NSString *)amount{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubviews];
        _amountLabel.text = [NSString stringWithFormat:@"￥%@",amount];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.blackBgView];
    [self addSubview:self.bgView];
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(1000);
        make.size.mas_equalTo(CGSizeMake(300 * WIDTH_MULTIPLE, 260 * WIDTH_MULTIPLE));
    }];
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.topLine];
    [self addSubview:self.depositLabel];
    [self addSubview:self.amountLabel];
    [self addSubview:self.passwordView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.tipsLabel];
    [self addSubview:self.forgetPwdBtn];
    [self addSubview:self.closeBtn];
}

- (void)layoutSubviews{
    
    [_blackBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self);
    }];
    
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.equalTo(_bgView);
        make.height.mas_equalTo(45 * WIDTH_MULTIPLE);
    }];
    
    [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(_bgView);
        make.top.equalTo(_titleLabel.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    [_depositLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(_bgView);
        make.top.equalTo(_titleLabel.mas_bottom).mas_offset(20 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(20 * WIDTH_MULTIPLE);
    }];
    
    [_amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_bgView);
        make.right.equalTo(_bgView).offset(-10 * WIDTH_MULTIPLE);
        make.top.equalTo(_depositLabel.mas_bottom).mas_offset(20 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(40 * WIDTH_MULTIPLE);
    }];
    
    [_passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_amountLabel.mas_bottom).offset(30 * WIDTH_MULTIPLE);
        make.left.equalTo(_bgView);
        make.right.equalTo(_bgView);
        make.height.mas_equalTo(35 * WIDTH_MULTIPLE);
    }];
    
    [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_passwordView).offset(20 * WIDTH_MULTIPLE);
        make.top.equalTo(_passwordView.mas_bottom).offset(10 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(150 * WIDTH_MULTIPLE, 20 * WIDTH_MULTIPLE));
    }];
    
    [_forgetPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.height.equalTo(_tipsLabel);
        make.right.equalTo(_passwordView).offset(-10 * WIDTH_MULTIPLE);
        make.width.mas_equalTo(80 * WIDTH_MULTIPLE);
    }];
    
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.top.equalTo(_bgView);
        make.size.mas_equalTo(CGSizeMake(45 * WIDTH_MULTIPLE, 45 * WIDTH_MULTIPLE));
    }];
}

#pragma mark - publicMethod
- (void)showInputPasswordView{
    
    //[self addSubview:self.blackBgView];
    [UIView animateWithDuration:0.5 animations:^{
        
        _blackBgView.alpha = 0.6;
        [_bgView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self).offset(-70 * WIDTH_MULTIPLE);
        }];
        [self layoutIfNeeded];
        
    }];
}

#pragma mark - 输入密码delegate
- (void)passwordCompleteInput:(HYPasswordView *)passwordView{
    
    NSString *authCode = passwordView.passwordString;
    DLog(@"%@",authCode);
    self.viewModel.depositPwd = authCode;
    [self.viewModel inputPwdComplectionAction];
}

- (void)setWithViewModel:(HYDepositViewModel *)viewModel{
    
    self.viewModel = viewModel;
}

#pragma mark - action
- (void)hideInputPwdView{
    
    [UIView animateWithDuration:0.4 animations:^{
        
        [self.blackBgView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (void)forgetPwd{
    
    [self hideInputPwdView];
    
    if (self.forgetPwdAction) {
        
        self.forgetPwdAction();
    }
}

#pragma mark - lazyload
- (UIView *)blackBgView{
    
    if (!_blackBgView) {
        
        _blackBgView = [UIView new];
        _blackBgView.backgroundColor = KAPP_BLACK_COLOR;
        _blackBgView.alpha = 0;
    }
    return _blackBgView;
}

- (UIView *)bgView{
    
    if (!_bgView) {
        
        _bgView = [UIView new];
        _bgView.backgroundColor = KAPP_WHITE_COLOR;
        _bgView.layer.cornerRadius = 6 * WIDTH_MULTIPLE;
        _bgView.clipsToBounds = YES;
    }
    return _bgView;
}

- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = KFitFont(18);
        _titleLabel.textColor = KAPP_272727_COLOR;
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"请输入提现密码";
    }
    return _titleLabel;
}

- (UIView *)topLine{
    
    if (!_topLine) {
        
        _topLine = [UIView new];
        _topLine.backgroundColor = KAPP_THEME_COLOR;
    }
    return _topLine;
}

- (UILabel *)depositLabel{
    
    if (!_depositLabel) {
        
        _depositLabel = [[UILabel alloc] init];
        _depositLabel.font = KFitFont(16);
        _depositLabel.textColor = KAPP_272727_COLOR;
        _depositLabel.numberOfLines = 0;
        _depositLabel.textAlignment = NSTextAlignmentCenter;
        _depositLabel.text = @"提现金额:";
    }
    return _depositLabel;
}

- (UILabel *)amountLabel{
    
    if (!_amountLabel) {
        
        _amountLabel = [[UILabel alloc] init];
        _amountLabel.font = KFitFont(26);
        _amountLabel.textColor = KAPP_272727_COLOR;
        _amountLabel.numberOfLines = 0;
        _amountLabel.textAlignment = NSTextAlignmentCenter;
        _amountLabel.text = @"￥1000";
    }
    return _amountLabel;
}

- (HYPasswordView *)passwordView{
    
    if (!_passwordView) {
        
        _passwordView = [[HYPasswordView alloc] init];
        _passwordView.isSetPassword = YES;
        _passwordView.delegate = self;
    }
    return _passwordView;
}

- (UILabel *)tipsLabel{
    
    if (!_tipsLabel) {
        
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.font = KFitFont(14);
        _tipsLabel.textColor = KAPP_b7b7b7_COLOR;
        _tipsLabel.numberOfLines = 0;
        _tipsLabel.textAlignment = NSTextAlignmentLeft;
        _tipsLabel.text = @"请输入提现密码";
    }
    return _tipsLabel;
}

- (UIButton *)forgetPwdBtn{
    
    if (!_forgetPwdBtn) {
        
        _forgetPwdBtn = [[UIButton alloc] init];
        [_forgetPwdBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
        _forgetPwdBtn.titleLabel.font = KFitFont(12);
        _forgetPwdBtn.backgroundColor = KAPP_WHITE_COLOR;
        [_forgetPwdBtn setTitleColor:KAPP_PRICE_COLOR forState:UIControlStateNormal];
        [_forgetPwdBtn addTarget:self action:@selector(forgetPwd) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetPwdBtn;
}

- (UIButton *)closeBtn{
    
    if (!_closeBtn) {
        
        _closeBtn = [[UIButton alloc] init];
        [_closeBtn setImage:[UIImage imageNamed:@"closeGray"] forState:UIControlStateNormal];
        [_closeBtn setTitleColor:KAPP_PRICE_COLOR forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(hideInputPwdView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

@end

//
//  HYSetDepositTipsView.m
//  Agency
//
//  Created by 胡勇 on 2017/11/9.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYSetDepositTipsView.h"

@interface HYSetDepositTipsView ()

/** 半透明背景 */
@property (nonatomic,strong) UIView *blackBgView;
/** 白色背景 */
@property (nonatomic,strong) UIView *bgView;
/** 提示 */
@property (nonatomic,strong) UILabel *titleLabel;
/** 提示 */
@property (nonatomic,strong) UILabel *tipsLabel;
/** 设置 */
@property (nonatomic,strong) UIButton *settingBtn;
@property (nonatomic,strong) UIView *topLine;
/** 底部黑线 */
@property (nonatomic,strong) UIView *bottomLine;

@end

@implementation HYSetDepositTipsView

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
        make.size.mas_equalTo(CGSizeMake(300 * WIDTH_MULTIPLE, 250 * WIDTH_MULTIPLE));
    }];
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.tipsLabel];
    [self addSubview:self.topLine];
    [self addSubview:self.bottomLine];
    [self addSubview:self.settingBtn];
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
    
    [_settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(_bgView);
        make.height.mas_equalTo(45 * WIDTH_MULTIPLE);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(_bgView);
        make.bottom.equalTo(_settingBtn.mas_top);
        make.height.mas_equalTo(1);
    }];
    
    [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_topLine.mas_bottom);
        make.left.right.equalTo(_bgView);
        make.bottom.equalTo(_bottomLine.mas_top);
    }];
    
}

#pragma mark - publicMethod
- (void)showTipsView{
    
    [UIView animateWithDuration:1 animations:^{
        
        _blackBgView.alpha = 0.6;
        [_bgView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self).offset(-80 * WIDTH_MULTIPLE);
        }];
        [self layoutIfNeeded];

    }];
}

- (void)hideTipsView{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _blackBgView.alpha = 0;
        [_bgView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self).offset(-KSCREEN_HEIGHT);
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(300 * WIDTH_MULTIPLE, 250 * WIDTH_MULTIPLE));
        }];
    }];
}

#pragma mark - action
- (void)settingBtnAction{
    
    if (self.jumpToSettingVCBlock) {
        
        self.jumpToSettingVCBlock();
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
        _titleLabel.text = @"请设置提现密码";
    }
    return _titleLabel;
}

- (UILabel *)tipsLabel{
    
    if (!_tipsLabel) {
        
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.font = KFitFont(18);
        _tipsLabel.textColor = KAPP_WHITE_COLOR;
        _tipsLabel.numberOfLines = 0;
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        NSString *str = @"您还未设置提现密码\n(请先设置提现密码再提现)";
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attributeStr addAttributes:@{NSFontAttributeName : KFitFont(18) , NSForegroundColorAttributeName : KAPP_272727_COLOR} range:NSMakeRange(0, 9)];
        [attributeStr addAttributes:@{NSFontAttributeName : KFitFont(16) , NSForegroundColorAttributeName : KAPP_b7b7b7_COLOR} range:NSMakeRange(9, str.length - 9)];
        _tipsLabel.attributedText = attributeStr;
    }
    return _tipsLabel;
}

- (UIButton *)settingBtn{
    
    if (!_settingBtn) {
        
        _settingBtn = [[UIButton alloc] init];
        [_settingBtn setTitle:@"去设置" forState:UIControlStateNormal];
        _settingBtn.titleLabel.font = KFitFont(18);
        _settingBtn.backgroundColor = KAPP_WHITE_COLOR;
        [_settingBtn setTitleColor:KAPP_THEME_COLOR forState:UIControlStateNormal];
        [_settingBtn addTarget:self action:@selector(settingBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _settingBtn;
}

- (UIView *)topLine{
    
    if (!_topLine) {
        
        _topLine = [UIView new];
        _topLine.backgroundColor = KAPP_THEME_COLOR;
    }
    return _topLine;
}

- (UIView *)bottomLine{
    
    if (!_bottomLine) {
        
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = KAPP_SEPERATOR_COLOR;
    }
    return _bottomLine;
}

@end

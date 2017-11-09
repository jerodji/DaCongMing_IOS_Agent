//
//  HYDispoitView.m
//  Agency
//
//  Created by 胡勇 on 2017/11/8.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYDispoitView.h"

@interface HYDispoitView()

@property (nonatomic,strong) UIView *whiteBgView;
@property (nonatomic,strong) UILabel *depositLabel;
@property (nonatomic,strong) UITextField *moneyTF;
@property (nonatomic,strong) UILabel *amountLabel;
@property (nonatomic,strong) UIView *bottomLine;
@property (nonatomic,strong) UILabel *tipsLabel;
@property (nonatomic,strong) UIButton *depostiBtn;
@property (nonatomic,strong) UIButton *depositAllBtn;

@end


@implementation HYDispoitView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = KAPP_TableView_BgColor;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.whiteBgView];
    [self addSubview:self.depositLabel];
    [self addSubview:self.moneyTF];
    [self addSubview:self.bottomLine];
    [self addSubview:self.amountLabel];
    [self addSubview:self.tipsLabel];
    [self addSubview:self.depostiBtn];
    [self addSubview:self.depositAllBtn];
}

- (void)layoutSubviews{
    
    [_whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(110 * WIDTH_MULTIPLE);
    }];
    
    [_depositLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(20 * WIDTH_MULTIPLE);
    }];
    
    [_moneyTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(_depositLabel.mas_bottom).offset(10 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(40 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-100 * WIDTH_MULTIPLE);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_depositLabel);
        make.right.equalTo(self);
        make.top.equalTo(_moneyTF.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    [_amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_depositLabel);
        make.top.equalTo(_bottomLine.mas_bottom);
        make.width.mas_equalTo(200 * WIDTH_MULTIPLE);
        make.bottom.equalTo(_whiteBgView);
    }];
    
    [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_depositLabel);
        make.top.equalTo(_whiteBgView.mas_bottom).offset(10 * WIDTH_MULTIPLE);
        make.width.mas_equalTo(200 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(20 * WIDTH_MULTIPLE);
    }];
    
    [_depostiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(25 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-25 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(50 * WIDTH_MULTIPLE);
        make.top.equalTo(_whiteBgView.mas_bottom).offset(60 * WIDTH_MULTIPLE);
    }];
    
    [_depositAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.right.equalTo(_whiteBgView);
        make.height.equalTo(_amountLabel);
        make.width.mas_equalTo(80 * WIDTH_MULTIPLE);
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

- (UILabel *)depositLabel{
    
    if (!_depositLabel) {
        
        _depositLabel = [[UILabel alloc] init];
        _depositLabel.font = KFitFont(13);
        _depositLabel.textAlignment = NSTextAlignmentLeft;
        _depositLabel.text = @"提现金额";
        _depositLabel.textColor = KAPP_7b7b7b_COLOR;
    }
    return _depositLabel;
}

- (UITextField *)moneyTF{
    
    if (!_moneyTF) {
        
        _moneyTF = [[UITextField alloc] initWithFrame:CGRectZero];
        _moneyTF.backgroundColor = [UIColor whiteColor];
        _moneyTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _moneyTF.font = KFitFont(30);
        _moneyTF.textColor = KAPP_272727_COLOR;
        _moneyTF.keyboardType = UIKeyboardTypePhonePad;
        _moneyTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入提现金额" attributes:@{NSForegroundColorAttributeName:KAPP_b7b7b7_COLOR,NSFontAttributeName : KFitFont(14)}];
    }
    return _moneyTF;
}

- (UIView *)bottomLine{
    
    if (!_bottomLine) {
        
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = KAPP_SEPERATOR_COLOR;
    }
    return _bottomLine;
}

- (UILabel *)amountLabel{
    
    if (!_amountLabel) {
        
        _amountLabel = [[UILabel alloc] init];
        _amountLabel.font = KFitFont(13);
        _amountLabel.textAlignment = NSTextAlignmentLeft;
        _amountLabel.text = @"可提现金额:￥987456321";
        _amountLabel.textColor = KAPP_b7b7b7_COLOR;
    }
    return _amountLabel;
}

- (UILabel *)tipsLabel{
    
    if (!_tipsLabel) {
        
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.font = KFitFont(12);
        _tipsLabel.textAlignment = NSTextAlignmentLeft;
        _tipsLabel.text = @"到账时间三个工作日内";
        _tipsLabel.textColor = KAPP_b7b7b7_COLOR;
    }
    return _tipsLabel;
}

- (UIButton *)depostiBtn{
    
    if (!_depostiBtn) {
        
        _depostiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_depostiBtn setTitle:@"提现" forState:UIControlStateNormal];
        _depostiBtn.backgroundColor = KAPP_THEME_COLOR;
        _depostiBtn.layer.cornerRadius = 25 * WIDTH_MULTIPLE;
        _depostiBtn.layer.masksToBounds = YES;
        [_depostiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
    return _depostiBtn;
}

- (UIButton *)depositAllBtn{
    
    if (!_depositAllBtn) {
        
        _depositAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_depositAllBtn setTitle:@"全部提现" forState:UIControlStateNormal];
        _depositAllBtn.backgroundColor = KAPP_WHITE_COLOR;
        [_depositAllBtn setTitleColor:KAPP_THEME_COLOR forState:UIControlStateNormal];
    }
    return _depositAllBtn;
}

@end

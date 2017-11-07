//
//  HYSelectInfoBtnView.m
//  Agency
//
//  Created by 胡勇 on 2017/11/7.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYSelectInfoBtnView.h"

@interface HYSelectInfoBtnView()

/** 提示信息 */
@property (nonatomic,strong) UILabel *tipsLabel;
@property (nonatomic,strong) UILabel *professionalLabel;
@property (nonatomic,strong) UIButton *confirmBtn;

@end

@implementation HYSelectInfoBtnView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.tipsLabel];
    [self addSubview:self.professionalLabel];
    [self addSubview:self.confirmBtn];
}

- (void)layoutSubviews{
    
    [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(60 * WIDTH_MULTIPLE);
    }];
    
    [_professionalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_tipsLabel.mas_bottom).offset(30 * WIDTH_MULTIPLE);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(20 * WIDTH_MULTIPLE);
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(30 * WIDTH_MULTIPLE);
    }];
}

#pragma mark - lazyload
- (UILabel *)tipsLabel{
    
    if (!_tipsLabel) {
        
        _tipsLabel = [[UILabel alloc] init];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"选择我的省份信息\n选择越多，通过概率越高哦！"];
        NSRange strRange = {0,[str length]};
        _tipsLabel.font = KFitFont(18);
        _tipsLabel.numberOfLines = 0;
        [str addAttribute:NSForegroundColorAttributeName value:KAPP_272727_COLOR range:strRange];
        [str addAttribute:NSFontAttributeName value:KFitFont(13) range:NSMakeRange(str.length - 14, 14)];
        _tipsLabel.attributedText = str;
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipsLabel;
}

- (UILabel *)professionalLabel{
    
    if (!_professionalLabel) {
        
        _professionalLabel = [[UILabel alloc] init];
        _professionalLabel.text = @"职业";
        _professionalLabel.font = KFitFont(15);
        _professionalLabel.textColor = KAPP_272727_COLOR;
        _professionalLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _professionalLabel;
}

- (UIButton *)confirmBtn{
    
    if (!_confirmBtn) {
        
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.backgroundColor = KAPP_WHITE_COLOR;
        [_confirmBtn setTitle:@"选好了去下一步" forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = KFitFont(18);
        [_confirmBtn setTitleColor:KAPP_272727_COLOR forState:UIControlStateNormal];
    }
    return _confirmBtn;
}

@end

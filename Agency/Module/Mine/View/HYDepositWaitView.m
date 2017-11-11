//
//  HYDepositWaitView.m
//  Agency
//
//  Created by 胡勇 on 2017/11/11.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYDepositWaitView.h"

@interface HYDepositWaitView ()

@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UILabel *applyLabel;
@property (nonatomic,strong) UILabel *amountLabel;
@property (nonatomic,strong) UILabel *reachLabel;

@end


@implementation HYDepositWaitView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = KAPP_WHITE_COLOR;
        [self setupSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame withAmount:(NSString *)amount{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = KAPP_WHITE_COLOR;
        [self setupSubviews];
        self.amountLabel.text = [NSString stringWithFormat:@"%@元",amount];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.imgView];
    [self addSubview:self.applyLabel];
    [self addSubview:self.amountLabel];
    [self addSubview:self.reachLabel];
}

- (void)layoutSubviews{
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(self).offset(16 * WIDTH_MULTIPLE);
        make.bottom.equalTo(self).offset(-16 * WIDTH_MULTIPLE);
        make.width.mas_equalTo(20 * WIDTH_MULTIPLE);
    }];
    
    [_applyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_imgView);
        make.left.equalTo(_imgView.mas_right).offset(10 * WIDTH_MULTIPLE);
        make.right.equalTo(self);
        make.height.mas_equalTo(20 * WIDTH_MULTIPLE);
    }];
    
    [_amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_applyLabel.mas_bottom).offset(8 * WIDTH_MULTIPLE);
        make.left.equalTo(_imgView.mas_right).offset(10 * WIDTH_MULTIPLE);
        make.right.equalTo(self);
        make.height.mas_equalTo(20 * WIDTH_MULTIPLE);
    }];
    
    [_reachLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(_imgView);
        make.left.equalTo(_imgView.mas_right).offset(10 * WIDTH_MULTIPLE);
        make.right.equalTo(self);
        make.height.mas_equalTo(20 * WIDTH_MULTIPLE);
    }];
}

#pragma mark - lazyload
- (UIImageView *)imgView{
    
    if (!_imgView) {
        
        _imgView = [UIImageView new];
        _imgView.image = [UIImage imageNamed:@"depositWait"];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgView;
}

- (UILabel *)applyLabel{
    
    if (!_applyLabel) {
        
        _applyLabel = [[UILabel alloc] init];
        _applyLabel.font = KFitFont(14);
        _applyLabel.textColor = KAPP_THEME_COLOR;
        _applyLabel.numberOfLines = 0;
        _applyLabel.textAlignment = NSTextAlignmentLeft;
        _applyLabel.text = @"提现申请已提交，等待处理中";
    }
    return _applyLabel;
}

- (UILabel *)amountLabel{
    
    if (!_amountLabel) {
        
        _amountLabel = [[UILabel alloc] init];
        _amountLabel.font = KFitFont(14);
        _amountLabel.textColor = KAPP_b7b7b7_COLOR;
        _amountLabel.numberOfLines = 0;
        _amountLabel.textAlignment = NSTextAlignmentLeft;
        _amountLabel.text = @"100000000元";
    }
    return _amountLabel;
}

- (UILabel *)reachLabel{
    
    if (!_reachLabel) {
        
        _reachLabel = [[UILabel alloc] init];
        _reachLabel.font = KFitFont(14);
        _reachLabel.textColor = KAPP_272727_COLOR;
        _reachLabel.numberOfLines = 0;
        _reachLabel.textAlignment = NSTextAlignmentLeft;
        _reachLabel.text = @"预计24小时内到账";
    }
    return _reachLabel;
}

@end

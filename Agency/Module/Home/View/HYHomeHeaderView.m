//
//  HYHomeHeaderView.m
//  Agency
//
//  Created by 胡勇 on 2017/11/2.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYHomeHeaderView.h"

@interface HYHomeHeaderView()

/** 收益 */
@property (nonatomic,strong) UILabel *earningLabel;
/** 深颜色背景 */
@property (nonatomic,strong) UIView *deepBgView;


@end

@implementation HYHomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.earningLabel];
    [self addSubview:self.moneyLabel];
    [self addSubview:self.deepBgView];
    [self addSubview:self.headerImgView];
    [self addSubview:self.nickNameLabel];
    [self addSubview:self.clientNumLabel];
    [self addSubview:self.myTeamsBtn];
}

- (void)layoutSubviews{
    
    [_earningLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(18 * WIDTH_MULTIPLE);
        make.top.equalTo(self).offset(15 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(25 * WIDTH_MULTIPLE);
        make.right.equalTo(self);
    }];
    
    [_deepBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(50 * WIDTH_MULTIPLE);
    }];
    
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_earningLabel);
        make.top.equalTo(_earningLabel.mas_bottom).offset(16 * WIDTH_MULTIPLE);
        make.right.equalTo(self);
        make.bottom.equalTo(_deepBgView.mas_top).offset(-5 * WIDTH_MULTIPLE);
    }];
    
    [_headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_earningLabel);
        make.size.mas_equalTo(CGSizeMake(40 * WIDTH_MULTIPLE, 40 * WIDTH_MULTIPLE));
        make.centerY.equalTo(_deepBgView);
    }];
    
    [_myTeamsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self).offset(-18 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(80 * WIDTH_MULTIPLE, 30 * WIDTH_MULTIPLE));
        make.centerY.equalTo(_deepBgView);
    }];
    
    [_clientNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(_myTeamsBtn.mas_left).offset(-12 * WIDTH_MULTIPLE);
        make.top.bottom.equalTo(_deepBgView);
        make.width.mas_equalTo(40 * WIDTH_MULTIPLE);
    }];
    
    [_nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_headerImgView.mas_right).offset(8 * WIDTH_MULTIPLE);
        make.top.bottom.equalTo(_deepBgView);
        make.right.equalTo(_clientNumLabel.mas_left).offset(-8 * WIDTH_MULTIPLE);
    }];
}

#pragma mark - lazyload
- (UILabel *)earningLabel{
    
    if (!_earningLabel) {
        
        _earningLabel = [[UILabel alloc] init];
        _earningLabel.font = KFitFont(25);
        _earningLabel.textColor = KAPP_WHITE_COLOR;
        _earningLabel.text = @"我的工资";
        _earningLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _earningLabel;
}

- (UILabel *)moneyLabel{
    
    if (!_moneyLabel) {
        
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.font = KFitFont(39);
        _moneyLabel.textColor = KAPP_WHITE_COLOR;
        _moneyLabel.text = @"$99887755.33";
        _moneyLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _moneyLabel;
}

- (UIView *)deepBgView{
    
    if (!_deepBgView) {
        
        _deepBgView = [UIView new];
        _deepBgView.backgroundColor = KCOLOR(@"28816f");
    }
    return _deepBgView;
}

- (UIImageView *)headerImgView{
    
    if (!_headerImgView) {
        
        _headerImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_placeholder"]];
        [_headerImgView sd_setImageWithURL:[NSURL URLWithString:[HYUserModel sharedInstance].userInfo.head_image_url] placeholderImage:[UIImage imageNamed:@"user_placeholder"]];
        _headerImgView.contentMode = UIViewContentModeScaleAspectFill;
        _headerImgView.layer.cornerRadius = 20 * WIDTH_MULTIPLE;
        _headerImgView.clipsToBounds = YES;
    }
    return _headerImgView;
}

- (UILabel *)nickNameLabel{
    
    if (!_nickNameLabel) {
        
        _nickNameLabel = [[UILabel alloc] init];
        _nickNameLabel.font = KFitFont(16);
        _nickNameLabel.textColor = KAPP_WHITE_COLOR;
        _nickNameLabel.text = @"未登录请登录";
        _nickNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nickNameLabel;
}

- (UILabel *)clientNumLabel{
    
    if (!_clientNumLabel) {
        
        _clientNumLabel = [[UILabel alloc] init];
        _clientNumLabel.font = KFitFont(11);
        _clientNumLabel.textColor = KAPP_WHITE_COLOR;
        _clientNumLabel.text = @"客户数\n+00";
        _clientNumLabel.numberOfLines = 0;
        _clientNumLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _clientNumLabel;
}

- (UIButton *)myTeamsBtn{
    
    if (!_myTeamsBtn) {
        
        _myTeamsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _myTeamsBtn.layer.cornerRadius = 4 * WIDTH_MULTIPLE;
        _myTeamsBtn.layer.borderColor = KAPP_WHITE_COLOR.CGColor;
        _myTeamsBtn.layer.borderWidth = WIDTH_MULTIPLE;
        _myTeamsBtn.titleLabel.font = KFitFont(14);
        [_myTeamsBtn setTitle:@"我的团队" forState:UIControlStateNormal];
        _myTeamsBtn.backgroundColor = _deepBgView.backgroundColor;
    }
    return _myTeamsBtn;
}

@end

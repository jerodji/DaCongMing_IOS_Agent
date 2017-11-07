//
//  HYSelectInfoHeaderView.m
//  Agency
//
//  Created by 胡勇 on 2017/11/7.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYSelectInfoHeaderView.h"

@interface HYSelectInfoHeaderView()

@property (nonatomic,strong) UIImageView *backImgView;
@property (nonatomic,strong) UIButton *backBtn;
/** 跳过 */
@property (nonatomic,strong) UIButton *skipBtn;

@end

@implementation HYSelectInfoHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.backImgView];
    [self addSubview:self.backBtn];
    [self addSubview:self.skipBtn];
}

- (void)layoutSubviews{
    
    [_backImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self);
    }];
    
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(self).offset(30 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(30 * WIDTH_MULTIPLE, 30 * WIDTH_MULTIPLE));
    }];
    
    [_skipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.top.equalTo(self).offset(30 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(60 * WIDTH_MULTIPLE, 20 * WIDTH_MULTIPLE));
    }];
}

#pragma mark - lazyload
- (UIImageView *)backImgView{
    
    if (!_backImgView) {
        
        _backImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _backImgView.image = [UIImage imageNamed:@"selectInfo_header"];
        _backImgView.contentMode = UIViewContentModeScaleAspectFill;
        _backImgView.clipsToBounds = YES;
    }
    return _backImgView;
}

- (UIButton *)backBtn{
    
    if (!_backBtn) {
        
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"back_black"] forState:UIControlStateNormal];

    }
    return _backBtn;
}

- (UIButton *)skipBtn{
    
    if (!_skipBtn) {
        
        _skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _skipBtn.backgroundColor = KAPP_b7b7b7_COLOR;
        [_skipBtn setTitle:@"跳过" forState:UIControlStateNormal];
        _skipBtn.titleLabel.font = KFitFont(14);
        _skipBtn.layer.cornerRadius = 10 * WIDTH_MULTIPLE;
        _skipBtn.layer.masksToBounds = YES;
        [_skipBtn setTitleColor:KAPP_WHITE_COLOR forState:UIControlStateNormal];
    }
    return _skipBtn;
}

@end

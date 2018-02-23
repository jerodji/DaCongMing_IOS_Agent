//
//  HYHomeBottomView.m
//  Agency
//
//  Created by 胡勇 on 2017/11/2.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYHomeBottomView.h"

@interface HYHomeBottomView()

@property (nonatomic,strong) UIImageView *iconImgView;
@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation HYHomeBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.iconImgView];
    [self addSubview:self.titleLabel];
}

- (void)layoutSubviews{
    
    [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(20 * WIDTH_MULTIPLE);
        make.centerY.equalTo(self);
        make.width.equalTo(@30);
        make.height.mas_equalTo(30);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.iconImgView.mas_right).offset(10 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
    }];
}

#pragma mark - lazyload
- (UIImageView *)iconImgView{
    
    if (!_iconImgView) {
        
        _iconImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"horn"]];
        _iconImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconImgView;
}

- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = KFitFont(12);
        _titleLabel.textColor = KAPP_WHITE_COLOR;
        _titleLabel.text = @"温馨提示:提现到银行卡的到账一般为三个工作日";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end

//
//  HYDispoitHeaderView.m
//  Agency
//
//  Created by 胡勇 on 2017/11/8.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYDispoitHeaderView.h"

@interface HYDispoitHeaderView()

/** icon */
@property (nonatomic,strong) UIImageView *iconImgView;
/** tipsLabel */
@property (nonatomic,strong) UILabel *tipsLabel;

@end

@implementation HYDispoitHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = KAPP_WHITE_COLOR;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.iconImgView];
    [self addSubview:self.tipsLabel];
}

- (void)layoutSubviews{
    
    [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(40 * WIDTH_MULTIPLE, 40 * WIDTH_MULTIPLE));
    }];
    
    [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_iconImgView.mas_right).offset(10 * WIDTH_MULTIPLE);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(200 * WIDTH_MULTIPLE, 40 * WIDTH_MULTIPLE));
    }];
}

#pragma mark - lazyload
- (UIImageView *)iconImgView{
    
    if (!_iconImgView) {
        
        _iconImgView = [UIImageView new];
        _iconImgView.image = [UIImage imageNamed:@"weChat_theme"];
        _iconImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconImgView;
}

- (UILabel *)tipsLabel{
    
    if (!_tipsLabel) {
        
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.font = KFitFont(14);
        _tipsLabel.textAlignment = NSTextAlignmentLeft;
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:@"提现至微信\n(微信登录账户)"];
        [attributeStr addAttributes:@{NSFontAttributeName : KFitFont(14),NSForegroundColorAttributeName : KAPP_272727_COLOR} range:NSMakeRange(0, attributeStr.length)];
        [attributeStr addAttributes:@{NSFontAttributeName : KFitFont(14),NSForegroundColorAttributeName : KAPP_7b7b7b_COLOR} range:NSMakeRange(5, attributeStr.length - 5)];
        _tipsLabel.numberOfLines = 0;
        _tipsLabel.attributedText = attributeStr;
    }
    return _tipsLabel;
}

@end

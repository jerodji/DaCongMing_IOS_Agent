//
//  HYNoAccessView.m
//  Agency
//
//  Created by 胡勇 on 2017/11/3.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYNoAccessView.h"

@interface HYNoAccessView()

/** 半透明背景 */
@property (nonatomic,strong) UIView *blackBgView;
/** 白色背景 */
@property (nonatomic,strong) UIView *bgView;
/** 无权限背景 */
@property (nonatomic,strong) UIView *noAccesssHeaderView;
/** 无权限 */
@property (nonatomic,strong) UIImageView *noAccessHeaderImgView;
/** 提示 */
@property (nonatomic,strong) UILabel *tipsLabel;


@end

@implementation HYNoAccessView

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
        make.centerY.equalTo(self).offset(-KSCREEN_HEIGHT);
        make.size.mas_equalTo(CGSizeMake(240 * WIDTH_MULTIPLE, 250 * WIDTH_MULTIPLE));
    }];
    
    [self addSubview:self.noAccesssHeaderView];
    [self addSubview:self.noAccessHeaderImgView];
    [self addSubview:self.tipsLabel];
    [self addSubview:self.joinBtn];
}

- (void)layoutSubviews{
    
    [_blackBgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self);
    }];
    
    
    [_noAccesssHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.right.equalTo(_bgView);
        make.height.mas_equalTo(106 * WIDTH_MULTIPLE);
    }];
    
    [_noAccessHeaderImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(_noAccesssHeaderView);
    }];
    
    [_joinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(_bgView).offset(-18 * WIDTH_MULTIPLE);
        make.left.equalTo(_bgView).offset(28 * WIDTH_MULTIPLE);
        make.right.equalTo(_bgView).offset(-28 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(40 * WIDTH_MULTIPLE);
    }];
    
    [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_noAccessHeaderImgView.mas_bottom);
        make.left.right.equalTo(_bgView);
        make.bottom.equalTo(_joinBtn.mas_top);
    }];
    
}

#pragma mark - publicMethod
- (void)showNoAccessView{
    
    [UIView animateWithDuration:0.4 animations:^{
        
        _blackBgView.alpha = 0.6;
       
        [_bgView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(240 * WIDTH_MULTIPLE, 250 * WIDTH_MULTIPLE));
        }];
        
        [self layoutIfNeeded];
    }];
}

- (void)hideNOAccessView{
    
    [UIView animateWithDuration:0.3 animations:^{
       
        _blackBgView.alpha = 0;
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self);
            make.top.equalTo(self.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(240 * WIDTH_MULTIPLE, 250 * WIDTH_MULTIPLE));
        }];
    }];
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
        _bgView.layer.cornerRadius = 4 * WIDTH_MULTIPLE;
        _bgView.clipsToBounds = YES;
    }
    return _bgView;
}

- (UIView *)noAccesssHeaderView{
    
    if (!_noAccesssHeaderView) {
        
        _noAccesssHeaderView = [UIView new];
        _noAccesssHeaderView.backgroundColor = KAPP_THEME_COLOR;
        _noAccesssHeaderView.layer.cornerRadius = 4 * WIDTH_MULTIPLE;
        _noAccesssHeaderView.clipsToBounds = YES;
    }
    return _noAccesssHeaderView;
}

- (UIImageView *)noAccessHeaderImgView{
    
    if (!_noAccessHeaderImgView) {
        
        _noAccessHeaderImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _noAccessHeaderImgView.image = [UIImage imageNamed:@"noAccess_header"];
        _noAccessHeaderImgView.contentMode = UIViewContentModeScaleAspectFill;
        _noAccessHeaderImgView.clipsToBounds = YES;
    }
    return _noAccessHeaderImgView;
}

- (UILabel *)tipsLabel{
    
    if (!_tipsLabel) {
        
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.font = KFitFont(18);
        _tipsLabel.textColor = KAPP_WHITE_COLOR;
        _tipsLabel.numberOfLines = 0;
        _tipsLabel.text = @"有钱就是任性";
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        NSString *str = @"加入大聪明获取权限\n(大聪明 大财富)";
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attributeStr addAttributes:@{NSFontAttributeName : KFitFont(18) , NSForegroundColorAttributeName : KAPP_272727_COLOR} range:NSMakeRange(0, 9)];
        [attributeStr addAttributes:@{NSFontAttributeName : KFitFont(16) , NSForegroundColorAttributeName : KAPP_b7b7b7_COLOR} range:NSMakeRange(9, str.length - 9)];
        _tipsLabel.attributedText = attributeStr;
    }
    return _tipsLabel;
}

- (UIButton *)joinBtn{
    
    if (!_joinBtn) {
        
        _joinBtn = [[UIButton alloc] init];
        [_joinBtn setTitle:@"立即加入" forState:UIControlStateNormal];
        _joinBtn.titleLabel.font = KFitFont(18);
        _joinBtn.backgroundColor = KAPP_THEME_COLOR;
        _joinBtn.layer.cornerRadius = 20 * WIDTH_MULTIPLE;
        _joinBtn.layer.masksToBounds = YES;
        [_joinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _joinBtn;
}

@end

//
//  HYMyTeamHeaderView.m
//  Agency
//
//  Created by Jack on 2017/11/17.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYMyTeamHeaderView.h"

@interface HYMyTeamHeaderView ()

@property (nonatomic,strong) UIImageView *bgImageView;
@property (nonatomic,strong) UILabel *numberLabel;
//@property (nonatomic,strong) UILabel *teamMemberLabel;

@property (nonatomic,strong) UIView *whiteBgView;

@end

@implementation HYMyTeamHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.bgImageView];
    [self addSubview:self.headerImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.numberLabel];
}

- (void)layoutSubviews{
    
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(200 * WIDTH_MULTIPLE);
    }];
    
    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self).offset(60 * WIDTH_MULTIPLE);
        make.size.mas_offset(CGSizeMake(70 * WIDTH_MULTIPLE, 70 * WIDTH_MULTIPLE));
        make.centerX.equalTo(self);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_headerImageView.mas_bottom).offset(8 * WIDTH_MULTIPLE);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(20 * WIDTH_MULTIPLE);
    }];
    
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_titleLabel.mas_bottom).offset(10 * WIDTH_MULTIPLE);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(20 * WIDTH_MULTIPLE);
    }];
    
    [_whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self);
        make.top.equalTo(_bgImageView.mas_bottom);
        make.height.mas_equalTo(75 * WIDTH_MULTIPLE);
    }];
    
//    [_teamMemberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.right.equalTo(self);
//        make.top.equalTo(_whiteBgView.mas_bottom).offset(10 * WIDTH_MULTIPLE);
//        make.bottom.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
//    }];
    
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self).offset(0);
        make.top.equalTo(_whiteBgView.mas_bottom).offset(10 * WIDTH_MULTIPLE);
        make.bottom.equalTo(self).offset(-2);
//        make.width.mas_equalTo(KSCREEN_WIDTH/2);
    }];
    
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_leftBtn.mas_right).offset(0);
        make.right.equalTo(self).offset(0);
        make.top.equalTo(_whiteBgView.mas_bottom).offset(10 * WIDTH_MULTIPLE);
        make.bottom.equalTo(self).offset(-2);
        make.width.equalTo(_leftBtn);
    }];
}

- (void)setIsShowBtn:(BOOL)isShowBtn{
    
    _isShowBtn = isShowBtn;
    if (self.isShowBtn) {
        
        [self addSubview:self.whiteBgView];
//        [self addSubview:self.teamMemberLabel];
        [self createButton];
        
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.backgroundColor = [UIColor whiteColor];
        _leftBtn.titleLabel.font = KFitFont(14);
        _leftBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_leftBtn setTitle:@"团队成员" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:KAPP_7b7b7b_COLOR forState:UIControlStateNormal];
        [self addSubview:_leftBtn];
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.backgroundColor = [UIColor whiteColor];
        _rightBtn.titleLabel.font = KFitFont(14);
        _rightBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_rightBtn setTitle:@"客户列表" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:KAPP_7b7b7b_COLOR forState:UIControlStateNormal];
        [self addSubview:_rightBtn];
    }
}

- (void)createButton{
    
    [self layoutIfNeeded];
    CGFloat itemWidth = KSCREEN_WIDTH / 3;
    
    NSArray *imageArray = @[@"info",@"group_chat",@"invite"];
    NSArray *titleArray = @[@"详情",@"群聊",@"邀请"];
    for (NSInteger i = 0; i < 3; i++) {
        
        HYButton *button = [HYButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:KAPP_THEME_COLOR forState:UIControlStateNormal];
        button.tag = 100 + i;
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(_whiteBgView).offset(14 * WIDTH_MULTIPLE);
            make.bottom.equalTo(_whiteBgView).offset(-14 * WIDTH_MULTIPLE);
            make.left.equalTo(self).offset(itemWidth * i);
            make.width.mas_equalTo(itemWidth);
        }];
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)buttonClick:(UIButton *)button{
    
    if (_delegate && [_delegate respondsToSelector:@selector(headerViewBtnClickIndex:)]) {
        
        [_delegate headerViewBtnClickIndex:button.tag - 100];
    }
}

#pragma mark - setter
- (void)setNumber:(NSString *)number{
    
    _number = number;
    
    _numberLabel.text = [NSString stringWithFormat:@"人数:%@",number];
}

#pragma mark - lazyload
- (UIImageView *)bgImageView{
    
    if (!_bgImageView) {
        
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _bgImageView.image = [UIImage imageNamed:@"wallet_header_bg"];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageView.clipsToBounds = YES;
    }
    return _bgImageView;
}

- (UIView *)whiteBgView{
    
    if (!_whiteBgView) {
        
        _whiteBgView = [UIView new];
        _whiteBgView.backgroundColor = KAPP_WHITE_COLOR;
    }
    return _whiteBgView;
}

- (UIImageView *)headerImageView{
    
    if (!_headerImageView) {
        
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _headerImageView.image = [UIImage imageNamed:@"user_placeholder"];
        _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headerImageView.layer.cornerRadius = 35 * WIDTH_MULTIPLE;
        _headerImageView.clipsToBounds = YES;
    }
    return _headerImageView;
}

- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"阿贾克斯的球队";
        _titleLabel.font = KFitFont(17);
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = KAPP_WHITE_COLOR;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)numberLabel{
    
    if (!_numberLabel) {
        
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.text = @"人数:+∞";
        _numberLabel.font = KFitFont(15);
        _numberLabel.numberOfLines = 0;
        _numberLabel.textColor = KAPP_WHITE_COLOR;
        _numberLabel.backgroundColor = [UIColor clearColor];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _numberLabel;
}

//- (UILabel *)teamMemberLabel{
//
//    if (!_teamMemberLabel) {
//
//        _teamMemberLabel = [[UILabel alloc] init];
//        _teamMemberLabel.text = @"    团队成员";
//        _teamMemberLabel.font = KFitFont(14);
//        _teamMemberLabel.numberOfLines = 0;
//        _teamMemberLabel.textColor = KAPP_7b7b7b_COLOR;
//        _teamMemberLabel.backgroundColor = [UIColor whiteColor];
//        _teamMemberLabel.textAlignment = NSTextAlignmentLeft;
//    }
//    return _teamMemberLabel;
//}





@end

//
//  HYHomeView.m
//  Agency
//
//  Created by 胡勇 on 2017/11/2.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYHomeView.h"
#import "HYHomeHeaderView.h"
#import "HYHomeMiddleView.h"
#import "HYHomeBottomView.h"
#import "HYHomeBtnView.h"

@interface HYHomeView()

/** 背景 */
@property (nonatomic,strong) UIImageView *bgImageView;

@property (nonatomic,strong) HYHomeHeaderView *headerView;
@property (nonatomic,strong) HYHomeMiddleView *middleView;
@property (nonatomic,strong) HYHomeBtnView *buttonView;
@property (nonatomic,strong) HYHomeBottomView *bottomView;
/** viewModel */
@property (nonatomic,strong) HYHomeViewModel *viewModel;


@end

@implementation HYHomeView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.bgImageView];
    [self addSubview:self.headerView];
    [self addSubview:self.middleView];
    [self addSubview:self.buttonView];
    [self addSubview:self.bottomView];
}

- (void)layoutSubviews{
    
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self);
    }];
    
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(15 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-15 * WIDTH_MULTIPLE);
        make.top.equalTo(self).offset(KSTATUSBAR_HEIGHT + 20 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(170 * WIDTH_MULTIPLE);
    }];
    
    [_middleView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(_headerView);
        make.top.equalTo(_headerView.mas_bottom).offset(15 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(74 * WIDTH_MULTIPLE);
    }];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(_headerView);
        make.bottom.equalTo(self).offset(-15 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(40 * WIDTH_MULTIPLE);
    }];
    
    [_buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(_headerView);
        make.top.equalTo(_middleView.mas_bottom).offset(20 * WIDTH_MULTIPLE);
        make.bottom.equalTo(_bottomView.mas_top).offset(-40 * WIDTH_MULTIPLE);
    }];
}

#pragma mark - setViewModel
- (void)setWithViewModel:(HYHomeViewModel *)viewModel{
    
    self.viewModel = viewModel;
    
    RAC(self.headerView.moneyLabel,text) = [RACObserve(viewModel, money) map:^id(id value) {
        
        return [NSString stringWithFormat:@"￥%@",value];
    }];
    
    //绑定数据
    [RACObserve(viewModel,headImgUrlStr) subscribeNext:^(NSString *headImgUrlStr) {
        
        [_headerView.headerImgView sd_setImageWithURL:[NSURL URLWithString:headImgUrlStr] placeholderImage:[UIImage imageNamed:@"user_placeholder"]];
    }];
    
    [RACObserve(viewModel, nickName) subscribeNext:^(id x) {
       
        if ([x isNotBlank]) {
            
            _headerView.nickNameLabel.text = x;
        }
        else{
            
            _headerView.nickNameLabel.text = @"未登录";
        }
    }];
    
    //点击按钮的信号
    [[_headerView.myTeamsBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribe:viewModel.jumpToMyTeam];
    
    [[_middleView.reportBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribe:viewModel.jumpToReportVC];
    [[_middleView.bankCardBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribe:viewModel.jumpToBankCardVC];
    [[_middleView.authBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribe:viewModel.jumpToAuthVC];
    
    [_buttonView setWithViewModel:viewModel];
}

#pragma mark - lazyload
- (UIImageView *)bgImageView{
    
    if (!_bgImageView) {
        
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _bgImageView.image = [UIImage imageNamed:@"login_bg"];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageView.clipsToBounds = YES;
    }
    return _bgImageView;
}

- (HYHomeHeaderView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [HYHomeHeaderView new];
        _headerView.backgroundColor = KCOLOR(@"45d0b7");
        _headerView.layer.cornerRadius = 4 * WIDTH_MULTIPLE;
        
    }
    return _headerView;
}

- (HYHomeMiddleView *)middleView{
    
    if (!_middleView) {
        
        _middleView = [HYHomeMiddleView new];
        _middleView.backgroundColor = [UIColor colorWithRGB:0x64b9aa alpha:0.4];
        _middleView.layer.cornerRadius = 4 * WIDTH_MULTIPLE;
        _middleView.layer.borderColor = KCOLOR(@"46d0b7").CGColor;
        _middleView.layer.borderWidth = 2 * WIDTH_MULTIPLE;
    }
    return _middleView;
}

- (HYHomeBtnView *)buttonView{
    
    if (!_buttonView) {
        
        _buttonView = [HYHomeBtnView new];
        _buttonView.backgroundColor = [UIColor clearColor];
    }
    return _buttonView;
}

- (HYHomeBottomView *)bottomView{
    
    if (!_bottomView) {

        _bottomView = [HYHomeBottomView new];
        _bottomView.backgroundColor = [UIColor colorWithRGB:0x64b9aa alpha:0.4];
    }
    return _bottomView;
}

@end

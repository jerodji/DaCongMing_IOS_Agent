//
//  HYMyWalletHeaderCell.m
//  Agency
//
//  Created by 胡勇 on 2017/11/8.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYMyWalletHeaderCell.h"

@interface HYMyWalletHeaderCell()

/** 背景 */
@property (nonatomic,strong) UIImageView *bgImageView;
@property (nonatomic,strong) UIButton *backBtn;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *saleAmountLabel;
/** 背景 */
@property (nonatomic,strong) UIView *labelBgView;
/** 佣金 */
@property (nonatomic,strong) UILabel *commissionLabel;
/** 佣金余额 */
@property (nonatomic,strong) UILabel *commissionBalanceLabel;
/** 本月销售额 */
@property (nonatomic,strong) UILabel *thisMonthAmoutnLabel;
/** 本月佣金 */
@property (nonatomic,strong) UILabel *thisMonthCommissionLabel;
/** 今日销售额 */
@property (nonatomic,strong) UILabel *todayAmoutnLabel;
@property (nonatomic,strong) NSMutableArray *titleArray;

@end

@implementation HYMyWalletHeaderCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.bgImageView];
    [self addSubview:self.backBtn];
    [self addSubview:self.titleLabel];
    [self addSubview:self.saleAmountLabel];
    [self addSubview:self.commissionLabel];
    [self addSubview:self.commissionBalanceLabel];
    [self addSubview:self.labelBgView];
    [self addSubview:self.thisMonthAmoutnLabel];
    [self addSubview:self.thisMonthCommissionLabel];
    [self addSubview:self.todayAmoutnLabel];
}


- (void)layoutSubviews{
    
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self);
    }];
    
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self);
        make.top.equalTo(self).offset(20 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(30 * WIDTH_MULTIPLE, 30 * WIDTH_MULTIPLE));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.height.equalTo(_backBtn);
        make.width.mas_equalTo(100 * WIDTH_MULTIPLE);
        make.centerX.equalTo(self);
    }];
    
    [_saleAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(20 * WIDTH_MULTIPLE);
        make.top.equalTo(self).offset(75 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(30 * WIDTH_MULTIPLE);
        make.right.equalTo(self);
    }];
    
    [_commissionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.height.equalTo(_saleAmountLabel);
        make.top.equalTo(_saleAmountLabel.mas_bottom);
    }];
    
    [_commissionBalanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(_saleAmountLabel);
        make.top.equalTo(_commissionLabel.mas_bottom).offset(20 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(40 * WIDTH_MULTIPLE);
    }];
    
    [_labelBgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(60 * WIDTH_MULTIPLE);
    }];
    
    [_thisMonthAmoutnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.bottom.equalTo(self);
        make.size.mas_offset(CGSizeMake(KSCREEN_WIDTH / 3, 60 * WIDTH_MULTIPLE));
    }];
    
    [_thisMonthCommissionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self);
        make.left.equalTo(_thisMonthAmoutnLabel.mas_right);
        make.size.mas_offset(CGSizeMake(KSCREEN_WIDTH / 3, 60 * WIDTH_MULTIPLE));
    }];
    
    [_todayAmoutnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self);
        make.left.equalTo(_thisMonthCommissionLabel.mas_right);
        make.size.mas_offset(CGSizeMake(KSCREEN_WIDTH / 3, 60 * WIDTH_MULTIPLE));
    }];
}

#pragma mark - setViewModel
- (void)setWithViewModel:(HYMyWalletViewModel *)viewModel{
    
    RAC(self.saleAmountLabel, text) = [RACObserve(viewModel, acc_totalSales) map:^id(id value) {
        
        return [NSString stringWithFormat:@"销售总额: %@",value];
    }];
    
    RAC(self.commissionLabel, text) = [RACObserve(viewModel, acc_totalCommission) map:^id(id value) {
        
        return [NSString stringWithFormat:@"累计佣金: %@",value];
    }];
    
    RAC(self.commissionBalanceLabel, attributedText) = [RACObserve(viewModel, balance) map:^id(id value) {
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"累计余额: %@",value]];
        NSRange strRange = {0,[str length]};
        [str addAttribute:NSFontAttributeName value:KFitFont(30) range:strRange];
        [str addAttribute:NSFontAttributeName value:KFitFont(22) range:NSMakeRange(0, 5)];
        return str;
    }];
    
    RAC(self.thisMonthAmoutnLabel, text) = [RACObserve(viewModel, thisMonthSales) map:^id(id value) {
        
        return [NSString stringWithFormat:@"本月销售额(元)\n%@",value];
    }];
    
    RAC(self.thisMonthCommissionLabel, text) = [RACObserve(viewModel, thisMonthCommission) map:^id(id value) {
        
        return [NSString stringWithFormat:@"本月佣金收入(元)\n%@",value];
    }];
    
    RAC(self.todayAmoutnLabel, text) = [RACObserve(viewModel, todaySales) map:^id(id value) {
        
        return [NSString stringWithFormat:@"本月销售额(元)\n%@",value];
    }];
    
    [[_backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribe:viewModel.backActionSubject];
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

- (UIButton *)backBtn{
    
    if (!_backBtn) {
        
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    }
    return _backBtn;
}

- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"钱包";
        _titleLabel.font = KFitFont(18);
        _titleLabel.textColor = KAPP_WHITE_COLOR;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)saleAmountLabel{
    
    if (!_saleAmountLabel) {
        
        _saleAmountLabel = [[UILabel alloc] init];
        _saleAmountLabel.text = @"销售总额:￥多的吓死你";
        _saleAmountLabel.font = KFitFont(22);
        _saleAmountLabel.textColor = KAPP_WHITE_COLOR;
        _saleAmountLabel.backgroundColor = [UIColor clearColor];
        _saleAmountLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _saleAmountLabel;
}

- (UILabel *)commissionLabel{
    
    if (!_commissionLabel) {
        
        _commissionLabel = [[UILabel alloc] init];
        _commissionLabel.text = @"累计佣金:￥998877";
        _commissionLabel.font = KFitFont(22);
        _commissionLabel.textColor = KAPP_WHITE_COLOR;
        _commissionLabel.backgroundColor = [UIColor clearColor];
        _commissionLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _commissionLabel;
}

- (UILabel *)commissionBalanceLabel{
    
    if (!_commissionBalanceLabel) {
        
        _commissionBalanceLabel = [[UILabel alloc] init];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"账户余额:￥多的无法显示"];
        NSRange strRange = {0,[str length]};
        [str addAttribute:NSFontAttributeName value:KFitFont(30) range:strRange];
        [str addAttribute:NSFontAttributeName value:KFitFont(22) range:NSMakeRange(0, 5)];
        _commissionBalanceLabel.attributedText = str;
        _commissionBalanceLabel.textColor = KAPP_WHITE_COLOR;
        _commissionBalanceLabel.backgroundColor = [UIColor clearColor];
        _commissionBalanceLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _commissionBalanceLabel;
}

- (UIView *)labelBgView{
    
    if (!_labelBgView) {
        
        _labelBgView = [UIView new];
        _labelBgView.backgroundColor = KAPP_BLACK_COLOR;
        _labelBgView.alpha = 0.3;
    }
    return _labelBgView;
}

- (UILabel *)thisMonthAmoutnLabel{
    
    if (!_thisMonthAmoutnLabel) {
        
        _thisMonthAmoutnLabel = [[UILabel alloc] init];
        _thisMonthAmoutnLabel.text = @"本月销售额(元)\n12306";
        _thisMonthAmoutnLabel.font = KFitFont(13);
        _thisMonthAmoutnLabel.textColor = KAPP_WHITE_COLOR;
        _thisMonthAmoutnLabel.numberOfLines = 0;
        _thisMonthAmoutnLabel.backgroundColor = [UIColor clearColor];
        _thisMonthAmoutnLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _thisMonthAmoutnLabel;
}

- (UILabel *)thisMonthCommissionLabel{
    
    if (!_thisMonthCommissionLabel) {
        
        _thisMonthCommissionLabel = [[UILabel alloc] init];
        _thisMonthCommissionLabel.text = @"本月佣金收入(元)\n12306";
        _thisMonthCommissionLabel.font = KFitFont(13);
        _thisMonthCommissionLabel.textColor = KAPP_WHITE_COLOR;
        _thisMonthCommissionLabel.numberOfLines = 0;
        _thisMonthCommissionLabel.backgroundColor = [UIColor clearColor];
        _thisMonthCommissionLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _thisMonthCommissionLabel;
}

- (UILabel *)todayAmoutnLabel{
    
    if (!_todayAmoutnLabel) {
        
        _todayAmoutnLabel = [[UILabel alloc] init];
        _todayAmoutnLabel.text = @"今日销售额(元)\n12306";
        _todayAmoutnLabel.font = KFitFont(13);
        _todayAmoutnLabel.textColor = KAPP_WHITE_COLOR;
        _todayAmoutnLabel.numberOfLines = 0;
        _todayAmoutnLabel.backgroundColor = [UIColor clearColor];
        _todayAmoutnLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _todayAmoutnLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

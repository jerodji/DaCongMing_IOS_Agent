//
//  HYBankInfoTableViewCell.m
//  Agency
//
//  Created by Jack on 2017/11/16.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBankInfoTableViewCell.h"
#import "UILabel+HYJustifyAlign.h"

@interface HYBankInfoTableViewCell ()

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIImageView *iconImgView;
@property (nonatomic,strong) UILabel *bankNameLabel;
@property (nonatomic,strong) UILabel *bankNoLabel;
@property (nonatomic,strong) UIButton *relieveBindBtn;
@property (nonatomic,strong) UILabel *addTimeLabel;
@property (nonatomic,strong) UITextView *textView;

@end

@implementation HYBankInfoTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.bgView];
    [self addSubview:self.iconImgView];
    [self addSubview:self.bankNameLabel];
    [self addSubview:self.textView];
    [self addSubview:self.bankNoLabel];
    [self addSubview:self.relieveBindBtn];
    [self addSubview:self.addTimeLabel];
}

- (void)layoutSubviews{
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.bottom.equalTo(self);
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
    }];
    
    [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.equalTo(_bgView).offset(15 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(40 * WIDTH_MULTIPLE, 40 * WIDTH_MULTIPLE));
    }];
    
    [_bankNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_iconImgView.mas_right).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(_iconImgView);
        make.width.mas_equalTo(200 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(40 * WIDTH_MULTIPLE);
    }];
    
    [_bankNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(_bgView).offset(-15 * WIDTH_MULTIPLE);
        make.top.equalTo(_iconImgView.mas_bottom).offset(25 * WIDTH_MULTIPLE);
        make.left.equalTo(_iconImgView);
        make.height.mas_equalTo(30 * WIDTH_MULTIPLE);
    }];
    
    [_addTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(_bgView).offset(-15 * WIDTH_MULTIPLE);
        make.top.equalTo(_bankNoLabel.mas_bottom).offset(16 * WIDTH_MULTIPLE);
        make.left.equalTo(_iconImgView);
        make.height.mas_equalTo(20 * WIDTH_MULTIPLE);
    }];
    
    [_relieveBindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_iconImgView);
        make.right.equalTo(_bgView).offset(-10 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(80 * WIDTH_MULTIPLE, 25 * WIDTH_MULTIPLE));
    }];
}

#pragma mark - setViewModel
- (void)setupWithCellModel:(HYBankCardCellModel *)cellModel{
    
    RAC(self.bankNameLabel,text) = [RACObserve(cellModel, bank_name) map:^id(id value) {
       
        return [NSString stringWithFormat:@"%@\n储蓄卡",cellModel.bank_name];
    }];
    
    RAC(self.bankNoLabel,text) = [RACObserve(cellModel, bankcard_id) map:^id(id value) {
       
        return [cellModel.bankcard_id stringByReplacingCharactersInRange:NSMakeRange(4, 9) withString:@" **** *** *** "];
    }];
    
    [_bankNoLabel LabelAlightLeftAndRightWithWidth:KSCREEN_WIDTH - 60 * WIDTH_MULTIPLE];
    
    [[_relieveBindBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       
        [cellModel relieveBind];
    }];
}

#pragma mark - lazyload
- (UIView *)bgView{
    
    if (!_bgView) {
        
        _bgView = [UIView new];
        _bgView.backgroundColor = KAPP_WHITE_COLOR;
        _bgView.layer.cornerRadius = 8 * WIDTH_MULTIPLE;
    }
    return _bgView;
}

- (UIImageView *)iconImgView{
    
    if (!_iconImgView) {
        
        _iconImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _iconImgView.image = [UIImage imageNamed:@"icbc_icon"];
        _iconImgView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    return _iconImgView;
}

- (UILabel *)bankNameLabel{
    
    if (!_bankNameLabel) {
        
        _bankNameLabel = [[UILabel alloc] init];
        _bankNameLabel.text = @"中国工商银行\n储蓄卡";
        _bankNameLabel.font = KFitFont(14);
        _bankNameLabel.numberOfLines = 0;
        _bankNameLabel.textColor = KAPP_272727_COLOR;
        _bankNameLabel.backgroundColor = [UIColor whiteColor];
        _bankNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _bankNameLabel;
}

- (UILabel *)bankNoLabel{
    
    if (!_bankNoLabel) {
        
        _bankNoLabel = [[UILabel alloc] init];
        _bankNoLabel.text = @"6225 **** **** **** 227";
        _bankNoLabel.font = KFitFont(25);
        _bankNoLabel.textColor = KAPP_272727_COLOR;
        _bankNoLabel.backgroundColor = [UIColor whiteColor];
        _bankNoLabel.textAlignment = NSTextAlignmentLeft;
        [_bankNoLabel LabelAlightLeftAndRightWithWidth:KSCREEN_WIDTH - 60 * WIDTH_MULTIPLE];
    }
    return _bankNoLabel;
}


- (UILabel *)addTimeLabel{
    
    if (!_addTimeLabel) {
        
        _addTimeLabel = [[UILabel alloc] init];
        _addTimeLabel.text = @"添加日期:2020-02-20";
        _addTimeLabel.font = KFitFont(13);
        _addTimeLabel.textColor = KAPP_7b7b7b_COLOR;
        _addTimeLabel.backgroundColor = [UIColor whiteColor];
        _addTimeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _addTimeLabel;
}

- (UIButton *)relieveBindBtn{
    
    if (!_relieveBindBtn) {
        
        _relieveBindBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //[_relieveBindBtn setTitle:@"解除绑定" forState:UIControlStateNormal];
        [_relieveBindBtn setTitleColor:KAPP_THEME_COLOR forState:UIControlStateNormal];
        _relieveBindBtn.titleLabel.font = KFitFont(15);
        
        NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:@"解除绑定"];
        [attribute addAttributes:@{NSUnderlineStyleAttributeName : [NSNumber numberWithInteger:NSUnderlineStyleSingle],NSUnderlineColorAttributeName : KAPP_THEME_COLOR,NSForegroundColorAttributeName : KAPP_THEME_COLOR} range:NSMakeRange(0, attribute.length)];
        [_relieveBindBtn setAttributedTitle:attribute forState:UIControlStateNormal];
        
    }
    return _relieveBindBtn;
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

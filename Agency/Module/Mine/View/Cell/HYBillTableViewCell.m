//
//  HYBillTableViewCell.m
//  Agency
//
//  Created by Jack on 2017/11/16.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBillTableViewCell.h"

@interface HYBillTableViewCell ()

@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIImageView *iconImgView;
@property (nonatomic,strong) UILabel *amountLabel;
@property (nonatomic,strong) UILabel *tipsLabel;
@property (nonatomic,strong) UIView *bottomLine;

@end

@implementation HYBillTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.timeLabel];
    [self addSubview:self.iconImgView];
    [self addSubview:self.amountLabel];
    [self addSubview:self.tipsLabel];
    [self addSubview:self.bottomLine];
}

- (void)layoutSubviews{
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.bottom.equalTo(self);
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.width.mas_equalTo(60 * WIDTH_MULTIPLE);
    }];
    
    [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_timeLabel.mas_right).offset(10 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(40 * WIDTH_MULTIPLE, 40 * WIDTH_MULTIPLE));
        make.centerY.equalTo(self);
    }];
    
    [_amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_iconImgView.mas_right).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.right.equalTo(self);
        make.height.mas_equalTo(20 * WIDTH_MULTIPLE);
    }];
    
    [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(self);
        make.left.right.equalTo(_amountLabel);
        make.height.mas_equalTo(20 * WIDTH_MULTIPLE);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark - lazyload
- (UIImageView *)iconImgView{
    
    if (!_iconImgView) {
        
        _iconImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _iconImgView.image = [UIImage imageNamed:@"icbc_icon"];
        _iconImgView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    return _iconImgView;
}

- (UILabel *)timeLabel{
    
    if (!_timeLabel) {
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"今天\n18:03";
        _timeLabel.font = KFitFont(13);
        _timeLabel.numberOfLines = 0;
        _timeLabel.textColor = KAPP_b7b7b7_COLOR;
        _timeLabel.backgroundColor = [UIColor whiteColor];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLabel;
}

- (UILabel *)amountLabel{
    
    if (!_amountLabel) {
        
        _amountLabel = [[UILabel alloc] init];
        _amountLabel.text = @"+268";
        _amountLabel.font = KFitFont(18);
        _amountLabel.numberOfLines = 0;
        _amountLabel.textColor = KAPP_272727_COLOR;
        _amountLabel.backgroundColor = [UIColor whiteColor];
        _amountLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _amountLabel;
}

- (UILabel *)tipsLabel{
    
    if (!_tipsLabel) {
        
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.text = @"提现至工商银行";
        _tipsLabel.font = KFitFont(14);
        _tipsLabel.numberOfLines = 0;
        _tipsLabel.textColor = KAPP_272727_COLOR;
        _tipsLabel.backgroundColor = [UIColor whiteColor];
        _tipsLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _tipsLabel;
}

- (UIView *)bottomLine{
    
    if (!_bottomLine) {
        
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = KAPP_SEPERATOR_COLOR;
    }
    return _bottomLine;
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

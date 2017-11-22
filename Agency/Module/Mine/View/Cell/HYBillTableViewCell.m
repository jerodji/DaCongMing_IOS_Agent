//
//  HYBillTableViewCell.m
//  Agency
//
//  Created by Jack on 2017/11/16.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBillTableViewCell.h"
#import "HYDateHandle.h"

@interface HYBillTableViewCell ()

@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *amountLabel;
@property (nonatomic,strong) UILabel *briefLabel;
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
    [self addSubview:self.amountLabel];
    [self addSubview:self.briefLabel];
    [self addSubview:self.bottomLine];
}

- (void)layoutSubviews{
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(self).offset(-5 * WIDTH_MULTIPLE);
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.width.mas_equalTo(160 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(20 * WIDTH_MULTIPLE);
    }];
    

    [_amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.width.mas_equalTo(140 * WIDTH_MULTIPLE);
    }];
    
    [_briefLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_timeLabel);
        make.right.equalTo(_amountLabel.mas_left).offset(-20 * WIDTH_MULTIPLE);
        make.bottom.equalTo(_timeLabel.mas_top).offset(-10 * WIDTH_MULTIPLE);
        make.top.equalTo(self).offset(10 * WIDTH_MULTIPLE);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark - setter
- (void)setModel:(HYBillModel *)model{
    
    _model = model;
    _amountLabel.text = model.amount;
    _briefLabel.text = model.trade_type;
    
    NSString *dateF = [HYDateHandle distanceTimeWithBeforeTime:[model.create_time longValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateFormat:@"HH:MM"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[model.create_time longValue]];
    NSString *time = [formatter stringFromDate:date];
    
    _timeLabel.text = [NSString stringWithFormat:@"%@  %@",dateF,time];
}

#pragma mark - lazyload

- (UILabel *)timeLabel{
    
    if (!_timeLabel) {
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"昨天 18:03";
        _timeLabel.font = KFitFont(13);
        _timeLabel.numberOfLines = 0;
        _timeLabel.textColor = KAPP_b7b7b7_COLOR;
        _timeLabel.textAlignment = NSTextAlignmentLeft;
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
        _amountLabel.textAlignment = NSTextAlignmentRight;
    }
    return _amountLabel;
}

- (UILabel *)briefLabel{
    
    if (!_briefLabel) {
        
        _briefLabel = [[UILabel alloc] init];
        _briefLabel.text = @"提现至工商银行(闹洞房顺丰速递)";
        _briefLabel.font = KFitFont(14);
        _briefLabel.numberOfLines = 0;
        _briefLabel.textColor = KAPP_272727_COLOR;
        _briefLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _briefLabel;
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

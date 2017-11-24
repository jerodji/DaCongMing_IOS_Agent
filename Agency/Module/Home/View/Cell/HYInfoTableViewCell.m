//
//  HYInfoTableViewCell.m
//  Agency
//
//  Created by Jack on 2017/11/21.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYInfoTableViewCell.h"
#import "HYLabel.h"

@interface HYInfoTableViewCell ()

@property (nonatomic,strong) HYLabel *briefLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIImageView *thumbnailImgView;

@end

@implementation HYInfoTableViewCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.briefLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.thumbnailImgView];
}

- (void)layoutSubviews{
    
    [_thumbnailImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self).offset(8 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(110 * WIDTH_MULTIPLE, 80 * WIDTH_MULTIPLE));
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.bottom.equalTo(self).offset(-15 * WIDTH_MULTIPLE);
        make.right.equalTo(_thumbnailImgView.mas_left).offset(-20 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(20 * WIDTH_MULTIPLE);
    }];
    
    [_briefLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(self).offset(15 * WIDTH_MULTIPLE);
        make.right.equalTo(_thumbnailImgView.mas_left).offset(-20 * WIDTH_MULTIPLE);
        make.bottom.mas_equalTo(_timeLabel.mas_top).offset(-10 * WIDTH_MULTIPLE);
    }];
}

#pragma mark - setter
- (void)setModel:(HYInfomationDetailModel *)model{
    
    _model = model;
    
    _briefLabel.text = model.descriptions;
    _timeLabel.text = model.createdAt;
    [_thumbnailImgView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"Image_placeholder"]];
}

#pragma mark - lazyload
- (HYLabel *)briefLabel{
    
    if (!_briefLabel) {
        
        _briefLabel = [[HYLabel alloc] init];
        _briefLabel.font = KFitFont(15);
        _briefLabel.textColor = KAPP_7b7b7b_COLOR;
        _briefLabel.text = @"隆庆六年（1572年）五月二十二日，明穆宗病危，三天后内阁大学士高拱、张居正、高仪被召入宫中。[11]  高拱等人进入寝宫东偏室，见明穆宗坐在御榻上";
        _briefLabel.verticalAlignment = VerticalAlignmentTop;
        _briefLabel.numberOfLines = 0;
        _briefLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _briefLabel;
}

- (UILabel *)timeLabel{
    
    if (!_timeLabel) {
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = KFitFont(12);
        _timeLabel.textColor = KAPP_b7b7b7_COLOR;
        _timeLabel.text = @"2017年11月11日";
        _timeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _timeLabel;
}

- (UIImageView *)thumbnailImgView{
    
    if (!_thumbnailImgView) {
        
        _thumbnailImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Image_placeholder"]];
        _thumbnailImgView.contentMode = UIViewContentModeScaleAspectFill;
        _thumbnailImgView.clipsToBounds = YES;
    }
    return _thumbnailImgView;
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

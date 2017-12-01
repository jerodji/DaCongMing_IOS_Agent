
//
//  HYTeamMemberCell.m
//  Agency
//
//  Created by Jack on 2017/11/18.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYTeamMemberCell.h"

@interface HYTeamMemberCell ()

@property (nonatomic,strong) UIImageView *headerImgView;
@property (nonatomic,strong) UILabel *nickNameLabel;
@property (nonatomic,strong) UILabel *IDLabel;
@property (nonatomic,strong) UILabel *agencyLabel;
@property (nonatomic,strong) UIView *bottomLine;

@end


@implementation HYTeamMemberCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.headerImgView];
    [self addSubview:self.nickNameLabel];
    [self addSubview:self.IDLabel];
    [self addSubview:self.agencyLabel];
    [self addSubview:self.bottomLine];
}

- (void)layoutSubviews{
    
    [_headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(40 * WIDTH_MULTIPLE, 40 *WIDTH_MULTIPLE));
    }];
    
    [_agencyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self).offset(-18 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(50 * WIDTH_MULTIPLE, 20 *WIDTH_MULTIPLE));
        make.centerY.equalTo(self);
    }];
    
    [_nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_headerImgView);
        make.height.mas_equalTo(20 *WIDTH_MULTIPLE);
        make.left.equalTo(_headerImgView.mas_right).offset(10 * WIDTH_MULTIPLE);
        make.right.equalTo(_agencyLabel.mas_left).offset(-20 * WIDTH_MULTIPLE);
    }];
    
    [_IDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_nickNameLabel.mas_bottom);
        make.height.mas_equalTo(20 *WIDTH_MULTIPLE);
        make.left.equalTo(_headerImgView.mas_right).offset(10 * WIDTH_MULTIPLE);
        make.right.equalTo(_agencyLabel.mas_left).offset(-20 * WIDTH_MULTIPLE);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark - setModel
- (void)setModel:(HYTeamMemberModel *)model{
    
    _model = model;
    
    [_headerImgView sd_setImageWithURL:[NSURL URLWithString:model.head_image_url] placeholderImage:[UIImage imageNamed:@"user_placeholder"]];
    _nickNameLabel.text = model.name;
    _IDLabel.text = model.id;
}

#pragma mark - lazyload
- (UIImageView *)headerImgView{
    
    if (!_headerImgView) {
        
        _headerImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _headerImgView.image = [UIImage imageNamed:@"groupChat_placeholder"];
        _headerImgView.contentMode = UIViewContentModeScaleAspectFit;
        _headerImgView.layer.cornerRadius = 20 * WIDTH_MULTIPLE;
        _headerImgView.clipsToBounds = YES;
    }
    return _headerImgView;
}

- (UILabel *)nickNameLabel{
    
    if (!_nickNameLabel) {
        
        _nickNameLabel = [[UILabel alloc] init];
        _nickNameLabel.text = @"老巴塔哥尼亚快车";
        _nickNameLabel.font = KFitFont(14);
        _nickNameLabel.numberOfLines = 0;
        _nickNameLabel.textColor = KAPP_7b7b7b_COLOR;
        _nickNameLabel.backgroundColor = [UIColor whiteColor];
        _nickNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nickNameLabel;
}

- (UILabel *)IDLabel{
    
    if (!_IDLabel) {
        
        _IDLabel = [[UILabel alloc] init];
        _IDLabel.text = @"NO:4399";
        _IDLabel.font = KFitFont(11);
        _IDLabel.textColor = KAPP_7b7b7b_COLOR;
        _IDLabel.backgroundColor = [UIColor whiteColor];
        _IDLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _IDLabel;
}

- (UILabel *)agencyLabel{
    
    if (!_agencyLabel) {
        
        _agencyLabel = [[UILabel alloc] init];
        _agencyLabel.text = @"经销商";
        _agencyLabel.font = KFitFont(13);
        _agencyLabel.textColor = KAPP_WHITE_COLOR;
        _agencyLabel.backgroundColor = KAPP_THEME_COLOR;
        _agencyLabel.textAlignment = NSTextAlignmentCenter;
        _agencyLabel.layer.cornerRadius = 4 * WIDTH_MULTIPLE;
        _agencyLabel.layer.masksToBounds = YES;
    }
    return _agencyLabel;
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

//
//  HYReportAllOrderCell.m
//  Agency
//
//  Created by 胡勇 on 2017/11/6.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYReportAllOrderCell.h"

@interface HYReportAllOrderCell()

/** 白色背景 */
@property (nonatomic,strong) UIView *whiteBgView;
/** 标题 */
@property (nonatomic,strong) UILabel *titleLabel;
/** 箭头 */
@property (nonatomic,strong) UIImageView *arrowImgView;
/** value */
@property (nonatomic,strong) UILabel *valueLabel;

@end

@implementation HYReportAllOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = KAPP_TableView_BgColor;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.whiteBgView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.arrowImgView];
    [self addSubview:self.valueLabel];
}

- (void)layoutSubviews{
    
    [_whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.bottom.equalTo(self).offset(-10 * WIDTH_MULTIPLE);

    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.top.bottom.equalTo(_whiteBgView);
        make.width.mas_equalTo(150 * WIDTH_MULTIPLE);
    }];
    
    [_arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_whiteBgView);
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(19 / 2, 29 / 2));
    }];
    
    [_valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(_arrowImgView.mas_left).offset(-10 * WIDTH_MULTIPLE);
        make.top.bottom.equalTo(_whiteBgView);
        make.width.mas_equalTo(150 * WIDTH_MULTIPLE);
    }];
}

#pragma mark - lazyload
- (UIView *)whiteBgView{
    
    if (!_whiteBgView) {
        
        _whiteBgView = [UIView new];
        _whiteBgView.backgroundColor = KAPP_WHITE_COLOR;
    }
    return _whiteBgView;
}

- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = KFitFont(14);
        _titleLabel.textColor = KAPP_7b7b7b_COLOR;
        _titleLabel.text = @"总订单量";
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UILabel *)valueLabel{
    
    if (!_valueLabel) {
        
        _valueLabel = [[UILabel alloc] init];
        _valueLabel.font = KFitFont(18);
        _valueLabel.textColor = KCOLOR(@"4bc7b1");
        _valueLabel.text = @"1234";
        _valueLabel.textAlignment = NSTextAlignmentRight;
    }
    return _valueLabel;
}

- (UIImageView *)arrowImgView{
    
    if (!_arrowImgView) {
        
        _arrowImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
        _arrowImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _arrowImgView;
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

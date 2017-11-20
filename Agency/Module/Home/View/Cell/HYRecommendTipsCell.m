//
//  HYRecommendTipsCell.m
//  Agency
//
//  Created by Jack on 2017/11/20.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYRecommendTipsCell.h"

@interface HYRecommendTipsCell ()

@property (nonatomic,strong) UILabel *selectLabel;
@property (nonatomic,strong) UILabel *tipsLabel;


@end

@implementation HYRecommendTipsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = KAPP_TableView_BgColor;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.selectLabel];
    [self addSubview:self.tipsLabel];

}

- (void)layoutSubviews{
    
    [_selectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(self).offset(8 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(180 * WIDTH_MULTIPLE, 20 * WIDTH_MULTIPLE));
    }];
    
    [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(50 * WIDTH_MULTIPLE);
        make.top.equalTo(_selectLabel.mas_bottom).offset(5 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(280 * WIDTH_MULTIPLE, 50 * WIDTH_MULTIPLE));
    }];
    
}

#pragma mark - lazyload
- (UILabel *)selectLabel{
    
    if (!_selectLabel) {
        
        _selectLabel = [[UILabel alloc] init];
        _selectLabel.font = KFitFont(12);
        _selectLabel.textColor = KAPP_b7b7b7_COLOR;
        _selectLabel.text = @"已选择:高级合伙人";
        _selectLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _selectLabel;
}

- (UILabel *)tipsLabel{
    
    if (!_tipsLabel) {
        
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.font = KFitFont(12);
        _tipsLabel.textColor = KAPP_b7b7b7_COLOR;
        _tipsLabel.text = @"高级合伙人是个沙比玩意儿，罗威的森林没得罗威，毛人凤大战风车,高级合伙人是个沙比玩意儿，罗威的森林没得罗威，毛人凤大战风车";
        _tipsLabel.numberOfLines = 0;
        _tipsLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _tipsLabel;
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

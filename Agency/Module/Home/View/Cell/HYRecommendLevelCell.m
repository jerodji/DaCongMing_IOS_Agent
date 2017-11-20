//
//  HYRecommendLevelCell.m
//  Agency
//
//  Created by Jack on 2017/11/20.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYRecommendLevelCell.h"

@interface HYRecommendLevelCell ()

@property (nonatomic,strong) UILabel *recommendLabel;

@end

@implementation HYRecommendLevelCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
        [self createButtons];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.recommendLabel];
}

- (void)layoutSubviews{
    
    [_recommendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(self).offset(8 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(180 * WIDTH_MULTIPLE, 20 * WIDTH_MULTIPLE));
    }];
}

- (void)createButtons{
    
    NSArray *imageArray = @[@"senior_parter",@"practice_parter",@"senior_agency",@"practice_agency"];
    NSArray *selectImgArray = @[@"senior_parter_select",@"practice_parter_select",@"senior_agency_select",@"practice_agency_select"];
    CGFloat margin = 10 * WIDTH_MULTIPLE;
    CGFloat itemWidth = (KSCREEN_WIDTH - 50 * WIDTH_MULTIPLE - margin * 3) / 4;
    for (NSInteger i = 0; i < 4; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:selectImgArray[i]] forState:UIControlStateSelected];
        button.frame = CGRectMake(25 * WIDTH_MULTIPLE + i * (itemWidth + margin), 34 * WIDTH_MULTIPLE, itemWidth, itemWidth);
        button.tag = 200 + i;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

#pragma mark - action
- (void)buttonClicked:(UIButton *)button{
    
    button.selected = !button.selected;
    
}

#pragma mark - lazyload
- (UILabel *)recommendLabel{
    
    if (!_recommendLabel) {
        
        _recommendLabel = [[UILabel alloc] init];
        _recommendLabel.font = KFitFont(14);
        _recommendLabel.textColor = KAPP_b7b7b7_COLOR;
        _recommendLabel.text = @"推荐等级";
        _recommendLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _recommendLabel;
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

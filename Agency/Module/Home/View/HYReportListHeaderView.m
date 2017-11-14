//
//  HYReportListHeaderView.m
//  Agency
//
//  Created by 胡勇 on 2017/11/13.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYReportListHeaderView.h"

@interface HYReportListHeaderView ()

@property (nonatomic,strong) UIImageView *bgImgView;
@property (nonatomic,strong) UILabel *allOrderLabel;
@property (nonatomic,strong) UILabel *allAmountLabel;

@end

@implementation HYReportListHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.bgImgView];
    [self addSubview:self.allOrderLabel];
    [self addSubview:self.allAmountLabel];
}

- (void)layoutSubviews{
    
    [_bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self);
    }];
    
    [_allOrderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(30 * WIDTH_MULTIPLE);
    }];
    
    [_allAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self);
        make.height.mas_equalTo(30 * WIDTH_MULTIPLE);
        make.bottom.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
    }];
}

#pragma mark - lazyload
- (UIImageView *)bgImgView{
    
    if (!_bgImgView) {
        
        _bgImgView = [UIImageView new];
        _bgImgView.image = [UIImage imageNamed:@"report_list_bg"];
        _bgImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _bgImgView;
}

- (UILabel *)allOrderLabel{
    
    if (!_allOrderLabel) {
        
        _allOrderLabel = [[UILabel alloc] init];
        _allOrderLabel.font = KFitFont(18);
        _allOrderLabel.textColor = KAPP_WHITE_COLOR;
        _allOrderLabel.backgroundColor = [UIColor clearColor];
        _allOrderLabel.textAlignment = NSTextAlignmentCenter;
        _allOrderLabel.text = @"订单总量:147258单";
    }
    return _allOrderLabel;
}

- (UILabel *)allAmountLabel{
    
    if (!_allAmountLabel) {
        
        _allAmountLabel = [[UILabel alloc] init];
        _allAmountLabel.font = KFitFont(15);
        _allAmountLabel.textColor = KAPP_WHITE_COLOR;
        _allAmountLabel.backgroundColor = [UIColor clearColor];
        _allAmountLabel.textAlignment = NSTextAlignmentCenter;
        _allAmountLabel.text = @"总金额:147258单";
    }
    return _allAmountLabel;
}

@end

//
//  HYBillHeaderVIew.m
//  Agency
//
//  Created by Jack on 2017/11/16.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBillHeaderVIew.h"

@interface HYBillHeaderVIew ()

@property (nonatomic,strong) UILabel *currentMonthLabel;
@property (nonatomic,strong) UIButton *lookBillBtn;

@end


@implementation HYBillHeaderVIew

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.currentMonthLabel];
    [self addSubview:self.lookBillBtn];
}


#pragma mark - lazyload
- (UILabel *)currentMonthLabel{
    
    if (!_currentMonthLabel) {
        
        _currentMonthLabel = [[UILabel alloc] init];
        _currentMonthLabel.text = @"本月账单";
        _currentMonthLabel.font = KFitFont(14);
        _currentMonthLabel.textColor = KAPP_272727_COLOR;
        _currentMonthLabel.backgroundColor = [UIColor whiteColor];
        _currentMonthLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _currentMonthLabel;
}

- (UIButton *)lookBillBtn{
    
    if (!_lookBillBtn) {
        
        _lookBillBtn = [[UIButton alloc] init];
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        [_lookBillBtn setTitle:@"查看月账单" forState:UIControlStateNormal];
        [_lookBillBtn setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
        [_lookBillBtn setTitleColor:KAPP_b7b7b7_COLOR forState:UIControlStateNormal];
        _lookBillBtn.titleLabel.font = KFitFont(14);
        
        UIImage *image = _lookBillBtn.imageView.image;
        [_lookBillBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -image.size.width - 2, 0, image.size.width + 2)];
        CGFloat strWidth = [@"查看月账单" widthForFont:KFitFont(14)];
        [_lookBillBtn setImageEdgeInsets:UIEdgeInsetsMake(0, strWidth + 2, 0, -strWidth - 2)];
        
    }
    return _lookBillBtn;
}

@end

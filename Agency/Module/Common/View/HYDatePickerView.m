
//
//  HYDatePickerView.m
//  Agency
//
//  Created by 胡勇 on 2017/11/6.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYDatePickerView.h"

@interface HYDatePickerView ()

/** 半透明view */
@property (nonatomic,strong) UIView *blackBgView;
/** 白色 */
@property (nonatomic,strong) UIView *whiteBgView;

@property (nonatomic,strong) UIDatePicker *datePicker;


@end

@implementation HYDatePickerView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.blackBgView];
    [self addSubview:self.whiteBgView];
    [self addSubview:self.datePicker];
    
    [_whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_bottom);
        make.height.mas_equalTo(250 * WIDTH_MULTIPLE);
    }];
}

- (void)layoutSubviews{
    
    
    [_blackBgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self);
    }];
    
    [_datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(_whiteBgView);
        make.top.equalTo(_whiteBgView).offset(40 * WIDTH_MULTIPLE);
    }];
}

- (void)showDatePicker{
    
    [self setupSubviews];
    
    [UIView animateWithDuration:0.5 animations:^{
       
        _blackBgView.alpha = 0.6;
        [_whiteBgView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_bottom).offset(-250 * WIDTH_MULTIPLE);
        }];
    }];
}

- (void)hideDatePicker{
    
    _blackBgView.alpha = 0;
    [_blackBgView removeFromSuperview];
    _blackBgView = nil;
    [UIView animateWithDuration:0.5 animations:^{
        
        [_whiteBgView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_bottom);
        }];
    } completion:^(BOOL finished) {
        
        [_whiteBgView removeFromSuperview];
        _whiteBgView = nil;
        
        [_datePicker removeFromSuperview];
        _datePicker = nil;
        
        [self removeFromSuperview];

    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self hideDatePicker];
}

#pragma mark - lazyload
- (UIView *)blackBgView{
    
    if (!_blackBgView) {
        
        _blackBgView = [UIView new];
        _blackBgView.backgroundColor = KAPP_BLACK_COLOR;
        _blackBgView.alpha = 0;
    }
    return _blackBgView;
}

- (UIView *)whiteBgView{
    
    if (!_whiteBgView) {
        
        _whiteBgView = [UIView new];
        _whiteBgView.backgroundColor = KAPP_WHITE_COLOR;
    }
    return _whiteBgView;
}

- (UIDatePicker *)datePicker{
    
    if (!_datePicker) {
        
        _datePicker = [[UIDatePicker alloc] init];
        NSDate *minDate = [NSDate dateWithString:@"2015-10-10" format:@"yyyy-MM-dd"];
        _datePicker.minimumDate = minDate;
        _datePicker.maximumDate = [NSDate date];
        _datePicker.datePickerMode = UIDatePickerModeDate;
    }
    return _datePicker;
}

@end

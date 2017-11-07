
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
/** 取消 */
@property (nonatomic,strong) UIButton *cancelBtn;
/** 确定 */
@property (nonatomic,strong) UIButton *confirmBtn;
/** 底部黑线 */
@property (nonatomic,strong) UIView *bottomLine;
/** 选择时间 */
@property (nonatomic,strong) NSString *selectDate;

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
    [self addSubview:self.cancelBtn];
    [self addSubview:self.confirmBtn];
    [self addSubview:self.bottomLine];
    
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
    
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.equalTo(_whiteBgView);
        make.size.mas_equalTo(CGSizeMake(60 * WIDTH_MULTIPLE, 40 * WIDTH_MULTIPLE));
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.top.equalTo(_whiteBgView);
        make.size.mas_equalTo(CGSizeMake(60 * WIDTH_MULTIPLE, 40 * WIDTH_MULTIPLE));
    }];
    
    [_bottomLine mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self);
        make.top.equalTo(_cancelBtn.mas_bottom);
        make.height.mas_equalTo(1);
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
    
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    if (touchPoint.y > KSCREEN_HEIGHT - 250 * WIDTH_MULTIPLE) {
        
        [self hideDatePicker];
    }
    
}

#pragma mark - action
- (void)confirmAction{
    
    if (self.selectBlock) {
        
        if (!self.selectDate) {
            
            self.selectDate = [[_datePicker date] stringWithFormat:@"yyyy-MM-dd"];
        }
        self.selectBlock(self.selectDate);
        [self hideDatePicker];
    }
}

- (void)timeChanged:(id)sender
{
    UIDatePicker *currentPicker = (UIDatePicker *) sender;
    NSDate *pickerDate = [currentPicker date];//格林尼治时间
    NSString *selectDate = [pickerDate stringWithFormat:@"yyyy-MM-dd"];
    NSLog(@"datepicker current time %@",selectDate);
    self.selectDate = selectDate;
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
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        _datePicker.locale = locale;
        _datePicker.minimumDate = minDate;
        _datePicker.maximumDate = [NSDate date];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        [_datePicker addTarget:self action:@selector(timeChanged:) forControlEvents:UIControlEventValueChanged];
        [_datePicker setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    }
    return _datePicker;
}

- (UIButton *)cancelBtn{
    
    if (!_cancelBtn) {
        
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.titleLabel.font = KFitFont(18);
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:KAPP_272727_COLOR forState:UIControlStateNormal];
        _cancelBtn.backgroundColor = _whiteBgView.backgroundColor;
        [_cancelBtn addTarget:self action:@selector(hideDatePicker) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)confirmBtn{
    
    if (!_confirmBtn) {
        
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.titleLabel.font = KFitFont(18);
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:KAPP_272727_COLOR forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = _whiteBgView.backgroundColor;
        [_confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

- (UIView *)bottomLine{
    
    if (!_bottomLine) {
        
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = KAPP_SEPERATOR_COLOR;
    }
    return _bottomLine;
}


@end

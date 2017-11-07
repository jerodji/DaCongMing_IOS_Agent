//
//  HYReportSelectCellModel.m
//  Agency
//
//  Created by 胡勇 on 2017/11/6.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYReportSelectCellModel.h"
#import "HYDatePickerView.h"

@interface HYReportSelectCellModel()

/** datePicker */
@property (nonatomic,strong) HYDatePickerView *datePicker;

@end

@implementation HYReportSelectCellModel


- (instancetype)init{
    
    if (self = [super init]) {

        self.startTimeStr = @"点我选择开始时间";
        self.endTimeStr = @"点我选择结束时间";
        
    }
    return self;
}

- (void)showStartValueSelectView{
    
    [KEYWINDOW addSubview:self.datePicker];
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(KEYWINDOW);
    }];
    [self.datePicker showDatePicker];
    __weak typeof (self)weakSelf = self;
    self.datePicker.selectBlock = ^(NSString *selectDate) {
        
        weakSelf.startTimeStr = selectDate;
    };
}

- (void)showEndValueSelectView{
    
    [KEYWINDOW addSubview:self.datePicker];
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(KEYWINDOW);
    }];
    [self.datePicker showDatePicker];
    __weak typeof (self)weakSelf = self;
    self.datePicker.selectBlock = ^(NSString *selectDate) {
        
        weakSelf.endTimeStr = selectDate;
    };
}

- (void)selectReports{
    
    

}




#pragma mark - lazyload
- (HYDatePickerView *)datePicker{
    
    if (!_datePicker) {
        
        _datePicker = [HYDatePickerView new];
    }
    return _datePicker;
}

@end

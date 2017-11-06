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

- (void)showStartValueSelectView{
    
    DLog(@"%s",__func__);
    [KEYWINDOW addSubview:self.datePicker];
    [_datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(KEYWINDOW);
    }];
    [_datePicker showDatePicker];
    
}

- (void)showEndValueSelectView{
    
    DLog(@"%s",__func__);

}

- (void)selectReports{
    
    DLog(@"%s",__func__);

}




#pragma mark - lazyload
- (HYDatePickerView *)datePicker{
    
    if (!_datePicker) {
        
        _datePicker = [HYDatePickerView new];
    }
    return _datePicker;
}

@end

//
//  HYDatePickerView.h
//  Agency
//
//  Created by 胡勇 on 2017/11/6.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectTime)(NSString *selectDate);

@interface HYDatePickerView : UIView

@property (nonatomic,copy) selectTime selectBlock;

- (void)setupSubviews;
- (void)showDatePicker;

@end

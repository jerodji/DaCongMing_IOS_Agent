//
//  HYAuthPhoneView.h
//  Agency
//
//  Created by 胡勇 on 2017/11/8.
//  Copyright © 2017年 胡勇. All rights reserved.
//

/** 验证手机验证码 */

#import <UIKit/UIKit.h>
#import "HYBindPhoneViewModel.h"

@interface HYAuthPhoneView : UIView

- (void)setWithViewModel:(HYBindPhoneViewModel *)viewModel;

@end

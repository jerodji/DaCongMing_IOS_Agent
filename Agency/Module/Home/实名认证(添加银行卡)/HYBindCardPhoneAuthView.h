//
//  HYBindCardPhoneAuthView.h
//  Agency
//
//  Created by Jack on 2017/11/27.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYUploadIDCardViewModel.h"

@interface HYBindCardPhoneAuthView : UIView

@property (nonatomic,strong) UITextField *phoneField;

- (void)setWithViewModel:(HYUploadIDCardViewModel *)viewModel;

@end

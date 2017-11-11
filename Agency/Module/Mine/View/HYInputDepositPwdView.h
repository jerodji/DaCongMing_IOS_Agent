//
//  HYInputDepositPwdView.h
//  Agency
//
//  Created by 胡勇 on 2017/11/10.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYDepositViewModel.h"

typedef void(^ForgetPwdBlock)(void);

@interface HYInputDepositPwdView : UIView

/** 忘记密码 */
@property (nonatomic,strong) ForgetPwdBlock forgetPwdAction;

- (instancetype)initWithFrame:(CGRect)frame WithAmount:(NSString *)amount;

- (void)showInputPasswordView;

- (void)hideInputPwdView;

- (void)setWithViewModel:(HYDepositViewModel *)viewModel;


@end

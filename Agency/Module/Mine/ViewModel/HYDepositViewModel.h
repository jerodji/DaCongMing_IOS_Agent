//
//  HYDepositViewModel.h
//  Agency
//
//  Created by 胡勇 on 2017/11/10.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYDepositViewModel : NSObject

/** 账户余额 */
@property (nonatomic,copy) NSString *balance;
/** 收入的余额 */
@property (nonatomic,copy) NSString *inputBalance;
/** 提现密码 */
@property (nonatomic,strong) NSString *depositPwd;
/** 提现 */
@property (nonatomic,strong) RACSubject *depositSubject;
/** 提现成功 */
@property (nonatomic,strong) RACSubject *depositSuccessSubject;

- (RACSignal *)depositBtnInvalid;

- (void)depositAction;

- (void)inputPwdComplectionAction;

@end

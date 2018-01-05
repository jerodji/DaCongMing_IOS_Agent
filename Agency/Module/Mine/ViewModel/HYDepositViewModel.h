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
/** 输入的余额 */
@property (nonatomic,copy) NSString *inputBalance;
/** 提现银行卡ID */
@property (nonatomic,copy) NSString *depositBankID;
/** 提现密码 */
@property (nonatomic,copy) NSString *depositPwd;
/** 提现 */
@property (nonatomic,strong) RACSubject *depositSubject;
/** 密码错误 */
@property (nonatomic,strong) RACSubject *passwordErrorSubject;
/** 提现成功 */
@property (nonatomic,strong) RACSubject *depositSuccessSubject;

- (RACSignal *)depositBtnInvalid;

- (void)depositAction;

- (void)inputPwdComplectionAction;

@end

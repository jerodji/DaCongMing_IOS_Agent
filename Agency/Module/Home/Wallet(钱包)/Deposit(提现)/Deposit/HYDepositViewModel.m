//
//  HYDepositViewModel.m
//  Agency
//
//  Created by 胡勇 on 2017/11/10.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYDepositViewModel.h"

@implementation HYDepositViewModel

- (instancetype)init{
    
    if (self = [super init]) {
        
        [self initializeSignal];
    }
    return self;
}

- (void)initializeSignal{
    
    _depositSubject = [RACSubject subject];
    _depositSuccessSubject = [RACSubject subject];
    _passwordErrorSubject = [RACSubject subject];

}

- (RACSignal *)depositBtnInvalid{
    
    RACSignal *inputBalanceSignal = RACObserve(self,inputBalance);
    RACSignal *isValid = [inputBalanceSignal map:^id(id value) {
        
        return @([value length] >= 1);
    }];
    
    return isValid;
}

#pragma mark - action
- (void)depositAction{
    
    if (([self.inputBalance integerValue] > [self.balance integerValue])) {
        
        [JRToast showWithText:@"账户余额不足" duration:2];
        return;
    }
//    if ([self.inputBalance isEqualToString:@"--"]) {
//        [JRToast showWithText:@"请输入正确的提现金额" ];
//        return;
//    }
//    if ([self.inputBalance integerValue] <= 0) {
//        [JRToast showWithText:@"请输入大于0的提现金额"];
//        return;
//    }

    
    [self.depositSubject sendNext:self.inputBalance];
}

- (void)inputPwdComplectionAction{
    
    [HYUserRequestHandle DepositWithMoney:_inputBalance password:_depositPwd bandCardID:self.depositBankID ComplectionBlock:^(BOOL isSuccess) {
       
        if (isSuccess) {
            
            [self.depositSuccessSubject sendNext:@"ok"];
        }
        else{
            
            [self.passwordErrorSubject sendNext:@"passwordError"];
        }
    }];
}


@end

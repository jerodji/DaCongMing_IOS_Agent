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
    
    if ([self.inputBalance integerValue] > [self.balance integerValue]) {
        
        [JRToast showWithText:@"账户余额不足" duration:2];
        return;
    }
    
    [self.depositSubject sendNext:self.inputBalance];
}

- (void)inputPwdComplectionAction{
    
    [self.depositSuccessSubject sendNext:@"ok"];
}


@end

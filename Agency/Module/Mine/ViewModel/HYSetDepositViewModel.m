//
//  HYSetDepositViewModel.m
//  Agency
//
//  Created by 胡勇 on 2017/11/10.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYSetDepositViewModel.h"

@interface HYSetDepositViewModel ()

@property (nonatomic,strong) RACSignal *depositPwdSignal;

@end

@implementation HYSetDepositViewModel

- (instancetype)init{
    
    if (self = [super init]) {
        
        [self initializeSignal];
    }
    return self;
}

- (void)initializeSignal{
    
    self.depositPwdSignal = RACObserve(self, depositPwd);
    _setPwdSuccessSubject = [RACSubject subject];
    
}

- (RACSignal *)confirmButtonIsValid{
    
    RACSignal *isValid = [_depositPwdSignal map:^id(id value) {
       
        return @([value length] >= 6);
    }];
    
    return isValid;
}

- (void)setDepositPasswordAction{
    
    [HYUserRequestHandle setDepositPassword:_depositPwd andAuthCode:_authCode ComplectionBlock:^(BOOL isSuccess) {
       
        if (isSuccess) {
            
            [JRToast showWithText:@"设置提现密码成功" duration:2];
            [self.setPwdSuccessSubject sendCompleted];
        }
        else{
            
        }
    }];
}

@end

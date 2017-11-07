//
//  HYBindPhoneViewModel.m
//  Agency
//
//  Created by 胡勇 on 2017/11/7.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBindPhoneViewModel.h"

@interface HYBindPhoneViewModel()

@property (nonatomic, strong) RACSignal *phoneSignal;
@property (nonatomic, strong) RACSignal *authCodeSignal;
@property (nonatomic, strong) RACSignal *isGettingSignal;


@end  

@implementation HYBindPhoneViewModel

- (instancetype)init{
    
    if (self = [super init]) {
        
        [self initializeSignal];
    }
    return self;
}

- (void)initializeSignal{
    
    _authBtnTitle = @"获取验证码";
    _isGetAuth = NO;
    _phoneSignal = RACObserve(self, phone);
    _authCodeSignal = RACObserve(self, authCode);
    _isGettingSignal = RACObserve(self, isGetAuth);
    
    _AuthSuccessSubject = [RACSubject subject];
    _AuthErrorSubject = [RACSubject subject];
    
}

#pragma mark - public method
- (RACSignal *)getAuthCodeButtonIsValid{

    RACSignal *isValid = [RACSignal combineLatest:@[_phoneSignal,_isGettingSignal] reduce:^id{
        
        return @(_phone.length == 11 || _isGetAuth );
    }];

    return isValid;
}

- (RACSignal *)confirmButtonIsValid{
    
    RACSignal *isValid = [RACSignal combineLatest:@[_phoneSignal,_authCodeSignal] reduce:^id{
        
        return @(_phone.length == 11 && _authCode.length >= 6);
    }];
    
    return isValid;
}

- (void)getAuthCode{
    
    NSLog(@"%s",__func__);
    [self countDown];
}

- (void)verifyAuthCode{
    
    NSLog(@"%s",__func__);
}

#pragma mark - Private Method
/**判断手机号是否有效*/
- (BOOL)validatePhoneNum:(NSString *)phoneNum{
    
    NSString *numReg = @"^(1)\\d{10}$";
    NSPredicate *numCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numReg];
    
    return [numCheck evaluateWithObject:phoneNum];
}

/** 倒计时的方法 */
- (void)countDown{
    
    __block NSInteger time = 59;
    //创建全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //创建监视时间变化的对象
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //每秒执行
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        //倒计时结束，关闭
        if (time <= 0) {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                _authBtnTitle = [NSString stringWithFormat:@"重新发送"];
                _isGetAuth = NO;
            });
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                _authBtnTitle = [NSString stringWithFormat:@"%ld秒后重试",time];
                _isGetAuth = YES;
                time--;
            });
        }
        
    });
    dispatch_resume(timer);
}

@end

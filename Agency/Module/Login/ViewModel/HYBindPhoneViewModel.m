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
    _phoneSignal = RACObserve(self, phone);
    _authCodeSignal = RACObserve(self, authCode);
    _isGettingSignal = RACObserve(self, isGetAuth);
    
    _AuthBtnTitleSubject = [RACSubject subject];
    _AuthSuccessSubject = [RACSubject subject];
    _AuthErrorSubject = [RACSubject subject];
    
    _AuthBtnTitleSubject = (RACSubject *)RACObserve(self, authBtnTitle);
}

#pragma mark - public method
- (RACSignal *)getAuthCodeButtonIsValid{

    RACSignal *isValid = [RACSignal combineLatest:@[_phoneSignal,_isGettingSignal] reduce:^id{
        
        if (_phone.length == 11 && _isGetAuth) {
            
            return @(0);
        }
        
        if (_phone.length != 11 ) {
            
            return @(0);
        }
        return @(1);
    }];

    return isValid;
}

- (RACSignal *)confirmButtonIsValid{


    RACSignal *isValid = [RACSignal combineLatest:@[_phoneSignal,_authCodeSignal] reduce:^id{
        
        return @(_phone.length == 11 && _authCode.length == 6);
    }];
    return isValid;
}

- (void)getAuthCodeAction{
    
    if (![self validatePhoneNum:self.phone]) {
        
        [JRToast showWithText:@"请输入有效的手机号"];
        return;
    }
    
    [HYUserRequestHandle getAuthCodeWithPhone:_phone ComplectionBlock:^(BOOL isSuccess) {
        
        if (isSuccess) {
            
            [self countDown];
        }
    }];
    
}

- (void)verifyAuthCodeAction{
    
    if (self.isBindPhone) {
        
        [HYUserRequestHandle bindPhone:_phone authCode:_authCode ComplectionBlock:^(BOOL isSuccess) {
            
            if (isSuccess) {
                
                [self.AuthSuccessSubject sendNext:@"ok"];
                //归档用户信息
                [HYPlistTools archiveObject:[HYUserModel sharedInstance] withName:KUserModelData];
            }
        }];
    }
    else{
        
        [HYUserRequestHandle verifyAuthCodeWithPhone:_phone authCode:_authCode ComplectionBlock:^(BOOL isSuccess) {
            
            if (isSuccess) {
                
                [self.AuthSuccessSubject sendNext:@"ok"];
                //归档用户信息
                [HYPlistTools archiveObject:[HYUserModel sharedInstance] withName:KUserModelData];
            }
        }];
    }
    
    
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
                
                self.authBtnTitle = [NSString stringWithFormat:@"重新发送"];
                self.isGetAuth = NO;
            });
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.authBtnTitle = [NSString stringWithFormat:@"%ld秒后重试",time];
                self.isGetAuth = YES;
                time--;
            });
        }
        
    });
    dispatch_resume(timer);
}

@end

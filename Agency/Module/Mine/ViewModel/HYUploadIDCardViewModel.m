//
//  HYUploadIDCardViewModel.m
//  Agency
//
//  Created by 胡勇 on 2017/11/8.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYUploadIDCardViewModel.h"

@interface HYUploadIDCardViewModel()

@property (nonatomic, strong) RACSignal *nameSignal;
@property (nonatomic, strong) RACSignal *IDCardSignal;
@property (nonatomic, strong) RACSignal *bankCardNumSignal;
@property (nonatomic, strong) RACSignal *authNumSignal;

@end

@implementation HYUploadIDCardViewModel

- (instancetype)init{
    
    if (self = [super init]) {
        
        [self initializeSignal];
    }
    return self;
}

- (void)initializeSignal{
    
    _authBtnTitle = @"获取验证码";
    _tipsLabelText = [NSString stringWithFormat:@"我们将发送验证码到:%@",[HYUserModel sharedInstance].userInfo.phone];
    _isGetAuth = YES;
    _nameSignal = RACObserve(self, name);
    _IDCardSignal = RACObserve(self, IDCard);
    _bankCardNumSignal = RACObserve(self, bankCardNum);
    _authNumSignal = RACObserve(self, authNum);
}

- (RACSignal *)getAuthCodeButtonIsValid{
    
    return [self rac_valuesForKeyPath:@"isGetAuth" observer:nil];
}

- (RACSignal *)confirmButtonIsValid{
    
    RACSignal *isValid = [RACSignal combineLatest:@[_nameSignal,_IDCardSignal,_bankCardNumSignal,_authNumSignal] reduce:^id{
        
        return @([_name isNotBlank] && _IDCard.length == 18 && _bankCardNum.length >= 16  && _authNum.length == 6);
    }];
    
    return isValid;
}

- (void)getAuthCodeAction{
    
    [HYUserRequestHandle getAuthCodeWithPhone:[HYUserModel sharedInstance].userInfo.phone ComplectionBlock:^(NSString *authCode) {
        
        if (authCode) {
            
            [JRToast showWithText:[NSString stringWithFormat:@"验证码已发送至%@",[HYUserModel sharedInstance].userInfo.phone]];
            self.tipsLabelText = [NSString stringWithFormat:@"验证码已发送至%@",[HYUserModel sharedInstance].userInfo.phone];
            [self countDown];
        }
    }];
    
}

- (void)confirmAction{
    
    [HYUserRequestHandle uploadIDCardInfoWithName:_name IDCardNum:_IDCard bankCardNum:_bankCardNum authCode:_authNum ComplectionBlock:^(BOOL isSuccess) {
        
        if (isSuccess) {
            
            
        }
    }];
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
                self.isGetAuth = YES;
            });
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.authBtnTitle = [NSString stringWithFormat:@"%ld秒后重试",time];
                self.isGetAuth = NO;
                time--;
            });
        }
        
    });
    dispatch_resume(timer);
}

@end

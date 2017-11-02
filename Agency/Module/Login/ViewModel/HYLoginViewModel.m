//
//  HYLoginViewModel.m
//  Agency
//
//  Created by 胡勇 on 2017/11/1.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYLoginViewModel.h"
#import "HYLoginRequestManager.h"

@interface HYLoginViewModel()

@property (nonatomic, strong) RACSignal *phoneSignal;
@property (nonatomic, strong) RACSignal *passwordSignal;

@end

@implementation HYLoginViewModel

- (instancetype)init{
    
    if (self = [super init]) {
        
        [self initializeSignal];
    }
    return self;
}

- (void)initializeSignal{
    
    _phoneSignal = RACObserve(self, phone);
    _passwordSignal = RACObserve(self, password);
    
    _loginSuccessSubject = [RACSubject subject];
    _loginErrorSubject = [RACSubject subject];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weChatLoginCallBack:) name:KWeChatLoginNotification object:nil];
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:KWeChatLoginNotification];
}

#pragma mark - public method
- (RACSignal *)loginButtonIsValid{
    
    RACSignal *isValid = [RACSignal combineLatest:@[_phoneSignal,_passwordSignal] reduce:^id{
       
        return @(_phone.length == 11 && _password.length > 6);
    }];
    
    return isValid;
}

- (void)loginAction{
    
    if (![self validatePhoneNum:_phone]) {
        
        [JRToast showWithText:@"请输入正确的手机号"];
        return;
    }
}

- (void)wechatLoginAction{
    
    if ([WXApi isWXAppInstalled]) {
        
        SendAuthReq *req = [SendAuthReq new];
        req.scope = @"snsapi_userinfo";
        req.state = @"com.dacongming";
        [WXApi sendReq:req];
    }
    else{
        
        [JRToast showWithText:@"please install WeChat"];
    }
}

#pragma mark - notification
- (void)weChatLoginCallBack:(NSNotification *)notification{
    
    NSString *weChatCallbackCode = notification.object;
    DLog(@"wechatLogin callBack code %@",weChatCallbackCode);
    NSDictionary *dict = @{@"code" : weChatCallbackCode};
    [HYLoginRequestManager weChatLoginWithProgram:dict ComplectionBlock:^(NSDictionary *result) {

        [self.loginSuccessSubject sendNext:result];
    }];
    //[self.loginSuccessSubject sendNext:dict];
}

#pragma mark - privateMethod
/** 判断手机号是否有效 */
- (BOOL)validatePhoneNum:(NSString *)phoneNum{
    
    NSString *numReg = @"^(1)\\d{10}$";
    NSPredicate *numCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numReg];
    
    return [numCheck evaluateWithObject:phoneNum];
}

@end

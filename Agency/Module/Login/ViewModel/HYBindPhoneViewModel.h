//
//  HYBindPhoneViewModel.h
//  Agency
//
//  Created by 胡勇 on 2017/11/7.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseViewModel.h"

@interface HYBindPhoneViewModel : HYBaseViewModel

/** 是否是绑定手机  或者验证手机 */
@property (nonatomic,assign) BOOL isBindPhone;

@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *authCode;
@property (nonatomic,copy) NSString *authBtnTitle;
@property (nonatomic,assign) BOOL isGetAuth;
@property (nonatomic,strong) RACSubject *AuthBtnTitleSubject;
@property (nonatomic,strong) RACSubject *AuthSuccessSubject;
@property (nonatomic,strong) RACSubject *AuthErrorSubject;


- (RACSignal *)getAuthCodeButtonIsValid;
- (RACSignal *)confirmButtonIsValid;

- (void)getAuthCodeAction;
- (void)verifyAuthCodeAction;

@end

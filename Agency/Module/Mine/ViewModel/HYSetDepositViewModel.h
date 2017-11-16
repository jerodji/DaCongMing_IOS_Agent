//
//  HYSetDepositViewModel.h
//  Agency
//
//  Created by 胡勇 on 2017/11/10.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYSetDepositViewModel : NSObject

@property (nonatomic,copy) NSString *authCode;
@property (nonatomic,copy) NSString *depositPwd;
@property (nonatomic,strong) RACSubject *setPwdSuccessSubject;
/** 密码错误 */
@property (nonatomic,strong) RACSubject *setPasswordErrorSubject;

- (RACSignal *)confirmButtonIsValid;

- (void)setDepositPasswordAction;

@end

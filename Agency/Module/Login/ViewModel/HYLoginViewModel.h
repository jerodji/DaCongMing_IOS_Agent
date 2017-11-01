//
//  HYLoginViewModel.h
//  Agency
//
//  Created by 胡勇 on 2017/11/1.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYLoginViewModel : NSObject

@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *password;
@property (nonatomic,strong) RACSubject *loginSuccessSubject;
@property (nonatomic,strong) RACSubject *loginErrorSubject;

- (RACSignal *)loginButtonIsValid;

- (void)loginAction;

- (void)wechatLoginAction;

@end

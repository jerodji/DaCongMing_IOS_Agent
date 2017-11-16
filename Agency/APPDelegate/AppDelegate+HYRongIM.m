//
//  AppDelegate+HYRongIM.m
//  Agency
//
//  Created by Jack on 2017/11/16.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "AppDelegate+HYRongIM.h"

@implementation AppDelegate (HYRongIM)

- (void)setupRongIMWithAPPKey:(NSString *)key{
    
    [[RCIM sharedRCIM] initWithAppKey:key];
    
    NSString *token = @"2Gyj7rc5gJCiQUIICUkgp6+YsUIoF3ojin3K277sfOk7F6/fjX/ayFtXOXWFejVF9kOSFK/mgw/RC9gTP/+uG6tdpZUyLdaH";
    [[RCIM sharedRCIM] connectWithToken:token     success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%ld", (long)status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        NSLog(@"token错误");
    }];
}

@end

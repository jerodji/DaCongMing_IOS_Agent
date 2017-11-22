//
//  AppDelegate.m
//  Agency
//
//  Created by 胡勇 on 2017/11/1.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "AppDelegate.h"
#import "HYLoginViewController.h"
#import "HYHomePageViewController.h"
#import "HYReachabilityManager.h"
#import "AppDelegate+HYRongIM.h"
#import "HYGuideViewController.h"
#import <Bugly/Bugly.h>

@interface AppDelegate () <WXApiDelegate>

@end
H

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = KAPP_TableView_BgColor;
    [self.window makeKeyAndVisible];
    
    [self setRootViewController];
    [self setupRongIMWithAPPKey:RONGCLOUD_IM_APPKEY];
    [HYReachabilityManager listenNetWorkingStatus];
    [WXApi registerApp:WXAppID];
     [self registerAPNSWith:application];
    
    application.applicationIconBadgeNumber = 0;
    
    //让键盘自适应高度
    IQKeyboardManager *manager= [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    
    [Bugly startWithAppId:TencentBuglyID];
    return YES;
    
    return YES;
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options{
    
    [WXApi handleOpenURL:url delegate:self];
    
    if ([url.host isEqualToString:@"safepay"]) {
        
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length > 0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    return YES;
}

/**
 *  微信回调
 */
- (void)onResp:(BaseResp *)resp{
    
    DLog(@"WeChat login callBack errorCode %@",resp.errStr);
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        //微信登录授权
        if (resp.errCode == 0) {
            //登录成功 发出通知
            SendAuthResp *atuhResp = (SendAuthResp *)resp;
            [[NSNotificationCenter defaultCenter] postNotificationName:KWeChatLoginNotification object:atuhResp.code];
        }
    }
    
    //微信支付回调
    if ([resp isKindOfClass:[PayResp class]]){
        
        PayResp *response = (PayResp*)resp;
        switch(response.errCode){
            case WXSuccess:
                //服务器端查询支付通知或查询API返回的结果再提示成功
                DLog(@"支付成功");
                [[NSNotificationCenter defaultCenter] postNotificationName:KWeChatPaySuccessNotification object:@"YES"];
                break;
            default:
                DLog(@"支付失败，retcode=%d",resp.errCode);
                [[NSNotificationCenter defaultCenter] postNotificationName:KWeChatPaySuccessNotification object:@"NO"];
                break;
        }
    }
}

#pragma mark - apns
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    NSString *token = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    DLog(@"-------device Token is %@",token);
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    // 远程推送的内容
    DLog(@"%@",userInfo);
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
    DLog(@"收到本地推送");
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler{
    
    DLog(@"收到远程推送消息:%@",userInfo);
    completionHandler(UIBackgroundFetchResultNewData);

}

#pragma mark - 生命周期
- (void)applicationWillResignActive:(UIApplication *)application {
    
    
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
   
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    application.applicationIconBadgeNumber = 0;
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
}

#pragma mark - method
- (void)setRootViewController{
    
    //判断是不是第一次使用
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstLaunch"]) {
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirstLaunch"];
        HYGuideViewController *guideVC = [[HYGuideViewController alloc] init];
        self.window.rootViewController = guideVC;
    }
    else{
        
        if(KUserDefaultsForKey(KUserPhone) && KUserDefaultsForKey(KUserPassword)){
            
            [HYUserRequestHandle LoginWithPhone:KUserDefaultsForKey(KUserPhone) password:KUserDefaultsForKey(KUserPassword) ComplectionBlock:^(NSDictionary *result) {
               
                if (result) {
                    
                    HYHomePageViewController *homeVC = [HYHomePageViewController new];
                    self.window.rootViewController = homeVC;
                    return;
                }
                
            }];
        }
        
        if ([HYPlistTools unarchivewithName:KUserModelData]) {
            
            
            HYHomePageViewController *homeVC = [HYHomePageViewController new];
            self.window.rootViewController = homeVC;
            
            HYUserModel *userModel = [HYPlistTools unarchivewithName:KUserModelData];
            HYUserModel *shareModel = [HYUserModel sharedInstance];
            shareModel.token = userModel.token;
            shareModel.userInfo = userModel.userInfo;
            shareModel.rong_token = userModel.rong_token;
            
        }
        else{
            
            HYLoginViewController *loginVC = [[HYLoginViewController alloc] init];
            self.window.rootViewController = loginVC;
        }
       
    }
    
    
    
}


@end

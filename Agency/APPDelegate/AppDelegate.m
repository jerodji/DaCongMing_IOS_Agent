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

@interface AppDelegate () <WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = KAPP_TableView_BgColor;
    [self.window makeKeyAndVisible];
    
    [self setRootViewController];
    [HYReachabilityManager listenNetWorkingStatus];
    [WXApi registerApp:WXAppID];
    
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


- (void)applicationWillResignActive:(UIApplication *)application {
    
    
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
   
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
}

#pragma mark - method
- (void)setRootViewController{
    
    if ([HYPlistTools unarchivewithName:KUserModelData]) {
        
        HYHomePageViewController *homeVC = [HYHomePageViewController new];
        self.window.rootViewController = homeVC;
        
        HYUserModel *userModel = [HYPlistTools unarchivewithName:KUserModelData];
        HYUserModel *shareModel = [HYUserModel sharedInstance];
        shareModel.token = userModel.token;
        shareModel.userInfo = userModel.userInfo;
    }
    else{
        
        HYLoginViewController *loginVC = [[HYLoginViewController alloc] init];
        self.window.rootViewController = loginVC;
    }
}


@end

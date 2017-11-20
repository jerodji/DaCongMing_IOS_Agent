//
//  AppDelegate+HYRongIM.m
//  Agency
//
//  Created by Jack on 2017/11/16.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "AppDelegate+HYRongIM.h"

#define IOS10_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define IOS9_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define IOS8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

@implementation AppDelegate (HYRongIM)

- (void)setupRongIMWithAPPKey:(NSString *)key{
    
    [[RCIM sharedRCIM] initWithAppKey:key];
    
     //NSString *token = @"2Gyj7rc5gJCiQUIICUkgp6+YsUIoF3ojin3K277sfOk7F6/fjX/ayFtXOXWFejVF9kOSFK/mgw/RC9gTP/+uG6tdpZUyLdaH";
//    NSString *userId = @"HhrmupU7V";
//    NSString *name = @"风车大战骑士";
//    NSString *portrait = @"http://7xogjk.com1.z0.glb.clouddn.com/HhrmupU7V1510747668639885986";
    
    if (![[HYUserModel sharedInstance].rong_token isNotBlank]) {
        
        return;
    }
    
    NSString *userId = [HYUserModel sharedInstance].userInfo.id;
    NSString *name = [HYUserModel sharedInstance].userInfo.name;
    NSString *portrait = [HYUserModel sharedInstance].userInfo.head_image_url;
    RCUserInfo *_currentUserInfo = [[RCUserInfo alloc] initWithUserId:userId name:name portrait:portrait];
    [RCIM sharedRCIM].currentUserInfo = _currentUserInfo;
    
   
    NSString *token = [HYUserModel sharedInstance].rong_token;
    [[RCIM sharedRCIM] connectWithToken:token     success:^(NSString *userId) {
        NSLog(@"---登陆成功。当前登录的用户ID：%@", userId);
    } error:^(RCConnectErrorCode status) {
        NSLog(@"---登陆的错误码为:%ld", (long)status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        NSLog(@"---token错误");
    }];
    
    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
    [[RCIM sharedRCIM] setReceiveMessageDelegate:self];

}

- (void)registerAPNSWith:(UIApplication *)application{
    
    if (@available(iOS 10.0, *)) {
        
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        //必须写代理，不然无法监听通知的接收与点击事件
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (!error && granted) {
                //用户点击允许
                NSLog(@"------注册成功");
            }else{
                //用户点击不允许
                NSLog(@"------注册失败");
            }
        }];
        
        // 可以通过 getNotificationSettingsWithCompletionHandler 获取权限设置
        //之前注册推送服务，用户点击了同意还是不同意，以及用户之后又做了怎样的更改我们都无从得知，现在 apple 开放了这个 API，我们可以直接获取到用户的设定信息了。注意UNNotificationSettings是只读对象哦，不能直接修改！
        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            
            NSLog(@"========%@",settings);
        }];
    }
    else{
        
        //注册推送, 用于iOS8-iOS10的系统
        if ([application
             respondsToSelector:@selector(registerUserNotificationSettings:)]) {
            UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                    settingsForTypes:(UIUserNotificationTypeBadge |
                                                                      UIUserNotificationTypeSound |
                                                                      UIUserNotificationTypeAlert)
                                                    categories:nil];
            [application registerUserNotificationSettings:settings];
        }
    }
}

#pragma mark - iOS10 收到通知（本地和远端） UNUserNotificationCenterDelegate
//App处于前台接收通知时
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    
    if (@available(iOS 10.0, *)) {
    
        //收到推送的请求
        UNNotificationRequest *request = notification.request;
        //收到推送的内容
        UNNotificationContent *content = request.content;
        //收到用户的基本信息
        NSDictionary *userInfo = content.userInfo;
//        //收到推送消息的角标
//        NSNumber *badge = content.badge;
//        //收到推送消息body
//        NSString *body = content.body;
//        //推送消息的声音
//        UNNotificationSound *sound = content.sound;
//        // 推送消息的副标题
//        NSString *subtitle = content.subtitle;
//        // 推送消息的标题
//        NSString *title = content.title;
        
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            
            NSLog(@"iOS10 收到远程通知:%@",userInfo);
        }
        else {
            // 判断为本地通知
            
            NSLog(@"iOS10 收到本地通知:%@",userInfo);
        }
        
        
        // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
        completionHandler(UNNotificationPresentationOptionBadge|
                          UNNotificationPresentationOptionSound|
                          UNNotificationPresentationOptionAlert);
    }
    
}

//App通知的点击事件
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    
    if (@available(iOS 10.0, *)) {

    
        //收到推送的请求
        UNNotificationRequest *request = response.notification.request;
        //收到推送的内容
        UNNotificationContent *content = request.content;
        //收到用户的基本信息
        NSDictionary *userInfo = content.userInfo;
        
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            
            NSLog(@"iOS10 点击了通知:%@",userInfo);
            
        }
        else {
            
    
        }
        
        HYMyTeamViewController *myTeamVC = [HYMyTeamViewController new];
        HYBaseNavController *nav = [[HYBaseNavController alloc] initWithRootViewController:myTeamVC];
        [KEYWINDOW.rootViewController presentViewController:nav animated:YES completion:nil];
        
        HYChatViewController *chatVC = [[HYChatViewController alloc] initWithConversationType:ConversationType_GROUP targetId:[HYUserModel sharedInstance].userInfo.group_id];
        [nav pushViewController:chatVC animated:YES];
        
        completionHandler(); // 系统要求执行这个方法
    }
}



#pragma mark - RCIMDelegate
- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status{
    
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"您的帐号在别的设备上登录，"
                              @"您被迫下线！"
                                                       delegate:nil
                                              cancelButtonTitle:@"知道了"
                                              otherButtonTitles:nil, nil];
        [alert show];
        
        HYLoginViewController *loginVC = [[HYLoginViewController alloc] init];
        self.window.rootViewController = loginVC;
    }
    else if (status == ConnectionStatus_DISCONN_EXCEPTION) {
        
        [[RCIMClient sharedRCIMClient] disconnect];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"您的帐号被封禁"
                                                       delegate:nil
                                              cancelButtonTitle:@"知道了"
                                              otherButtonTitles:nil, nil];
        [alert show];
        HYLoginViewController *loginVC = [[HYLoginViewController alloc] init];
        self.window.rootViewController = loginVC;
    }
}

- (BOOL)onRCIMCustomLocalNotification:(RCMessage *)message withSenderName:(NSString *)senderName{

    return NO;
}

- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left{
    
   if (@available(iOS 10.0, *)) {
       
       if ([message.content isKindOfClass:[RCTextMessage class]]) {
           
           //收到消息发送本地通知
           RCTextMessage *msg = (RCTextMessage *)message.content;
           
           // 设置触发条件 UNNotificationTrigger
           UNTimeIntervalNotificationTrigger *timeTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:0.01f repeats:NO];
           // 创建通知内容 UNMutableNotificationContent, 注意不是 UNNotificationContent ,此对象为不可变对象。
           UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
           content.title = @"群消息提醒";
           content.body = [NSString stringWithFormat:@"%@:%@",msg.senderUserInfo.name,msg.content];
           
           dispatch_async(dispatch_get_main_queue(), ^{
               
               content.badge = @([UIApplication sharedApplication].applicationIconBadgeNumber + 1);
           });
           content.sound = [UNNotificationSound soundNamed:@"sms-received.caf"];
           content.userInfo = @{@"pushType":@"chat",@"key2":@"value2"};
           
           // 创建通知标示
           NSString *requestIdentifier = @"Dely.X.time";
           
           // 创建通知请求 UNNotificationRequest 将触发条件和通知内容添加到请求中
           UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:content trigger:timeTrigger];
           
           UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
           // 将通知请求 add 到 UNUserNotificationCenter
           [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
               if (!error) {
                   
                   NSLog(@"推送已添加成功 %@", requestIdentifier);
               }
           }];
       }

   }
    
}

- (BOOL)onRCIMCustomAlertSound:(RCMessage *)message{

    return YES;
}

@end

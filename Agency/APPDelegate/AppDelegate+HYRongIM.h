//
//  AppDelegate+HYRongIM.h
//  Agency
//
//  Created by Jack on 2017/11/16.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "AppDelegate.h"
#import "HYBaseNavController.h"
#import "HYMyTeamViewController.h"
#import "HYChatViewController.h"

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate (HYRongIM) <RCIMConnectionStatusDelegate,RCIMReceiveMessageDelegate,UNUserNotificationCenterDelegate>

- (void)setupRongIMWithAPPKey:(NSString *)key;

- (void)registerAPNSWith:(UIApplication *)application;

@end

//
//  AppDelegate.m
//  Agency
//
//  Created by 胡勇 on 2017/11/1.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "AppDelegate.h"
#import "HYLoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = KAPP_TableView_BgColor;
    [self.window makeKeyAndVisible];
    
    HYLoginViewController *loginVC = [[HYLoginViewController alloc] init];
    self.window.rootViewController = loginVC;
    
    return YES;
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


@end

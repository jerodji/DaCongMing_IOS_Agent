//
//  UIViewController+XIB.m
//  Agency
//
//  Created by hailin on 2018/2/5.
//  Copyright © 2018年 Jerod. All rights reserved.
//

#import "UIViewController+XIB.h"

@implementation UIViewController (XIB)

+ (instancetype)loadXIB {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

@end


@implementation UIViewController (currentVC)

//+ (instancetype)shareIns {
//    static NSObject* ins ;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        ins = [[[self class] alloc] init];
//    });
//    return ins;
//}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self seekCurrentVCFrom:rootViewController];
    return currentVC;
}

+ (UIViewController *)seekCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    // 视图是被presented出来的
    if ([rootVC presentedViewController]) {
        rootVC = [rootVC presentedViewController];
    }
    // 根视图为UITabBarController
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        currentVC = [self seekCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    }
    // 根视图为UINavigationController
    else if ([rootVC isKindOfClass:[UINavigationController class]]){
        currentVC = [self seekCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    }
    // 根视图为非导航类
    else {
        currentVC = rootVC;
    }
    return currentVC;
}

@end

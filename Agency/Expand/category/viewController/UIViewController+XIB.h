//
//  UIViewController+XIB.h
//  Agency
//
//  Created by hailin on 2018/2/5.
//  Copyright © 2018年 Jerod. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (XIB)
+ (instancetype)loadXIB;
@end

@interface UIViewController (currentVC)

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC;

@end

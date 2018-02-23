//
//  JJAlert.h
//  UnicornTV
//
//  Created by JerodJi on 2017/11/23.
//  Copyright © 2017年 Droi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SURE)(void);
typedef void(^CANCLE)(void);
typedef void(^ACTION)(void);

@interface JJAlert : NSObject

+ (void)showMessage:(NSString*)message;
+ (void)showMessage:(NSString *)message withActionTitle:(NSString*)title action:(ACTION)_action;

+ (void)showMessage:(NSString*)message cancleAction:(CANCLE)_cancle sureAction:(SURE)_sure;
+ (void)showMessageWithVC:(UIViewController*)vc message:(NSString*)message cancleAction:(CANCLE)_cancle sureAction:(SURE)_sure;

@end

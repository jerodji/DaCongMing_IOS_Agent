//
//  HYSetPwdViewController.h
//  Agency
//
//  Created by Jack on 2017/12/29.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseViewController.h"

@interface HYSetPwdViewController : HYBaseViewController

/** 手机号 */
@property (nonatomic,copy) NSString *phone;
/** 验证码 */
@property (nonatomic,copy) NSString *authCode;

@end

//
//  HYDepositVC.h
//  Agency
//
//  Created by 胡勇 on 2017/11/8.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseViewController.h"

@interface HYDepositVC : HYBaseViewController

/** 余额 */
@property (nonatomic,strong) NSString *balance;
/** 是否设置提现密码 */
@property (nonatomic,assign) BOOL isSetaccountPwd;

@end

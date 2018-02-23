//
//  HYSetDispoitPwdVC.h
//  Agency
//
//  Created by 胡勇 on 2017/11/8.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseViewController.h"

typedef NS_ENUM(NSInteger, PrevTargetType) {
    PrevTargetTypeUploadIDCardVC = 0
};

typedef void (^PWDBLOCK)(NSString* crashPWD);

@interface HYSetDispoitPwdVC : HYBaseViewController

@property (nonatomic,copy) NSString *authCode;
@property (nonatomic,copy) PWDBLOCK PWDCB;

@property (nonatomic,assign) PrevTargetType targetType;
@property (nonatomic,assign) BOOL removeBankCard;
@end

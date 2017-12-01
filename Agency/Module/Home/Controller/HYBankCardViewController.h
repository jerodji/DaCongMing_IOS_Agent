//
//  HYBankCardViewController.h
//  Agency
//
//  Created by 胡勇 on 2017/11/3.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseViewController.h"

typedef void(^HYSelectBankCard)(NSString *bankCardID);

@interface HYBankCardViewController : HYBaseViewController

/** 是否是选择银行卡 */
@property (nonatomic,assign) BOOL isSelectBankCard;
/** 选择银行卡的回调 */
@property (nonatomic,copy) HYSelectBankCard selectCardBlock;

@end

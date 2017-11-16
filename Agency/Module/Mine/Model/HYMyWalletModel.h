//
//  HYMyWalletModel.h
//  Agency
//
//  Created by 胡勇 on 2017/11/10.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYMyWalletModel : HYBaseModel

/** 账户余额 */
@property (nonatomic,strong) NSString *balance;
/** 销售总额 */
@property (nonatomic,strong) NSString *acc_totalSales;
/** 累计佣金 */
@property (nonatomic,copy) NSString *acc_totalCommission;
/** 本月销售额 */
@property (nonatomic,copy) NSString *thisMonthSales;
/** 本月佣金 */
@property (nonatomic,copy) NSString *thisMonthCommission;
/** 今日销售额 */
@property (nonatomic,copy) NSString *todaySales;
/** 是否设置提现密码 */
@property (nonatomic,copy) NSString *isSetaccountPwd;

@end


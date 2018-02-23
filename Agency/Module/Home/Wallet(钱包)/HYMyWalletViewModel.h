//
//  HYMyWalletViewModel.h
//  Agency
//
//  Created by 胡勇 on 2017/11/8.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYMyWalletModel.h"

@interface HYMyWalletViewModel : NSObject

/** 账户余额 */
@property (nonatomic,strong) NSString *balance;
/** 销售总额 */
@property (nonatomic,copy) NSString *acc_totalSales;
/** 累计佣金 */
@property (nonatomic,copy) NSString *acc_totalCommission;
/** 本月销售额 */
@property (nonatomic,copy) NSString *thisMonthSales;
/** 本月佣金 */
@property (nonatomic,copy) NSString *thisMonthCommission;
/** 今日销售额 */
@property (nonatomic,copy) NSString *todaySales;
/** 是否设置提现密码 */
@property (nonatomic,assign) BOOL isSetaccountPwd;
/** model */
@property (nonatomic,strong) HYMyWalletModel *model;

@property (nonatomic,strong) RACSubject *backActionSubject;


- (void)setWithModel:(HYMyWalletModel *)model;

- (void)getMyWalletInfo:(BOOL)isViewWillAppear;

@end

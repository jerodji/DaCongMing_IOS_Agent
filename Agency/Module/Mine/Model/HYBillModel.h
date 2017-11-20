//
//  HYBillModel.h
//  Agency
//
//  Created by Jack on 2017/11/16.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYBillModel : HYBaseModel

@property (nonatomic,copy) NSString *guid;
@property (nonatomic,copy) NSString *account_id;
@property (nonatomic,copy) NSString *opening_balance;
@property (nonatomic,copy) NSString *trade_type;
@property (nonatomic,copy) NSString *amount;
@property (nonatomic,copy) NSString *closing_balance;
@property (nonatomic,copy) NSString *sorder_id;
@property (nonatomic,copy) NSString *stat;
@property (nonatomic,copy) NSString *create_time;


@end

/**
 
 {
 "guid": null,
 "account_id": null,
 "opening_balance": 0,
 "trade_type": "Commission2Account",
 "amount": 0.016,
 "closing_balance": 0,
 "sorder_id": "010201711131000001843141865",
 "stat": null,
 "create_time": "2017-11-13 17:22:33.0"
 }
 */

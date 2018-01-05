//
//  HYRecommendInfoModel.h
//  Agency
//
//  Created by Jack on 2018/1/4.
//  Copyright © 2018年 胡勇. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 "id": 4,
 "agent_level": "V5",
 "bonus_ratio": 0.2,
 "repayment_ratio": 0.3,
 "repay_bonus_ratio": 0.5,
 "title": "高级合伙人",
 "illustrate": "可以发展自己的客户和经销商团队并推荐他人成为合伙人及经销商",
 "rb_account": "31050180480000000238",
 "rb_account_title": "上海萨拜电子商务有限公司",
 "rb_bankinfo": "中国建设银行股份有限公司上海广富林路支行"
 */

@interface HYRecommendInfoModel : NSObject

@property (nonatomic,copy) NSString *agent_level;
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *bonus_ratio;
@property (nonatomic,copy) NSString *repayment_ratio;
@property (nonatomic,copy) NSString *repay_bonus_ratio;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *illustrate;
@property (nonatomic,copy) NSString *rb_account;
@property (nonatomic,copy) NSString *rb_account_title;
@property (nonatomic,copy) NSString *rb_bankinfo;

@end

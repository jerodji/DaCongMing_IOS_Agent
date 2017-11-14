//
//  HYReportListModel.h
//  Agency
//
//  Created by 胡勇 on 2017/11/13.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYReportListModel : NSObject

@property (nonatomic,copy) NSString *totalAmount;
@property (nonatomic,copy) NSString *orderCount;
@property (nonatomic,copy) NSString *totalCommission;
@property (nonatomic,copy) NSArray *dataList;

@end

//
//  HYReportSelectCellModel.h
//  Agency
//
//  Created by 胡勇 on 2017/11/6.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseCellViewModel.h"

@interface HYReportSelectCellModel : HYBaseCellViewModel


/** 开始时间 */
@property (nonatomic,copy) NSString *startTimeStr;
/** 结束时间 */
@property (nonatomic,copy) NSString *endTimeStr;
/** 订单号 */
@property (nonatomic,copy) NSString *orderNo;
/** 是否入帐 */
@property (nonatomic,assign)BOOL isEntry;
/** 查询到结果 */
@property (nonatomic,strong) RACSubject *selectResultSubject;

- (void)showStartValueSelectView;

- (void)showEndValueSelectView;

- (void)selectReports;

@end

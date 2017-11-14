//
//  HYReportCellViewModel.h
//  Agency
//
//  Created by 胡勇 on 2017/11/13.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseCellViewModel.h"
#import "HYReportModel.h"

@interface HYReportCellViewModel : HYBaseCellViewModel

@property (nonatomic,copy) NSString *headImageUrl;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *timeStr;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *orderID;
@property (nonatomic,assign) BOOL state;
@property (nonatomic,assign) BOOL isReceive;
@property (nonatomic,strong) HYReportModel *model;

- (RACSignal *)drawDownBtnIsInvalid;

- (instancetype)initWithModel:(HYReportModel *)model;

- (void)drawDownTheReport;

@end

//
//  HYReportCellViewModel.m
//  Agency
//
//  Created by 胡勇 on 2017/11/13.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYReportCellViewModel.h"

@implementation HYReportCellViewModel

- (instancetype)initWithModel:(HYReportModel *)model{
    
    if (self = [super init]) {
        
        self.model = model;
        [self setupData];
    }
    return self;
}

- (void)setupData{
    
    RAC(self,title) = RACObserve(self.model, buyer_name);
    RAC(self,headImageUrl) = RACObserve(self.model, buyer_head_image);
    RAC(self,timeStr) = RACObserve(self.model, create_time);
    RAC(self,price) = RACObserve(self.model, commission);
    RAC(self,state) = [RACObserve(self.model, isreceive) map:^id(id value) {
      
        return @([value boolValue]);
    }];
    RAC(self,orderID) = RACObserve(self.model, sorder_id);
}

- (void)drawDownTheReport{
    
    [HYUserRequestHandle drawDownTheReportWithOrderID:self.orderID ComplectionBlock:^(BOOL isSuccess) {
       
        if (isSuccess) {
            
            self.model.stat = @"1";
            [JRToast showWithText:@"领取成功"];
        }
    }];
}

@end

//
//  HYMyWalletViewModel.m
//  Agency
//
//  Created by 胡勇 on 2017/11/8.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYMyWalletViewModel.h"

@interface HYMyWalletViewModel()

/** model */
@property (nonatomic,strong) HYMyWalletModel *model;

@end

@implementation HYMyWalletViewModel

- (instancetype)init{
    
    if (self = [super init]) {
        
        [self initializeSignal];
    }
    return self;
}

- (void)initializeSignal{
    
    _backActionSubject = [RACSubject subject];

}

- (void)getMyWalletInfo{
    
    [HYUserRequestHandle getMyWalletComplectionBlock:^(HYMyWalletModel *model) {
       
        self.model = model;
        
        RAC(self,balance) = RACObserve(model, balance);
        RAC(self,acc_totalSales) = RACObserve(self.model, acc_totalSales);
        RAC(self,acc_totalCommission) = RACObserve(self.model, acc_totalCommission);
        RAC(self,thisMonthSales) = RACObserve(self.model, thisMonthSales);
        RAC(self,thisMonthCommission) = RACObserve(self.model, thisMonthCommission);
        RAC(self,todaySales) = RACObserve(self.model, todaySales);
        RAC(self,isSetaccountPwd) = [RACObserve(self.model, isSetaccountPwd) map:^id(id value) {
           
            return @([value integerValue]);
        }];
        
        DLog(@"-----:%@",self.balance);
    }];
}

- (void)setWithModel:(HYMyWalletModel *)model{
    
    self.model = model;
    
}


@end
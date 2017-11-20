
//
//  HYRecommendViewModel.m
//  Agency
//
//  Created by Jack on 2017/11/20.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYRecommendViewModel.h"

@implementation HYRecommendViewModel

- (instancetype)init{
    
    if (self = [super init]) {
        
        [self initializeSignal];
    }
    return self;
}

- (void)initializeSignal{
    
    _confirmSuccessSubject = [RACSubject subject];
}

- (RACSignal *)confirmButtonIsValid{
    
    RACSignal *recommendedSignal = RACObserve(self, recommendedID);
    RACSignal *payerNameSignal = RACObserve(self, payerName);
    RACSignal *payAccountSignal = RACObserve(self, payAccount);
    RACSignal *phoneNumSignal = RACObserve(self, phoneNum);

    RACSignal *isValid = [RACSignal combineLatest:@[_recommendedID,payerNameSignal,payAccountSignal,phoneNumSignal] reduce:^id{
        
        return @([_recommendedID isNotBlank] && [_payerName isNotBlank] && [_payAccount isNotBlank]  && _phoneNum.length == 11);
    }];
    
    return isValid;
}

- (void)confirmAction{
    
    
}

@end

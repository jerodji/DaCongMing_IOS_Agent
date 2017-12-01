
//
//  HYRecommendViewModel.m
//  Agency
//
//  Created by Jack on 2017/11/20.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYRecommendViewModel.h"

@interface HYRecommendViewModel()

@property (nonatomic,strong) RACSignal *recommendedSignal;
@property (nonatomic,strong) RACSignal *payerNameSignal;
@property (nonatomic,strong) RACSignal *payAccountSignal;
@property (nonatomic,strong) RACSignal *phoneNumSignal;


@end

@implementation HYRecommendViewModel

- (instancetype)init{
    
    if (self = [super init]) {
        
        [self initializeSignal];
    }
    return self;
}

- (void)initializeSignal{
    
    self.RecommendSelectLevel = RecommendLevelSenior;
    _recommendedSignal = RACObserve(self, recommendedID);
    _payerNameSignal = RACObserve(self, payerName);
    _payAccountSignal = RACObserve(self, payAccount);
    _phoneNumSignal = RACObserve(self, phoneNum);
    _confirmSuccessSubject = [RACSubject subject];
}

#pragma mark - setter
- (void)setRecommendSelectLevel:(RecommendLevel)RecommendSelectLevel{
    
    _RecommendSelectLevel = RecommendSelectLevel;
    switch (RecommendSelectLevel) {
        case RecommendLevelSenior:
        {
            self.selectStr = @"已选择:高级合伙人";
            self.selectTips = @"即拥有大聪明APP最高级别权限，有全部推荐权，可组建自己的专属销售团队。可享有公司合伙人权限最高级别的分红与返利。";
        }
            break;
        case RecommendLevelPractice:
        {
            self.selectStr = @"已选择:实习合伙人";
            self.selectTips = @"即高级合伙人的实习期，拥有全部推荐权，亦可组建专属销售团队。可享有合伙人权限的部分分红与返利，完成实习条件自动升级为高级合伙人";
        }
            break;
        case RecommendLevelSeniorAgent:
        {
            self.selectStr = @"已选择:高级经销商";
            self.selectTips = @"即是大聪明APP的经销商。拥有部分推荐权，可加入高级合伙人或实习合伙人的团队，不可组建专属销售团队。可享有经销商权限的分红和返利。";
        }
            break;
        case RecommendLevelPracticeAgent:
        {
            self.selectStr = @"已选择:实习经销商";
            self.selectTips = @"即是高级经销商的实习期，拥有部分部分推荐权。可加入高级合伙人或实习合伙人的团队，不可组建专属销售团队。可享有经销商权限的部分分红和返利，完成实习条件自动升级为高级经销商";
        }
            break;
        default:
            break;
    }
}

- (RACSignal *)confirmButtonIsValid{
    
    
    RACSignal *isValid = [_recommendedSignal map:^id(id value) {
        
        return @(_recommendedID.length >= 3);
    }];
    
    return isValid;
    
}

- (void)confirmAction{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:_recommendedID forKey:@"recomer_id"];
    switch (_RecommendSelectLevel) {
        case RecommendLevelSenior:
            [dict setValue:@"V5" forKey:@"recomLevel"];
            break;
        case RecommendLevelPractice:
            [dict setValue:@"V4" forKey:@"recomLevel"];
            break;
        case RecommendLevelSeniorAgent:
            [dict setValue:@"V3" forKey:@"recomLevel"];
            break;
        case RecommendLevelPracticeAgent:
            [dict setValue:@"V2" forKey:@"recomLevel"];
            break;
        default:
            break;
    }
    
    if (_RecommendSelectLevel == RecommendLevelSenior || _RecommendSelectLevel == RecommendLevelSeniorAgent) {
        
        [dict setValue:_payAccount forKey:@"bankCard_id"];
        [dict setValue:_payerName forKey:@"payer_name"];
        [dict setValue:_phoneNum forKey:@"payer_phoneNum"];

    }
    
    [HYUserRequestHandle recommendParterWithDict:dict ComplectionBlock:^(BOOL isSuccess) {
       
        if (isSuccess) {
            
            [self.confirmSuccessSubject sendNext:@"ok"];
        }
    }];
}

@end

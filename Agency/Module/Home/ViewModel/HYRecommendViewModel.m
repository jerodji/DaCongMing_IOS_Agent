
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
            self.selectTips = @"高级合伙人是个什么WAN，年费收费的十几分防守打法你知道吗，发什么呆沙比玩意，电话费附加税快递费发酒疯";
        }
            break;
        case RecommendLevelPractice:
        {
            self.selectStr = @"已选择:实习合伙人";
            self.selectTips = @"实习合伙人是个什么WAN，年费收费的十几分防守打法你知道吗，发什么呆沙比玩意，电话费附加税快递费发酒疯";
        }
            break;
        case RecommendLevelSeniorAgent:
        {
            self.selectStr = @"已选择:高级代理人";
            self.selectTips = @"高级代理人是个什么WAN，年费收费的十几分防守打法你知道吗，发什么呆沙比玩意，电话费附加税快递费发酒疯";
        }
            break;
        case RecommendLevelPracticeAgent:
        {
            self.selectStr = @"已选择:实习代理人";
            self.selectTips = @"实习代理人是个什么WAN，年费收费的十几分防守打法你知道吗，发什么呆沙比玩意，电话费附加税快递费发酒疯";
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

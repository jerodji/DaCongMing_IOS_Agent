//
//  HYRecommendViewModel.h
//  Agency
//
//  Created by Jack on 2017/11/20.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, RecommendLevel) {
    
    RecommendLevelSenior = 0,
    RecommendLevelPractice,
    RecommendLevelSeniorAgent,
    RecommendLevelPracticeAgent
};

@interface HYRecommendViewModel : NSObject

@property (nonatomic,assign) RecommendLevel RecommendSelectLevel;
@property (nonatomic,copy) NSString *selectStr;
@property (nonatomic,copy) NSString *selectTips;
@property (nonatomic,copy) NSString *recommendedID;
@property (nonatomic,copy) NSString *payerName;
@property (nonatomic,copy) NSString *payAccount;
@property (nonatomic,copy) NSString *phoneNum;
@property (nonatomic,copy) NSString *authBtnTitle;
@property (nonatomic,strong) NSMutableArray *recommendModelArray;
@property (nonatomic,strong) RACSubject *confirmSuccessSubject;

- (RACSignal *)confirmButtonIsValid;

- (void)confirmAction;

@end

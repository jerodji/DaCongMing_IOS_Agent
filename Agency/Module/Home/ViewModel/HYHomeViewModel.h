//
//  HYHomeViewModel.h
//  Agency
//
//  Created by 胡勇 on 2017/11/3.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYHomeViewModel : NSObject


@property (nonatomic,copy) NSString *headImgUrlStr;
@property (nonatomic,copy) NSString *nickName;
@property (nonatomic,copy) NSString *money;


@property (nonatomic,strong) RACSignal *nickNameSignal;
@property (nonatomic,strong) RACSignal *headerImgSigal;

@property (nonatomic,strong) RACSubject *jumpToMyTeam;
@property (nonatomic,strong) RACSubject *jumpToReportVC;
@property (nonatomic,strong) RACSubject *jumpToBankCardVC;
@property (nonatomic,strong) RACSubject *jumpToAuthVC;

@property (nonatomic,strong) RACSubject *buttonSubject;


- (void)setWithUserModel:(HYUserModel *)userModel;

@end

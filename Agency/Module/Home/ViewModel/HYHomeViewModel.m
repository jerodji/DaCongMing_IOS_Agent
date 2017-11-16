//
//  HYHomeViewModel.m
//  Agency
//
//  Created by 胡勇 on 2017/11/3.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYHomeViewModel.h"

@interface HYHomeViewModel()



@end

@implementation HYHomeViewModel

- (instancetype)init{
    
    if (self = [super init]) {
        
        [self initializeSignal];
    }
    return self;
}

- (void)initializeSignal{
    
    _jumpToMyTeam = [RACSubject subject];
    _jumpToReportVC = [RACSubject subject];
    _jumpToBankCardVC = [RACSubject subject];
    _jumpToAuthVC = [RACSubject subject];
    
    _buttonSubject = [RACSubject subject];

    
}

- (void)setWithUserModel:(HYUserModel *)userModel{
    
    RAC(self,nickName) = RACObserve(userModel,userInfo.name);
    RAC(self,headImgUrlStr) = RACObserve(userModel, userInfo.head_image_url);
}

@end

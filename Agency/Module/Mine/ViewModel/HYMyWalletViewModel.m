//
//  HYMyWalletViewModel.m
//  Agency
//
//  Created by 胡勇 on 2017/11/8.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYMyWalletViewModel.h"

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


@end

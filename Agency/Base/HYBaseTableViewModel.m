//
//  HYBaseTableViewModel.m
//  Agency
//
//  Created by 胡勇 on 2017/11/6.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseTableViewModel.h"

@implementation HYBaseTableViewModel

- (instancetype)init{
    
    if (self = [super init]) {
        
        [self initializeProperty];
    }
    return self;
}

- (void)initializeProperty{
    
    _backgroundColor = KAPP_TableView_BgColor;
    _separatorColor = KAPP_SEPERATOR_COLOR;
}


#pragma mark - lazyload
- (NSMutableArray *)datalist{
    
    if (!_datalist) {
        
        _datalist = [NSMutableArray array];
    }
    return _datalist;
}

@end

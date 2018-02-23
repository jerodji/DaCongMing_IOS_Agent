//
//  HYBankCardCellModel.m
//  Agency
//
//  Created by Jack on 2017/11/16.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBankCardCellModel.h"

@interface HYBankCardCellModel()

@end


@implementation HYBankCardCellModel

- (instancetype)initWithModel:(HYBankCardModel *)model{
    
    if (self = [super init]) {
        
        self.bank_name = model.bank_name;
        self.bankcard_id = model.bankcard_id;
        self.model = model;
    }
    return self;
}








@end

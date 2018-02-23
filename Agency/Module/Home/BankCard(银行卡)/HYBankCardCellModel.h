//
//  HYBankCardCellModel.h
//  Agency
//
//  Created by Jack on 2017/11/16.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYBankCardModel.h"

@interface HYBankCardCellModel : NSObject

@property (nonatomic,copy) NSString *bank_name;
@property (nonatomic,copy) NSString *bankcard_id;
@property (nonatomic,strong) HYBankCardModel *model;




- (instancetype)initWithModel:(HYBankCardModel *)model;


- (void)relieveBind;

@end

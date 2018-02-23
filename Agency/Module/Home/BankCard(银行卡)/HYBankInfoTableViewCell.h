//
//  HYBankInfoTableViewCell.h
//  Agency
//
//  Created by Jack on 2017/11/16.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYBankCardCellModel.h"

typedef void(^RemoveCardBLK)(void);

@interface HYBankInfoTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *addTimeLabel;

@property (nonatomic,weak) UIViewController * targetVC;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,copy) RemoveCardBLK clickRemoveCardCB;

- (void)setupWithCellModel:(HYBankCardCellModel *)cellModel;

@end

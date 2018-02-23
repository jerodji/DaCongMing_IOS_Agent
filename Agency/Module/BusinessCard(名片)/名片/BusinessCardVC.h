//
//  BusinessCardVC.h
//  Agency
//
//  Created by hailin on 2018/1/29.
//  Copyright © 2018年 胡勇. All rights reserved.
//

#import "HYBaseViewController.h"
#import "BusinessCardModel.h"

@interface BusinessCardVC : HYBaseViewController
@property (nonatomic,strong) NSArray<BusinessCardModel*> * cardModels;
- (instancetype)init;
@end

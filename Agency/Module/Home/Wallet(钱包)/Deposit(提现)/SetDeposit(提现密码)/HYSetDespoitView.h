//
//  HYSetDespoitView.h
//  Agency
//
//  Created by 胡勇 on 2017/11/9.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYSetDepositViewModel.h"

typedef void (^INFOBLK)(NSString* crashPwd);

@interface HYSetDespoitView : UIView

@property (nonatomic,assign) BOOL removeBankCard;
@property (nonatomic,copy) INFOBLK infoCB;

- (void)setWithViewModel:(HYSetDepositViewModel *)viewModel;


@end

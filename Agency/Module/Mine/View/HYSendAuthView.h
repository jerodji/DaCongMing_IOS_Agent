//
//  HYSendAuthView.h
//  Agency
//
//  Created by 胡勇 on 2017/11/8.
//  Copyright © 2017年 胡勇. All rights reserved.
//

/** 完善信息发送验证码 */

#import <UIKit/UIKit.h>
#import "HYUploadIDCardViewModel.h"

@interface HYSendAuthView : UIView

/** 是否是绑定银行卡   0为实名认证 */
@property (nonatomic,assign) BOOL isBindBankCard;

- (void)setWithViewModel:(HYUploadIDCardViewModel *)viewModel;

@end

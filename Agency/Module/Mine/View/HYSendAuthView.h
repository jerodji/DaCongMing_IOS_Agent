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

- (void)setWithViewModel:(HYUploadIDCardViewModel *)viewModel;

@end

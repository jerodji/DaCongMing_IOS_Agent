//
//  HYSetDepositTipsView.h
//  Agency
//
//  Created by 胡勇 on 2017/11/9.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JumpToSettingVC)(void);

@interface HYSetDepositTipsView : UIView

/** 去设置 */
@property (nonatomic,strong) JumpToSettingVC jumpToSettingVCBlock;

- (void)showTipsView;

@end

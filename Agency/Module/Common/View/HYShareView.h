//
//  HYShareView.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/22.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYShareView : UIView

/** 分享的 */
@property (nonatomic,strong) NSDictionary *shareDict;

- (void)showShareView;

@end

//
//  HYLoginRequestManager.h
//  Agency
//
//  Created by 胡勇 on 2017/11/2.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYLoginRequestManager : NSObject

/**
 *  微信登录
 */
+ (void)weChatLoginWithProgram:(NSDictionary *)dict ComplectionBlock:(void(^)(NSDictionary *result))complection;

@end

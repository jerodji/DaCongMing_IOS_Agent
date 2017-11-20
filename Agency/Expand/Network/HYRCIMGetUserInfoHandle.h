//
//  HYRCIMGetUserInfoHandle.h
//  Agency
//
//  Created by Jack on 2017/11/18.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYRCIMGetUserInfoHandle : NSObject

/** Id获取好友的用户信息 */
+ (void)getUserInfo:(NSString *)userId completion:(void (^)(RCUserInfo *user))completion;

/** 获取群组信息 */
+ (void)getGroupInfo:(NSString *)groupID completion:(void (^)(RCGroup *group))completion;

@end

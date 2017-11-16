//
//  HYDataBaseManager.h
//  Agency
//
//  Created by Jack on 2017/11/16.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYDataBaseManager : NSObject

+ (instancetype)shareInstance;

/** 将融云的用户信息插入数据库 */
- (void)insertRCUserToDB:(RCUserInfo *)RCUser;

/** 删除用户信息 */
- (RCUserInfo *)removeRCUserById:(NSString *)userId;



@end

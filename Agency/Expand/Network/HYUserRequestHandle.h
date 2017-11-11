//
//  HYUserRequestHandle.h
//  Agency
//
//  Created by 胡勇 on 2017/11/8.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYMyWalletModel.h"

@interface HYUserRequestHandle : NSObject

/**
 *  微信登录
 */
+ (void)weChatLoginWithProgram:(NSDictionary *)dict ComplectionBlock:(void(^)(NSDictionary *result))complection;

/**
 *  手机号登录
 */
+ (void)LoginWithPhone:(NSString *)phone password:(NSString *)password ComplectionBlock:(void(^)(NSDictionary *result))complection;

/**
 *  获取手机验证码
 */
+ (void)getAuthCodeWithPhone:(NSString *)phone ComplectionBlock:(void(^)(BOOL isSuccess))complection;

/**
 *  验证手机验证码
 */
+ (void)verifyAuthCodeWithPhone:(NSString *)phone authCode:(NSString *)authCode ComplectionBlock:(void(^)(BOOL isSuccess))complection;

/**
 *  绑定手机
 */
+ (void)bindPhone:(NSString *)phone authCode:(NSString *)authCode ComplectionBlock:(void(^)(BOOL isSuccess))complection;


/**
 *  设置用户名
 */
+ (void)setUserNameComplectionBlock:(void(^)(BOOL isSuccess))complection;

/**
 *  上传身份证银行卡信息
 */
+ (void)uploadIDCardInfoWithName:(NSString *)name IDCardNum:(NSString *)IDCardNum bankCardNum:(NSString *)bankCardNum authCode:(NSString *)authCode ComplectionBlock:(void(^)(BOOL isSuccess))complection;

/**
 *  获取账户信息
 */
+ (void)getAccountInfoComplectionBlock:(void(^)(NSDictionary *result))complection;

/**
 *  设置提现密码
 */
+ (void)setDepositPassword:(NSString *)password andAuthCode:(NSString *)authCode ComplectionBlock:(void(^)(BOOL isSuccess))complection;

/**
 *  查询报表信息
 */
+ (void)selectReportInfoWithStartTime:(NSString *)startTime endTime:(NSString *)endTime isEntry:(BOOL)isEntry ComplectionBlock:(void(^)(NSArray *datalist))complection;

/**
 *  获取我的钱包
 */
+ (void)getMyWalletComplectionBlock:(void(^)(HYMyWalletModel *model))complection;

/**
 *  提现
 */
+ (void)DepositWithMoney:(NSString *)money password:(NSString *)password ComplectionBlock:(void(^)(BOOL isSuccess))complection;

@end

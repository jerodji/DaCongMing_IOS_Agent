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
 *  刷新用户数据
 */
+ (void)refreshUserInfo;

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
+ (void)bindPhone:(NSString *)phone authCode:(NSString *)authCode  ComplectionBlock:(void(^)(BOOL isSuccess))complection;


/**
 *  设置用户名
 */
+ (void)setUserNameComplectionBlock:(void(^)(BOOL isSuccess))complection;

/**
 *  上传身份证银行卡信息
 */
//+ (void)uploadIDCardInfoWithName:(NSString *)name IDCardNum:(NSString *)IDCardNum bankCardNum:(NSString *)bankCardNum authCode:(NSString *)authCode ComplectionBlock:(void(^)(BOOL isSuccess))complection;
+ (void)uploadIDCardInfoWithName:(NSString *)name
                       IDCardNum:(NSString *)IDCardNum
                     bankCardNum:(NSString *)bankCardNum
                        phoneNum:(NSString *)phone
                        authCode:(NSString *)authCode
                ComplectionBlock:(void (^)(BOOL))complection;
/**
 *  绑定银行卡
 */
//+ (void)bindBankCardWithName:(NSString *)name IDCardNum:(NSString *)IDCardNum bankCardNum:(NSString *)bankCardNum authCode:(NSString *)authCode ComplectionBlock:(void(^)(BOOL isSuccess))complection;
+ (void)bindBankCardWithName:(NSString *)name
                   IDCardNum:(NSString *)IDCardNum
                 bankCardNum:(NSString *)bankCardNum
                    pboneNum:(NSString *)phone
                    authCode:(NSString *)authCode
            ComplectionBlock:(void (^)(BOOL))complection;

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
+ (void)selectReportInfoWithStartTime:(NSString *)startTime endTime:(NSString *)endTime isEntry:(BOOL)isEntry ComplectionBlock:(void(^)(NSDictionary *dict))complection;

/**
 *  获取我的钱包
 */
+ (void)getMyWalletWithViewWillAppear:(BOOL)isViewWillAppear ComplectionBlock:(void(^)(HYMyWalletModel *model))complection;

/**
 *  提现
 */
+ (void)DepositWithMoney:(NSString *)money password:(NSString *)password bandCardID:(NSString *)bankCardID ComplectionBlock:(void(^)(BOOL isSuccess))complection;

/**
 *  领取结算单
 */
+ (void)drawDownTheReportWithOrderID:(NSString *)orderID ComplectionBlock:(void(^)(BOOL isSuccess))complection;

/**
 *  获取团队成员
 */
+ (void)getTeamMemberWithGroupID:(NSString *)groupID ComplectionBlock:(void(^)(NSDictionary *dict))complection;

/**
 *  推荐合伙人
 */
+ (void)recommendParterWithDict:(NSDictionary *)dict ComplectionBlock:(void(^)(BOOL isSuccess))complection;

/**
 *  查询订单数据
 */
+ (void)getBillDataWithPageNo:(NSInteger)pageNO ComplectionBlock:(void(^)(NSArray *datalist))complection;

/**
 *  获取绑定银行卡列表
 */
+ (void)getBankCardListComplectionBlock:(void(^)(NSArray *datalist))complection;

/**
 *  获取所有的文章列表
 */
+ (void)getAllArticleListWithPageNo:(NSInteger)pageNO ComplectionBlock:(void(^)(NSArray *datalist))complection;

/**
 *  设置登录密码
 */
+ (void)setPasswordWithPhone:(NSString *)phone password:(NSString *)password authCode:(NSString *)authCode ComplectionBlock:(void(^)(BOOL isSuccess))complection;

/**
 *  获取推荐信息
 */
+ (void)getRecommendDataComplectionBlock:(void(^)(NSArray *datalist))complection;

@end


//
//  WebApi.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#ifndef WebApi_h
#define WebApi_h

#define WXAppID                 @"wx7520b242e7e6776c"
#define TencentBuglyID          @"62a0980d1e"
#define QIYUAPPID               @"c8f8ca70f45342c288cb2e23e0c6b600"
#define RONGCLOUD_IM_APPKEY     @"bmdehs6pb1jrs"




/** ------------------------------网络接口------------------------------- */
//接口总域名
#define API_DomainStr           @"https://www.laopdr.cn"

/********************************用户相关*********************************/
#pragma mark - 用户相关
//登录
#define API_Login               @"HAILIN_AGENT_SERVER/userlogin.do"

//退出登录
#define API_Logout               @"HAILIN_AGENT_SERVER/userLoginOut.do"

//微信登录
#define API_WeChatLogin         @"HAILIN_AGENT_SERVER/wechatLogin.do"

//获取验证码
#define API_GetAuthCode         @"HAILIN_AGENT_SERVER/getPhoneCode.do"

//验证手机验证码 绑定手机同一个接口
#define API_VerifyAuthCode        @"HAILIN_AGENT_SERVER/checkPhoneCode.do"

//设置密码
#define API_SetPassword           @"HAILIN_AGENT_SERVER/setUserPwd.do"

//实名认证
#define API_Certification           @"HAILIN_AGENT_SERVER/userAuth.do"

//绑定银行卡
#define API_BindBankCard           @"HAILIN_AGENT_SERVER/bankCardBundling.do"


//设置提现密码
#define API_SetDepositPassword           @"HAILIN_AGENT_SERVER/setWithdrawCashPwd.do"

//提现
#define API_Deposit                     @"HAILIN_AGENT_SERVER/withdrawCash.do"

//查询报表信息
#define API_SelectReportInfo           @"HAILIN_AGENT_SERVER/getMyRF.do"

//获取钱包信息
#define API_GetMyWalletInfo           @"HAILIN_AGENT_SERVER/getUserAccount.do"

//领取结算单
#define API_DrawDownReport            @"HAILIN_AGENT_SERVER/commission2UserAccount.do"

//获取账单
#define API_GetBillInfo           @"HAILIN_AGENT_SERVER/queryAccountStream.do"

//推荐合伙人
#define API_RecommendParter           @"HAILIN_AGENT_SERVER/recomPartner.do"

//获取绑定银行卡列表
#define API_GetBankCardList           @"HAILIN_AGENT_SERVER/getBankCardList.do"

//获取文章列表
#define API_GetArticleList           @"HAILIN_AGENT_SERVER/articleList.do"


#pragma mark - 融云
/********************************融云IM*********************************/
//获取群组成员列表
#define API_GetTeamMember            @"HAILIN_AGENT_SERVER/queryGroupMember.do"

//根据用户ID获取用户信息
#define API_GetRCIMUserInfo            @"HAILIN_AGENT_SERVER/getGroupMemberInfo.do"

//获取群信息
#define API_GetGroupInfo            @"HAILIN_AGENT_SERVER/getGroupInfo.do"

#endif /* WebApi_h */

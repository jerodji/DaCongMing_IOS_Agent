
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
#define TencentBuglyID          @"fee8e3dbb9"
#define QIYUAPPID               @"c8f8ca70f45342c288cb2e23e0c6b600"

/** ------------------------------网络接口------------------------------- */
//接口总域名
#define API_DomainStr           @"http://www.laopdr.cn"

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

//验证手机验证码
#define API_VerifyAuthCode        @"HAILIN_AGENT_SERVER/checkPhoneCode.do"

//设置密码
#define API_SetPassword           @"HAILIN_AGENT_SERVER/setUserPwd.do"


#endif /* WebApi_h */

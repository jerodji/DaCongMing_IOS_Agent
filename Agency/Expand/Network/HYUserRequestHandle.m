
//
//  HYUserRequestHandle.m
//  Agency
//
//  Created by 胡勇 on 2017/11/8.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYUserRequestHandle.h"

@implementation HYUserRequestHandle

+ (void)weChatLoginWithProgram:(NSDictionary *)dict ComplectionBlock:(void (^)(NSDictionary *))complection{
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_WeChatLogin withParameter:dict isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code = [[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                NSDictionary *dataInfo = [returnData objectForKey:@"data"];
                HYUserModel *user = [HYUserModel sharedInstance];
                [user modelSetWithDictionary:dataInfo];
                
                //归档
                [HYPlistTools archiveObject:user withName:KUserModelData];
                complection(dataInfo);
                
                [JRToast showWithText:@"微信登录成功" duration:2];
               
               //登录融云
               NSString *userId = [HYUserModel sharedInstance].userInfo.id;
               NSString *name = [HYUserModel sharedInstance].userInfo.name;
               NSString *portrait = [HYUserModel sharedInstance].userInfo.head_image_url;
               RCUserInfo *_currentUserInfo = [[RCUserInfo alloc] initWithUserId:userId name:name portrait:portrait];
               [RCIM sharedRCIM].currentUserInfo = _currentUserInfo;
               
               NSString *token = [HYUserModel sharedInstance].rong_token;
               [[RCIM sharedRCIM] connectWithToken:token     success:^(NSString *userId) {
                  NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
               } error:^(RCConnectErrorCode status) {
                  NSLog(@"登陆的错误码为:%ld", (long)status);
               } tokenIncorrect:^{
                  //token过期或者不正确。
                  NSLog(@"token错误");
               }];

            }
            else{
                
                complection(nil);
                [JRToast showWithText:@"login error"];
            }
        }
        else{
            
            complection(nil);
            [JRToast showWithText:@"wechat login error"];
        }
    }];
}

+ (void)LoginWithPhone:(NSString *)phone password:(NSString *)password ComplectionBlock:(void (^)(NSDictionary *))complection{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:phone forKey:@"user_phone"];
    [param setValue:password forKey:@"user_pwd"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_Login withParameter:param isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code = [[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                NSDictionary *dataInfo = [returnData objectForKey:@"data"];
                HYUserModel *user = [HYUserModel sharedInstance];
                [user modelSetWithDictionary:dataInfo];
                
                //归档
                [HYPlistTools archiveObject:user withName:KUserModelData];
                complection(dataInfo);
                [JRToast showWithText:@"登录成功" duration:2];
               
               //登录融云
               NSString *userId = [HYUserModel sharedInstance].userInfo.id;
               NSString *name = [HYUserModel sharedInstance].userInfo.name;
               NSString *portrait = [HYUserModel sharedInstance].userInfo.head_image_url;
               RCUserInfo *_currentUserInfo = [[RCUserInfo alloc] initWithUserId:userId name:name portrait:portrait];
               [RCIM sharedRCIM].currentUserInfo = _currentUserInfo;
               
               NSString *token = [HYUserModel sharedInstance].rong_token;
               [[RCIM sharedRCIM] connectWithToken:token     success:^(NSString *userId) {
                  NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
               } error:^(RCConnectErrorCode status) {
                  NSLog(@"登陆的错误码为:%ld", (long)status);
               } tokenIncorrect:^{
                  //token过期或者不正确。
                  NSLog(@"token错误");
               }];

            }
            else{
                
                complection(nil);
                [JRToast showWithText:[returnData valueForKey:@"message"]];
            }
        }
        else{
            
            complection(nil);
            [JRToast showWithText:@"账号登录失败"];
        }
    }];
}

+ (void)getAuthCodeWithPhone:(NSString *)phone ComplectionBlock:(void (^)(BOOL))complection{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:phone forKey:@"phoneNum"];
    [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];

    [[HTTPManager shareHTTPManager] postDataFromUrl:API_GetAuthCode withParameter:param isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code = [[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                complection(YES);
                //[JRToast showWithText:@"获取验证码成功" duration:2];

            }
            else{
                
                complection(NO);
                [JRToast showWithText:[returnData valueForKey:@"message"] duration:2];

            }
        }
        else{
            
            complection(NO);
            [JRToast showWithText:@"获取验证码出现问题" duration:2];
        }
    }];
}

+ (void)verifyAuthCodeWithPhone:(NSString *)phone authCode:(NSString *)authCode ComplectionBlock:(void (^)(BOOL))complection{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:phone forKey:@"phoneNum"];
    [param setValue:authCode forKey:@"phoneCode"];
    [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_VerifyAuthCode withParameter:param isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code =[[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                complection(YES);
                [JRToast showWithText:@"校验验证码成功" duration:2];

            }
            else{
                
                complection(NO);
                [JRToast showWithText:[returnData valueForKey:@"message"] duration:2];
                
            }
        }
        else{
            complection(NO);
            [JRToast showWithText:@"校验验证码失败" duration:2];
        }
    }];
}

+ (void)bindPhone:(NSString *)phone authCode:(NSString *)authCode ComplectionBlock:(void (^)(BOOL))complection{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:phone forKey:@"phoneNum"];
    [param setValue:@"phone_check001" forKey:@"check_type"];
    [param setValue:authCode forKey:@"phoneCode"];
    [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_VerifyAuthCode withParameter:param isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code =[[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                complection(YES);
            }
            else{
                
                complection(NO);
                [JRToast showWithText:[returnData valueForKey:@"message"]];
                
            }
        }
        else{
            
            complection(NO);
            [JRToast showWithText:@"绑定手机失败" duration:2];
        }
    }];
}

+ (void)getAccountInfoComplectionBlock:(void (^)(NSDictionary *))complection{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_Login withParameter:param isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code = [[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                NSDictionary *dict = [returnData objectForKey:@"data"];
                complection(dict);
            }
            else{
                
                complection(nil);
                [JRToast showWithText:[returnData valueForKey:@"message"]];
                
            }
        }
        else{
            
            complection(nil);
            [JRToast showWithText:[returnData valueForKey:@"message"] duration:2];
        }
    }];
}


+ (void)uploadIDCardInfoWithName:(NSString *)name IDCardNum:(NSString *)IDCardNum bankCardNum:(NSString *)bankCardNum authCode:(NSString *)authCode ComplectionBlock:(void (^)(BOOL))complection{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [param setValue:name forKey:@"real_name"];
    [param setValue:IDCardNum forKey:@"card_id"];
    [param setValue:bankCardNum forKey:@"bankCard_no"];
    [param setValue:[HYUserModel sharedInstance].userInfo.phone forKey:@"phoneNum"];
    [param setValue:authCode forKey:@"phoneCode"];

    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_Certification withParameter:param isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code = [[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                //NSDictionary *dict = [returnData objectForKey:@"data"];
                complection(YES);
            }
            else{
                
                complection(NO);
                [JRToast showWithText:[returnData valueForKey:@"message"] duration:2];
                
            }
        }
        else{
            
            complection(NO);
            [JRToast showWithText:@"完善信息失败" duration:2];
        }
    }];
}

+ (void)setDepositPassword:(NSString *)password andAuthCode:(NSString *)authCode ComplectionBlock:(void (^)(BOOL))complection{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:password forKey:@"withDrawCashPwd"];
    [param setValue:password forKey:@"repwithDrawCashPwd"];
    [param setValue:authCode forKey:@"phoneCode"];
    [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [param setValue:[HYUserModel sharedInstance].userInfo.phone forKey:@"phoneNum"];
    
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_SetDepositPassword withParameter:param isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code =[[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                complection(YES);
            }
            else{
                
                complection(NO);
                [JRToast showWithText:[returnData valueForKey:@"message"]];
                
            }
        }
        else{
            
            complection(NO);
            [JRToast showWithText:@"设置提现密码失败" duration:2];
        }
    }];
}

+ (void)selectReportInfoWithStartTime:(NSString *)startTime endTime:(NSString *)endTime isEntry:(BOOL)isEntry ComplectionBlock:(void (^)(NSDictionary *))complection{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:startTime forKey:@"begin_date"];
    [param setValue:endTime forKey:@"end_date"];
    [param setValue:@(isEntry) forKey:@"stat"];
    [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_SelectReportInfo withParameter:param isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code =[[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                NSDictionary *dict = [returnData objectForKey:@"data"];
                complection(dict);
            }
            else{
                
                complection(nil);
                [JRToast showWithText:[returnData valueForKey:@"message"]];
                
            }
        }
        else{
            
            complection(nil);
            [JRToast showWithText:@"查询报表信息失败失败" duration:2];
        }
    }];
}

+ (void)getMyWalletComplectionBlock:(void (^)(HYMyWalletModel *))complection{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_GetMyWalletInfo withParameter:param isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code =[[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                NSDictionary *dict = [returnData objectForKey:@"data"][@"userAccountInfo"];
                HYMyWalletModel *model = [HYMyWalletModel modelWithDictionary:dict];
                complection(model);
            }
            else{
                
                complection(nil);
                [JRToast showWithText:[returnData valueForKey:@"message"]];
                
            }
        }
        else{
            
            complection(nil);
            [JRToast showWithText:@"获取钱包信息失败" duration:2];
        }
    }];
}

+ (void)DepositWithMoney:(NSString *)money password:(NSString *)password ComplectionBlock:(void (^)(BOOL))complection{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:money forKey:@"drawCashAmount"];
    [param setValue:password forKey:@"drawCashPwd"];
    [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_Deposit withParameter:param isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code =[[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                complection(YES);
            }
            else{
                
                complection(NO);
                [JRToast showWithText:[returnData valueForKey:@"message"]];
                
            }
        }
        else{
            
            complection(NO);
            [JRToast showWithText:@"提现失败" duration:2];
        }
    }];
}

+ (void)drawDownTheReportWithOrderID:(NSString *)orderID ComplectionBlock:(void (^)(BOOL))complection{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [param setValue:orderID forKey:@"sorder_ids"];

    [[HTTPManager shareHTTPManager] postDataFromUrl:API_DrawDownReport withParameter:param isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code =[[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
            
                complection(YES);
            }
            else{
                
                complection(NO);
                [JRToast showWithText:[returnData valueForKey:@"message"]];
                
            }
        }
        else{
            
            complection(NO);
            [JRToast showWithText:@"领取失败" duration:2];
        }
    }];
}

+ (void)getTeamMemberWithGroupID:(NSString *)groupID ComplectionBlock:(void (^)(NSDictionary *dict))complection{
   
   NSMutableDictionary *param = [NSMutableDictionary dictionary];
   [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];
   [param setValue:groupID forKey:@"group_id"];
   
   [[HTTPManager shareHTTPManager] postDataFromUrl:API_GetTeamMember withParameter:param isShowHUD:YES success:^(id returnData) {
      
      if (returnData) {
         
         NSInteger code =[[returnData objectForKey:@"code"] integerValue];
         if (code == 000) {
            
            
            NSDictionary *data = [returnData objectForKey:@"data"];
            complection(data);
         }
         else{
            
            complection(nil);
            [JRToast showWithText:[returnData valueForKey:@"message"]];
            
         }
      }
      else{
         
         complection(nil);
         [JRToast showWithText:@"获取群成员信息失败" duration:2];
      }
   }];
}

@end

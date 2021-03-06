
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
                [JRToast showWithText:[returnData objectForKey:@"message"] duration:2.0f];
            }
        }
        else{
            
            complection(nil);
           [JRToast showWithText:@"微信登录失败" duration:2.0f];
        }
    }];
}

+ (void)refreshUserInfo{
   
   NSMutableDictionary *param = [NSMutableDictionary dictionary];
   [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];
   //获取用户信息
   [[HTTPManager shareHTTPManager] postDataFromUrl:API_GetUserInfo withParameter:param isShowHUD:NO success:^(id returnData) {
      
      if (returnData) {
         
         NSInteger code = [[returnData objectForKey:@"code"] integerValue];
         if (code == 000) {
            
            NSString *token = [HYUserModel sharedInstance].token;
            NSString *rong_token = [HYUserModel sharedInstance].rong_token;
            NSDictionary *data = [returnData objectForKey:@"data"];
            HYUserModel *user = [HYUserModel sharedInstance];
            [user modelSetWithDictionary:data];
            user.token = token;
            user.rong_token = rong_token;
         }
         else{
            
            [JRToast showWithText:[returnData valueForKey:@"message"] duration:2];
            
         }
      }
      else{
         
         [JRToast showWithText:@"获取用户信息出现问题" duration:2];
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
               
               //将用户名和密码保存起来
               [KUSERDEFAULTS setValue:phone forKey:KUserPhone];
               [KUSERDEFAULTS setValue:password forKey:KUserPassword];
               [KUSERDEFAULTS setValue:@"phone" forKey:KUserLoginType];
               [KUSERDEFAULTS synchronize];
               
               if (![HYPlistTools unarchivewithName:KUserModelData]) {
                  
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
               
               //归档
               [HYPlistTools archiveObject:user withName:KUserModelData];
               complection(dataInfo);
               [JRToast showWithText:@"登录成功" duration:2];
               
            }
            else{
                
                complection(nil);
               [JRToast showWithText:[returnData valueForKey:@"message"] duration:2.0];
//               KEYWINDOW.rootViewController = [[HYLoginViewController alloc] init];
               [[RCIMClient sharedRCIMClient] logout];
               [[HYUserModel sharedInstance] clearData];
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

+ (void)verifyAuthCodeWithPhone:(NSString *)phone authCode:(NSString *)authCode  ComplectionBlock:(void (^)(BOOL))complection{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:phone forKey:@"phoneNum"];
    [param setValue:authCode forKey:@"phoneCode"];
    [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];
   [param setValue:@"" forKey:@""];
    
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


+ (void)uploadIDCardInfoWithName:(NSString *)name
                       IDCardNum:(NSString *)IDCardNum
                     bankCardNum:(NSString *)bankCardNum
                        phoneNum:(NSString *)phone
                        authCode:(NSString *)authCode
                ComplectionBlock:(void (^)(BOOL))complection
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [param setValue:name forKey:@"real_name"];
    [param setValue:IDCardNum forKey:@"card_id"];
    [param setValue:bankCardNum forKey:@"bankCard_no"];
    [param setValue:phone forKey:@"phoneNum"];
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

+ (void)bindBankCardWithName:(NSString *)name
                   IDCardNum:(NSString *)IDCardNum
                 bankCardNum:(NSString *)bankCardNum
                    pboneNum:(NSString *)phone
                    authCode:(NSString *)authCode
            ComplectionBlock:(void (^)(BOOL))complection{
   
   NSMutableDictionary *param = [NSMutableDictionary dictionary];
   [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];
   [param setValue:name forKey:@"real_name"];
   [param setValue:IDCardNum forKey:@"card_id"];
   [param setValue:bankCardNum forKey:@"bankCard_no"];
   [param setValue:phone forKey:@"phoneNum"];
   [param setValue:authCode forKey:@"phoneCode"];
   
   
   [[HTTPManager shareHTTPManager] postDataFromUrl:API_BindBankCard withParameter:param isShowHUD:YES success:^(id returnData) {
      
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
         [JRToast showWithText:@"绑定银行卡失败" duration:2];
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

////获取钱包信息
+ (void)getMyWalletWithViewWillAppear:(BOOL)isViewWillAppear ComplectionBlock:(void(^)(HYMyWalletModel *model))complection {
    
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
                if (!isViewWillAppear) {
                    complection(nil);
                    [JRToast showWithText:[returnData valueForKey:@"message"]];
                }
            }
        }
        else{
            
            //complection(nil);
            [JRToast showWithText:@"获取钱包信息失败" duration:2];
        }
    }];
}

+ (void)DepositWithMoney:(NSString *)money password:(NSString *)password bandCardID:(NSString *)bankCardID ComplectionBlock:(void (^)(BOOL))complection{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:money forKey:@"drawCashAmount"];
    [param setValue:password forKey:@"drawCashPwd"];
    [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [param setValue:bankCardID forKey:@"bankCard_id"];

    
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
//推荐合伙人
+ (void)recommendParterWithDict:(NSDictionary *)dict ComplectionBlock:(void (^)(BOOL))complection{
   
   NSMutableDictionary *param = [NSMutableDictionary dictionary];
   [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];
   [param setValuesForKeysWithDictionary:dict];
   
   [[HTTPManager shareHTTPManager] postDataFromUrl:API_RecommendParter withParameter:param isShowHUD:YES success:^(id returnData) {
      
      if (returnData) {
         
         NSInteger code = [[returnData objectForKey:@"code"] integerValue];
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
         [JRToast showWithText:@"推荐合伙人失败" duration:2];
      }
   }];
}

+ (void)getBillDataWithPageNo:(NSInteger)pageNO ComplectionBlock:(void (^)(NSArray *))complection{
   
   NSMutableDictionary *param = [NSMutableDictionary dictionary];
   [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];
   [param setValue:@(pageNO) forKey:@"pageNo"];

   [[HTTPManager shareHTTPManager] postDataFromUrl:API_GetBillInfo withParameter:param isShowHUD:YES success:^(id returnData) {
      
      if (returnData) {
         
         NSInteger code = [[returnData objectForKey:@"code"] integerValue];
         if (code == 000) {
            
            NSArray *array = returnData[@"data"][@"dataList"];
            complection(array);
         }
         else{
            
            complection(nil);
            [JRToast showWithText:[returnData valueForKey:@"message"]];
            
         }
      }
      else{
         
         complection(nil);
         [JRToast showWithText:@"获取账单信息失败" duration:2];
      }
   }];
}
//获取绑定银行卡列表
+ (void)getBankCardListComplectionBlock:(void (^)(NSArray *))complection{
   
   NSMutableDictionary *param = [NSMutableDictionary dictionary];
   [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];
   
   [[HTTPManager shareHTTPManager] postDataFromUrl:API_GetBankCardList withParameter:param isShowHUD:NO success:^(id returnData) {
      
      if (returnData) {
         
         NSInteger code = [[returnData objectForKey:@"code"] integerValue];
         if (code == 000) {
            
            NSArray *array = returnData[@"data"];
            complection(array);
         }
         else{
            
            complection(nil);
            [JRToast showWithText:[returnData valueForKey:@"message"]];
            
         }
      }
      else{
         
         complection(nil);
         [JRToast showWithText:@"获取银行卡信息失败" duration:2];
      }
   }];
}

+ (void)getAllArticleListWithPageNo:(NSInteger)pageNO ComplectionBlock:(void(^)(NSArray *datalist))complection{
   
   NSMutableDictionary *param = [NSMutableDictionary dictionary];
   [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];
   [param setValue:@(pageNO) forKey:@"pageNo"];

   
   [[HTTPManager shareHTTPManager] postDataFromUrl:API_GetArticleList withParameter:param isShowHUD:YES success:^(id returnData) {
      
      if (returnData) {
         
         NSInteger code = [[returnData objectForKey:@"code"] integerValue];
         if (code == 000) {
            
            NSArray *array = returnData[@"data"][@"list"];
            if (array.count) {
               
               complection(array);
            }
            else{
               
               complection(array);
            }
         }
         else{
            
            complection(nil);
            [JRToast showWithText:[returnData valueForKey:@"message"]];
            
         }
      }
      else{
         
         complection(nil);
         [JRToast showWithText:@"获取文章列表失败" duration:2];
      }
   }];
}

+ (void)setPasswordWithPhone:(NSString *)phone password:(NSString *)password authCode:(NSString *)authCode ComplectionBlock:(void (^)(BOOL))complection{
   
   NSMutableDictionary *param = [NSMutableDictionary dictionary];
   [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];
   [param setValue:phone forKey:@"phoneNum"];
   [param setValue:authCode forKey:@"phoneCode"];
   [param setValue:password forKey:@"user_pwd"];

   [[HTTPManager shareHTTPManager] postDataFromUrl:API_SetPassword withParameter:param isShowHUD:YES success:^(id returnData) {
      
      if (returnData) {
         
         NSInteger code = [[returnData objectForKey:@"code"] integerValue];
         if (code == 000) {
            
            complection(YES);
            [JRToast showWithText:@"设置成功"];
         }
         else{
            
            complection(NO);
            [JRToast showWithText:[returnData valueForKey:@"message"]];
            
         }
      }
      else{
         
         complection(NO);
      }
   }];
}

+ (void)getRecommendDataComplectionBlock:(void (^)(NSArray *))complection{
   
   [[HTTPManager shareHTTPManager] postDataFromUrl:API_RecommendData withParameter:nil isShowHUD:YES success:^(id returnData) {
      
      if (returnData) {
         
         NSInteger code = [[returnData objectForKey:@"code"] integerValue];
         if (code == 000) {
            
            NSArray *array = returnData[@"data"];
            if (array.count) {
               
               complection(array);
            }
            else{
               
               complection(array);
            }
         }
         else{
            
            complection(nil);
            [JRToast showWithText:[returnData valueForKey:@"message"]];
            
         }
      }
      else{
         
         complection(nil);
         [JRToast showWithText:@"获取推荐信息失败" duration:2];
      }
   }];
}

@end

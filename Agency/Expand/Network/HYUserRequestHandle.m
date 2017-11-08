
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
            }
            else{
                
                complection(nil);
                [JRToast showWithText:[returnData valueForKey:@"message"]];
            }
        }
        else{
            
            complection(nil);
            [JRToast showWithText:[returnData valueForKey:@"message"]];
        }
    }];
}

+ (void)getAuthCodeWithPhone:(NSString *)phone ComplectionBlock:(void (^)(NSString *))complection{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:phone forKey:@"phoneNum"];
    [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];

    [[HTTPManager shareHTTPManager] postDataFromUrl:API_Login withParameter:param isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code =[[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                complection(nil);
            }
            else{
                
                complection(nil);
                [JRToast showWithText:[returnData valueForKey:@"message"]];

            }
        }
        else{
            
            complection(nil);
            [JRToast showWithText:@"获取验证码错误"];
        }
    }];
}

+ (void)verifyAuthCodeWithPhone:(NSString *)phone authCode:(NSString *)authCode ComplectionBlock:(void (^)(BOOL))complection{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:phone forKey:@"phoneNum"];
    [param setValue:authCode forKey:@"phoneCode"];
    [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_Login withParameter:param isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code =[[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                complection(YES);
            }
            else{
                
                complection(NO);
                [JRToast showWithText:@"校验验证码失败"];
                
            }
        }
        else{
            
            complection(NO);
            [JRToast showWithText:[returnData valueForKey:@"message"]];
        }
    }];
}

+ (void)bindPhone:(NSString *)phone authCode:(NSString *)authCode ComplectionBlock:(void (^)(BOOL))complection{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:phone forKey:@"phoneNum"];
    [param setValue:@"phone_check001" forKey:@"check_type"];
    [param setValue:authCode forKey:@"phoneCode"];
    [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_Login withParameter:param isShowHUD:YES success:^(id returnData) {
        
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
            [JRToast showWithText:[returnData valueForKey:@"message"]];
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
            [JRToast showWithText:[returnData valueForKey:@"message"]];
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
            [JRToast showWithText:[returnData valueForKey:@"message"]];
        }
    }];
}

@end

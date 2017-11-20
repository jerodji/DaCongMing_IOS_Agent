//
//  HYRCIMGetUserInfoHandle.m
//  Agency
//
//  Created by Jack on 2017/11/18.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYRCIMGetUserInfoHandle.h"

@implementation HYRCIMGetUserInfoHandle

+ (void)getUserInfo:(NSString *)userId completion:(void (^)(RCUserInfo *))completion{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [param setValue:userId forKey:@"member_id"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_GetRCIMUserInfo withParameter:param isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code =[[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                NSDictionary *dict = [returnData objectForKey:@"data"][@"memberInfo"];
                RCUserInfo *userInfo = [RCUserInfo modelWithDictionary:dict];
                completion(userInfo);
            }
            else{
                
                completion(nil);
                [JRToast showWithText:[returnData valueForKey:@"message"]];
                
            }
        }
        else{
            
            completion(nil);
            [JRToast showWithText:@"获取成员信息失败" duration:2];
        }
    }];
}

+ (void)getGroupInfo:(NSString *)groupID completion:(void (^)(RCGroup *group))completion{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [param setValue:groupID forKey:@"group_id"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_GetGroupInfo withParameter:param isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code =[[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                NSDictionary *dict = [returnData objectForKey:@"data"][@"groupInfo"];
                RCGroup *group = [RCGroup modelWithDictionary:dict];
                completion(group);
            }
            else{
                
                completion(nil);
                [JRToast showWithText:[returnData valueForKey:@"message"]];
                
            }
        }
        else{
            
            completion(nil);
            [JRToast showWithText:@"获取群信息失败" duration:2];
        }
    }];
}

@end

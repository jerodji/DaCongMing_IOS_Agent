//
//  HYLoginRequestManager.m
//  Agency
//
//  Created by 胡勇 on 2017/11/2.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYLoginRequestManager.h"

@implementation HYLoginRequestManager

+ (void)weChatLoginWithProgram:(NSDictionary *)dict ComplectionBlock:(void (^)(NSDictionary *))complection{
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_WeChatLogin withParameter:dict isShowHUD:YES success:^(id returnData) {
       
        if (returnData) {
            
            NSInteger code =[[returnData objectForKey:@"successed"] integerValue];
            if (code == 000) {
                
                NSDictionary *dataInfo = [returnData objectForKey:@"dataInfo"];
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
            
            [JRToast showWithText:@"wechat login error"];
        }
    }];
}

@end

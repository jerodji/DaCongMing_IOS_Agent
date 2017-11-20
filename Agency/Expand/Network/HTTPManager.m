//
//  HTTPManager.m
//  xtd
//
//  Created by leimo on 2017/8/10.
//  Copyright © 2017年 sj. All rights reserved.
//

#import "HTTPManager.h"
#import "HYLoginViewController.h"

@implementation HTTPManager

+ (instancetype)shareHTTPManager{

    static HTTPManager *httpManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        httpManager = [HTTPManager new];
    });
    return httpManager;
}

- (void)getDataFromUrl:(NSString *)url withParameter:(NSDictionary *)para isShowHUD:(BOOL)isShowHUD success:(requestSuccess)successBlock{
    
    if (isShowHUD) {

        [MBProgressHUD showPregressHUD:KEYWINDOW];
    }
    
    NSString *urlString= [NSString stringWithFormat:@"%@/%@",API_DomainStr,url];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/html", nil];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.0f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.securityPolicy.allowInvalidCertificates = YES;

    
    [manager GET:urlString parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (isShowHUD) {
            
            [MBProgressHUD hidePregressHUD:KEYWINDOW];
        }
        successBlock(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (isShowHUD) {
            
            [MBProgressHUD hidePregressHUD:KEYWINDOW];
        }
    }];
}

- (void)postDataFromUrl:(NSString *)url withParameter:(NSDictionary *)para isShowHUD:(BOOL)isShowHUD success:(requestSuccess)successBlock{

    if (isShowHUD) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD showPregressHUD:KEYWINDOW];
        });
        
    }
    
    NSString *urlString= [NSString stringWithFormat:@"%@/%@",API_DomainStr,url];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain", @"text/html", nil];

    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10.0f;

    //采用JSON的方式来解析数据
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    // 设置超时时间
//    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
//    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    
    [manager POST:urlString parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (isShowHUD) {
                
                [MBProgressHUD hidePregressHUD:KEYWINDOW];
            }
            [MBProgressHUD hidePregressHUD:KEYWINDOW];
        });
        
        
        
        NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
        
        if (code == -111) {
            
            //token过期了,跳转登录页面
            [[HYUserModel sharedInstance] clearData];
            HYLoginViewController *loginVC = [[HYLoginViewController alloc] init];
            [UIApplication sharedApplication].keyWindow.rootViewController = loginVC;
            [JRToast showWithText:@"账号登录信息有误，请重新登录" duration:3];
        }
        else{
          
            successBlock(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (isShowHUD) {
            
            [MBProgressHUD hidePregressHUD:KEYWINDOW];
        }
        successBlock(nil);
    }];
}


@end

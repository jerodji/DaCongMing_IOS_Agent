//
//  HYChatViewController.m
//  Agency
//
//  Created by Jack on 2017/11/16.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYChatViewController.h"
#import "HYRCIMGetUserInfoHandle.h"

@interface HYChatViewController () <RCIMUserInfoDataSource,RCIMGroupMemberDataSource,RCIMGroupInfoDataSource>

@end

@implementation HYChatViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"我的群聊";
    [RCIM sharedRCIM].userInfoDataSource = self;
    [RCIM sharedRCIM].groupMemberDataSource = self;
    [RCIM sharedRCIM].groupInfoDataSource = self;
    [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
    [IQKeyboardManager sharedManager].enable = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = KAPP_NAV_COLOR;
    self.navigationController.navigationBar.translucent = NO;
    [self setStatusBarBackgroundColor:KAPP_NAV_COLOR];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
    [self setStatusBarBackgroundColor:KAPP_WHITE_COLOR];
    [self setNeedsNavigationBackground:0];
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        
        statusBar.backgroundColor = color;
    }
}

- (void)setNeedsNavigationBackground:(CGFloat)alpha {
    

    // 导航栏背景透明度设置
    UIView *barBackgroundView = [[self.navigationController.navigationBar subviews] objectAtIndex:0];// _UIBarBackground
    UIImageView *backgroundImageView = [[barBackgroundView subviews] objectAtIndex:0];// UIImageView
    if (self.navigationController.navigationBar.isTranslucent) {
        if (backgroundImageView != nil && backgroundImageView.image != nil) {
            barBackgroundView.alpha = alpha;
        }
        else {
            UIView *backgroundEffectView = [[barBackgroundView subviews] objectAtIndex:1];// UIVisualEffectView
            if (backgroundEffectView != nil) {
                backgroundEffectView.alpha = alpha;
            }
        }
    }
    else {
        barBackgroundView.alpha = alpha;
    }
    self.navigationController.navigationBar.clipsToBounds = YES;
    
}


#pragma mark - RCIMDelegate
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion{
    
    if ([userId isEqualToString:[RCIM sharedRCIM].currentUserInfo.userId]) {
        
        //当前登录账户
        [HYRCIMGetUserInfoHandle getUserInfo:userId completion:^(RCUserInfo *user) {
            
            [[RCIM sharedRCIM] refreshUserInfoCache:user withUserId:userId];
            completion(user);
        }];
    }
    else{
        
        //其他人
        [HYRCIMGetUserInfoHandle getUserInfo:userId completion:^(RCUserInfo *user) {
            
            completion(user);
        }];
    }
}

- (void)getGroupInfoWithGroupId:(NSString *)groupId completion:(void (^)(RCGroup *))completion{
    
    [HYRCIMGetUserInfoHandle getGroupInfo:groupId completion:^(RCGroup *group) {
       
        completion(group);
    }];
}

- (void)getAllMembersOfGroup:(NSString *)groupId result:(void (^)(NSArray<NSString *> *))resultBlock{
    
    [HYUserRequestHandle getTeamMemberWithGroupID:groupId ComplectionBlock:^(NSDictionary *dict) {
       
        if (dict) {
            
            NSArray *datalist = dict[@"memberList"];
            NSMutableArray *tempArray = [NSMutableArray array];
            for (NSDictionary *dict in datalist) {
                
                [tempArray addObject:dict[@"id"]];
            }
            
            resultBlock(tempArray);
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}





@end

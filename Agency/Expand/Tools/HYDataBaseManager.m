//
//  HYDataBaseManager.m
//  Agency
//
//  Created by Jack on 2017/11/16.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYDataBaseManager.h"
#import <FMDB/FMDB.h>

@interface HYDataBaseManager()

@property (nonatomic,strong) FMDatabaseQueue *dbQueue;

@end

@implementation HYDataBaseManager

+ (instancetype)shareInstance{
    
    static HYDataBaseManager *dataBaseMgr;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        dataBaseMgr = [[HYDataBaseManager alloc] init];
        
    });
    return dataBaseMgr;
}


#pragma mark - lazyload
- (FMDatabaseQueue *)dbQueue{
    
    if ([RCIMClient sharedRCIMClient].currentUserInfo.userId == nil) {
        
        return nil;
    }
    
    if (!_dbQueue) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
        NSString *const rongCloud = @"rongCloud";
        NSString *library = [[paths objectAtIndex:0] stringByAppendingPathComponent:rongCloud];
        NSString *dbPath = [library stringByAppendingPathComponent:[NSString stringWithFormat:@"RongCloudDB%@",[RCIMClient sharedRCIMClient].currentUserInfo.userId]];
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    }
    return _dbQueue;
}

@end

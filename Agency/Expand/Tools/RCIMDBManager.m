//
//  RCIMDBManager.m
//  Agency
//
//  Created by Jack on 2017/11/17.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "RCIMDBManager.h"

@interface RCIMDBManager()

@property (nonatomic,strong) FMDatabaseQueue *dbQueue;

@end

@implementation RCIMDBManager

//表名
static NSString *const groupTableName = @"groupTable";
static NSString *const groupMemberName = @"groupMemberTable";



+ (instancetype)shareInstance{
    
    static RCIMDBManager *dataBaseMgr;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        dataBaseMgr = [[RCIMDBManager alloc] init];
        
    });
    return dataBaseMgr;
}

#pragma mark - public
- (void)insertRCUserToDB:(RCUserInfo *)RCUser{
    
    
}

- (RCUserInfo *)removeRCUserById:(NSString *)userId{
    
    return nil;
}

#pragma mark - private
//是否需要创建表
- (void)_createTableIfNeed{
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
       
        if (![self isTableExist:groupTableName withDB:db]) {
            
            //创建群组表
            NSString *createTableSql = @"CREATE TABLE groupTable (id integer PRIMARY KEY autoincrement,groupId text,name text,headerImgUrl text,introduce text,createTime text)";
            NSString *createIndexSql = @"create unique index index_groupId on groupTable(groupId)";
            [db executeQuery:createTableSql];
            [db executeQuery:createIndexSql];
        }
        
        if (![self isTableExist:groupMemberName withDB:db]) {
            
            //创建群成员表
        }
        
    }];
}


#pragma mark - determine the table if exist
- (BOOL)isTableExist:(NSString *)tableName withDB:(FMDatabase *)db{
    
    BOOL isExist = NO;
    FMResultSet *rs = [db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next]) {
        
        NSInteger count = [rs intForColumn:@"count"];
        if (count == 0) {
            
            isExist = NO;
        }
        else{
            isExist = YES;
        }
    }
    [rs close];
    return isExist;
}


#pragma mark - lazyload
- (FMDatabaseQueue *)dbQueue{
    
    if ([RCIMClient sharedRCIMClient].currentUserInfo.userId == nil) {
        
        return nil;
    }
    
    if (!_dbQueue) {
        
        //创建数据库
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *const rongCloud = @"rongCloud";
        NSString *library = [[paths lastObject] stringByAppendingPathComponent:rongCloud];
        NSString *dbPath = [library stringByAppendingPathComponent:[NSString stringWithFormat:@"RongCloudDB%@.db",[RCIMClient sharedRCIMClient].currentUserInfo.userId]];
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
        
        if (_dbQueue) {
            
            [self _createTableIfNeed];
        }
    }
    return _dbQueue;
}

@end

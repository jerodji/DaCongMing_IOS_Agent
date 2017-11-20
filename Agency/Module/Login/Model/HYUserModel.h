//
//  HYUserModel.h
//  Agency
//
//  Created by 胡勇 on 2017/11/2.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYUserInfo : NSObject <NSCoding>

/** id */
@property (nonatomic, copy) NSString *id;
/** name */
@property (nonatomic, copy) NSString *name;
/** age */
@property (nonatomic, copy) NSString *age;
/** sex */
@property (nonatomic, copy) NSString *sex;
/** adress */
@property (nonatomic, copy) NSString *adress;
/** phone */
@property (nonatomic, copy) NSString *phone;
/** note */
@property (nonatomic, copy) NSString *note;
/** head_image_url */
@property (nonatomic, copy) NSString *head_image_url;
/** qr */
@property (nonatomic, copy) NSString *qrpath;
/** qr */
@property (nonatomic, copy) NSString *group_id;

/** V0没有权限 */
@property (nonatomic,copy) NSString *level;

@end

@interface HYUserModel : NSObject <NSCoding>

/** token */
@property (nonatomic,copy) NSString *token;
/** 融云token */
@property (nonatomic,copy) NSString *rong_token;
/** userinfo */
@property (nonatomic,strong) HYUserInfo *userInfo;

+ (instancetype)sharedInstance;

- (void)clearData;

@end



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
/** 我的收益 */
@property (nonatomic, copy) NSString *total_incom;
/** V0没有权限 V2实习经销商 V3高级经销商 V4实习合伙人 V5高级合伙人 V6特约合伙人 */
@property (nonatomic,copy) NSString *level;
/** 是否已经实名认证 */
@property (nonatomic,copy) NSString *isauth;

@property (nonatomic,copy) NSString * real_name;

@property (nonatomic,copy) NSString * card_id;
//是否是合伙人
@property (nonatomic,copy) NSString * ispartner;

@property (nonatomic,copy) NSString * groupMemberNum;
@end

/**
 {
     "code": "000",
     "data": {
         "userInfo": {
             "id": "o-13Mv3pdaihECi3-30cWamAWWGg",
             "name": "紫气东来",
             "age": 0,
             "phone": "",
             "head_image_url": "http://www.laopdr.cn/hpt_image/htp_201801241000000637462940.jpg",
             "qrpath": "https://www.laopdr.cn/qrcode/-1928778721.png",
             "level": "V0",
             "isauth": "0",
             "real_name": "",//
             "card_id": "",  //
             "total_incom": "0.00",
             "ispartner": "0",
             "groupMemberNum": 0//
         },
         "AgentStatus": "0" //是否加入大聪明
     }
 }
 */

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



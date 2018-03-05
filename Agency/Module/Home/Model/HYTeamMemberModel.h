//
//  HYTeamMemberModel.h
//  Agency
//
//  Created by Jack on 2017/11/18.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYTeamMemberModel : HYBaseModel

@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *head_image_url;
@property (nonatomic,copy) NSString *age;
@property (nonatomic,copy) NSString * uid;
@property (nonatomic,copy) NSString * groupMemberNum;

@end

/**
 {
     age = 0,
     id = "10000734",
     head_image_url = "http://www.laopdr.cn/hpt_image/htp_201802251000000210766087.jpg",
     uid = 0,
     name = "_Levy",
     groupMemberNum = 0,
 }
 */

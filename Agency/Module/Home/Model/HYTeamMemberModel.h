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

@end

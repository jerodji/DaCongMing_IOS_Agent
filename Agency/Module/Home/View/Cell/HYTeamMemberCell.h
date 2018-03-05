//
//  HYTeamMemberCell.h
//  Agency
//
//  Created by Jack on 2017/11/18.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYTeamMemberModel.h"

@interface HYTeamMemberCell : UITableViewCell

@property (nonatomic,strong) HYTeamMemberModel *model;

@property (nonatomic,strong) UIImageView *headerImgView;
@property (nonatomic,strong) UILabel *nickNameLabel;
@property (nonatomic,strong) UILabel *IDLabel;
@property (nonatomic,strong) UILabel *agencyLabel;
@property (nonatomic,strong) UIView *bottomLine;

@end

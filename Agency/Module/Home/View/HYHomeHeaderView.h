//
//  HYHomeHeaderView.h
//  Agency
//
//  Created by 胡勇 on 2017/11/2.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYHomeHeaderView : UIView

/** 图像 */
@property (nonatomic,strong) UIImageView *headerImgView;
/** 昵称 */
@property (nonatomic,strong) UILabel *nickNameLabel;
/** 客户数 */
@property (nonatomic,strong) UILabel *clientNumLabel;
/** 我的团对 */
@property (nonatomic,strong) UIButton *myTeamsBtn;
/** money */
@property (nonatomic,strong) UILabel *moneyLabel;

@end

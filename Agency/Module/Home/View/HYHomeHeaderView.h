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
/** 我的团对 */
@property (nonatomic,strong) UIButton *myTeamsBtn;

@end

//
//  HYMyTeamHeaderView.h
//  Agency
//
//  Created by Jack on 2017/11/17.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HYTeamHeaderViewBtnClickDelegate <NSObject>

- (void)headerViewBtnClickIndex:(NSInteger)index;

@end

@interface HYMyTeamHeaderView : UIView

@property (nonatomic,weak) id<HYTeamHeaderViewBtnClickDelegate> delegate;

@property (nonatomic,copy) NSString *number;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UIImageView *headerImageView;


@end
